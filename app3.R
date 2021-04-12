library(shiny)

ui <- fluidPage(
  # App title 
  titlePanel("Generate random DNA"),
  numericInput(inputId = "n",
               "Length of the random DNA string", value = 50),
  verbatimTextOutput("txtout")
)

server <- function(input, output, session) {
  output$txtout <- renderText({
    
    random_dna <- function(l){
      nucleotides <- sample(c("A", "T", "G", "C"), size = l, replace = TRUE)
      dna = paste0(nucleotides, collapse = "")
      header = paste("> Random dna string with length", toString(l), sep = " ")
      fasta = paste(header, dna, sep = "\n")
      
      return(fasta)
    
    }
    paste(random_dna(input$n))
  }) 
}

shinyApp(ui, server)