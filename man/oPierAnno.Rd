% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/oPierAnno.r
\name{oPierAnno}
\alias{oPierAnno}
\title{Function to prioritise seed genes only from a list of pNode objects using annotation data}
\usage{
oPierAnno(
data,
list_pNode,
network = c("STRING_highest", "STRING_high", "STRING_medium",
"STRING_low",
"PCommonsUN_high", "PCommonsUN_medium", "PCommonsDN_high",
"PCommonsDN_medium",
"PCommonsDN_Reactome", "PCommonsDN_KEGG", "PCommonsDN_HumanCyc",
"PCommonsDN_PID",
"PCommonsDN_PANTHER", "PCommonsDN_ReconX", "PCommonsDN_TRANSFAC",
"PCommonsDN_PhosphoSite", "PCommonsDN_CTD", "KEGG", "KEGG_metabolism",
"KEGG_genetic", "KEGG_environmental", "KEGG_cellular",
"KEGG_organismal",
"KEGG_disease"),
STRING.only = c(NA, "neighborhood_score", "fusion_score",
"cooccurence_score",
"coexpression_score", "experimental_score", "database_score",
"textmining_score")[1],
weighted = FALSE,
network.customised = NULL,
seeds.inclusive = TRUE,
normalise = c("laplacian", "row", "column", "none"),
restart = 0.7,
normalise.affinity.matrix = c("none", "quantile"),
verbose = TRUE,
placeholder = "http://galahad.well.ox.ac.uk/bigdata",
guid = NULL
)
}
\arguments{
\item{data}{a data frame with two columns: 1st column for seed/node
names, 2nd column for the weight values. It intends to store annotation
data or something similar}

\item{list_pNode}{a list of "pNode" objects or a "pNode" object.
Alternatively, it is NULL, meaning no restrictioin}

\item{network}{the built-in network. Currently two sources of network
information are supported: the STRING database (version 10) and the
Pathways Commons database (version 7). STRING is a meta-integration of
undirect interactions from the functional aspect, while Pathways
Commons mainly contains both undirect and direct interactions from the
physical/pathway aspect. Both have scores to control the confidence of
interactions. Therefore, the user can choose the different quality of
the interactions. In STRING, "STRING_highest" indicates interactions
with highest confidence (confidence scores>=900), "STRING_high" for
interactions with high confidence (confidence scores>=700),
"STRING_medium" for interactions with medium confidence (confidence
scores>=400), and "STRING_low" for interactions with low confidence
(confidence scores>=150). For undirect/physical interactions from
Pathways Commons, "PCommonsUN_high" indicates undirect interactions
with high confidence (supported with the PubMed references plus at
least 2 different sources), "PCommonsUN_medium" for undirect
interactions with medium confidence (supported with the PubMed
references). For direct (pathway-merged) interactions from Pathways
Commons, "PCommonsDN_high" indicates direct interactions with high
confidence (supported with the PubMed references plus at least 2
different sources), and "PCommonsUN_medium" for direct interactions
with medium confidence (supported with the PubMed references). In
addtion to pooled version of pathways from all data sources, the user
can also choose the pathway-merged network from individual sources,
that is, "PCommonsDN_Reactome" for those from Reactome,
"PCommonsDN_KEGG" for those from KEGG, "PCommonsDN_HumanCyc" for those
from HumanCyc, "PCommonsDN_PID" for those froom PID,
"PCommonsDN_PANTHER" for those from PANTHER, "PCommonsDN_ReconX" for
those from ReconX, "PCommonsDN_TRANSFAC" for those from TRANSFAC,
"PCommonsDN_PhosphoSite" for those from PhosphoSite, and
"PCommonsDN_CTD" for those from CTD. For direct (pathway-merged)
interactions sourced from KEGG, it can be 'KEGG' for all,
'KEGG_metabolism' for pathways grouped into 'Metabolism',
'KEGG_genetic' for 'Genetic Information Processing' pathways,
'KEGG_environmental' for 'Environmental Information Processing'
pathways, 'KEGG_cellular' for 'Cellular Processes' pathways,
'KEGG_organismal' for 'Organismal Systems' pathways, and 'KEGG_disease'
for 'Human Diseases' pathways}

\item{STRING.only}{the further restriction of STRING by interaction
type. If NA, no such restriction. Otherwide, it can be one or more of
"neighborhood_score","fusion_score","cooccurence_score","coexpression_score","experimental_score","database_score","textmining_score".
Useful options are c("experimental_score","database_score"): only
experimental data (extracted from BIND, DIP, GRID, HPRD, IntAct, MINT,
and PID) and curated data (extracted from Biocarta, BioCyc, GO, KEGG,
and Reactome) are used}

\item{weighted}{logical to indicate whether edge weights should be
considered. By default, it sets to false. If true, it only works for
the network from the STRING database}

\item{network.customised}{an object of class "igraph". By default, it
is NULL. It is designed to allow the user analysing their customised
network data that are not listed in the above argument 'network'. This
customisation (if provided) has the high priority over built-in
network. If the user provides the "igraph" object with the "weight"
edge attribute, RWR will assume to walk on the weighted network}

\item{seeds.inclusive}{logical to indicate whether non-network seed
genes are included for prioritisation. If TRUE (by default), these
genes will be added to the netowrk}

\item{normalise}{the way to normalise the adjacency matrix of the input
graph. It can be 'laplacian' for laplacian normalisation, 'row' for
row-wise normalisation, 'column' for column-wise normalisation, or
'none'}

\item{restart}{the restart probability used for Random Walk with
Restart (RWR). The restart probability takes the value from 0 to 1,
controlling the range from the starting nodes/seeds that the walker
will explore. The higher the value, the more likely the walker is to
visit the nodes centered on the starting nodes. At the extreme when the
restart probability is zero, the walker moves freely to the neighbors
at each step without restarting from seeds, i.e., following a random
walk (RW)}

\item{normalise.affinity.matrix}{the way to normalise the output
affinity matrix. It can be 'none' for no normalisation, 'quantile' for
quantile normalisation to ensure that columns (if multiple) of the
output affinity matrix have the same quantiles}

\item{verbose}{logical to indicate whether the messages will be
displayed in the screen. By default, it sets to true for display}

\item{placeholder}{the characters to tell the location of built-in RDS
files. See \code{\link{oRDS}} for details}

\item{guid}{a valid (5-character) Global Unique IDentifier for an OSF
project. See \code{\link{oRDS}} for details}
}
\value{
an object of class "pNode", a list with following components:
\itemize{
\item{\code{priority}: a matrix of nNode X 6 containing node priority
information, where nNode is the number of nodes in the input graph, and
the 5 columns are "name" (node names), "node" (1 for network genes, 0
for non-network seed genes), "seed" (1 for seeds, 0 for non-seeds),
"weight" (weight values), "priority" (the priority scores that are
rescaled to the range [0,1]), "rank" (ranks of the priority scores),
"description" (node description)}
\item{\code{g}: an input "igraph" object}
\item{\code{call}: the call that produced this result}
}
}
\description{
\code{oPierAnno} is supposed to prioritise seed genes only from a list
of pNode objects using annotation data. To prioritise genes, it first
extracts seed genes from a list of pNode objects and then scores seed
genes using annotation data (or something similar). It implements
Random Walk with Restart (RWR) and calculates the affinity score of all
nodes in the graph to the seeds. The priority score is the affinity
score. Parallel computing is also supported for Linux-like or Windows
operating systems. It returns an object of class "pNode".
}
\note{
The input graph will treat as an unweighted graph if there is no
'weight' edge attribute associated with
}
\examples{
\dontrun{
# a) provide the seed nodes/genes with the weight info
## load ImmunoBase
ImmunoBase <- oRDS(RData.customised='ImmunoBase',
placeholder=placeholder)
## get genes within 500kb away from AS GWAS lead SNPs
seeds.genes <- ImmunoBase$AS$genes_variants
## seeds weighted according to distance away from lead SNPs
data <- 1- seeds.genes/500000

# b) perform priority analysis
pNode <- oPierGenes(data=data, network="PCommonsDN_medium",restart=0.7,
placeholder=placeholder)

# c) get annotation data
data.file <- file.path(placeholder, "iAnno.txt")
iA <- read.delim(data.file, header=TRUE, stringsAsFactors=FALSE)[,
1:14]
data_anno <- subset(iA, OMIM>0, select=c("Symbol","OMIM"))

# d) perform priority analysis using annotation data
pNode_anno <- oPierAnno(data_anno, list_pNode=pNode,
network="PCommonsDN_medium", restart=0.7, placeholder=placeholder)

# c) save to the file called 'Genes_priority.Anno.txt'
write.table(pNode_anno$priority, file="Genes_priority.Anno.txt",
sep="\t", row.names=FALSE)
}
}
\seealso{
\code{\link{oPierMatrix}}, \code{\link{oPierGenes}}
}
