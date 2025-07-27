---
title: "Visualizing Carbon Dioxide Levels"
output: html_notebook
---

```{r message=FALSE, warning=FALSE, error=TRUE}

# load libraries and data
library(readr)
library(dplyr)
library(ggplot2)
```

```{r error=TRUE}

options(scipen=10000) #removes scientific notation

#Create NOAA Visualization:
noaa_data <- read_csv("carbon_dioxide_levels.csv")

head(noaa_data)
```


```{r error=TRUE}

noaa_viz = ggplot(data = noaa_data, aes(x = Age_yrBP, y = CO2_ppmv)) +
  geom_line(color = "#355CFF", size = 0.6) +
  labs(
    title = "Carbon Dioxide Levels From 8,000 to 136 Years BP", 
    subtitle = "From World Data Center for Paleoclimatology and NOAA Paleoclimatology Program", 
    x = "Years Before Today (0=1950)", 
    y = "Carbon Dioxide Level (Parts Per Million)") +
  scale_x_reverse(lim=c(800000,0)) +
  theme_minimal(base_family = "sans") +  # <- Use system sans-serif font
  theme(
   panel.background = element_rect(fill = "#E6E0EC", color = NA),
   plot.background = element_rect(fill = "#E6E0EC", color = NA),
   plot.title = element_text(size = 18, face = "bold", color = "#333333"),
   plot.subtitle = element_text(size = 12, color = "#333333"),
   axis.title = element_text(size = 12, color = "#333333"),
   axis.text = element_text(size = 10, color = "#333333"),
   panel.grid.major = element_line(color = "#DAD4E5"),
   panel.grid.minor = element_blank()
  )

noaa_viz



```
```{r message=FALSE, error=TRUE}

#Create IAC Visualization

iac_data <- read_csv("yearly_co2.csv")

head(iac_data)
#Note that the data_mean_global is an equivalent metric to CO2_ppmv. 
#We will not be using the other two columns in this project.
#The years in this dataset correspond to chronological modern dates. 
#Time is not defined in terms of BP.

```
```{r error=TRUE}

iac_viz <- ggplot(data = iac_data, aes(x = year, y = data_mean_global)) +
  geom_line(color = "#355CFF", size = 0.6) +
  labs(
    title = "Carbon Dioxide Levels over Time",
    subtitle = "From Institute for Atmospheric and Climate Science (IAC).",
    x = "Year", 
    y = "Carbon Dioxide Level (Parts Per Million)",
    linetype = "") +
  geom_hline(aes(yintercept = millenia_max, linetype = "Historical CO2 Peak before 1950")) +
  theme_minimal(base_family = "sans") +  # <- Use system sans-serif font
  theme(
   panel.background = element_rect(fill = "#E6E0EC", color = NA),
   plot.background = element_rect(fill = "#E6E0EC", color = NA),
   plot.title = element_text(size = 18, face = "bold", color = "#333333"),
   plot.subtitle = element_text(size = 12, color = "#333333"),
   axis.title = element_text(size = 12, color = "#333333"),
   axis.text = element_text(size = 10, color = "#333333"),
   panel.grid.major = element_line(color = "#DAD4E5"),
   panel.grid.minor = element_blank()
  )
 
iac_viz

```


```{r error=TRUE}

#Let’s highlight the rise in carbon dioxide levels by adding a horizontal line 
#that represents the maximum level in the first chart spanning over 8,000 years of carbon dioxide data. 

#Line below create a new variable named millennia_max 
#and retrieve the maximum value of the CO2_ppmv column in the noaa_data.

millenia_max <- max(noaa_data$CO2_ppmv)

millenia_max

```
```{r error=TRUE}

ggsave("noaa_viz_plot.pdf", plot = noaa_viz, width = 10, height = 6)
```


```{r error=TRUE}

ggsave("iac_viz_plot.pdf", plot = iac_viz, width = 10, height = 6)

```

