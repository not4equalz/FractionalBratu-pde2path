# Numerical Bifurcation Analysis of Fractional Bratu-Picard Models

This repository contains the code used for my master's thesis, *Numerical Bifurcation Analysis of Fractional Bratu-Picard Models*.

It contains a folder with the base code required to run the models in **pde2path**, together with a folder containing the code used to generate the figures presented in the thesis.

Most of the code is split into sections corresponding to the different models, numerical experiments, and figures.

The code includes an implementation of the spectral fractional Laplacian based on "Numerical continuation for fractional PDEs: sharp teeth and bloated snakes" by Ehstand et al.

## System Requirements / Recommendations

### Required

* MATLAB R2025a (confirmed working) with the following add-ons:

  * Partial Differential Equation Toolbox
  * Symbolic Math Toolbox
* A copy of pde2path V3.2. No additional pde2path packages or libraries are required.

### Recommended

* Adding `setpde2path.m` to your `startup.m` MATLAB file.
* Using either Windows 11 or Linux. The code has not been tested on macOS.

## References

The numerical continuation computations in this repository are performed using **pde2path**:

> **pde2path – a MATLAB package for continuation and bifurcation in systems of PDEs**, Version 3.2, 2025.
> https://pde2path.uol.de/

The implementation of the spectral fractional Laplacian is based on the numerical method described in:

> N. Ehstand, C. Kuehn, and C. Soresina,
> **“Numerical continuation for fractional PDEs: sharp teeth and bloated snakes,”**
> *Communications in Nonlinear Science and Numerical Simulation*, vol. 98, 105762, 2021.
> DOI: https://doi.org/10.1016/j.cnsns.2021.105762

If you use this code in your research, please cite the corresponding master's thesis:

> van de Weerd, N. (2026). *Numerical Bifurcation Analysis of Fractional Bratu-Picard Models*. Master's thesis, Utrecht University.  
> https://studenttheses.uu.nl/handle/20.500.12932/53015 
