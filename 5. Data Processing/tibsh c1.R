library(tidyverse)

my_data <- read.csv("Sanitation.csv")

write.csv(my_data,'Sanitation.csv')

head(my_data)
str(my_data)

ggplot(my_data, aes(x=Access_to_Sanitation, y=Life_Expectancy)) +
    geom_point()

my_data2 <- my_data[order(my_data["Access_to_Sanitation"]),]
View(my_data20)

my_data20 = my_data2[c(1:20),]



my_data20 %>% 
ggplot(aes(x=Country, y=Access_to_Sanitation)) +
    geom_bar(stat="identity") +
    theme(axis.text.x = element_text(angle = 90, hjust = 1))

my_data20 %>% 
    arrange(Access_to_Sanitation) %>% 
    mutate(Country = factor(Country, levels = Country)) %>%
    ggplot(aes(x=Country,y=Access_to_Sanitation)) +
    geom_bar(stat="identity") +
    theme(axis.text.x = element_text(angle = 90, hjust = 1))

my_data <- my_data[order(my_data["Access_to_Sanitation"]),]

barplot(my_data[c(1:20),"Access_to_Sanitation"],
        names.arg = as.vector(my_data[c(1:20),"Country"]),
        col = "red", las = 2,
        ylab = "Access to Sanintation (% of Population)")

my_data <- my_data[order(my_data["Life_Expectancy"]),]

barplot(my_data[c(1:20),"Life_Expectancy"],
        names.arg = as.vector(my_data[c(1:20),"Country"]),
        col = "blue", las = 2,
        ylab = "Life Expectancy (years)")

sanitation <- as.vector(my_data$Access_to_Sanitation)
model <- lm(Life_Expectancy ~ sanitation, data=my_data)

summary(model)
model

{
plot(my_data$Access_to_Sanitation, my_data$Life_Expectancy, xlab = "Access to Sanitation (% of Population)",
     ylab = "Life Expectancy (years)", col = "blue", lwd = 2)

# Fit a line in the plot
abline(model, col = "red")
}

ggplot(my_data, aes(x=Access_to_Sanitation,y=Life_Expectancy) ) +
    geom_point() + 
    geom_abline(intercept = 53.5102, slope = 0.2412, color='red')
