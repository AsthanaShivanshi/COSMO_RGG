#!/bin/bash
#SBATCH --job-name=Temp_Present_COSMO_preprocessing
#SBATCH --chdir=/work/FAC/FGSE/IDYST/tbeucler/downscaling
#SBATCH --output=sasthana/Downscaling/COSMO_RGG/logs/present_cosmo_%A_%a.log
#SBATCH --error=sasthana/Downscaling/COSMO_RGG/logs/present_cosmo_%A_%a.log
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4       
#SBATCH --mem=256G
#SBATCH --time=3-00:00:00     

module load cdo

export PROJ_LIB="$ENVIRONMENT/share/proj"
export HDF5_USE_FILE_LOCKING=FALSE 

BASE_DIR="/work/FAC/FGSE/IDYST/tbeucler/downscaling"



cd "$BASE_DIR" || { echo "failed to cd into base dir"; exit 1; }

mkdir -p "$BASE_DIR/sasthana/Downscaling/COSMO_RGG/COSMO/COSMO_present"



T2M_DIR="/reference/FGSE/climate_simulations/cosmo6_2km_climate/1h_2D/"

TMP_dir=$(mktemp -d "$BASE_DIR/sasthana/Downscaling/COSMO_RGG/COSMO/COSMO_present/tmp_temp_XXXXXX")

echo "Temporary directory: $TMP_dir"

T2M_FILES=($T2M_DIR/*.nz)

COUNTER=0

echo "Number of T2M files: ${#T2M_FILES[@]}"
echo "Porcessing temperature files"

for file in "${T2M_FILES[@]}"; do
    COUNTER=$((COUNTER + 1))
    echo "processing file : $file"
    cdo sellonlatbox,-10,40,35,70 -selname,T_2M "$file" "$TMP_dir/$(basename "$file").nc"
    echo "Processed $COUNTER / ${#T2M_FILES[@]} temp files"

    done

echo "Concatenating temp files"

cdo mergetime "$TMP_dir"/*.nc "$BASE_DIR/sasthana/Downscaling/COSMO_RGG/COSMO/COSMO_present/COSMO_t2m_present.nc"
rm -r "$TMP_dir"

echo "Done with temp"
