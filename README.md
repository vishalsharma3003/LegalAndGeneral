# Legal and General Assignment

This dashboard has been created by Vishal Sharma as an assignment from Legal & General on the fake data generated using a random generator. This dashboard is not intended to be used for marketing purposes and should be considered only as a medium for showcasing skillset on R Shiny and related technologies. In terms of technologies, implementations of HTML, CSS, JS, can be found. Different services used in this dashboard include highcharts, bootstrap library, fontawesome, and more.

## How to use

This app follows the following structure:

* The main folder consist of ui.R, server.R, global.R which can be used to build the application
* The additional contents can be found in www folder
* The modules are stored in modules folder
* Two additional file funs.R is used to add functions

## Architechture

* This app is divided into 3 modules: Overview, Analytics, and About.
* Every module is composed of two functions 1) a piece of UI, and 2) a fragment of server logic that uses that UI – similar to the way that Shiny apps are split into UI and server logic.
* The function body of ui starts with the statement `ns <- NS(id)`. It takes the string `id` and creates a namespace function.
* All input and output IDs that appear in the function body are wrapped in a call to `ns()`.
* The ui structure follows the `fluidRow()` formats.
* The server logic is encapsulated in a single function for every module called as module server function.
* Every server function has a call to `moduleServer()`, to which two things are passed. One is the `id`, and the second is the module function.

## Optimizations

* Preprocessed data has been used in the modules to minimize calculations during running app.
* The initialization of app is less than 1 second because the data is loaded as in when required. (Check [server.R](./server.R))
* The use of `dplyr` is minimized and replaced with base R wherever possible.

## User experience

* The app has been created with an impressive UI with custom elements.
* Css has been used for some beautification.
* The elements follows shiny layouts so as to avoid any overflows.
* The categories and their colors are consistent throughout the app. For example, 'Female' is in 'red' color.
* All the maps are created using `highchars.js`

## Selling Points

* Legal and General branding colors are used
* Quick initial load of the app
* Wide variety of functionalities included
* Beautiful user interface
* Very easy to use and responsive to inputs
* Wide variety of flexibility to user and giving as much information at the same time.
* Disclaimer included in About tab to avoid any legal issues.
* Code is standardized to make it more usable

## Infrastucture

* This app can be accessed via shinyapps.io server using [https://vishalsharma.shinyapps.io/LegalAndGeneral/](https://vishalsharma.shinyapps.io/LegalAndGeneral/)
* In terms of performance, locahost > shinyapps.io


Made with :heart: by Vishal Sharma




