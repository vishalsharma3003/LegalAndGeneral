# About Module

about_ui <- function(id) {
  ns = NS(id)
  
  tagList(
    # ===banner================
    fluidRow(banner(
      maintext = "About",
      subtext = mytext(
        paste0(
          '<i>Details about Legal & General, Shiny, and myself</br></i>'
        )
      )
    ),
    width = 12),
    
    
    # ===banner boxes================
    fluidRow(box(htmlOutput(ns(
      "general"
    )), width = 12)),
    fluidRow(box(htmlOutput(
      ns("about_lg")
    ), width = 12)),
    fluidRow(box(htmlOutput(
      ns("about_shiny")
    ), width = 12)),
    fluidRow(box(htmlOutput(ns(
      "about_me"
    )), width = 12))
  )
  
}

about_server <- function(id, data) {
  # overview_server <- function(input, output, session) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    
    # =========== General =====================
    output$general <- renderText({
      paste0(
        paste0("<h3>Introduction</h3>"),
        paste0("<p>This dashboard has been created by Vishal Sharma as an assignment from Legal & General on the fake data generated using a random generator. This dashboard is not intended to be used for marketing purposes and should be considered only as a medium for showcasing skillset on R Shiny and related technologies. In terms of technologies, implementations of HTML, CSS, JS, can be found. Different services used in this dashboard include highcharts, bootstrap library, fontawesome, and more.</p>")
      )
    })
    
    # =========== About L&G =====================
    output$about_lg <- renderText({
      paste0(
        paste0("<a href='https://www.legalandgeneral.com/' target='_blank'><img src ='https://www.legalandgeneral.com/landg-assets/global-shared-assets/logos/landg-logo.svg' alt='L&G Logo' style = 'height:100px;'></a><br/>"),
        paste0("<p>Legal & General Group plc, commonly known as Legal & General, is a British multinational financial services and asset management company headquartered in London, England. Its products and services include investment management, lifetime mortgages (a form of equity release), pensions, annuities, and life assurance. As of January 2020, it no longer provides general insurance following the sale of Legal & General Insurance to Allianz. It has operations in the United Kingdom and United States, with investment management businesses in the Gulf, Europe and Asia.</p>"),
        paste0("<p>Legal & General is listed on the London Stock Exchange and is a constituent of the FTSE 100 Index. Legal & General Investment Management (LGIM), the asset management arm of L&G, is the 10th largest investment management firm in the world by AUM. It is also the second largest institutional investment management firm in Europe (after BlackRock).</p>")
      )
    })
    
    # =========== About Shiny =====================
    output$about_shiny <- renderText({
      paste0(
        paste0("<a href='https://shiny.rstudio.com/' target='_blank'><img src ='https://shiny.rstudio.com/images/shiny-solo.svg' alt='Shiny Logo' style = 'height:100px;'></a>"),
        paste0("<p>Shiny is an R package that makes it easy to build interactive web apps straight from R. You can host standalone apps on a webpage or embed them in R Markdown documents or build dashboards. You can also extend your Shiny apps with CSS themes, htmlwidgets, and JavaScript actions.</p>"),
        paste0("<p>Shiny is a part of RStudio IDE which is an integrated development environment for R, a programming language for statistical computing and graphics. It is available in two formats: RStudio Desktop is a regular desktop application while RStudio Server runs on a remote server and allows accessing RStudio using a web browser.</p>")
      )
    })
    
    # =========== About Me =====================
    output$about_me <- renderText({
      paste0(
        paste0("<h3>Vishal Sharma</h3>"),
        paste0("Highly analytical and process-oriented scientist, strategist, and technical community builder with 7 years of cross-industry experience and significant experience in Analytics, Machine learning, Predictive Modeling, Classification Models, data visualizations, Exploratory data analysis, and other data science activities. Highly skilled in R Programming, Linear Regression, Statistics, intermediate skills in Python and a master's degree in Data Science from BITS, Pilani. Working Experience of FORTUNE 500 company. Passionate about integrating statistical and computation methods into digital products to drive business value.</p>"),
        paste0("<p>I am a driven leader with interdisciplinary, technical background, combining academic curiosity with industry best practices. I greatly value mentorship, collaborative team building, creative solutioning, transparency, and personal growth. Pursuing Ph.D. in Computer Science and Engineering from Amity University, Noida with the broad area of research being Deepfake Detection. </p>"),
        paste0("<a href='https://www.linkedin.com/in/vishalsharma3003/' target='_blank'><i class='fa fa-linkedin-square' style='font-size:36px;color:blue;'></i></a>&nbsp;&nbsp;&nbsp;&nbsp;"),
        paste0("<a href='https://github.com/vishalsharma3003' target='_blank'><i class='fa fa-github' style='font-size:36px;color:black;'></i></a>&nbsp;&nbsp;&nbsp;&nbsp;"),
        paste0("<a href='https://stackoverflow.com/users/12262111/vishal-sharma' target='_blank'><i class='fa fa-stack-overflow' style='font-size:36px;color:gray;'></i></a>&nbsp;&nbsp;&nbsp;&nbsp;"),
        paste0("<a class='productName' href='https://vishalsharma.shinyapps.io/VishalSharmaCV/' target='_blank'>Shiny CV</a>&nbsp;&nbsp;&nbsp;&nbsp;")
      )
    })
    
  })
}
