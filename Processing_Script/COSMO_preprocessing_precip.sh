#!/bin/bash
#SBATCH --job-name=Precip_Present_COSMO_preprocessing
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



PRECIP_DIR="/reference/FGSE/climate_simulations/cosmo6_2km_climate/5min_2D/"

TMP_dir=$(mktemp -d "$BASE_DIR/sasthana/Downscaling/COSMO_RGG/COSMO/COSMO_present/precip_temp_XXXXXX")

echo "Temporary directory: $TMP_dir"

PRECIP_FILES=($PRECIP_DIR/*.nz)

COUNTER=0

echo "Number of PRECIP files: ${#PRECIP_FILES[@]}"
echo "Porcessing precipitation files"

for file in "${PRECIP_FILES[@]}"; do
    COUNTER=$((COUNTER + 1))
    echo "processing file : $file"
    cdo sellonlatbox,-10,40,35,70 -selname,TOT_PREC "$file" "$TMP_dir/$(basename "$file").nc"
    echo "Processed $COUNTER / ${#PRECIP_FILES[@]} precip files"
    done

echo "Concatenating precip files"
cdo cat "$TMP_dir"/*.nc "$BASE_DIR/sasthana/Downscaling/COSMO_RGG/COSMO/COSMO_present/COSMO_precip_present.nc"
rm -r "$TMP_dir"
echo "Done with precip"