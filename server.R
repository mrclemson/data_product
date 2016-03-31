library(shiny)

## scripts available at https://github.com/mrclemson/data_product

# Define server logic required to summarize and view the selected dataset
shinyServer(function(input, output) {

    # Read in the dataset
    setwd("./")
    auto = read.csv("auto_selection.csv")

    # Return the requested subset of the dataset
    final <- reactive({
        if (input$car_type_input == "All") {
            subset(auto,  MSRP >= input$MSRP_input[1] & MSRP <= input$MSRP_input[2], select = c(Make, Model, MSRP))
        } else {
            subset(auto,  MSRP >= input$MSRP_input[1] & MSRP <= input$MSRP_input[2]
                          & Car_type == input$car_type_input, select = c(Make, Model, MSRP))
        }
    })

    # Return the number of selections
    output$summary <- renderPrint({
        s <- paste("Your search returned", as.character(dim(final())[1]), "vehicles!")
        print(noquote(s))
    })

    # Show the actual selections
    output$details <- renderTable({
        ordered <- final()[order(final()$MSRP),]
        print(ordered)
    })
})
