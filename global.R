library(shinydashboardPlus)
library(shinydashboard)
# remotes::install_github("dreamRs/particlesjs")
library(particlesjs)
library(dplyr)
library(highcharter)
library(snakecase)
library(DT)
library(sever)
library(shinyjs)
library(shinycssloaders)
library(purrr)

source(file = "funs.R")

title <- "L&G"
companies_data <- read.csv("companies_data.csv")
member_data <- read.csv("member_data.csv")
full_data <- member_data %>% left_join(companies_data, by = c("ID" = "member_id"))
full_data <- full_data %>% mutate(FullName = paste(trimws(First.Name), trimws(Last.Name), " "), MonthlySalary = Annual.Salary/12)

ImportShinyModules()
