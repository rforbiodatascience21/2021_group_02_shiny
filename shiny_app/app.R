library(shiny)

ui <- fluidPage(
  # App title 
  titlePanel("Generate random sequence (DNA, RNA, Protein)"),
  selectInput("output_type", label = "Sequence type", choices = c("RNA", "DNA", "Protein")),
  numericInput(inputId = "n",
               "Length of the random sequence", value = 50),
  verbatimTextOutput("txtout")
)

server <- function(input, output, session) {
  output$txtout <- renderText({
    
    random_dna <- function(t,l){
      if (t == "RNA") {
        seq = c("A", "U", "G", "C")
      }
      else if (t == "DNA") {
        seq = c("A", "T", "G", "C")
      }
      else if (t == "Protein") {
        seq = c("F","S","Y","L","P","H","R",
                "K","D","E","T","N","Q","C",
                "U","G","A","V","I", "M", "W" )
      }
      nucleotides <- sample(seq, size = l, replace = TRUE)
      fullSeq = paste0(nucleotides, collapse = "")
      header = paste("> Random sequence with length", toString(l), sep = " ")
      fasta = paste(header, fullSeq, sep = "\n")
      
      return(fasta)
      
    }
    paste(random_dna(input$output_type, input$n))
  }) 
}

shinyApp(ui, server)