library(RSelenium)
library(XML)

remDr <- remoteDriver(port = 4445L)

# Főoldal megnyitása
print(paste(Sys.time(),"- Kezdés"))

remDr$open()
remDr$navigate("http://kernyilvantartas.zalajaras.hu/public/")
Sys.sleep(1)
remDr$screenshot(display = TRUE)


webElem<-remDr$findElement(using = 'xpath', value = '//*[@id="btn"]')
webElem$highlightElement()
webElem$clickElement()
print('ok')
Sys.sleep(5)
remDr$screenshot(display = TRUE)

for(i in 1:4200){
  
  webElem<-remDr$findElement(using = 'xpath', value = paste('//*[@id="lap"]/option[',i,']', sep=''))
  
  webElem$clickElement()
  
  Sys.sleep(1)
  
  remDr$screenshot(display = TRUE)
  
  html_source<-remDr$getPageSource()
  
  fileConn<-file(paste("/home/rstudio/mbvk/html/",i,".html", sep=''))
  writeChar(html_source[[1]], fileConn, useBytes=T)
  close(fileConn)
  
}