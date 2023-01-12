# Overview Module

overview_ui <- function(id) {
  ns <- NS(id)
  
  tagList(fluidRow(
    tags$div(id = "mybox",
             box(
               width = 2,
               footer =
                 boxPad(color = "transparent",
                        uiOutput(ns("companyname")),
                        uiOutput(ns("position")),
                        uiOutput(ns("purpose")))
             )),
    tags$div(
      id = "mybox2",
      gradientBox(
        title = "Properties",
        icon = "fa fa-th",
        collapsible = FALSE,
        width = 10,
        footer = fluidRow(
          column(width = 2, uiOutput(ns("total_company"))),
          column(width = 2, uiOutput(ns(
            "total_employees"
          ))),
          column(width = 2, uiOutput(ns(
            "total_occupations"
          ))),
          column(width = 2, uiOutput(ns(
            "avg_salary_annual"
          ))),
          column(width = 2, uiOutput(ns(
            "avg_salary_monthly"
          ))),
          column(width = 2, uiOutput(ns("avg_age")))
        )
      )
    )
  ),
  
  fluidRow(box(
    withSpinner(highchartOutput(ns("company_distribution"), width = "100%", height = '500px'), type = 7), width = 6
  ),
  box(
    withSpinner(highchartOutput(ns("gender_distribution"), width = "100%", height = '500px'), type = 7), width = 6
  )),
  
  fluidRow(box(
    withSpinner(highchartOutput(ns("gender_occupation"), width = "100%", height = '500px'), type = 7), width = 6
  ),
  box(
    withSpinner(highchartOutput(ns("average_salary_age"), width = "100%", height = '500px'), type = 7), width = 6
  )))
}

overview_server <- function(id, data) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    
    # =========== Basic Details =====================
    output$companyname <- renderUI({
      d_InfoCard(
        value = "Legal & General",
        title = "Company",
        hover_lift = FALSE ,
        customcss = TRUE
      )
    })
    
    output$position <- renderUI({
      d_InfoCard(
        value = "Data Analytics Developer",
        title = "Position",
        hover_lift = FALSE ,
        customcss = TRUE
      )
    })
    
    output$purpose <- renderUI({
      d_InfoCard(
        value = "Assessment",
        title = "Purpose",
        hover_lift = FALSE ,
        customcss = TRUE
      )
    })
    
    # =========== Properties =====================
    output$total_company <- renderUI({
      value <- n_distinct(full_data$company_name[!is.na(full_data$company_name)])
      comparisonBox(
        value = value,
        title = "# Companies",
        description = "Number of companies in the dataset",
        icon = "fa fa-building"
      )
    })
    
    output$total_employees <- renderUI({
      value <-
        format(n_distinct(full_data$ID),
               big.mark = ",",
               big.interval = 3)
      comparisonBox(
        value = value,
        title = "# Employees",
        description = "Number of employees in the dataset",
        icon = "fa fa-people"
      )
    })
    
    output$total_occupations <- renderUI({
      value <- n_distinct(full_data$Occupation)
      comparisonBox(
        value = value,
        title = "# Occupations",
        description = "Number of occupations in the dataset",
        icon = "fa fa-building"
      )
    })
    
    output$avg_salary_annual <- renderUI({
      value <-
        paste0("£ ", format(
          round(mean(full_data$Annual.Salary, na.rm = TRUE), 2),
          big.mark = ",",
          big.interval = 3
        ))
      comparisonBox(
        value = value,
        title = "Annual Salary",
        description = "Average of annual salary for all employees",
        icon = "fa fa-building"
      )
    })
    
    output$avg_salary_monthly <- renderUI({
      value <-
        paste0("£ ", format(
          round(mean(
            full_data$Annual.Salary / 12, na.rm = TRUE
          ), 2),
          big.mark = ",",
          big.interval = 3
        ))
      comparisonBox(
        value = value,
        title = "Monthly Salary",
        description = "Average of monthly salary for all employees",
        icon = "fa fa-building"
      )
    })
    
    output$avg_age <- renderUI({
      value <-
        paste0(round(mean(full_data$Age, na.rm = TRUE), 2), " years")
      comparisonBox(
        value = value,
        title = "Age",
        description = "Average age for all the employees in the dataset",
        icon = "fa fa-building"
      )
    })
    
    # =========== Comapny Distribution =====================
    output$company_distribution <- renderHighchart({
      res <-
        full_data %>% 
        group_by(company_name) %>% 
        summarise(count = n()) %>% 
        mutate(Percentage = count * 100 / sum(count)) %>% 
        ungroup() %>% 
        filter(!is.na(company_name))
      
      highchart() %>% hc_title(text = "Employee Distribution by Companies") %>% hc_add_series(
        type = "pie",
        data = res,
        hcaes(x = company_name, y = Percentage),
        size = 300,
        innerSize = '40%',
        startAngle = 0,
        dataLabels = list(enabled = TRUE, format = "<b>{point.company_name}</b><br/>{point.Percentage: ,.2f} %"),
        style = list(
          color = "#333",
          fontSize = "13px",
          fontWeight = "normal"
        )
      ) %>% hc_tooltip(pointFormat = "<b>Employees: {point.Percentage:,.2f} %</b>", shared = TRUE) %>%
        hc_exporting(enabled = TRUE,
                     buttons = list(contextButton = list(menuItems = highchart_menu(title)))) %>%
        hc_credits(
          enabled = TRUE,
          text = "This chart represents distribution of employees across all companies",
          position = list(align = 'center'),
          style = list(color = '#756142',
                       fontSize = "11px")
        ) %>% hc_add_theme(lng_theme(palettes = ""))
    })
    
    # =========== Gender Distribution =====================
    output$gender_distribution <- renderHighchart({
      data <-
        full_data %>% 
        group_by(Gender) %>% 
        summarise(count = n()) %>% 
        mutate(Percentage = count * 100 / sum(count)) %>% 
        ungroup() %>% 
        mutate(drilldown = Gender) %>% 
        rename(name = "Gender", y = "Percentage") %>% 
        select(-count)
      
      drilldown_data <-
        full_data %>% 
        group_by(Gender, company_name) %>% 
        summarise(count = n()) %>% 
        ungroup() %>% 
        mutate(percent = count*100/sum(count)) %>% 
        arrange(-count) %>% 
        filter(!is.na(company_name)) %>% 
        group_nest(Gender) %>% 
        mutate(
          id = Gender,
          type = "column",
          name = Gender,
          data = map(data, mutate, name = company_name, value = percent),
          data = map(data, select, c(name, value)),
          data = map(data, list_parse2)
        )
      
      drilldown_data <- list_parse(drilldown_data)
      
      highchart() %>% hc_title(text = "Gender Distribution") %>% 
        hc_xAxis(type = "category") %>% 
        hc_yAxis(labels = list(format = "{value} %")) %>% 
        hc_add_series(
          type = "pie",
          data = data,
          hcaes(x = name, y = y, drilldown = drilldown),
          size = 300,
          innerSize = '40%',
          startAngle = 0,
          dataLabels = list(enabled = TRUE, format = "<b>{point.name}</b><br/>{point.y: ,.2f} %"),
          style = list(
            color = "#333",
            fontSize = "13px",
            fontWeight = "normal"
          ),
          drilldown = TRUE,
          name = "Gender"
        ) %>% hc_tooltip(
          headerFormat = "{series.name}</br>",
          pointFormat = "<b>{point.name}: {point.y:,.2f} % </b>of total", shared = FALSE
        ) %>%
        hc_exporting(enabled = TRUE,
                     buttons = list(contextButton = list(menuItems = highchart_menu(title)))) %>%
        hc_credits(
          enabled = TRUE,
          text = "This chart represents distribution of gender among organisations. Click on pie element for further drilldown",
          position = list(align = 'center'),
          style = list(color = '#756142',
                       fontSize = "11px")
        ) %>% hc_add_theme(lng_theme()) %>% 
        hc_drilldown(
          allowPointDrilldown = TRUE,
          series = drilldown_data,
          breadcrumbs = list(
            position = list(align = "right")
          )
        )
    })
    
    # =========== Gender by Occupation =====================
    output$gender_occupation <- renderHighchart({
      res1 <-
        full_data %>% 
        group_by(Occupation, Gender) %>% 
        summarise(Count = n()) %>% 
        ungroup()
      
      res <- full_data %>%
        group_by(Occupation) %>%
        summarise(ct = n()) %>%
        ungroup() %>%
        filter(Occupation != "") %>%
        arrange(-ct) %>%
        head(10) %>% left_join(res1, by = c("Occupation" = "Occupation")) %>%
        select(-c("ct"))
      
      highchart() %>%
        hc_chart(type = "column") %>%
        hc_title(text = "Count of Genders based on Occupation") %>%
        hc_xAxis(categories = unique(res$Occupation),
                 crosshair = TRUE) %>%
        hc_yAxis(min = 0, title = list(text = "Count of Employees")) %>%
        hc_add_series(
          name = "Female",
          data = res %>% filter(Gender == "Female") %>% filter(Occupation != "") %>% select(-c("Occupation")),
          "column",
          hcaes(x = Gender, y = Count),
          dataLabels = list(enabled = TRUE,
                            style = list(fontWeight = "bold")),
          pointPlacement = 0.1,
          dataSorting = list(enabled = TRUE, matchByName = TRUE)
        ) %>% hc_tooltip(shared = TRUE,
                         headerFormat = '<span style="font-size: 15px">{point.x}</span><br/>',
                         pointFormat = '<span style="color:{point.color}">\u25CF</span> {series.name}: <b>{point.y} employees</b><br/>') %>%
        hc_add_series(
          name = "Male",
          data = res %>% filter(Gender == "Male") %>% filter(Occupation != "") %>% select(-c("Occupation")),
          "column",
          hcaes(x = Gender, y = Count),
          dataLabels = list(enabled = TRUE,
                            style = list(fontWeight = "bold"))
        ) %>%
        hc_plotOptions(series = list(
          pointWidth = 30,
          opacity = .9,
          # pointPadding = .25,
          shadow = TRUE
        )) %>%
        hc_exporting(enabled = TRUE,
                     buttons = list(contextButton = list(menuItems = highchart_menu(title)))) %>%
        hc_credits(
          enabled = TRUE,
          text = "This chart represents the comparison of genders in top 10 occupations",
          position = list(align = 'center'),
          style = list(color = '#756142',
                       fontSize = "11px")
        ) %>% hc_add_theme(lng_theme())
    })
    
    # =========== Average Salary and Age =====================
    output$average_salary_age <- renderHighchart({
      res1 <-
        full_data %>% 
        group_by(company_name) %>% 
        summarise(AverageSalary = mean(Annual.Salary, na.rm = TRUE)) %>% 
        ungroup() %>% 
        filter(!is.na(company_name)) %>% 
        mutate(color = c('#7cb5ec', '#434348', '#90ed7d', '#f7a35c', '#8085e9', '#f15c80', '#e4d354', '#2c9090', '#f45b5b'))
      
      res2 <-
        full_data %>% 
        group_by(company_name) %>% 
        summarise(AverageAge = mean(Age, na.rm = TRUE)) %>% 
        ungroup() %>% 
        filter(!is.na(company_name))
      
      highchart() %>%
        hc_chart(zoomType = "xy") %>%
        hc_title(text = "Average Annual Salary and Age based on Company", align = "center") %>%
        hc_xAxis(categories = res1$company_name, crosshair = TRUE) %>%
        hc_yAxis_multiples(
          list(
            title = list(text = "Annual Salary"),
            labels = list(format = "£ {value}", style = list(color = "#000000")),
            opposite = FALSE
          ),
          list(
            title = list(text = "Age"),
            labels = list(format = "{value} years", style = list(color = "#000000")),
            opposite = TRUE
          )
        ) %>%
        hc_add_series(
          data = res1,
          type = "column",
          yAxis = 0,
          name = "Annual Salary",
          hcaes(x = company_name, y = AverageSalary, color = color),
          tooltip = list(valuePrefix = "£ ")
        ) %>%
        hc_add_series(
          data = res2,
          type = "spline",
          yAxis = 1,
          name = "Age",
          hcaes(x = company_name, y = AverageAge),
          tooltip = list(valueSuffix = " years")
        ) %>%
        hc_legend(
          align = "center",
          x = 40,
          verticalAlign = "top",
          y = 30,
          floating = TRUE,
          backgroundColor = "rgba(255,255,255,0.25)"
        ) %>%
        hc_tooltip(shared = TRUE,
                   headerFormat = '<span style="font-size: 15px">{point.x}</span><br/>',
                   pointFormat = '<span style="color:{point.color}">\u25CF</span> {series.name}: <b>{point.y:,.2f}</b><br/>') %>%
        hc_exporting(enabled = TRUE,
                     buttons = list(contextButton = list(menuItems = highchart_menu(title)))) %>%
        hc_credits(
          enabled = TRUE,
          text = "This chart represents the averages of annual salary and age for differnt companies",
          position = list(align = 'center'),
          style = list(color = '#756142',
                       fontSize = "11px")
        ) %>% hc_add_theme(lng_theme(palettes = ""))
    })
  })
}
