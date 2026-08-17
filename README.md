# Breast Cancer Classification Using K-Nearest Neighbors (KNN)

## Problem
Can we predict whether a breast tumor is benign or malignant using cell measurements alone? This matters because a fast, reliable second check on a diagnosis could help catch cancer cases that might otherwise be missed or delayed.

## Approach
- Used the Wisconsin Breast Cancer Diagnostic dataset (569 patients, 30 numeric features describing cell nuclei characteristics)
- Cleaned the data and removed a non-informative empty column introduced during CSV import
- Built and compared KNN classification models using two preprocessing methods: min-max normalization and z-score standardization
- Tested four k-values (1, 5, 21, 30) to evaluate how the choice of k affects model performance
- Evaluated each model using a cross-tabulation of predicted vs. actual diagnoses, focused specifically on false negatives (malignant cases predicted as benign), since this is the error type with the most serious real-world consequences

## Key Finding
Accuracy alone was misleading. k=21 and k=30 both scored a high 98% accuracy, but each missed 2 real malignant cases, classifying them as benign. k=5, despite a slightly lower 96% accuracy, caught every single malignant case in the test set (0 false negatives), at the cost of 4 false positives (benign cases flagged for unnecessary follow-up).

In a medical screening context, a missed cancer diagnosis is far more costly than an unnecessary follow-up test. k=5 was selected as the better model despite not having the highest accuracy score, because it prioritizes patient safety over a marginally better headline number.

| k | Accuracy | False Negatives (missed cancer) | False Positives |
|---|---|---|---|
| 1 | 94% | 2 | 4 |
| 5 | 96% | 0 | 4 |
| 21 | 98% | 2 | 0 |
| 30 | 98% | 2 | 0 |

## Tools
R, class (KNN), gmodels (CrossTable), ggplot2

## Files
- `breast-cancer-knn-classification.R` — full analysis script
- `accuracy_by_k.png`, `false_negatives_by_k.png` — visual comparison across k-values
- Dataset: [Wisconsin Breast Cancer Diagnostic Dataset, UCI ML Repository](https://archive.ics.uci.edu/dataset/17/breast+cancer+wisconsin+diagnostic)
