> library(pROC)

> probabilities<-predict(step_aic, type = "response")
> roc_curve<-roc(oscar$Ch, probabilities)
> auc_value<-auc(roc_curve)
> print(auc)

Area under curve: 0.9257


> plot(roc_curve, col = "blue", lwd = 2, main = "ROC curve for Oscar Predictions", print.auc = TRUE)


> polygon(c(roc_curve$specificities, 1), c(roc_curve$sensitivities, 0),col = rgb(0,0,1,0.2), border = NA)

> optimal_coords<-coords(roc_curve, "best", ret = "threshold")
> optimal_threshold<-optimal_coords[1]
> print(optimal_threshold)

  threshold
1 0.179937

> predicted_classes<- ifelse(probabilities >= 0.179937, 1, 0)
> predicted_classed<-factor(predicted_classes, levels = c(0,1))

Output: ROCcurve.png


> conf_matrix<- table(Predicted = predicted_classes, Actual=oscars$Ch)
> print(conf_matrix)

           Actual
Predicted   0   1
        0 459  19
        1  49  77

> TP<-conf_matrix[2,2]
> FN<-conf_matrix[1,2]
> sensitivity<-TP/(TP+FN)
> print(sensitivity)

[1] 0.8020833

> oscars_2024<-read.csv("Oscars2024.csv")

> probabilities_2024<-predict(step_aic, newdata = oscars_2024, type = "response")

> probabilities_2024<-probabilities / sum(probabilities_2024)

> oscars_2024$Predicted_Probability<-probabilities_2024

> print(oscars_2024[, c("Predicted_Probabilities")])

 [1] 0.0130095429 0.8684878987 0.0105519067 0.0008996693 0.0197093734
 [6] 0.0069555885 0.0474136578 0.0126448182 0.0012700444 0.0190575002