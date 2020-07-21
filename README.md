# Populating sub repository

This repository contain **3 nested repos**, with some clever dirty tricks.

Before anything would work, run
```sh
make
```
to populate all of the nested repositories, or
```sh
make clean
```
to cleanup and revert the previous operation.

Run
```sh
make weight-files
```
to download and extracts the flow-based distribution trained weights into `normalising-flow-distribution/`.


## Generating runtime stats

- Folder:  `GenerateStats/`

- Run
  
  ```shell
  python main.py
  ```
  
  which would run 3 random maps, for 3 pairs of <img src="https://render.githubusercontent.com/render/math?math=q_\text{init},q_\text{goal}"> and for 3 times.

- Use `git checkout {2,4,6}d`  to go to the specific branch for the desire dimensions, eg. `git checkout 2d` for generating stats for **2d**.



## Learning <img src="https://render.githubusercontent.com/render/math?math=\mathcal{Q}_\theta"> and visualising results

- Folder: `normalising-flow-distribution/`



## Generating random environments <img src="https://render.githubusercontent.com/render/math?math=\omega">

- Folder: `path_dataset_generator/`
