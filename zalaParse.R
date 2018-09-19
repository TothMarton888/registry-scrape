library(RSelenium)

library(XML)

doc_html = htmlTreeParse("Kereskedelmi Nyilvántartási Rendszer Public.html",
                         useInternal = TRUE)

# Fejléc -----------------

table_header<-NULL

for(i in 1:41){
  xpath = paste('/html/body/div[1]/div[3]/div[1]/div/div[', i, ']')
  doc_html_name_value <- xpathApply(doc_html, xpath, function(x) { list(name=xmlName(x), content=xmlValue(x)); })
  clean_content = gsub("\n","",doc_html_name_value[[1]]$content,fixed=T) 
  clean_content = gsub("\t","",clean_content,fixed=T)
  clean_content = trimws(clean_content)
  table_header<-append(table_header, clean_content)
  }

# Táblázat tartalma --------------
# Első sor -----------------------
table_row <-NULL

for(i in 1:41){
xpath = paste('/html/body/div[1]/div[3]/div[2]/div/div[', i, ']')
doc_html_name_value <- xpathApply(doc_html, xpath, function(x) { list(name=xmlName(x), content=xmlValue(x)); })
clean_content = gsub("\n","",doc_html_name_value[[1]]$content,fixed=T) 
clean_content = gsub("\t","",clean_content,fixed=T)
clean_content = trimws(clean_content)
table_row<-append(table_row, clean_content)
}
table_contents<-table_row

# Többi sor -----------------------
for(j in 2:100){
  table_row <-NULL
  for(i in (41*(j-1)+1):(41*j)){
    xpath = paste('/html/body/div[1]/div[3]/div[2]/div/div[', i, ']')
    doc_html_name_value <- xpathApply(doc_html, xpath, function(x) { list(name=xmlName(x), content=xmlValue(x)); })
    clean_content = gsub("\n","",doc_html_name_value[[1]]$content,fixed=T) 
    clean_content = gsub("\t","",clean_content,fixed=T)
    clean_content = trimws(clean_content)
    print(clean_content)
    table_row<-append(table_row, clean_content)
    }
  table_contents = rbind(table_row, table_contents)
}

colnames(table_contents) = header
row.names(table_contents) <- c(1:100)
