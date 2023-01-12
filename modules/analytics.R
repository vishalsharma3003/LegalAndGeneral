# Analytics Module

analytics_ui <- function(id) {
  ns = NS(id)
  
  tagList(
    # ===banner================
    fluidRow(banner(
      maintext = "Analysis",
      selectInput(
        inputId = ns("select_company"),
        label = "Select Company: ",
        choices  = unique(full_data$company_name[!is.na(full_data$company_name)]),
        selected = "Vehement Capital Partners"
      ),
      subtext = "<i>Analytics based on company</i>"
    ),
    width = 12), 
    
    
    # ===banner boxes================
    
    fluidRow(
      box(
        width = 12,
        valueBoxOutput(ns("company_name") , width = 3),
        valueBoxOutput(ns("total_employees") , width = 3),
        valueBoxOutput(ns("mean_age") , width = 3),
        valueBoxOutput(ns("mean_salary") , width = 3)
        
      )
    ),
    
    fluidRow(
      box(
        title = "Annual Salary Extrema",
        height = "auto",
        width = 12,
        box(width = 6,
            withSpinner(
              highchartOutput(ns("highest_salary"), width = "100%", height = '300px'), type = 7
            )),
        box(width = 6,
            withSpinner(
              highchartOutput(ns("lowest_salary"), width = "100%", height = '300px'), type = 7
            ))
      )
    ),
    
    fluidRow(box(
      withSpinner(highchartOutput(
        ns("age_occupation"), width = "100%", height = '600px'
      ), type = 7), width = 6
    ),
    box(
      withSpinner(highchartOutput(
        ns("average_salary_age"),
        width = "100%",
        height = '600px'
      ), type = 7), width = 6
    )),
    
    fluidRow(
      box(
        title = "List of All Employees",
        withSpinner(dataTableOutput(ns("tab_employees")), type = 7), 
        height = "auto",
        width = 12
      )
    )
  )
  
}

analytics_server <- function(id, data) {
  # overview_server <- function(input, output, session) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    
    # =========== Reactive Data =====================
    company_data <- reactive({
      full_data %>% filter(company_name == input$select_company)
    })
    
    # =========== Banner Boxes =====================
    output$company_name <- renderValueBox({
      value <- input$select_company
      valueBox(
        value = value,
        subtitle = "Company Name",
        color = "light-blue",
        width = 3
      )
    })
    
    output$total_employees <- renderValueBox({
      value <-
        format(nrow(company_data()),
               big.mark = ",",
               big.interval = 3)
      valueBox(
        value = value,
        subtitle = "Total Employees",
        color = "light-blue",
        width = 3
      )
    })
    
    output$mean_age <- renderValueBox({
      value <- round(mean(company_data()$Age, na.rm = TRUE), 2)
      valueBox(
        value = value,
        subtitle = "Average Age",
        color = "light-blue",
        width = 3
      )
    })
    
    output$mean_salary <- renderValueBox({
      value <-
        paste0("£ ", format(
          round(mean(
            company_data()$Annual.Salary, na.rm = TRUE
          ), 2),
          big.mark = ",",
          big.interval = 3
        ))
      valueBox(
        value = value,
        subtitle = "Average Salary",
        color = "light-blue",
        width = 3
      )
    })
    
    # =========== Highest Salary =====================
    output$highest_salary <- renderHighchart({
      max_sal <- max(company_data()$Annual.Salary, na.rm = TRUE)
      which_max_sal <-
        company_data()$Occupation[which.max(company_data()$Annual.Salary)]
      
      highchart() %>%
        hc_chart(type = "solidgauge") %>%
        hc_title(
          text = paste0(
            "<span style = 'font-size:20px'><b>",
            which_max_sal,
            "</b></span>"
          ),
          useHTML = TRUE
        ) %>%
        hc_subtitle(text = "Highest Salary") %>%
        hc_pane(
          center = c("50%", "85%"),
          size = "170%",
          startAngle = -90,
          endAngle = 90,
          background = list(
            # backgroundColor = "default",
            innerRadius = "60%",
            outerRadius = "100%",
            shape = "arc"
          )
        ) %>%
        hc_exporting(enabled = FALSE) %>%
        hc_tooltip(enabled = FALSE) %>%
        hc_yAxis(
          stops = list(c(0.1, "#DF5353"),
                       c(0.5, "#DDDF0D"),
                       c(0.9, "#55BF3B")),
          lineWidth = 10,
          tickWidth = 0,
          minorTickInterval = NULL,
          tickAmount = 2,
          title = list(y = -70),
          labels = list(y = 16),
          min = 0,
          max = max(full_data$Annual.Salary, na.rm = TRUE)
        ) %>%
        hc_add_series(
          name = "Highest Salary",
          data = max_sal,
          dataLabels = list(
            y = -50,
            borderWidth = 0,
            useHTML = TRUE,
            style = list(fontSize = "36px"),
            format = paste0(
              "<b>£",
              format(max_sal, big.mark = ",", big.interval = 3),
              "</b>"
            )
          )
        ) %>%
        hc_plotOptions(solidgauge = list(dataLabels = list(
          y = 5,
          borderWidth = 0,
          useHTML = TRUE
        )))
    })
    
    # =========== Lowest Salary =====================
    output$lowest_salary <- renderHighchart({
      min_sal <- min(company_data()$Annual.Salary, na.rm = TRUE)
      which_min_sal <-
        company_data()$Occupation[which.min(company_data()$Annual.Salary)]
      
      highchart() %>%
        hc_chart(type = "solidgauge") %>%
        hc_title(
          text = paste0(
            "<span style = 'font-size:20px'><b>",
            which_min_sal,
            "</b></span>"
          ),
          useHTML = TRUE
        ) %>%
        hc_subtitle(text = "Lowest Salary") %>%
        hc_pane(
          center = c("50%", "85%"),
          size = "170%",
          startAngle = -90,
          endAngle = 90,
          background = list(
            # backgroundColor = "default",
            innerRadius = "60%",
            outerRadius = "100%",
            shape = "arc"
          )
        ) %>%
        hc_exporting(enabled = FALSE) %>%
        hc_tooltip(enabled = FALSE) %>%
        hc_yAxis(
          stops = list(c(0.1, "#DF5353"),
                       c(0.5, "#DDDF0D"),
                       c(0.9, "#55BF3B")),
          lineWidth = 10,
          tickWidth = 0,
          minorTickInterval = NULL,
          tickAmount = 2,
          title = list(y = -70),
          labels = list(y = 16),
          min = 0,
          max = max(full_data$Annual.Salary, na.rm = TRUE)
        ) %>%
        hc_add_series(
          name = "Lowest Salary",
          data = min_sal,
          dataLabels = list(
            y = -50,
            borderWidth = 0,
            useHTML = TRUE,
            style = list(fontSize = "36px"),
            format = paste0(
              "<b>£",
              format(min_sal, big.mark = ",", big.interval = 3),
              "</b>"
            )
          )
        ) %>%
        hc_plotOptions(solidgauge = list(dataLabels = list(
          y = 5,
          borderWidth = 0,
          useHTML = TRUE
        )))
    })
    
    # =========== Age & Occupation =====================
    output$age_occupation <- renderHighchart({
      res <-
        company_data() %>% group_by(Occupation) %>% summarise(low = min(Age, na.rm = TRUE),
                                                              high = max(Age, na.rm = TRUE)) %>% 
        filter(Occupation != "") %>% rename(name = "Occupation")
      
      highchart() %>% 
        hc_chart(type = "dumbbell", inverted = TRUE) %>% 
        hc_legend(enabled = TRUE) %>% 
        hc_title(text = "Age range for occupation") %>%
        hc_tooltip(shared = TRUE) %>%
        hc_xAxis(type = "category") %>% 
        hc_yAxis(title = list(text = "Occupation")) %>%
        hc_add_series(name = "Age (years)", data = res) %>% 
        hc_exporting(enabled = TRUE,
                     buttons = list(contextButton = list(menuItems = highchart_menu(title)))) %>%
        hc_credits(
          enabled = TRUE,
          text = "This chart represents the range of age related to the occupations",
          position = list(align = 'center'),
          style = list(color = '#756142',
                       fontSize = "11px")
        ) %>% hc_add_theme(lng_theme(palettes = ""))
      
    })
    
    # =========== Average Salary & Age =====================
    output$average_salary_age <- renderHighchart({
      res <- company_data() %>%  group_by(Age) %>% summarise(high = max(Annual.Salary, na.rm = TRUE), low = min(Annual.Salary, na.rm = TRUE), avg = mean(Annual.Salary, na.rm = TRUE)) %>% filter(!is.na(Age)) %>% 
        arrange(Age)
      
      ranges <- list()
      
      for (i in 1:nrow(res)) {
        ranges[[i]] <- c(res$low[i], res$high[i])
      }
      
      averages <- res$avg
      
      highchart() %>%
        hc_title(text = "Range of salaries for different age") %>%
        hc_xAxis(categories = res$Age, title = list(text = "Age")) %>%
        hc_yAxis(title = list(text = "Salary"), labels = list(format = "£ {value}")) %>%
        hc_tooltip(crosshairs = TRUE, shared = TRUE, valuePrefix = "£") %>%
        hc_add_series(name = "Average Salary", data = averages, 
                      marker = list(fillColor = "white", lineWidth = 2, 
                                    lineColor = "#7cb5ec"), zIndex = 1) %>%
        hc_add_series(name = "Salary Range", data = ranges, type = "arearange",
                      lineWidth = 0, color = "#7cb5ec", 
                      fillOpacity = 0.3, zIndex = 0, marker = list(enabled = F)) %>% 
        hc_exporting(enabled = TRUE,
                     buttons = list(contextButton = list(menuItems = highchart_menu(title)))) %>%
        hc_credits(
          enabled = TRUE,
          text = "This chart represents the range of salaries for different ages",
          position = list(align = 'center'),
          style = list(color = '#756142',
                       fontSize = "11px")
        ) %>% hc_add_theme(lng_theme(palettes = ""))
      
    })
    
    # =========== Employees table =====================
    output$tab_employees <- renderDataTable({
      res <- company_data() %>% 
        mutate(MonthlySalary = paste0("£", trimws(format(round(MonthlySalary,0), big.mark = ",", big.interval = 3)))) %>% 
        select(FullName, Age, Gender, Occupation, MonthlySalary)
      colnames(res) <- to_title_case(colnames(res))
      
      datatable(
        data = res,
        extensions = c('Buttons'),
        class = c("row-border","stripe"),
        options = list(
          columnDefs = list(
            list(targets = c(0), className = 'dt-body-left'),
            list(targets = c(1:4), className = 'dt-right')
          ),
          scrollCollapse = TRUE,
          scrollX = TRUE,
          paging = TRUE,
          Searching = TRUE,
          ordering = FALSE,
          dom = 'Bfrtip',
          # dom = 'Blrt',
          style = 'default',
          initComplete = JS(
            "function(settings, json) {",
            "$(this.api().table().header()).css({'background-color': '#72afd2'});",
            "}"
          ),
          buttons = list(
            list(
              extend = 'colvis',
              columns = ':not(.noVis)',
              text = '<i class="fa fas fa-list"></i> <span class="caret text-white"></span>'
            ),
            list(
              extend = 'collection',
              text = '<i class="fa fas fa-share-alt"></i> <span class="caret text-white"></span>',
              buttons = list(
                list(extend = 'copy', title = paste0("Members of ", input$select_company)),
                list(extend = 'excel', title = paste0("Members of ", input$select_company)),
                list(extend = 'csv', title = paste0("Members of ", input$select_company)),
                list(extend = 'pdf', title = paste0("Members of ", input$select_company)),
                list(extend = 'print', title = paste0("Members of ", input$select_company))
              )
            )
          )
        ),
        selection  = "single",
        escape =  FALSE,
        rownames = FALSE
      )
    })
    
  })
}
