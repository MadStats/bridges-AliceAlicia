#####Import
library(tidyverse)
#Set work directory to where the bridge data files are downloaded.
setwd('/Users/MacBook/Desktop/479/BridgeData')
#build an empty dataframe
bridge <- data.frame()
#start a loop to go through all the years
for(i in 1992:2015){
  #get the path of each year
  wd <- paste(getwd(),"/",i,"del",sep="")
  #get all the files of each state
  allstates <- dir(wd)
  #start a loop through all the states
  for(astate in allstates){
    #make sure that the excel files won't bother
    if(length(grep('\.txt\\>',astate))==0){
      next
    }
    path <- paste(path,"/",astate,sep="")
    tmpdataframe <- read_csv(path)
    #ignore empty files
    if(nrow(tmpdataframe)==0){
      next
    }
    #variable selection
    tmpdataframe <- select(tmpdataframe,
                           STATE_CODE_001,
                           STRUCTURE_NUMBER_008,
                           PLACE_CODE_004,
                           DESIGN_LOAD_031,
                           ADT_029,
                           YEAR_ADT_030,
                           DECK_COND_058,
                           SUPERSTRUCTURE_COND_059,
                           SUBSTRUCTURE_COND_060,
                           CHANNEL_COND_061,
                           CULVERT_COND_062)
    tmpdataframe$year <- i
    tmpdataframe <- select(tmpdataframe,STATE_CODE_001,STRUCTURE_NUMBER_008,year,everything())
    bridge <- rbind(bridge,tmpdataframe)
  }
}
remove(tmpdataframe,i,astate,wd,allstates,path)
#save the data to a RDS file.
write_rds(bridge, "bridge.rds")
