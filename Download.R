ncbi_ids <- c("HQ433692.1","HQ433694.1","HQ433691.1") # make object called ncbi_ids containing a vector with 3 ncbi IDs(accession.version IDs), each corresponding to a different sequence of the 16S gene of Borrelia burgdorferi on GenBank
library(rentrez) # loads rentrez package (for functions related to GenBank)
Bburg<-entrez_fetch(db = "nuccore", id = ncbi_ids, rettype = "fasta") # creates object called Bburg that contains the sequences with IDs corresponding to the 3 in the vector ncbi_ids, downloaded from the NCBI Nucelotide database in fasta format
Sequences<-strsplit(Bburg, split="(?<=\n\n)", perl=TRUE) # split Sequences object into 3 element list
Sequences<-unlist(Sequences)# make Sequeneces list into a vector
header<-gsub("(^>.*sequence)\\n[ATCG].*","\\1",Sequences)# separate headers
seq<-gsub("^>.*sequence\\n([ATCG].*)","\\1",Sequences)# separate sequences
Sequences<-data.frame(Name=header,Sequence=seq)# create dataframe with two columns, Name (headers) and Sequences
Sequences<-data.frame(lapply(Sequences, function(x) {gsub("\\n", "", x)}))
write.csv(Sequences, "Sequences.csv", row.names=FALSE)
