# FEABUS_Compute_Canada
EM stitch and alignment on compute canada server

## Overview
FEABUS (https://github.com/YuelongWu/feabas) is a very useful pipeline to realize the EM volume reconstruction by stitch and alignment from the 2d raw tiles. To make it possible to run on the clusters in Compute Canada, I listed a comprehensive pipeline where it could be referred on to use multiple computers running your large dataset alignment efficiently. 

## Set up Compute Canada environment
We need to first have the FEABUS repository cloned to the folder you will be working on:
```bash
git clone https://github.com/YuelongWu/feabas.git
```

I offered a run.slurm file as an example to set up all the python packages FEABUS requires. Note that we need to have the triangle wheel and the requirements.txt (I offered both) to the FEABUS respository first. And then use the command to upload the job to the server
```bash
sbatch run.slurm
```
## Following the instructions of FEABUS
We need to make sure that every time in the .slurm file you upload, we need to match the step we will be wroking on. e.g. when we are working on the alignment rendering step, we will need to make the "srun python" command to be:
```bash
srun python /home/codee/scratch/feabas/scripts/align_main.py --mode rendering
```
## Rendering issue
The rendering was not done in the same run and some old files came into the way (unlikely). To make sure this didn't happen, it is recommended to run tools/normalize_aligned_meshes.py after the alignment optimization but BEFORE any rendering is done.

We'll need to delete affected files (matches, tforms etc) when you made a correction. Otherwise if the program found the file, it would assume completion and skip the computation.
