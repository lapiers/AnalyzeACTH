## AnalyzeACTH
### Single and multiple regressions, and scatterplots for clinical bloodwork and gene expression data.
([AnalyzeACTH.R](../AnalyzeACTH-master/scripts/AnalyzeACTH.R)) will allow you to load a RobinsonEtAl_Sup1 .csv with various datapoints, perform single regressions of Body Mass Index (BMI) vs. ACTH from the Complete Blood Count with Differential (CBC-D) results, and produce 2-D scatterplots and boxplots for the results. 




## Normal range og ACTH
Adults normally have ACTH levels of 10-50 pg/ml at 8 a.m. The number drops to below 5-10 pg/ml at midnight.
```


```
## Install necessary packages

> install.packages("ggplot2")
> library(ggplot2)
```


```
## Read data
> IBS1 <- read.csv("data/RobinsonEtAl_Sup1.csv", header = TRUE)
> head(IBS1)
> write.csv(IBS1, "data_output/output.csv")


> IBS1$ACTH_result <- "NA"
```

```
## Assign "HIGH", "NORMAL", or "LOW" based on clinical range to the LDH_result parameter
##https://www.uptodate.com/contents/measurement-of-acth-crh-and-other-hypothalamic-and-pituitary-peptides

> IBS1$ACTH_result[IBS1$ACTH > 60] <- "HIGH"

> IBS1$ACTH_result[IBS1$ACTH <= 60 & IBS1$ACTH >= 10] <- "NORMAL"

> IBS1$ACTH_result[IBS1$ACTH < 10] <- "LOW"

> write.csv(IBS1, "data_output/ACTH_result.csv")
```
```

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


## Single Regression Test
ACTH.regression <- lm(BMI ~ ACTH, data=IBS1)
summary(ACTH.regression)
```

```
## Output the results to a file
## http://www.cookbook-r.com/Data_input_and_output/Writing_text_and_output_from_analyses_to_a_file/
sink('data_output/ACTH_regression.txt', append = TRUE)
print(ACTH.regression)
sink()

```
```
##
## ANOVA: IBS-subtype vs. Bloodwork parameter
```
> ACTH.aov <- aov(ACTH ~ IBS.subtype, data = IBS1)
> summary(ACTH.aov)
> sink('data_output/ACTH_anova.txt', append = TRUE)
> print(ACTH.aov)
> sink()

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

![ACTH_scatterplot](../master/fig_output/ACTH_scatterplot.png?sanitize=true)

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

```
![ACTH_boxplot](../master/fig_output/ACTH_boxplot.png?sanitize=true)
