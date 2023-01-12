ui <- dashboardPagePlus(
  skin = "blue-light",
  # =========== Header =====================
  header= dashboardHeader(),
  # =========== Sidebar =====================
  sidebar = dashboardSidebar(
    sidebarMenu_custom(
      menuItem(
        text = "Overview",
        tabName = "overview",
        icon = icon('home')
      ),
      menuItem(
        text = "Analytics",
        tabName = "analytics",
        icon = icon('chart-simple')
      ),
      menuItem(
        text = "About",
        tabName = "about",
        icon = icon('circle-info')
      )
    )
  ),
  # =========== Body =====================
  body = dashboardBody(
    
    mystyle(),
    myparticle(),
    shinyjs::useShinyjs(),
    useSever(),
    
    tabItems(
      tabItem(
        "overview",
        overview_ui("overview")
      ),
      tabItem(
        "analytics",
        analytics_ui("analytics")
      ),
      tabItem(
        "about",
        about_ui("about")
      )
    )
  ),
  
  # =========== Footer =====================
  # footer = footer()
  rightsidebar = rightSidebar(),
  title = "L&G Dashboard"
)