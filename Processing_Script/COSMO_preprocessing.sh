#!/bin/bash
#SBATCH --job-name=COSMO_preprocessing
#SBATCH --chdir=/work/FAC/FGSE/IDYST/tbeucler/downscaling
#SBATCH --output=sasthana/Downscaling/COSMO_RGG/logs/chron_split_observational_%A_%a.log
#SBATCH --error=sasthana/Downscaling/COSMO_RGG/logs/chron_split_observational_%A_%a.log
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4       
#SBATCH --mem=256G
#SBATCH --time=20:00:00     

module load cdo

export PROJ_LIB="$ENVIRONMENT/share/proj"
export HDF5_USE_FILE_LOCKING=FALSE 

BASE_DIR="/work/FAC/FGSE/IDYST/tbeucler/downscaling"

cd "$BASE_DIR" || { echo "failed to cd into base dir"; exit 1; }

mkdir -p "$BASE_DIR/sasthana/Downscaling/COSMO_RGG/COSMO/COSMO_pgw"


cdo sellonlatbox,-10,30,35,70 -selname,T_2M \
    -cat "/reference/FGSE/climate_simulations/cosmo6_2km_climate_PGW_MPI_HR/1h_2D/*.nz" \
    "$BASE_DIR/sasthana/Downscaling/COSMO_RGG/COSMO/COSMO_pgw/COSMO_t2m_pgw_europe.nc"

cdo sellonlatbox,-10,30,35,70 -daysum \
    -selname,TOT_PREC \
    -cat "/reference/FGSE/climate_simulations/cosmo6_2km_climate_PGW_MPI_HR/5min_2D/*.nz" \
    "$BASE_DIR/sasthana/Downscaling/COSMO_RGG/COSMO/COSMO_pgw/COSMO_totprec_daily_pgw_europe.nc"