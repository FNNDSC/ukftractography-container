# UKFTractography Container

This repository provides a container image for:

- [UKFTractography](https://github.com/pnlbwh/ukftractography)
- Slicer 4 (revision 28257)
- [whitematteranalysis @ commit 9d24e5e](https://github.com/SlicerDMRI/whitematteranalysis/tree/9d24e5e832ceb02ef0fce47f1089774e8e47d407) using Python 2.7

## Usage: `UKFTractography`

```shell
apptainer exec docker://docker.io/fnndsc/ukftractography:latest Slicer --launch UKFTractography
```

### Usage: `wm_harden_transform.py`

> [!WARNING]  
> `wm_harden_transform.py` opens `Slicer` which requires an X server, even though no window is shown.

```shell
apptainer exec docker://docker.io/fnndsc/ukftractography:latest wm_harden_transform.py -t ... ... ... /opt/Slicer-4.10.2/Slicer
```
