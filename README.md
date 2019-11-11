## AnalyzeACTH
### Single and multiple regressions, and scatterplots for clinical bloodwork and gene expression data.
([AnalyzeACTH.R](../AnalyzeACTH-master/scripts/AnalyzeACTH.R)) will allow you to load a RobinsonEtAl_Sup1 .csv with various datapoints, perform single regressions of Body Mass Index (BMI) vs. ACTH from the Complete Blood Count with Differential (CBC-D) results, and produce 2-D scatterplots and boxplots for the results. 

Data (RobinsonEtAl_Sup1.csv) was downloaded from: 

Robinson, JM. et al. 2019. Complete blood count with differential: An effective diagnostic for IBS subtype in the context of BMI? BioRxiv. doi: https://doi.org/10.1101/608208.

##
### Results of ACTH regression, BMI x ACTH
```
> ACTH.regression <- lm(BMI ~ ACTH, data=IBS1)
> print(ACTH.regression)

Call:
lm(formula = BMI ~ ACTH, data = IBS1)

Coefficients:
(Intercept)         ACTH  
    25.5406       0.0661  
```
```
ggplot(IBS1, aes(x=BMI, y=ACTH)) +
  geom_point() +    
  geom_smooth(method=lm) 
```
##
### Results of single regression, BMI x C-Reactive Protein (CRP)
```
> ACTH.regression <- lm(BMI ~ CRP, data=IBS1)
> print(ACTH.regression)

Call:
lm(formula = BMI ~ ACTH + CRP, data = IBS1)

Coefficients:
(Intercept)         ACTH  
    25.5406       0.0661  

```

![ACTH_scatterplot](lapiers/AnalyzeACTH-master/fig_output/ACTH_scatterplot.png?sanitize=true)
##
##
## Boxplots
```
> png("fig_output/ACTH_boxplot.png")
> ACTH_boxplot <- boxplot(ACTH ~ IBS.subtype, data = IBS1, main="ACTH by IBS subtype", 
                       xlab = "IBS.subtype", ylab = "ACTH"
)
> print(ACTH_boxplot)
> dev.off()


> boxplot(ACTH ~ IBS.subtype, data = IBS1, main="ACTH by IBS subtype", 
        xlab = "IBS.subtype", ylab = "ACTH"
)
