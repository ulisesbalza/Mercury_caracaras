rm(list=ls())

# Associated paper:
# Balza, Brasso, Lois, Pütz & Raya-Rey (2021)
# The highest mercury concentrations ever reported in a South American bird, the Striated Caracara (Phalcoboenus australis)
# Polar Biology. https://doi.org/10.1007/s00300-021-02938-w

#Required packages

# Loading data 
data <- read.csv ("input/caracara_hg_database_final.csv", sep=";")
head(data) #Hg concentrations are in ppm or mg/kg


#Data exploration

#histogram
hist(data$hg)

#Mean values/group
tapply(data$hg, data$group, mean)
tapply(data$hg, data$feather_type, mean)

# Descriptive plots
plot(data$hg ~ data$group, pch=19, xlab="", ylab="Mercury concentration (mg/kg)")
plot(data$hg ~ data$feather_type, pch=19, xlab="Feather type", ylab="Mercury concentration (mg/kg)")

