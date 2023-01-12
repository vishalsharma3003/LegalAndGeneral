# =========== Customised highchart menu =====================

highchart_menu <- function(deal) {
  issue <- paste(
    "function() {
    $(location).attr('href', 'mailto:vishalsharma3003@gmail.com?subject='
                  + encodeURIComponent('Issue on chart : ' + this.title.textStr)
                  + '&body='
                  + encodeURIComponent('Please check issue on chart ' + '\"' + this.title.textStr + '\"' + ",
    "':",
    deal,
    "' + ",
    "'Dashboard'",
    "));
        }"
  )
  
  myMenuItems  <- list(
    list(
      text = "Export Data",
      onclick = JS("function () { this.downloadCSV(); }")
    ),
    list(
      text = "Download Image",
      onclick = JS("function () {
                  this.exportChart({ type: 'image/png' }); }")
    ),
    list(
      text = "Download PDF",
      onclick = JS(
        "function () {
                  this.exportChart({ type: 'application/pdf' }); }"
      )
    ),
    list(text = "Report Issue",
         onclick = JS(issue))
  )
  
  return(myMenuItems)
}

# =========== Customised sidebar menu =====================
sidebarMenu_custom <- function(..., title = NULL) {
  items <- list(...)
  
  div(
    id = "sidebar-menu",
    class = "main_menu_side hidden-print main_menu",
    div(
      class = "menu_section",
      if (!is.null(title))
        tags$h3(title),
      tags$ul(class = "nav side-menu",
              id = "main_tabset",
              items)
    )
  )
}


# =========== Particles =====================

js2 <- "
$(document).ready(function(){
  var $navbar = $('.main-header .navbar');
  var height = $navbar.height() + 'px';
  var leftMargin = $navbar.find('a.sidebar-toggle').css('width');
  var rightMargin = $navbar.find('.navbar-custom-menu').css('width');
  var width = `calc(100% - ${rightMargin} - ${leftMargin})`;
  $('#particles-container').css({
    position: 'relative',
    width: width,
    height: height,
    'margin-left': leftMargin
  });
  $navbar.append($('#particles-container'));
});
"

myparticle <- function() {
  tagList(
    tags$head(tags$script(HTML(js2))),
    
    tags$div(
      id = "particles-container",
      tags$div(id = "particles-target",
               style = "position: absolute;width: 100%; height: 60px; margin-top: -60px;")
    ),
    
    particles(
      target_id = "particles-target",
      element_id = "particles",
      config = particles_config(
        particles.number.value = 200L,
        particles.color.value = "#FFF",
        particles.shape.type = "star",
        particles.line_linked.color = "#FFF"
      )
    )
  )
}



# =========== Customised styles =====================
mystyle <- function() {
  tags$head(
    tags$link(rel = "shortcut icon", href = "favicon.ico"),
    tags$style(
      HTML(
        "
.wrapper{height:auto!important;position:relative;overflow-x:hidden;overflow-y:hidden}
body{color:#333;font-family:'Helvetica Neue',Roboto,Arial,'Droid Sans',sans-serif}
.box{border-top:none;margin-left:0!important;box-shadow:none}
.box .border-right{border-right:1px solid #ADB2B5}
.bg-red{background-color:#f5365c!important}
.box.box-solid>.box-body{padding:0;border:none}
.highcharts-button-box{fill:#377ca7!important}
.bannerbackground{position:relative;top:0;font-family:'Roboto',sans-serif;background-image:repeating-linear-gradient(45deg,transparent,transparent 35px,rgba(255,255,255,0.05) 35px,rgba(255,255,255,0.05) 70px),linear-gradient(#377ca7,rgba(55,124,167,0.8));padding:5px 0 15px 30px;font-size:100%;margin:0 15px 10px}
.bannerbackground h2{font-weight:500;font-family:'Roboto',sans-serif;line-height:1.1;color:#fff;display:inline-block}
.bannerbackground span{display:block;color:#fff;font-size:15px;font-family:'Roboto',sans-serif;line-height:1.1;margin-left:3px;margin-top:-5px;padding-bottom:5px}
.bannerbackground label{font-weight:500;color:#fff;font-family:'Roboto',sans-serif;font-size:16px}
.blockquote-wrapper{display:flex}
.blockquote{position:relative;font-family:'Barlow Condensed',sans-serif;max-width:620px;margin:20px auto;align-self:center}
.blockquote h1{font-family:'Abril Fatface',cursive;position:relative;color:#377ca7;font-size:2.8rem;font-weight:400;line-height:1;margin:0;border:solid 2px;border-radius:20px;padding:25px}
.blockquote a{color:#f39c12;text-decoration:underline!important}
@media all and (min-width: 600px) {
.blockquote h1{font-size:3rem;line-height:1.2}
}
.box-custom{position:relative;width:100%;max-width:750px;z-index:1;margin:40px auto;align-self:center}
.boxItem{width:100%}
.boxItem:before,.boxItem:after{content:'';width:2em;border-bottom:1px solid #337ab7;position:absolute;top:100%;padding-top:100px;margin-right:85px;margin-left:10px}
.boxItem:before{right:20%}
.boxItem:after{left:30%}
.boxItem:first-of-type:before,.boxItem:last-of-type:after{display:none}
@media only screen and (min-width: 769px) and (max-width: 1281px) {
.boxItem:before,.boxItem:after{width:1.5em;margin-left:15px}
.boxItem:before{right:20.5%}
}
.boxItem .box{border:1px solid #377ca7!important}
.boxItem .box-header{color:#777;display:block;padding:10px;position:relative;text-align:center;padding:7px 10px 4px;border-bottom:1px solid #d7d7d7}
.profile-username{font-size:20px!important;color:#666}
.btn-export-excel{position:relative;width:57px;height:78px;background:#FFF;cursor:auto}
.btn-export-excel > a{display:block;height:76px;background-size:45px 45px;background-position:center 10px;background-repeat:no-repeat;font-family:Tahoma,Arial,sans-serif;font-size:11px;color:#333;text-align:left;padding:0;margin:0;font-weight:400;text-shadow:none;background-image:url(https://www.flexmonster.com/flexmonster/toolbar/img/toolbar/menu_xls_large.png)}
.btn-export-excel > a > span{position:absolute;top:52px;line-height:10px;left:0;right:0;text-align:center}
.dataTables_scrollBody::-webkit-scrollbar-track{border:1px solid #000;background-color:#FFF}
.dataTables_scrollBody::-webkit-scrollbar{width:10px;background-color:#FFF}
.dataTables_scrollBody::-webkit-scrollbar-thumb{background:#e8eaf2;border-top:1px solid #000;border-bottom:1px solid #000}
.html-widget.gauge svg{height:135%;margin-top:-30px}
.shiny-notification-message{color:#FFF;font-weight:500;font-size:16px;text-align:center;border:none;background-color:#588BAE!important}
.shiny-notification-close{color:#FFF}
.btn-1{background:#4e89ad;color:#fff;border:1px solid #eee}
.btn-1:hover{background:#4e89ad;color:#fff}
.btn-1:active{background:#4e89ad;top:2px;color:#fff}
.btn-1:before{position:absolute;height:100%;left:0;top:0;line-height:3;font-size:140%;width:60px}
.box2 .box-header{color:#777;display:block;padding:10px;position:relative;text-align:center;padding:7px 10px 4px;border-bottom:1px solid #d7d7d7}
#mybox2 .box-title,#mybox2 .box-header{color:#377ca7!important;background:#ecf0f5;font-weight:500;font-family:'Source Sans Pro',sans-serif;font-size:22px!important}
.btn.radiobtn.btn-default.active{color:#fff;background:#408ebf}
.btn.radiobtn.btn-default{background:#FFF}
.small-box .icon-large{color:#FFFFFF78!important}
.list-group-item{padding:15px!important}
.list-group-item .fa,.fas{font-weight:900;font-size:18px}
.bootstrap-select>.dropdown-toggle{border:1px solid #f4f4f4;background:#6095b6;color:#fff;opacity:1}
.lastRow{border-top:1px solid #111!important;font-size:13px;font-weight:600;color:#1c273c;letter-spacing:.5px}
table.dataTable tr td:first-child,table.dataTable tr th:first-child{background:#f3f4f7;text-align:left!important}
table.dataTable td{font-family:'Roboto',sans-serif;font-size:14px!important;color:#1c273c!important}
table.dataTable th{display:table-cell;border-top-width:0;font-family:'Roboto',sans-serif;font-weight:700!important;font-size:13px;color:#1c273c;letter-spacing:.5px;vertical-align:middle;border-top:1px solid #111;padding-left:8px!important;padding-right:8px!important}
/*table.dataTable.stripe tbody tr.odd,table.dataTable.display tbody tr.odd{background-color:#fff!important}*/
table.dataTable tr.selected td,table.dataTable td.selected{background-color:#e4edf3!important}
expensesinfo-mytable tr:first-child td,#expensesinfo-mytable tr:last-child td{border-top:1px solid #111!important;border-bottom:1px solid #111!important;font-weight:600!important;font-size:13px!important;letter-spacing:.5px;text-transform:uppercase}
div.dt-buttons{float:right!important}
div.dt-buttons .fa,.fas{font-size:18px}
button.dt-button.buttons-collection{padding:.25em .4em .1em!important;background-color:#444!important;color:#fff!important;background-image:none!important}
div.dt-button-collection{width:120px!important;margin-left:-10px!important}
.icon2-shape{border:1px solid!important}
.icon2{width:4rem!important;height:4rem!important}
.icon2-shape i,.icon2-shape svg{font-size:2.25rem!important;font-weight:600!important}
.svg-outline{stroke:#377ca7;fill:none;margin-left:7px;width:40px!important;height:40px!important}
.svg-outline2{stroke:#377ca7!important;fill:#377ca7!important}
.svg-outline-collapsed{width:40px!important;height:40px!important}
.svg-outline-uncollapsed{width:20px!important;height:20px!important;margin-bottom:-2px}
#mybox .box>.box-body{padding:0;border:none}
#mybox .box-footer{background-color:#ecf0f5}
#mybox .pad{padding-top:0}
#mybox .col-sm-2{padding-right:0}
.box-footer{background:#ecf0f5;border-bottom-right-radius:0!important;border-bottom-left-radius:0!important}
.text-black{color:#377ca7!important}
.comparisonBox{text-align:left;background-color:#fff;position:relative;text-overflow:ellipsis;white-space:initial;border:1px solid #38699a;box-shadow:0 .46875rem 2.1875rem rgba(102,153,204,0.03),0 .9375rem 1.40625rem rgba(102,153,204,0.03),0 .25rem .53125rem rgba(102,153,204,0.05),0 .125rem .1875rem rgba(102,153,204,0.03);border-radius:.25rem;border-bottom:5px solid #377ca7;padding:10px}
.comparisonBox>.description-text{text-transform:none;color:#377ca7;font-size:16px;font-weight:500;white-space:initial;font-family:'Inter UI',sans-serif}
.comparisonBox>.description-header{font-size:30px;color:#377ca7;font-weight:500;font-family:'Source Sans Pro',sans-serif;white-space:initial}
.mycss0{font-size:13px;color:#377ca7;text-overflow:ellipsis;overflow:hidden;position:relative}
.mycss{font-size:13px;color:#377ca7;text-overflow:ellipsis;overflow:hidden;position:relative}
h5.card-title2{font-size:16px;color:#377ca7}
.mydescription-header{font-size:30px;color:#377ca7;font-weight:500;font-family:'Source Sans Pro',sans-serif;margin:0,white-space: initial}
.mydescription-header2{font-size:18px;color:#377ca7;font-weight:600}
.card2-stats .card-body{padding:.5rem 1.75rem!important;border:1px solid #38699a;box-shadow:0 .46875rem 2.1875rem rgba(102,153,204,0.03),0 .9375rem 1.40625rem rgba(102,153,204,0.03),0 .25rem .53125rem rgba(102,153,204,0.05),0 .125rem .1875rem rgba(102,153,204,0.03);border-radius:.25rem}
.mydescription-text{text-transform:none;color:#377ca7;font-size:16px;font-weight:500;white-space:initial;font-family:'Inter UI',sans-serif}
@media only screen and (min-width: 769px) and (max-width: 1281px) {
.comparisonBox{padding-left:10px}
.comparisonBox>.description-text{font-size:13px}
.comparisonBox>.description-header{font-size:24px}
.mycss{font-size:11px}
.text-green{font-size:11px}
.text-red{font-size:11px}
.mydescription-header2{font-size:15px}
.col-sm{padding-right:15px!important;padding-left:15px!important;margin-top:2px!important;margin-bottom:2px!important;box-shadow:0 .46875rem 2.1875rem rgba(102,153,204,0.03),0 .9375rem 1.40625rem rgba(102,153,204,0.03),0 .25rem .53125rem rgba(102,153,204,0.05),0 .125rem .1875rem rgba(102,153,204,0.03)}
.card2-stats .card-body{padding:.25rem 1.25rem!important}
h5.card-title2{font-size:14px}
.mb-1,.my-1{margin-bottom:0!important}
.card2-stats .card-body{border:1px solid #38699a}
.mydescription-text{font-size:12px}
.mydescription-header{font-size:24px}
#mybox2 .box-title,#mybox2 .box-header{font-size:20px!important}
}
.myClass{font-size:28px;line-height:50px;text-align:left;font-weight:600;font-family:'Helvetica Neue',Helvetica,Arial,sans-serif;padding:0 15px;overflow:hidden;color:#fff}
.myClass img{margin-bottom:5px}
        ")
    ),
    #### ---- JS ----####
    includeCSS("www/custom.css"),
    tags$script(src = "init.js"),
    tags$script(
      HTML(
        '
      $(document).ready(function() {
      $("header").find("nav").append(\'<div id="pageHeader" class="myClass"></div>\');
      });
      '
      )
    )
  )
}

# =========== Utility functions =====================

# Import all the shiny modules
ImportShinyModules <- function(path = "./modules/") {
  if (is.null(path)) {
    stop("Argument `path` is mandatory")
  }
  moduleFiles <-
    list.files(path = path,
               pattern = "\\.[Rr]",
               recursive = TRUE)
  
  for (i in 1:length(moduleFiles)) {
    moduleFilePath <- paste0(path, moduleFiles[i])
    source(moduleFilePath, encoding = "UTF-8")
  }
  
}

# Comparison box
comparisonBox <-
  function(stat = NULL,
           stat_color = NULL,
           stat_icon = NULL,
           icon = NULL,
           value = NULL,
           title = NULL,
           description = NULL,
           right_border = FALSE,
           margin_bottom = FALSE,
           customcss = FALSE) {
    cl <- "comparisonBox"
    if (isTRUE(right_border))
      cl <- paste0(cl, " border-right")
    if (isTRUE(margin_bottom))
      cl <- paste0(cl, " margin-bottom")
    
    numcl <- "description-percentage"
    if (!is.null(stat_color))
      numcl <- paste0(numcl, " text-", stat_color)
    
    shiny::tags$div(
      class = cl,
      if (!customcss) {
        shiny::tags$span(class = "description-text",
                         if (!is.null(icon))
                           shiny::tags$i(class = icon),
                         title)
      } else {
        shiny::tags$span(class = "mydescription-text",
                         if (!is.null(icon))
                           shiny::tags$i(class = icon),
                         title)
      },
      
      if (!customcss) {
        shiny::tags$h5(class = "description-header", value)
      } else {
        shiny::tags$h5(class = "mydescription-header", value)
      }
      
      ,
      shiny::tags$span(class = numcl,
                       if (!is.null(stat_icon))
                         shiny::tags$i(class = stat_icon),
                       stat),
      shiny::tags$span(class = "mycss", description)
    )
  }

# Info card
d_InfoCard <-
  function(value,
           title = NULL,
           stat = NULL,
           stat_icon = NULL,
           stat_color = NULL,
           description = NULL,
           icon = NULL,
           icon_background = "blue",
           hover_lift = TRUE,
           shadow = FALSE,
           background_color = NULL,
           gradient = FALSE,
           width = 3,
           customcss = FALSE) {
    iconCl <- "icon2 icon2-shape text-black"
    numcl <- "description-percentage"
    if (!is.null(stat_color))
      numcl <- paste0(numcl, " text-", stat_color)
    
    cardCl <- "card card2-stats mb-2"
    if (hover_lift)
      cardCl <- paste0(cardCl, " card-lift--hover")
    if (shadow)
      cardCl <- paste0(cardCl, " shadow")
    if (gradient) {
      if (!is.null(background_color))
        cardCl <- paste0(cardCl, " bg-gradient-", background_color)
    } else {
      if (!is.null(background_color))
        cardCl <- paste0(cardCl, " bg-", background_color)
    }
    
    if (!is.null(background_color))
      if (background_color == "default")
        text_color <- "text-white"
    else
      text_color <- NULL
    else
      text_color <- NULL
    
    shiny::tags$div(
      class = cardCl,
      shiny::tags$div(
        class = "card-body",
        # upper part
        shiny::fluidRow(
          Column2(if (!customcss) {
            shiny::tags$h5(class = paste0("card-title mb-1", text_color), title)
          } else {
            shiny::tags$h5(class = paste0("card-title2 mb-1", text_color), title)
          }
          
          ,
          
          if (!customcss) {
            shiny::span(class = paste0("h2 font-weight-bold", text_color), value)
          } else {
            shiny::span(class = "mydescription-header2", value)
          })
          ,
          shiny::tags$div(class = "col-auto",
                          if (!is.null(icon))
                            shiny::tags$div(class = iconCl,
                                            icon))
        ),
        # lower part
        shiny::tags$span(class = numcl,
                         if (!is.null(stat_icon))
                           shiny::tags$i(class = stat_icon),
                         stat),
        shiny::tags$span(class = "mycss0", description)
      )
    )
    
  }

# Customised column
Column2 <-
  function (...,
            width = NULL,
            center = FALSE,
            offset = NULL) {
    colCl <- "col-sm"
    if (!is.null(width))
      colCl <- paste0(" col-sm-", width)
    if (!is.null(offset))
      colCl <- paste0(colCl, " offset-sm-", offset)
    if (center)
      colCl <- paste0(colCl, " text-center")
    htmltools::tags$div(class = colCl, ...)
  }


# Customised banner
banner <- function(maintext, ..., subtext) {
  dots <-
    if (length(list(...)))
      sapply(list(...), function(x)
        as.character(
          tags$div(style = "display: inline-block; vertical-align:top; margin-top:-70px; margin-right:10px; margin-left: auto; float:right;", x)
        ))
  else
    character()
  
  dots <- paste0("    ", dots, "\n", collapse = "")
  
  subtext <-
    if (!missing(subtext))
      paste0("    <span>", subtext, "</span>\n")
  else
    ""
  
  HTML(
    paste0(
      "<div class='bannerbackground'>\n  <h2>",
      maintext,
      "</h2>\n",
      subtext,
      dots,
      "</div>\n"
    )
  )
  
}

# Customised text
mytext <- function(text) {
  htmltools::HTML(
    paste0(
      "<p style='font-size:16px; font-weight: 500; font-family: \"Roboto\", sans-serif;
                      margin-top: 5px;'>",
      text,
      "</p>"
    )
  )
  
}

# L&G Theme
lng_theme <- function(palettes = "default", ...) {
  theme <-
    list(
      chart = list(
        backgroundColor = "#FFFFFF",
        style = list(fontFamily = "Roboto",
                     color = "#213e82")
      ),
      title = list(
        align = "center",
        style = list(
          fontFamily = "Roboto",
          color = "#444",
          fontWeight = "bold"
        )
      ),
      subtitle = list(
        align = "center",
        style = list(
          fontFamily = "Roboto",
          color = "#666",
          fontWeight = "normal"
        )
      ),
      tooltip = list(
        backgroundColor = "#FFFFFF",
        borderColor = "#76c0c1",
        style = list(color = "#213e82")
      ),
      credits = list(style = list(color = "#444")),
      labels = list(style = list(color = "#D7D7D8")),
      
      drilldown = list(
        activeAxisLabelStyle = list(color = "#F0F0F3"),
        activeDataLabelStyle = list(color = "#F0F0F3")
      ),
      
      navigation = list(buttonOptions = list(
        symbolStroke = "#DDDDDD",
        theme = list(fill = "#505053")
      )),
      legendBackgroundColor = "rgba(0, 0, 0, 0.5)",
      background2 = "#505053",
      dataLabelsColor = "#B0B0B3",
      textColor = "#C0C0C0",
      contrastTextColor = "#F0F0F3",
      maskColor = "rgba(255,255,255,0.3)"
    )
  
  if (palettes == 'default') {
    # Red Blue Yellow Green
    colors = c("#f45b5b", "#7cb5ec", "#e4d354", "#f7a35c")
    theme[["colors"]] <- colors
  }
  
  theme <- structure(theme, class = "hc_theme")
  
  if (length(list(...)) > 0) {
    theme <- hc_theme_merge(theme,
                            hc_theme(...))
  }
  
  theme
}
