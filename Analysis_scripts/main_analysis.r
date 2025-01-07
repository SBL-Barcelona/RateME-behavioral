library(mediation)
library(emmeans)
library(quantreg)
source("RateME-behavioral/Analysis_scripts/plots.R")
mediate <- mediation::mediate


### Load data file

file_whole <- "/home/luisman/Escritorio/Polex/Clean_whole_dataset.csv"
data <- read.csv(file_whole, sep = ",")


## Needs Satisfaction Personals

personal_condition <- c("personal", "personal_cyb")

for (cond in personal_condition) {

    data_pers <- filter(data, condition == cond)

    fit <- lm(bscmMean ~ group,
        data = data_pers, na.action = na.omit)
    sum <- summary(fit)

    coef <- data.frame(sum$coefficients)
    coef[2, c(1, 3)] <- -coef[2, c(1, 3)]
    coef$d <- 2 * sum$coefficients[, 3] / sqrt(sum$df[2])
    coef$ci_low <- coef$Estimate - coef$Std..Error * qnorm(0.99)
    coef$ci_high <- coef$Estimate + coef$Std..Error * qnorm(0.99)

    if (cond == "_cyb") {
        fname <- "/bscm_cyberball.csv"
    } else {
        fname <- "/bscm_ratemePersonal.csv"
    }

    #write.csv(coef, fname)
    plot_personal_bscm(data_pers)

}


## Needs Satisfaction Political

data_political <- filter(data, condition == "political")
fit <- lm(bscmMean ~ group * IF_UkMe,
    data = data_political, na.action = na.omit)
sum <- summary(fit)

coef <- data.frame(sum$coefficients)
coef[2, c(1, 3)] <- -coef[2, c(1, 3)]
coef[7, c(1, 3)] <- -coef[7, c(1, 3)]
coef$d <- 2 * sum$coefficients[, 3] / sqrt(sum$df[2])
coef$ci_low <- coef$Estimate - coef$Std..Error * qnorm(0.99)
coef$ci_high <- coef$Estimate + coef$Std..Error * qnorm(0.99)

fname <- "/bscm_ratemePolitical.csv"
#write.csv(coef, fname)
plot_political_bscm(data_political)


### Needs Satisfaction Whole Sample

fit <- lm(bscmMean ~ group * condition,
    data = data, na.action = na.omit)
sum <- summary(fit)

coef <- data.frame(sum$coefficients)
coef[2, c(1, 3)] <- -coef[2, c(1, 3)]
coef$d <- 2 * sum$coefficients[, 3] / sqrt(sum$df[2])
coef$ci_low <- coef$Estimate - coef$Std..Error * qnorm(0.99)
coef$ci_high <- coef$Estimate + coef$Std..Error * qnorm(0.99)

fname <- "/bscm_ratemeWhole.csv"
#write.csv(coef, fname)
plot_whole_bscm(data)

### Post-hoc analysis

pairs(contrast(emmeans(fit, ~group | condition),
    interaction = "pairwise"), by = NULL)
pairs(emmeans(fit, ~condition), by = NULL)
eff_size(emmeans(fit, ~condition),
    sigma = sigma(fit), edf = fit$df.residual)


### Needs Satisfaction Subscales

bscm_vars <- c("bscmControl", "bscmSelfEsteem",
        "bscmBelong", "bscmMeaningExist")

for (depVar in bscm_vars) {

    form <- paste(depVar, "~",
        "group * condition")
    fit <- lm(form, data = data, na.action = na.omit)
    sum <- summary(fit)

    coef <- data.frame(sum$coefficients)
    coef[2, c(1, 3)] <- -coef[2, c(1, 3)]
    coef$d <- 2 * sum$coefficients[, 3] / sqrt(sum$df[2])
    coef$ci_low <- coef$Estimate - coef$Std..Error * qnorm(0.99)
    coef$ci_high <- coef$Estimate + coef$Std..Error * qnorm(0.99)

    print(coef)

    varName <- switch(depVar, "bscmControl" = "Control",
        "bscmSelfEsteem" = "Self-esteem", "bscmBelong" = "Belongniness",
        "bscmMeaningExist" = "Meaningful existence")

    fname <- paste(varName, "csv", sep = ".")
    #write.csv(coef, fname)

}

cond <- c("personal_cyb", "personal", "political")
plot_multiple_effects(data, bscm_vars, cond)


## State Hostility Personals

for (cond in personal_condition) {

    data_pers <- filter(data, condition == cond)

    fit <- glm(shosMedian ~ group, data = data_pers,
        na.action = na.omit, family = "poisson")
    sum <- summary(fit)

    coef <- data.frame(sum$coefficients)
    coef$ci_low <- coef$Estimate - coef$Std..Error * qnorm(0.99)
    coef$ci_high <- coef$Estimate + coef$Std..Error * qnorm(0.99)

    if (cond == "_cyb") {
        fname <- "/shos_cyberball.csv"
    } else {
        fname <- "/shos_ratemePersonal.csv"
    }

    #write.csv(coef, fname)
    plot_personal_shos(data_pers)

}


### State Hostility Political

fit <- glm(round(shosMedian) ~ group, data = data_political,
    na.action = na.omit, family = "poisson")
sum <- summary(fit)


coef <- data.frame(sum$coefficients)
coef$ci_low <- coef$Estimate - coef$Std..Error * qnorm(0.99)
coef$ci_high <- coef$Estimate + coef$Std..Error * qnorm(0.99)

fname <- "/shos_ratemePolitical.csv"
#write.csv(coef, fname)
plot_political_shos(data_political)


## State Hostility Whole

fit <- glm(round(shosMedian) ~ group * condition, data = data,
    na.action = na.omit, family = "poisson")

pairs(contrast(emmeans(fit, ~group | condition),
    interaction = "pairwise"), by = NULL)
pairs(emmeans(fit, ~condition), by = NULL)
eff_size(emmeans(fit, ~condition),
    sigma = sigma(fit), edf = fit$df.residual)

sum <- summary(fit)
coef <- data.frame(sum$coefficients)
coef$rr <- exp(-coef)
coef$ci_low <- coef$Estimate - coef$Std..Error * qnorm(0.99)
coef$ci_high <- coef$Estimate + coef$Std..Error * qnorm(0.99)
print(coef)

fname <- "/bscm_ratemeWhole.csv"
#write.csv(coef, fname)
plot_whole_shos(data)

### State Hostility subscales

shos_vars <- c("shosEmotion", "shosAction")

for (depVar in shos_vars) {

    form <- paste(depVar, "~",
        "group * condition")
    fit <- glm(form, data = data, na.action = na.omit, family = "poisson")
    sum <- summary(fit)

    coef <- data.frame(sum$coefficients)
    coef[2, c(1, 3)] <- -coef[2, c(1, 3)]
    coef$d <- 2 * sum$coefficients[, 3] / sqrt(sum$df[2])
    coef$ci_low <- coef$Estimate - coef$Std..Error * qnorm(0.99)
    coef$ci_high <- coef$Estimate + coef$Std..Error * qnorm(0.99)

    varName <- switch(depVar, "shosEmotion" = "Emotional Hostility",
        "shosAction" = "Action Hostility")

    fname <- paste(varName, "csv", sep = ".")
    #write.csv(coef, fname)

}

cond <- c("personal_cyb", "personal", "political")
plot_multiple_effects(data, shos_vars, cond)


### Intergroup Attitudes Psychological Needs model

dep_vars <- c("arisRadMean", "arisActMean", "colNarcissMean",
    "outThreat1Mean", "outThreat2Mean", "physForm_uk", "spirForm_uk",
    "costlySac")

for (depVar in dep_vars) {

    form <- paste(depVar, "~",
        "bscmMean * group + condition + IF_UkMe +
        IF_EurMe + age + factor(gender)")

    fit <- rq(form, data = data, na.action = na.omit, tau = 0.5)
    sum <- summary(fit, se = "boot", R = 1000)

    p <- pairs(contrast(emmeans(fit, ~bscmMean | group, data = data),
        interaction = "pairwise"), by = NULL)

    coef <- data.frame(sum$coefficients)
    coef$ci_low <- coef$Value - coef$Std..Error * qnorm(0.99)
    coef$ci_high <- coef$Value + coef$Std..Error * qnorm(0.99)

    print(depVar)
    print(coef)

    fname <- file.path("/",
        paste("bscm_", depVar, ".csv", sep = ""))
    write.csv(coef, fname)

}

create_political_table(data, dep_vars, "bscmMean")
create_political_table(data, dep_vars, "shosMedian")

dep_vars <- c("arisRadMean", "arisActMean", "colNarcissMean",
    "outThreat1Mean", "outThreat2Mean")
plot_multiple_scales(data, dep_vars, "bscmMean")



### Intergroup Attitudes State Hostility model

personalCondition <- c("personal", "personal_cyb")

dep_vars <- c("arisRadMean", "arisActMean", "colNarcissMean",
    "outThreat1Mean", "outThreat2Mean", "physForm_uk", "spirForm_uk")

for (depVar in dep_vars) {

    form <- paste(depVar, "~",
        "shosMean * group + condition + IF_UkMe +
        IF_EurMe + age + factor(gender)")

    fit <- rq(form, data = data, na.action = na.omit, tau = 0.5)
    sum <- summary(fit, se = "boot", R = 5000)

    p <- pairs(contrast(emmeans(fit, ~shosMean | group, data = data),
        interaction = "pairwise"), by = NULL)

    coef <- data.frame(sum$coefficients)
    coef$ci_low <- coef$Value - coef$Std..Error * qnorm(0.99)
    coef$ci_high <- coef$Value + coef$Std..Error * qnorm(0.99)

    fname <- file.path("/",
        paste("shosMean_", depVar, ".csv", sep = ""))
    write.csv(coef, fname)

}

dep_vars <- c("arisRadMean", "arisActMean", "colNarcissMean",
    "outThreat1Mean", "outThreat2Mean")
plot_multiple_scales(data, dep_vars, "shosMean")