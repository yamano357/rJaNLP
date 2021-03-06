% Generated by roxygen2 (4.0.2): do not edit by hand
\docType{methods}
\name{cabocha}
\alias{cabocha}
\title{Japanese Dependency Structure Analyze using CaboCha}
\usage{
\S4method{cabocha}{jaNLP}(str = "")
}
\arguments{
\item{\code{str}}{input single character vector for CaboCha analysis}
}
\value{
\describe{
 \item{\code{chunk_id}}{chunk_id}
 \item{\code{link}}{dependency-link(chunk_id)}
 \item{\code{surface}}{表層形}
 \item{\code{feature}}{品詞,品詞細分類1,品詞細分類2,品詞細分類3,活用形,活用型,原形,読み,発音}
 \item{\code{ne}}{Named Entity(based on IREX)}
 \item{\code{head_pos}}{head position}
 \item{\code{func_pos}}{function(function word) position}
 \item{\code{score}}{dependency score}
 }
}
\description{
The \code{cabocha} method of \code{jaNLP} class for Japanese Dependency Structure Analyze
}
\details{
CaboCha is Japanese Dependency Structure Analyzer created by Taku Kudo \cr \url{https://code.google.com/p/cabocha/} \cr \cr The \code{cabocha} method using CaboCha-Option "-f1 -n1"
}
\examples{
library(RjaNLP)
example <- JaNLP$new(text = "すもももももももものうち")
res.cabocha <- example$cabocha()
}

