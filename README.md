# A Symmetric Graph Transformation Framework for Image Compression

## Abstract

In this paper, a framework for image and video intra-frame coding able to effectively employ the multiple transform paradigm using Symmetry-Based Graph Fourier Transforms (SBGFTs) is proposed. As data representation relies heavily on the characteristics of signal classes in high dimensional spaces, over the years it has been understood that signal instances for a given class, e.g., images, typically lie on a manifold which is not a single linear subspace. Accordingly, standards for image/video compression have considered to introduce multiple representation models to encode the data, i.e., multiple linear block transforms. However, the advantages are currently limited typically due to implementation complexity and the high signaling cost of the representation mode. As a result, only a small set of alternative transforms is typically considered, which restricts the adaptation capabilities to the data. In this paper, we instead argue that it is feasible to incorporate into the image coding framework a large set of SBGFTs which can overcome the aforementioned drawbacks. Specifically, we demonstrate the ability to derive the block encoding transform index from the quantization pattern fingerprint using a Multilayer Perceptron (MLP) architecture, achieving prediction with high confidence, surpassing 80% for 4-top accuracy. This translates into a more efficient entropy coding strategy for the index, allowing to save on the average more than 3 bits per block. These experimental results highlight the significant benefits of SBGFTs for multiple transform coding, particularly when combined with the proposed MLP based index prediction, with only a limited increase in computational complexity.

## About the code

In [**Matlab_code**](https://github.com/AlessandroGnutti/Transform-index-Prediction-based-on-FCNN/tree/main/Matlab_code) you can find the Matlab code for generating the [**Dataset**](https://github.com/AlessandroGnutti/Transform-index-Prediction-based-on-FCNN/tree/main/Dataset), which is composed by the quantized transform coefficients blocks (```Xq_QPXX.mat```), the graph index labels (```y_QPXX.mat```) and the prediction mode labels (```predModes_QPXX.mat```).

## Models and results

In [**Results**](https://github.com/AlessandroGnutti/Transform-Index-Prediction-based-on-FCNN/tree/main/Results) you can find the confusion matrices and the top-k accuracies for each dataset (with and without prediction mode for residuals).

In [**Models**](https://github.com/AlessandroGnutti/Transform-Index-Prediction-based-on-FCNN/tree/main/Models) you can find the trained models for each dataset (with and without prediction mode for residuals).

In [**Architectures_figures**](https://github.com/AlessandroGnutti/Transform-Index-Prediction-based-on-FCNN/tree/main/Architectures_figures) you can find the illustration of the model architectures for each dataset.

## Preliminary results on comparison between SBGFTs and Explicit MTS (VVC)

In [**Extended-results**](https://github.com/AlessandroGnutti/Transform-index-Prediction-based-on-FCNN/tree/main/Extended-results) you can find the Matlab code for generating a preliminary comparison between SBGFTs and explicit Multiple Transform Selection (MTS) adopted in VVC. Run ```main_fixedSize_residuals_H2666.m``` for producing the results associated with MTS (that is ```ResultsResiduals8x8_MTS.mat```) and ```main_fixedSize_residuals.m``` for producing the results associated with SBGFTs (that is ```ResultsResiduals8x8_SBGFT.mat```). ```myplot_residuals.m``` plots the RD curves.

## Citation

If you use this code in your work, please consider citing the following paper:

```
@ARTICLE{10577960,
  author={Gnutti, Alessandro and Guerrini, Fabrizio and Leonardi, Riccardo},
  journal={IEEE Access}, 
  title={A Symmetric Graph Transformation Framework for Image Compression}, 
  year={2024},
  volume={12},
  number={},
  pages={90738-90749},
  keywords={Transforms;Image coding;Indexes;Discrete cosine transforms;Transform coding;Encoding;Standards;Image coding;multiple transforms;symmetry-based graph Fourier transforms;H.266/VVC;mode prediction;quantization;neural network architectures;multilayer perceptron},
  doi={10.1109/ACCESS.2024.3421346}}
```


## Contacts

For any information, please send an email to alessandro.gnutti@unibs.it


