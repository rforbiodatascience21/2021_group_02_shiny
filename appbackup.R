library(shiny)

ui <- fluidPage(
  # App title 
  titlePanel("Generate random DNA"),
  selectInput("output_type", label = "Nucleotide type", choices = c("RNA", "DNA")),
  numericInput(inputId = "n",
               "Length of the random DNA string", value = 50),
  verbatimTextOutput("txtout")
)

server <- function(input, output, session) {
  output$txtout <- renderText({
    
    random_dna <- function(t,l){
      if (t == "RNA") {
        nuc = c("A", "U", "G", "C")
      }
      if (t == "DNA") {
        nuc = c("A", "T", "G", "C")
      }
      nucleotides <- sample(nuc, size = l, replace = TRUE)
      dna = paste0(nucleotides, collapse = "")
      header = paste("> Random Nucleotide string with length", toString(l), sep = " ")
      fasta = paste(header, dna, sep = "\n")
      
      return(fasta)
      
    }
    paste(random_dna(input$output_type, input$n))
  }) 
}

shinyApp(ui, server)