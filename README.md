# FEABUS_Compute_Canada

**EM Stitching and Alignment on Compute Canada Clusters**

## Overview

[FEABUS](https://github.com/YuelongWu/feabas) is a powerful pipeline designed for electron microscopy (EM) volume reconstruction via stitching and alignment of raw 2D tiles. This repository provides a practical guide to running FEABUS efficiently on Compute Canada’s high-performance computing clusters. It includes examples of directory organization, image placement, and a workflow for parallel processing of large datasets.

## Setup on Compute Canada

### 1. Clone the FEABUS Repository

Start by cloning the official FEABUS repository into your working directory:

```bash
git clone https://github.com/YuelongWu/feabas.git
```

### 2. Prepare the Environment

A sample `run.slurm` file is provided to set up the necessary Python environment and dependencies on Compute Canada. Make sure the following files are placed in the FEABUS root directory:
- `requirements.txt`
- Pre-built `triangle` wheel (`.whl`) file

Then, submit the job to the scheduler:

```bash
sbatch run.slurm
```

## Running FEABUS on the Cluster

Follow the FEABUS instructions carefully, but with an important note: for each SLURM script you submit, ensure that the `srun` command matches the specific processing step you're executing.

For example, to run the alignment rendering step:

```bash
srun python /home/codee/scratch/feabas/scripts/align_main.py --mode rendering
```

Make sure to change the mode (`--mode`) appropriately for each processing stage (e.g., `matching`, `optimization`, `rendering`).

## Rendering Notes and Troubleshooting

In some cases, rendering may not execute correctly if leftover files from previous runs are present. To avoid this issue:

1. After alignment optimization and **before** any rendering step, run the normalization script:

   ```bash
   python tools/normalize_aligned_meshes.py
   ```

2. If corrections are made (e.g., new matches or transformations), delete any previously generated intermediate files (`matches`, `tforms`, etc.).  
   FEABUS skips computation if it detects these files, assuming the step is already complete.

## Using Multiple Nodes on the Cluster

To accelerate the stitching and alignment process, you can leverage multiple nodes and CPUs when submitting jobs on Compute Canada.

Here is an example using SLURM job arrays with `srun python`:

```bash
#SBATCH --array=0-100  # Adjust this range based on the number of jobs required (e.g., 101 jobs)
srun python /home/codee/scratch/feabas/scripts/thumbnail_main.py --mode match --start $start --stop $stop --step 1
```
