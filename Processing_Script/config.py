import os
BASE_DIR = os.environ.get("BASE_DIR", "/work/FAC/FGSE/IDYST/tbeucler/downscaling")
DATASETS_RAW= os.environ.get("DATASETS_RAW", f"{BASE_DIR}/sasthana/Downscaling/COSMO_RGG/COSMO")
OUTPUTS_DIR= os.environ.get("OUTPUTS_DIR", f"{BASE_DIR}/sasthana/Downscaling/COSMO_RGG/Outputs")
COSMO_Training_Dataset= os.environ.get("COSMO_Training_Dataset", f"{BASE_DIR}/sasthana/Downscaling/COSMO_RGG/COSMO_Training_Dataset")
