server <- function(input, output, session) {
  sever()
  
  # =========== Header =====================
  observe({
    
    # L&G logo in Header
    shinyjs::html("pageHeader",
                  HTML(paste(
                    tags$img(src="https://www.lgamerica.com/docs/default-source/brand-resources/l-g_logo_rgb_4c_white_final.png?sfvrsn=fc56323f_2",
                             width=75, height=50),
                    "<span>Legal & General Dashboard</span>")))
    
    
    
  })
  
  addClass(selector = "body", class = "sidebar-collapse")
  
  # =========== Server Functions =====================
  overview_server("overview")
  analytics_server("analytics")
  about_server("about")
}