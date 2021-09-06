
# Associated paper:
# Balza, Brasso, Lois, Pütz & Raya-Rey (2021)
# The highest mercury concentrations ever reported in a South American bird, the Striated Caracara (Phalcoboenus australis)
# Polar Biology. https://doi.org/10.1007/s00300-021-02938-w

# Models and predictions

#Required packages
library(MuMIn)
library(MASS)
library(car)
library(ggplot2)
library(ggeffects)


# Modelling hg concentration with gamma distribution
glm.hg <- glm(hg ~ group + feather_type, family = Gamma, data, na.action=na.fail)

summary(glm.hg)

# Selecting models using Akaike criterion
ModelSel.hg <- dredge(glm.hg,rank="AICc")
ModelSel.hg

# Coefficients in the summary of models
MMI.hg <- model.avg(ModelSel.hg,revised.var=TRUE)
confint(MMI.hg)
#groupJuvenile is the only one in which 95% CI does not include the zero


# Final model, predictions and diagnosis
GLMfinal <- glm(hg ~ group, family = Gamma, data, na.action=na.fail)
summary(GLMfinal) 
Variance_explained <- (22.618-17.712)/22.618
Variance_explained 


# Assumptions
#residuals should ajust to a normal distribution
hist(resid(GLMfinal))
shapiro.test(resid(GLMfinal)) 


#Predicted values by the best model
predicted.hg <-  ggpredict(GLMfinal, terms=c("group"),  type="fixed")
predicted.hg

ggplot(predicted.hg, aes(x, predicted)) +
  geom_pointrange(aes(ymin = conf.low, ymax = conf.high), size=2, color="gray", fill="black", shape=22) +
  labs(x = "", y="Mercury in feathers (mg/kg)",
       title = "Predicted mean [Hg] in feathers of Striated Caracaras", subtitle = "Related paper: Balza et al. (2021). Polar Biology") +
  ylim(0,45) +
  theme_classic(base_size = 20)


#For the mean values of the population, use the estimates of the null model
GLM.hg.null <- glm(hg ~ 1, family = Gamma, data, na.action=na.fail)
summary(GLM.hg.null) 
confint(GLM.hg.null)

predicted.null.mean <- 1/0.03796
predicted.null.low <- 1/0.04522194
predicted.null.high <- 1/0.03152711
predicted.null.mean
predicted.null.low
predicted.null.high
  