import os


BASE_DIR = os.environ.get("BASE_DIR", "/work/FAC/FGSE/IDYST/tbeucler/downscaling")
DATASETS_TRAINING_DIR= os.environ.get("DATASETS_TRAINING_DIR", f"{BASE_DIR}/sasthana/Downscaling/Downscaling_Models/Training_Chronological_Dataset")
UNET_1971_DIR= os.environ.get("UNET_1971", f"{BASE_DIR}/sasthana/Downscaling/Downscaling_Models/models_UNet/UNet_Deterministic_Training_Dataset")
UNET_COMBINED_DIR= os.environ.get("UNET_COMBINED", f"{BASE_DIR}/sasthana/Downscaling/Downscaling_Models/models_UNet/UNet_Deterministic_Combined_Dataset")
TARGET_DIR= os.environ.get("TARGET_DIR", f"{BASE_DIR}/sasthana/Downscaling/Processing_and_Analysis_Scripts/data_1971_2023/HR_files_full")   
OUTPUTS_DIR= os.environ.get("OUTPUTS_DIR", f"{BASE_DIR}/sasthana/Downscaling/Processing_and_Analysis_Scripts/Outputs")
MODELS_DIR= os.environ.get("MODELS_DIR", f"{BASE_DIR}/sasthana/Downscaling/Downscaling_Models/Model_Runs")
GCM_PIPELINE_DIR= os.environ.get("GCM_PIPELINE_DIR", f"{BASE_DIR}/sasthana/Downscaling/GCM_pipeline")   