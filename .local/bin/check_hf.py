from pyannote.audio import Pipeline
import os

token = os.environ.get("HF_TOKEN")
print(f"Testing token starting with: {token[:4]}...")

try:
    pipeline = Pipeline.from_pretrained("pyannote/speaker-diarization-3.1", use_auth_token=token)
    if pipeline is None:
        print("Error: Pipeline.from_pretrained returned None. This usually means access is denied or terms are not accepted.")
    else:
        print("Success: Diarization pipeline loaded!")
except Exception as e:
    print(f"Error loading pipeline: {e}")
