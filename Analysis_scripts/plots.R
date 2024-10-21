library(matrixStats)
library(ggplot2)
library(quantreg)
library(dplyr)
library(gt)
library(emmeans)


plot_personal_bscm <- function(data) {

    ### Do first fit only with confounding factors (age and gender)

    fit <- lm(bscmMean ~ factor(gender) + age, data = data, na.action = na.omit)

    ### Remove variance related to confounding factors by keeping residuals + intercept

    if (length(fit$na.action) != 0) {
        data2 <- data.frame(bscmMean = (fit$residuals + fit$coefficients[1]),
            group = data$group[-fit$na.action])
    } else {
        data2 <- data.frame(bscmMean = (fit$residuals + fit$coefficients[1]),
            group = data$group)
    }

    ### Fit linear model with clean variable and factor of interest

    fit <- lm(bscmMean ~ group, data = data, na.action = na.omit)

    ### Create mean and CI data frame for plot

    data_dummy <- data.frame(group = c("exclusion", "inclusion"))
    pred <- predict(fit, data_dummy, interval = "confidence", level = 0.99)
    data_dummy$bscmMean <- pred[, 1]
    data_dummy$se <- pred[, 3] - pred[, 1]


    ### Plot function

    ggplot(NULL, aes(x = group, y = bscmMean)) +
        geom_violin(aes(color = group), position = position_dodge(width = 0.9),
            data = data2, fill = "#ECECEC") +
        geom_point(position = position_jitterdodge(dodge.width = 0.9,
                jitter.width = 0.25),
            aes(color = group, fill = group),
            data = data2, size = 5, alpha = 0.5, shape = 21) +
            ylim(1, 5) +
        geom_pointrange(data = data_dummy,
            aes(ymax = bscmMean + se, ymin = bscmMean - se, color = group),
            position = position_dodge2(width = 0.9),
            size = 1.8, lwd = 2.5) +
        theme_classic() +
        scale_fill_manual(values = c("#CC79A7", "#56B4E9"), guide = "none") +
        scale_color_manual(values = c("#6b3c55", "#2e6889"),
            labels = c("Exclusion", "Inclusion"), name = "") +
        theme(axis.text.x = element_text(family = "Helvetica",
                size = 30, face = "bold"),
            axis.text.y = element_text(family = "Helvetica",
                size = 30, face = "bold"),
            axis.title.x = element_text(family = "Helvetica",
                size = 35, face = "bold"),
            axis.title.y = element_text(family = "Helvetica",
                size = 35, face = "bold"),
            axis.line = element_line(linewidth = 1),
            legend.key.size = unit(2, "cm"),
            legend.text = element_text(family = "Helvetica", size = 20)) +
        scale_x_discrete(labels = c("TRUE" = "\nExlusion",
                "FALSE" = "\nInclusion")) +
        labs(
            x = "",
            y = "Psychological Needs\n",
        )

}


plot_political_bscm <- function(data) {

    ### Do first fit only with confounding factors (age and gender)

    fit <- lm(bscmMean ~ factor(gender) + age, data = data, na.action = na.omit)

    ### Remove variance related to confounding factors by keeping residuals + intercept

    data2 <- data.frame(bscmMean = (fit$residuals + fit$coefficients[1]),
        group = data$group[-fit$na.action],
        IF_UkMe = data$IF_UkMe[-fit$na.action])

    ### Fit linear model with clean variable and factor of interest

    fit <- lm(bscmMean ~ group * IF_UkMe, data = data, na.action = na.omit)

    ### Create mean and CI data frame for plot

    data_dummy <- data.frame(group = rep(c("exclusion", "inclusion"), 2),
        IF_UkMe = rep(c(TRUE, FALSE), each = 2))
    pred <- predict(fit, data_dummy, interval = "confidence", level = 0.99)

    data_dummy$bscmMean <- pred[, 1]
    data_dummy$se <- pred[, 3] - pred[, 1]


    ### Plot function

    ggplot(NULL, aes(x = IF_UkMe, y = bscmMean)) +
        geom_violin(aes(color = group), position = position_dodge(width = 0.9),
            data = data2, fill = "#ECECEC") +
        geom_point(position = position_jitterdodge(dodge.width = 0.9,
                jitter.width = 0.25),
            aes(color = group, fill = group),
            data = data2, size = 5, alpha = 0.5, shape = 21) +
            ylim(1, 5) +
        geom_pointrange(data = data_dummy,
            aes(ymax = bscmMean + se, ymin = bscmMean - se, color = group),
            position = position_dodge2(width = 0.9),
            size = 1.8, lwd = 2.5) +
        theme_classic() +
        scale_fill_manual(values = c("#CC79A7", "#56B4E9"), guide = "none") +
        scale_color_manual(values = c("#6b3c55", "#2e6889"),
            labels = c("Exclusion", "Inclusion"), name = "") +
        theme(axis.text.x = element_text(family = "Helvetica",
                size = 30, face = "bold"),
            axis.text.y = element_text(family = "Helvetica",
                size = 30, face = "bold"),
            axis.title.x = element_text(family = "Helvetica",
                size = 35, face = "bold"),
            axis.title.y = element_text(family = "Helvetica",
                size = 35, face = "bold"),
            axis.line = element_line(linewidth = 1),
            legend.key.size = unit(2, "cm"),
            legend.text = element_text(family = "Helvetica", size = 20)) +
        scale_x_discrete(labels = c("TRUE" = "\nFused",
                "FALSE" = "\nNon-Fused")) +
        labs(
            x = "",
            y = "Psychological Needs\n",
        )

}


plot_whole_bscm <- function(data) {

    ### Do first fit only with confounding factors (age and gender)

    fit <- lm(bscmMean ~ factor(gender) + age, data = data, na.action = na.omit)

    ### Remove variance related to confounding factors by keeping residuals + intercept

    data2 <- data.frame(bscmMean = (fit$residuals + fit$coefficients[1]),
        group = data$group[-fit$na.action], 
        condition = data$condition[-fit$na.action])

    ### Fit linear model with clean variable and factor of interest

    fit <- lm(bscmMean ~ group * condition, data = data, na.action = na.omit)

    ### Create mean and CI data frame for plot

    cond_order <- c("political", "personal", "personal_cyb")
    data_dummy <- data.frame(group = rep(c("exclusion", "inclusion"), 3),
        condition = rep(cond_order, 2))

    pred <- predict(fit, data_dummy, interval = "confidence", level = 0.99)

    data_dummy$bscmMean <- pred[, 1]
    data_dummy$se <- pred[, 3] - pred[, 1]


    ### Plot function

    ggplot(NULL, aes(x = factor(condition, level = cond_order), y = bscmMean)) +
        geom_violin(aes(color = group), position = position_dodge(width = 0.9),
            data = data2, fill = "#ECECEC") +
        geom_point(position = position_jitterdodge(dodge.width = 0.9,
                jitter.width = 0.25),
            aes(color = group, fill = group),
            data = data2, size = 5, alpha = 0.5, shape = 21) +
            ylim(1, 5) +
        geom_pointrange(data = data_dummy,
            aes(ymax = bscmMean + se, ymin = bscmMean - se, color = group),
            position = position_dodge2(width = 0.9),
            size = 1.8, lwd = 2.5) +
        theme_classic() +
        scale_fill_manual(values = c("#CC79A7", "#56B4E9"), guide = "none") +
        scale_color_manual(values = c("#6b3c55", "#2e6889"),
            labels = c("Exclusion", "Inclusion"), name = "") +
        theme(axis.text.x = element_text(family = "Helvetica",
                size = 30, face = "bold"),
            axis.text.y = element_text(family = "Helvetica",
                size = 30, face = "bold"),
            axis.title.x = element_text(family = "Helvetica",
                size = 35, face = "bold"),
            axis.title.y = element_text(family = "Helvetica",
                size = 35, face = "bold"),
            axis.line = element_line(linewidth = 1),
            legend.key.size = unit(2, "cm"),
            legend.text = element_text(family = "Helvetica", size = 20)) +
        scale_x_discrete(labels = c("personal" = "\nPersonal \n RateME",
                "personal_cyb" = "\nCyberball",
                "political" = "\nGroup \n RateME")) +
        labs(
            x = "",
            y = "Psychological Needs\n",
        )

}



plot_personal_shos <- function(data) {

    ### Do first fit only with confounding factors (age and gender)

    fit <- glm(round(shosMedian) ~ factor(gender) + age, data = data,
        na.action = na.omit, family = "poisson")

    ### Remove variance related to confounding factors by keeping residuals + exp(intercept)

    if (length(fit$na.action) != 0) {
        data2 <- data.frame(shosMedian = fit$residuals + exp(fit$coefficients[1]),
            group = data$group[-fit$na.action])
    } else {
        data2 <- data.frame(shosMedian = fit$residuals + exp(fit$coefficients[1]),
            group = data$group)
    }

    ### Fit linear model with clean variable and factor of interest

    fit <- glm(round(shosMedian) ~ group, data = data,
        na.action = na.omit, family = "poisson")

    ### Create mean and CI data frame for plot

    data_dummy <- data.frame(group = c("exclusion", "inclusion"))
    pred <- predict(fit, data_dummy, se.fit = TRUE, type = "response")

    data_dummy$shosMedian <- pred$fit
    data_dummy$se <- pred$se.fit


    ### Plot function

    ggplot(NULL, aes(x = group, y = shosMedian)) +
        geom_violin(aes(color = group), position = position_dodge(width = 0.9),
            data = data2, fill = "#ECECEC") +
        geom_point(position = position_jitterdodge(dodge.width = 0.9,
                jitter.width = 0.25),
            aes(color = group, fill = group),
            data = data2, size = 5, alpha = 0.5, shape = 21) +
            ylim(1, 5) +
        geom_pointrange(data = data_dummy,
            aes(ymax = shosMedian + se, ymin = shosMedian - se, color = group),
            position = position_dodge2(width = 0.9),
            size = 1.8, lwd = 2.5) +
        theme_classic() +
        scale_fill_manual(values = c("#CC79A7", "#56B4E9"), guide = "none") +
        scale_color_manual(values = c("#6b3c55", "#2e6889"),
            labels = c("Exclusion", "Inclusion"), name = "") +
        theme(axis.text.x = element_text(family = "Helvetica",
                size = 30, face = "bold"),
            axis.text.y = element_text(family = "Helvetica",
                size = 30, face = "bold"),
            axis.title.x = element_text(family = "Helvetica",
                size = 35, face = "bold"),
            axis.title.y = element_text(family = "Helvetica",
                size = 35, face = "bold"),
            axis.line = element_line(linewidth = 1),
            legend.key.size = unit(2, "cm"),
            legend.text = element_text(family = "Helvetica", size = 20)) +
        scale_x_discrete(labels = c("TRUE" = "\nExlusion",
                "FALSE" = "\nInclusion")) +
        labs(
            x = "",
            y = "State Hostility\n",
        )

}


plot_political_shos <- function(data) {

    ### Do first fit only with confounding factors (age and gender)

    fit <- glm(round(shosMedian) ~ factor(gender) + age, data = data,
        na.action = na.omit, family = "poisson")

    ### Remove variance related to confounding factors by keeping residuals + exp(intercept)

    data2 <- data.frame(shosMedian = fit$residuals + exp(fit$coefficients[1]),
        group = data$group[-fit$na.action],
        IF_UkMe = data$IF_UkMe[-fit$na.action])

    ### Fit linear model with clean variable and factors of interest

    fit <- glm(round(shosMedian) ~ group * IF_UkMe, data = data,
        na.action = na.omit, family = "poisson")

    ### Create mean and CI data frame for plot

    data_dummy <- data.frame(group = rep(c("exclusion", "inclusion"), 2),
        IF_UkMe = rep(c(TRUE, FALSE), each = 2))
    pred <- predict(fit, data_dummy, se.fit = TRUE, type = "response")

    data_dummy$shosMedian <- pred$fit
    data_dummy$se <- pred$se.fit


    ### Plot function

    ggplot(NULL, aes(x = IF_UkMe, y = shosMedian)) +
        geom_violin(aes(color = group), position = position_dodge(width = 0.9),
            data = data2, fill = "#ECECEC") +
        geom_point(position = position_jitterdodge(dodge.width = 0.9,
                jitter.width = 0.25),
            aes(color = group, fill = group),
            data = data2, size = 5, alpha = 0.5, shape = 21) +
            ylim(1, 5) +
        geom_pointrange(data = data_dummy,
            aes(ymax = shosMedian + se, ymin = shosMedian - se, color = group),
            position = position_dodge2(width = 0.9),
            size = 1.8, lwd = 2.5) +
        theme_classic() +
        scale_fill_manual(values = c("#CC79A7", "#56B4E9"), guide = "none") +
        scale_color_manual(values = c("#6b3c55", "#2e6889"),
            labels = c("Exclusion", "Inclusion"), name = "") +
        theme(axis.text.x = element_text(family = "Helvetica",
                size = 30, face = "bold"),
            axis.text.y = element_text(family = "Helvetica",
                size = 30, face = "bold"),
            axis.title.x = element_text(family = "Helvetica",
                size = 35, face = "bold"),
            axis.title.y = element_text(family = "Helvetica",
                size = 35, face = "bold"),
            axis.line = element_line(linewidth = 1),
            legend.key.size = unit(2, "cm"),
            legend.text = element_text(family = "Helvetica", size = 20)) +
        scale_x_discrete(labels = c("TRUE" = "\nFused",
                "FALSE" = "\nNon-Fused")) +
        labs(
            x = "",
            y = "State Hostility\n",
        )

}


plot_whole_shos <- function(data) {

    ### Do first fit only with confounding factors (age and gender)

    fit <- glm(round(shosMedian) ~ factor(gender) + age, data = data,
        na.action = na.omit, family = "poisson")

    ### Remove variance related to confounding factors by keeping residuals + exp(intercept)

    data2 <- data.frame(shosMedian = fit$residuals + exp(fit$coefficients[1]),
        group = data$group[-fit$na.action],
        condition = data$condition[-fit$na.action])

    ### Fit linear model with clean variable and factors of interest

    fit <- glm(round(shosMedian) ~ group * condition, data = data,
        na.action = na.omit, family = "poisson")

    ### Create mean and CI data frame for plot

    cond_order <- c("political", "personal", "personal_cyb")
    data_dummy <- data.frame(group = rep(c("exclusion", "inclusion"), 3),
        condition = rep(cond_order, 2))

    pred <- predict(fit, data_dummy, se.fit = TRUE, type = "response")

    data_dummy$shosMedian <- pred$fit
    data_dummy$se <- pred$se.fit


    ### Plot function

    ggplot(NULL, aes(x = factor(condition, level = cond_order), y = shosMedian)) +
        geom_violin(aes(color = group), position = position_dodge(width = 0.9),
            data = data2, fill = "#ECECEC") +
        geom_point(position = position_jitterdodge(dodge.width = 0.9,
                jitter.width = 0.25),
            aes(color = group, fill = group),
            data = data2, size = 5, alpha = 0.5, shape = 21) +
            ylim(1, 5) +
        geom_pointrange(data = data_dummy,
            aes(ymax = shosMedian + se, ymin = shosMedian - se, color = group),
            position = position_dodge2(width = 0.9),
            size = 1.8, lwd = 2.5) +
        theme_classic() +
        scale_fill_manual(values = c("#CC79A7", "#56B4E9"), guide = "none") +
        scale_color_manual(values = c("#6b3c55", "#2e6889"),
            labels = c("Exclusion", "Inclusion"), name = "") +
        theme(axis.text.x = element_text(family = "Helvetica",
                size = 30, face = "bold"),
            axis.text.y = element_text(family = "Helvetica",
                size = 30, face = "bold"),
            axis.title.x = element_text(family = "Helvetica",
                size = 35, face = "bold"),
            axis.title.y = element_text(family = "Helvetica",
                size = 35, face = "bold"),
            axis.line = element_line(linewidth = 1),
            legend.key.size = unit(2, "cm"),
            legend.text = element_text(family = "Helvetica", size = 20)) +
        scale_x_discrete(labels = c("personal" = "\nPersonal \n RateME",
                "personal_cyb" = "\nCyberball",
                "political" = "\nGroup \n RateME")) +
        labs(
            x = "",
            y = "State Hostility\n",
        )

}



plot_multiple_effects <- function(data, dep_vars, grouping) {

    estims <- vector("numeric", length(dep_vars) * 3)
    se <- vector("numeric", length(dep_vars) * 3)

    ### Iterate over the subscale variables to compute estimates and CI

    for (i in seq_along(dep_vars)) {

        for (j in seq_along(grouping)) {
            data_tmp <- filter(data, condition == grouping[j])
            form <- paste(dep_vars[i], "~", "group + age + gender")
            fit <- lm(form, data = data_tmp, na.action = na.omit)
            sum <- summary(fit)
            id_output <- 3 * (i - 1) + j
            estims[id_output] <- sum$coefficients[2, 1]
            se[id_output] <- as.numeric(sum$coefficients[2, 2]) * qnorm(0.99)
        }
    }

    ### Create data frame for plot

    data_plot <- data.frame(vars = rep(dep_vars, each = length(grouping)),
    estimates = -estims,
    se = se,
    condition = rep(grouping, length(dep_vars)))


    ### Plot function

    ggplot(data_plot, aes(x = vars, y = estimates,
            color = factor(condition, level = grouping))
            ) +
        geom_hline(yintercept = 0, linetype = "dashed") +
        geom_pointrange(aes(ymax = estimates + se, ymin = estimates - se),
                size = 2, lwd = 3, position = position_dodge(0.7)) +
        theme_classic() +
        scale_color_manual(values = c("#88CCEE", "#DDCC77", "#CC79A7"),
            labels = c("Cyberball", "Interpersonal RateME", "Intergroup RateME"),
            name = "", guide = guide_legend(reverse = TRUE)) +
        theme(axis.text.x = element_text(family = "Helvetica",
                size = 30, face = "bold"),
            axis.text.y = element_text(family = "Helvetica",
                size = 30, face = "bold"),
            axis.title.x = element_text(family = "Helvetica",
                size = 35, face = "bold"),
            axis.title.y = element_text(family = "Helvetica",
                size = 35, face = "bold"),
            axis.line = element_line(linewidth = 1),
            legend.key.size = unit(2, "cm"),
            legend.text = element_text(family = "Helvetica", size = 20)) +
        scale_x_discrete(labels = c("shosEmotion" = "Emotional \n Hostility",
                "shosAction" = "Action \n Hostility")) +
        labs(
            x = "",
            y = "\nEstimate (CI)",
        ) + coord_flip()

}



plot_multiple_scales <- function(data, dep_vars, scale) {

    var_order <-  c("interaction", scale, "exclusion")
    estims <- vector("numeric", length(dep_vars) * 3)
    se <- vector("numeric", length(dep_vars) * 3)

    ### Iterate over the political attitudes variables to compute estimates and CI

    for (i in seq_along(dep_vars)) {

        form <- paste(dep_vars[i], "~", scale,
            "* group + condition + IF_EurMe + IF_UkMe + age + factor(gender)")

        if (grepl("Form", dep_vars[i], fixed = TRUE)) {
            fit <- lm(form, data = data, na.action = na.omit)
            sum <- summary(fit)
            df_var <- fit$df
        } else if (grepl("costly", dep_vars[i], fixed = TRUE)) {
            data$costlySac <- data$costlySac > 0
            fit <- glm(form, data = data, na.action = na.omit, family = "binomial")
            sum <- summary(fit)
            df_var <- fit$df
        } else {
            fit <- rq(form, data = data, na.action = na.omit, tau = 0.5)
            sum <- summary(fit, se = "boot", R = 5000)
            df_var <- sum$rdf+13
        }

        id_output <- 3 * (i - 1) + 1
        estims[id_output] <- -sum$coefficients[13, 1]
        estims[id_output + 1] <- sum$coefficients[2, 1]
        estims[id_output + 2] <- -sum$coefficients[3, 1]
        se[id_output] <- as.numeric(sum$coefficients[13, 2]) * qnorm(0.99)
        se[id_output + 1] <- as.numeric(sum$coefficients[2, 2]) * qnorm(0.99)
        se[id_output + 2] <- as.numeric(sum$coefficients[3, 2]) * qnorm(0.99)
    }

    ### Create data frame for plot

    data_plot <- data.frame(vars = rep(dep_vars, each = 3),
    estimates = estims,
    se = se,
    quest = rep(var_order, length(dep_vars)))


    ### Plot function

    ggplot(data_plot, aes(x = factor(quest, level = var_order),
            y = estimates, color = factor(vars, level = rev(dep_vars)))) +
        geom_hline(yintercept = 0, linetype = "dashed") +
        geom_pointrange(aes(ymax = estimates + se, ymin = estimates - se),
                size = 1.25, lwd = 2.5, position = position_dodge(0.7)) +
        theme_classic() +
        scale_color_manual(values = rev(c("#88CCEE", "#DDCC77", "#CC79A7",
                "#63c376", "#965fc6", "#b8894b", "#3e3ab1", "#096628")),
            labels = rev(c("Radicalism", "Activism", "Collective Narcissism",
                "Symbolic Threat", "Realistic Threat", "Physical Formidability UK",
                "Spiritual Formidability UK", "Costly Sacrifices")),
            name = "", guide = guide_legend(reverse = TRUE)) +
        theme(axis.text.x = element_text(family = "Helvetica",
                size = 30, face = "bold"),
            axis.text.y = element_text(family = "Helvetica",
                size = 30, face = "bold"),
            axis.title.x = element_text(family = "Helvetica",
                size = 35, face = "bold"),
            axis.title.y = element_text(family = "Helvetica",
                size = 35, face = "bold"),
            axis.line = element_line(linewidth = 1),
            legend.key.size = unit(2, "cm"),
            legend.text = element_text(family = "Helvetica", size = 20)) +
        scale_x_discrete(labels = c("bscmMean" = "Psychological Needs",
                "exclusion" = "Exclusion",
                "interaction" = "Psychological Needs \n * Exclusion")) +
        labs(
            x = "",
            y = "\nEstimate (CI)",
        ) + coord_flip()

}