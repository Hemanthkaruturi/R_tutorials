  setwd('C:/Eminent')

# Disply the pdf files in the current folder
# files_pdf_list = list.files(pattern = "pdf$")
# files_pdf_list[2]

# Read the pdf file using pdftools package
library(pdftools)
library(stringr)

#file_pdf = files_pdf_list[2]
file_pdf = 'HYDvsPNJ-split.pdf'

# Read HYDvsPNJ-split.pdf
dream11 = pdf_text(file_pdf)
class(dream11) 
length(dream11)
# Access the first element of the character vector 

 
for(p in 1:length(dream11) ) {
    
page_p = dream11[p]
page_p_teams = strsplit(page_p, '\r\n')
temp = unlist(page_p_teams)
 
if(p > 1) {

        test_total = temp[ ! nchar(temp)<200] 

        pk = str_locate_all(pattern ='Player', test_total[1])
        pk = as.data.frame(pk)

        test_total = test_total[-1]
        
        next_page_df = data.frame(
            team  = substr(test_total,1,pk[1,1]-1)
            ,p1   = substr(test_total,pk[1,1],pk[2,1]-1)
            ,p2   = substr(test_total,pk[2,1],pk[3,1]-1)
            ,p3   = substr(test_total,pk[3,1],pk[4,1]-1)
            ,p4   = substr(test_total,pk[4,1],pk[5,1]-1)
            ,p5   = substr(test_total,pk[5,1],pk[6,1]-1)
            ,p6   = substr(test_total,pk[6,1],pk[7,1]-1)
            ,p7   = substr(test_total,pk[7,1],pk[8,1]-1)
            ,p8   = substr(test_total,pk[8,1],pk[9,1]-1)
            ,p9   = substr(test_total,pk[9,1],pk[10,1]-1)    
            ,p10   = substr(test_total,pk[10,1],pk[11,1]-1)
            ,p11   = substr(test_total,pk[11,1],nchar(test_total) )
        )
        
        page_df = rbind(page_df, next_page_df)
        
            
  } else {
      
        test_total = temp[ ! nchar(temp)<200] 
        test_total = test_total[-1]
        
        pk = str_locate_all(pattern ='Player', test_total[1])
        pk = as.data.frame(pk)
        
        
        page_df = data.frame(
            team  = substr(test_total,1,pk[1,1]-1)
            ,p1   = substr(test_total,pk[1,1],pk[2,1]-1)
            ,p2   = substr(test_total,pk[2,1],pk[3,1]-1)
            ,p3   = substr(test_total,pk[3,1],pk[4,1]-1)
            ,p4   = substr(test_total,pk[4,1],pk[5,1]-1)
            ,p5   = substr(test_total,pk[5,1],pk[6,1]-1)
            ,p6   = substr(test_total,pk[6,1],pk[7,1]-1)
            ,p7   = substr(test_total,pk[7,1],pk[8,1]-1)
            ,p8   = substr(test_total,pk[8,1],pk[9,1]-1)
            ,p9   = substr(test_total,pk[9,1],pk[10,1]-1)    
            ,p10   = substr(test_total,pk[10,1],pk[11,1]-1)
            ,p11   = substr(test_total,pk[11,1],nchar(test_total) )
        )
        
         
  }

}
 
View(page_df)
  
write.table(page_df,'page.csv',sep = ',' , row.names = F, col.names = F)
 
