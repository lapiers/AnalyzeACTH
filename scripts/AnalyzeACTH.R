## BTEC330 Park Project2

## Install necessary packages

install.packages("ggplot2")
library(ggplot2)

## Read data
IBS1 <- read.csv("data/RobinsonEtAl_Sup1.csv", header = TRUE)
head(IBS1)
write.csv(IBS1, "data_output/output.csv")


IBS1$ACTH_result <- "NA"

## Assign "HIGH", "NORMAL", or "LOW" based on clinical range to the LDH_result parameter
##https://www.uptodate.com/contents/measurement-of-acth-crh-and-other-hypothalamic-and-pituitary-peptides

IBS1$ACTH_result[IBS1$ACTH > 60] <- "HIGH"

IBS1$ACTH_result[IBS1$ACTH <= 60 & IBS1$ACTH >= 10] <- "NORMAL"

IBS1$ACTH_result[IBS1$ACTH < 10] <- "LOW"

write.csv(IBS1, "data_output/ACTH_result.csv")

##  Single Regressions for BMI vs. ACTH
##  Data was obtained from Robinson, et al. 2019 (doi: https://doi.org/10.1101/608208)
##  https://statquest.org/2017/10/30/statquest-multiple-regression-in-r/
##  http://www.sthda.com/english/articles/40-regression-analysis/167-simple-linear-regression-in-r/
##  http://r-statistics.co/Linear-Regression.html

## Single Regression Test
ACTH.regression <- lm(BMI ~ ACTH, data=IBS1)
summary(ACTH.regression)

## Output the results to a file
## http://www.cookbook-r.com/Data_input_and_output/Writing_text_and_output_from_analyses_to_a_file/
sink('data_output/ACTH_regression.txt', append = TRUE)
print(ACTH.regression)
sink()

## ANOVA: IBS-subtype vs. Bloodwork parameter
## http://www.sthda.com/english/wiki/one-way-anova-test-in-r
ACTH.aov <- aov(ACTH ~ IBS.subtype, data = IBS1)
summary(ACTH.aov)
sink('data_output/ACTH_anova.txt', append = TRUE)
print(ACTH.aov)
sink()

## Scatterplots
## https://www.statmethods.net/graphs/scatterplot.html

ggplot(IBS1, aes(x=BMI, y=ACTH)) +
  geom_point() +    
  geom_smooth(method=lm) 

png("fig_output/ACTH_scatterplot.png")
ACTH_scatterplot <- ggplot(IBS1, aes(x = BMI, y = ACTH)) +
  geom_point() +    
  geom_smooth(method = lm) 

print(ACTH_scatterplot)
dev.off()

## Box plots
## https://www.statmethods.net/graphs/boxplot.html

png("fig_output/ACTH_boxplot.png")
ACTH_boxplot <- boxplot(ACTH ~ IBS.subtype, data = IBS1, main="ACTH by IBS subtype", 
                       xlab = "IBS.subtype", ylab = "ACTH"
)
print(ACTH_boxplot)
dev.off()


boxplot(ACTH ~ IBS.subtype, data = IBS1, main="ACTH by IBS subtype", 
        xlab = "IBS.subtype", ylab = "ACTH"
)

## 3D scatterplot for the most significant 3-variable multiple regression model
## http://www.sthda.com/english/wiki/scatterplot3d-3d-graphics-r-software-and-data-visualization

s3d <- scatterplot3d(IBS$BMI, IBS$SerumCortisol, IBS$CRP,  pch=16, color="steelblue", box="TRUE", highlight.3d=FALSE, type="h", main="BMI x Cortisol x CRP")
fit <- lm(SerumCortisol ~ BMI + CRP, data=IBS)
s3d$plane3d(fit)
