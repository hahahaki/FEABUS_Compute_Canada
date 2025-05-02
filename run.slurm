#!/bin/bash
#SBATCH --nodes=1
#SBATCH --job-name=feabus
#SBATCH --cpus-per-task=24
#SBATCH --mem=127000M
#SBATCH --account=def-mzhen
#SBATCH --time=12:00:00
#SBATCH --output=/home/codee/scratch/feabas/small_project_whole/logs/align_match_%j_%N.txt

module load StdEnv/2023
module load python/3.10
module load cuda/12.2
module load gcc opencv/4.10.0
module load libspatialindex
virtualenv --no-download $SLURM_TMPDIR/env
source $SLURM_TMPDIR/env/bin/activate
pip install --no-index --upgrade pip
pip install --no-index -r /home/codee/scratch/feabas/requirements.txt
PYTHONPATH='' pip install --no-index /home/codee/scratch/feabas/triangle-20250106-cp310-cp310-manylinux_2_17_x86_64.manylinux2014_x86_64.whl
pip install --no-index -r /home/codee/scratch/feabas/requirements.txt
log_dir="/home/codee/scratch/feabas/small_project_whole/logs"

echo log_dir : `pwd`/$log_dir
mkdir -p `pwd`/$log_dir

echo "$SLURM_NODEID Launching python script"
echo "Job Array Index: $SLURM_ARRAY_TASK_ID"
echo "Processing range: start=$start, stop=$stop"
echo log_dir : `pwd`/$log_dir

# Calculate start and stop based on the job array index
start=$((SLURM_ARRAY_TASK_ID * 3))
stop=$((start + 3))

echo "start is $start end is $end"
#srun python /home/codee/scratch/feabas/scripts/stitch_main.py --mode rendering #> $log_dir/feabusstitch0118_$SLURM_ARRAY_TASK_ID
#srun python /home/codee/scratch/feabas/scripts/thumbnail_main.py --mode match --start $start --stop $stop --step 1 

#srun python /home/codee/scratch/feabas/scripts/align_main.py --mode downsample
# stitch match is 7min
#python /home/codee/scratch/feabas/scripts/stitch_main.py --mode optimization 1 min
#python /home/codee/scratch/feabas/scripts/stitch_main.py --mode rendering 0.5 min
#srun python /home/codee/scratch/feabas/scripts/thumbnail_main.py --mode downsample
#python /home/codee/scratch/feabas/scripts/thumbnail_main.py --mode match
#python /home/codee/scratch/feabas/scripts/align_main.py --mode meshing
#srun python /home/codee/scratch/feabas/scripts/align_main.py --mode matching
#srun python /home/codee/scratch/feabas/scripts/align_main.py --mode optimization
#srun python /home/codee/scratch/feabas/scripts/align_main.py --mode rendering
#srun python /home/codee/scratch/feabas/scripts/align_main.py --mode downsample
#SBATCH --array=0-100  # Adjust this range based on total intervals needed, 101 jobs in total
echo "done!!!!!!!"