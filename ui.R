library(shiny)

# Read in the dataset
setwd("./")
auto = read.csv("auto_selection.csv")

# Define UI for dataset viewer application
shinyUI(pageWithSidebar(

    # Application title
    headerPanel("Car selection"),

    # Choose a vehicle type
    # Choose the range of MSRP
    sidebarPanel(
        selectInput("car_type_input", "Choose a vehicle type",
                    choices = c("All", levels(auto$Car_type))),

        sliderInput("MSRP_input",
                    "Choose the MSRP",
                    min_MSRP <- floor(min(auto$MSRP)/1000)*1000,
                    max_MSRP <- ceiling(max(auto$MSRP)/1000)*1000,
                    value = c(min_MSRP,max_MSRP),
                    step = 1000)
    ),

    # Return the number of vehicles met the searching conditions
    # Along with the list of all vehicles
    mainPanel(
        verbatimTextOutput("summary"),

        tableOutput("details")
    )
))
