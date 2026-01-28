#!/bin/bash

# Database Management Utility - Total Control Edition
# No hidden variables, no app-specific logic. Explicit arguments only.
# All operations happen in the Current Working Directory (CWD).

set -e

# Configuration
REMOTE_HOST="fix"

# Detect if we are running on the remote host
IS_REMOTE=false
if [[ "$(hostname)" == "fix" ]] || [[ -f "/home/deploy/production/deployments/docker-compose.infra.yml" ]]; then
    IS_REMOTE=true
fi

usage() {
    echo "Usage: $0 <command> [args...]"
    echo ""
    echo "Commands:"
    echo "  dump-local         <db> <user>               - Create a local database dump in CWD"
    echo "  dump-remote        <container> <db> <user>   - Create a remote database dump in CWD"
    echo "  pull               [remote_path]             - Download *.dump from VPS to CWD (default: /home/deploy/)"
    echo "  push               <file> [remote_path]      - Upload local file to VPS (default: /home/deploy/)"
    echo "  restore-local      <file> <db> <user>        - Restore a dump to local database"
    echo "  restore-remote     <file> <container> <db> <user> - Restore a dump to VPS database"
    echo "  reset-remote       <container> <db> <user>   - Wipe and recreate public schema on VPS"
    echo "  count-remote       <container> <db> <user> <table> - Quick row count check on VPS"
    echo ""
    echo "Detailed Examples:"
    echo "  # Dump remote 'law' DB directly to your local CWD:"
    echo "  $0 dump-remote datafixa-postgres law datafixa_user"
    echo ""
    echo "  # Restore a local file 'law.dump' to your local 'law' DB:"
    echo "  $0 restore-local ./law.dump law postgres"
    echo ""
    echo "  # Pull any dump files from the remote /home/deploy/ folder to CWD:"
    echo "  $0 pull"
    echo ""
    echo "  # Check count of 'users' in remote Engine DB:"
    echo "  $0 count-remote engine-postgres engine_db engine_user users"
    echo ""
    exit 1
}

if [ "$#" -lt 1 ]; then
    usage
fi

CMD=$1

DUMP_NAME="db_$(date +%Y%m%d_%H%M%S).dump"

case $CMD in
    dump-local)
        DB=$2; USER=$3
        if [[ -z "$DB" || -z "$USER" ]]; then usage; fi
        echo "Dumping local database ($DB as $USER) to ./$DUMP_NAME..."
        pg_dump -h localhost -U "$USER" -d "$DB" --format=custom -f "./$DUMP_NAME"
        echo "Done: ./$DUMP_NAME"
        ;;

    dump-remote)
        CONT=$2; DB=$3; USER=$4
        if [[ -z "$CONT" || -z "$DB" || -z "$USER" ]]; then usage; fi
        echo "Dumping remote database ($DB as $USER in $CONT) to CWD..."
        if [ "$IS_REMOTE" = true ]; then
            docker exec -t "$CONT" pg_dump -U "$USER" -d "$DB" --format=custom > "./$DUMP_NAME"
            echo "Done: ./$DUMP_NAME"
        else
            ssh "$REMOTE_HOST" "docker exec -t $CONT pg_dump -U $USER -d $DB --format=custom" > "./$DUMP_NAME"
            echo "Done: ./$DUMP_NAME (Downloaded locally)"
        fi
        ;;

    pull)
        REMOTE_P=${2:-"/home/deploy/"}
        if [ "$IS_REMOTE" = true ]; then echo "Error: Pull is for local use"; exit 1; fi
        echo "Pulling *.dump files from $REMOTE_HOST:$REMOTE_P to $(pwd)..."
        rsync -avzP "$REMOTE_HOST:$REMOTE_P/*.dump" ./
        ;;

    push)
        FILE=$2; REMOTE_P=${3:-"/home/deploy/"}
        if [ "$IS_REMOTE" = true ]; then echo "Error: Push is for local use"; exit 1; fi
        if [ -z "$FILE" ]; then usage; fi
        echo "Pushing $FILE to $REMOTE_HOST:$REMOTE_P..."
        rsync -avzP "$FILE" "$REMOTE_HOST:$REMOTE_P"
        ;;

    restore-local)
        FILE=$2; DB=$3; USER=$4
        if [[ -z "$FILE" || -z "$DB" || -z "$USER" ]]; then usage; fi
        echo "Restoring $FILE to local database ($DB as $USER)..."
        pg_restore -h localhost -U "$USER" -d "$DB" --clean --if-exists --no-owner "$FILE"
        ;;

    restore-remote)
        FILE=$2; CONT=$3; DB=$4; USER=$5
        if [[ -z "$FILE" || -z "$CONT" || -z "$DB" || -z "$USER" ]]; then usage; fi

        if [ "$IS_REMOTE" = true ]; then
            echo "Restoring file $FILE to container $CONT ($DB as $USER)..."
            docker exec -i "$CONT" pg_restore -U "$USER" -d "$DB" --no-owner --role="$USER" < "$FILE"
        else
            echo "Uploading and restoring $FILE to remote container $CONT ($DB as $USER)..."
            ssh "$REMOTE_HOST" "docker exec -i $CONT pg_restore -U $USER -d $DB --no-owner --role=$USER" < "$FILE"
        fi
        ;;

    reset-remote)
        CONT=$2; DB=$3; USER=$4
        if [[ -z "$CONT" || -z "$DB" || -z "$USER" ]]; then usage; fi
        read -p "Are you sure you want to RESET the remote $DB database in $CONT? (y/N) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            echo "Resetting remote $DB database..."
            if [ "$IS_REMOTE" = true ]; then
                docker exec -i "$CONT" psql -U "$USER" -d "$DB" -c 'DROP SCHEMA public CASCADE; CREATE SCHEMA public;'
            else
                ssh "$REMOTE_HOST" "docker exec -i $CONT psql -U $USER -d $DB -c 'DROP SCHEMA public CASCADE; CREATE SCHEMA public;'"
            fi
        fi
        ;;

    count-remote)
        CONT=$2; DB=$3; USER=$4; TABLE=$5
        if [[ -z "$CONT" || -z "$DB" || -z "$USER" || -z "$TABLE" ]]; then usage; fi
        echo "Counting rows in $TABLE ($DB) on remote..."
        if [ "$IS_REMOTE" = true ]; then
            docker exec -i "$CONT" psql -U "$USER" -d "$DB" -c "SELECT count(*) FROM $TABLE;"
        else
            ssh "$REMOTE_HOST" "docker exec -i $CONT psql -U $USER -d $DB -c 'SELECT count(*) FROM $TABLE;'"
        fi
        ;;

    *)
        usage
        ;;
esac
