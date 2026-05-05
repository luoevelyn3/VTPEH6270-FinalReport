library(shiny)

df <- read.csv("6270_Dataset_Selection_Luo_20260204.csv", check.names = FALSE)

numeric_vars <- setdiff(names(df)[sapply(df, is.numeric)], "FIPS")

ui <- fluidPage(
  
  tags$head(
    tags$style(HTML("
      body {
        background-color: #f7f9fc;
      }
      h1 {
        color: #1f4e79;
        font-weight: 700;
      }
      h3 {
        color: #1f4e79;
        margin-top: 25px;
      }
      .well {
        background-color: #eef4fb;
        border: 1px solid #d6e2f0;
      }
      .btn-default {
        background-color: #2c7fb8;
        color: white;
        border-color: #2c7fb8;
      }
      .btn-default:hover {
        background-color: #225f8a;
        color: white;
      }
    "))
  ),
  
  titlePanel("County-Level Health and Demographic Explorer"),
  
  p("Goal: This app examines associations between county-level demographic characteristics and health outcomes across U.S. counties using the dataset selected for the course project. Users can choose two numeric variables to visualize their relationship in a scatter plot, inspect a fitted linear trend, and review summary statistics including means, standard deviations, correlation, and sample size. The app is intended to support exploratory public health analysis by helping users identify broad patterns in aging, socioeconomic conditions, and health status."),
  
  p(strong("Author: "), "Yuhui Luo"),
  
  p(strong("Data source: "), "County-level health and demographic dataset selected for the course project."),
  
  p(strong("Methods: "), "Users select two numeric variables. The app generates a scatter plot with a fitted linear trend, a histogram of the selected outcome variable, and summary statistics."),
  
  p(
    strong("GitHub Repository: "),
    tags$a(
      href = "https://github.com/luoevelyn3/VTPEH6270-CP05/tree/main/my_shiny_app",
      "View code on GitHub",
      target = "_blank"
    )
  ),
  
  p(strong("AI disclosure: "), "ChatGPT was used to support coding, debugging, and wording refinement."),
  
  sidebarLayout(
    
    sidebarPanel(
      selectInput(
        "xvar",
        "Choose x-axis variable:",
        choices = numeric_vars,
        selected = "% 65 and Over"
      ),
      selectInput(
        "yvar",
        "Choose y-axis variable:",
        choices = numeric_vars,
        selected = "% Fair or Poor Health"
      ),
      actionButton("update", "Update analysis")
    ),
    
    mainPanel(
      h3("Scatter Plot"),
      plotOutput("scatter_plot", height = "400px"),
      
      h3("Distribution of Selected Y Variable"),
      plotOutput("hist_plot", height = "300px"),
      
      h3("Summary Statistics"),
      tableOutput("summary_table")
    )
  )
)

server <- function(input, output, session) {
  
  selected_data <- eventReactive(input$update, {
    x <- df[[input$xvar]]
    y <- df[[input$yvar]]
    keep <- complete.cases(x, y)
    
    data.frame(
      x = x[keep],
      y = y[keep]
    )
  }, ignoreNULL = FALSE)
  
  output$scatter_plot <- renderPlot({
    dat <- selected_data()
    
    plot(
      dat$x, dat$y,
      xlab = input$xvar,
      ylab = input$yvar,
      main = paste(input$yvar, "vs", input$xvar),
      pch = 19,
      col = rgb(44/255, 127/255, 184/255, 0.55)
    )
    
    if (nrow(dat) > 1) {
      abline(lm(y ~ x, data = dat), lwd = 2, col = "#d95f0e")
    }
  })
  
  output$hist_plot <- renderPlot({
    dat <- selected_data()
    
    hist(
      dat$y,
      main = paste("Distribution of", input$yvar),
      xlab = input$yvar,
      col = "#9ecae1",
      border = "white"
    )
  })
  
  output$summary_table <- renderTable({
    dat <- selected_data()
    
    data.frame(
      Statistic = c(
        paste("Mean of", input$xvar),
        paste("SD of", input$xvar),
        paste("Mean of", input$yvar),
        paste("SD of", input$yvar),
        paste("Correlation between", input$xvar, "and", input$yvar),
        "Number of counties"
      ),
      Value = c(
        mean(dat$x, na.rm = TRUE),
        sd(dat$x, na.rm = TRUE),
        mean(dat$y, na.rm = TRUE),
        sd(dat$y, na.rm = TRUE),
        cor(dat$x, dat$y, use = "complete.obs"),
        nrow(dat)
      )
    )
  }, digits = 3)
}

shinyApp(ui = ui, server = server)