import sys
print(f"Python: {sys.version}")

try:
    import torch
    print("torch: ok")
    import torchaudio
    print("torchaudio: ok")
    import whisperx
    print("whisperx: ok")
    import pyannote.audio
    print("pyannote.audio: ok")
    import pandas
    print("pandas: ok")
    import scipy
    print("scipy: ok")
    import sklearn
    print("sklearn: ok")
    import semver
    print("semver: ok")
    import soundfile
    print("soundfile: ok")
    import asteroid_filterbanks
    print("asteroid-filterbanks: ok")
    import tensorboardX
    print("tensorboardX: ok")
except ImportError as e:
    print(f"MISSING DEPENDENCY: {e}")
    sys.exit(1)
except Exception as e:
    print(f"OTHER ERROR: {e}")
    sys.exit(1)
