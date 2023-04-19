# Transform-Index-Prediction-based-on-FCNN

## Overview

## About the code

In [**Matlab_code**](https://github.com/AlessandroGnutti/Transform-index-Prediction-based-on-FCNN/tree/main/Matlab_code) you can find the Matlab code for generating the [**Dataset**](https://github.com/AlessandroGnutti/Transform-index-Prediction-based-on-FCNN/tree/main/Dataset), which is composed by the quantized transform coefficients blocks (```Xq_QPXX.mat```), the graph index labels (```y_QPXX.mat```) and the prediction mode labels (```predModes_QPXX.mat```).

## Models and results

In [**Results**](https://github.com/AlessandroGnutti/Transform-Index-Prediction-based-on-FCNN/tree/main/Results) you can find the confusion matrices and the top-k accuracies for each dataset (with and without prediction mode for residuals).

In [**Models**](https://github.com/AlessandroGnutti/Transform-Index-Prediction-based-on-FCNN/tree/main/Models) you can find the trained models for each dataset (with and without prediction mode for residuals).

In [**Architectures_figures**](https://github.com/AlessandroGnutti/Transform-Index-Prediction-based-on-FCNN/tree/main/Architectures_figures) you can find the illustration of the model architectures for each dataset.

## Preliminary results on comparison between SBGFTs and Explicit MTS (VVC)

In [**Extended-results**](https://github.com/AlessandroGnutti/Transform-index-Prediction-based-on-FCNN/tree/main/Extended-results) you can find the Matlab code for generating a preliminary comparison between SBGFTs and explicit Multiple Transform Selection (MTS) adopted in VVC. Run ```main_fixedSize_residuals_H2666.m``` for producing the results associated with MTS (that is ```ResultsResiduals8x8_MTS.mat```) and ```main_fixedSize_residuals.m``` for producing the results associated with SBGFTs (that is ```ResultsResiduals8x8_SBGFT.mat```). ```myplot_residuals.m``` plots the RD curves.

A bug was fixed, now the curves are updated and correct.


## Contacts

For any information, please send an email to alessandro.gnutti@unibs.it


