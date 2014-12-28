#' Japanese NLP package for R
#'
#' RjaNLP is Natural Language Processing package for Japanese documents
#'
#' This package is NLP tool(MeCab, CaboCha and so on) wrapper object \cr and include text data process method
#'
#' @name RjaNLP-package
#' @aliases RjaNLP-package
#' @rdname RjaNLP_package
#' @docType package
#' @keywords documentation
#'
#' @author
#' Author: Yoshiaki AMANO. \cr
#' Maintainer: Yoshiaki AMANO. \cr
#' Twitter: @@yamano357
#' @seealso 
#' \code{\link[openNLP:Parse_Annotator]{openNLP::Parse_Annotator}} \cr
#' \code{\link[NLP:annotators]{NLP::annotators}} \cr
#' \code{\link[tm:tokenizer]{tm::tokenizer}} 
#' @import R6
#'  Rcpp
#'  Rcpp11
#'  BH
#' @exportPattern '^[[:alpha:]]+' 
NULL


library(R6)
library(Rcpp)
library(Rcpp11)
library(BH)

JaNLP <- R6Class(
  classname = "jaNLP",
  portable = FALSE,
  public = list(
    text = NA,
    initialize = function(text) {
      if (!missing(text)) {
        self$text <- text
      } else {
        self$text <- ""
      }
    },
    mecab = function() {
      if (!is.na(self$text)) {
        executeMecab(str = self$text)
      } else {
        executeMecab(str = "")
      }
    },
    cabocha = function() {
      if (!is.na(self$text)) {
        executeCabocha(str = self$text)
      } else {
        executeCabocha(str = "")
      }
    }
  )
)


#' Japanese Part-of-Speech and Morphological Analyze using MeCab
#'
#' The \code{mecab} method of \code{jaNLP} class for Japanese PoS tagging and morphological analyze
#'
#' MeCab is Part-of-Speech and Morphological Analyzer created by Taku Kudo \cr \url{https://code.google.com/p/mecab/} \cr \cr The \code{mecab} method using MeCab-Option "-l 2" \cr See \url{http://mecab.googlecode.com/svn/trunk/mecab/doc/index.html}
#'
#' @name mecab
#' @aliases mecab
#' @rdname mecab
#' @docType methods
#'
#' @usage \S4method{mecab}{jaNLP}(str = "")
#' @param \code{str} input single character vector for MeCab analysis
#' @return  
#'  \describe{
#'  \item{\code{surface}}{表層形}
#'  \item{\code{posid}}{pos-id \url{http://mecab.googlecode.com/svn/trunk/mecab/doc/posid.html}}
#'  \item{\code{feature}}{品詞,品詞細分類1,品詞細分類2,品詞細分類3,活用形,活用型,原形,読み,発音}
#'  \item{\code{char_type}}{char.def}
#'  \item{\code{stat}}{MECAB_NOR=0, MECAB_UNK=1, MECAB_BOS=2, MECAB_EOS=3}
#'  \item{\code{cost}}{cumulative cost}
#'  \item{\code{wcost}}{word occur cost}
#'  \item{\code{alpha}}{foward log prob}
#'  \item{\code{beta}}{backward log prob}
#'  \item{\code{prob}}{marginal probability}
#'  }
#' @examples
#' library(RjaNLP)
#' example <- JaNLP$new(text = "すもももももももものうち")
#' res.mecab <- example$mecab()
#' example <- JaNLP$new(text = "")
#' example$mecab()
NULL

#' Japanese Dependency Structure Analyze using CaboCha
#'
#' The \code{cabocha} method of \code{jaNLP} class for Japanese Dependency Structure Analyze
#'
#' CaboCha is Japanese Dependency Structure Analyzer created by Taku Kudo \cr \url{https://code.google.com/p/cabocha/} \cr \cr The \code{cabocha} method using CaboCha-Option "-f1 -n1"
#'
#' @name cabocha
#' @aliases cabocha
#' @rdname cabocha
#' @docType methods
#'
#' @usage \S4method{cabocha}{jaNLP}(str = "")
#' @param \code{str} input single character vector for CaboCha analysis
#' @return  
#'  \describe{
#'  \item{\code{chunk_id}}{chunk_id}
#'  \item{\code{link}}{dependency-link(chunk_id)}
#'  \item{\code{surface}}{表層形}
#'  \item{\code{feature}}{品詞,品詞細分類1,品詞細分類2,品詞細分類3,活用形,活用型,原形,読み,発音}
#'  \item{\code{ne}}{Named Entity(based on IREX)}
#'  \item{\code{head_pos}}{head position}
#'  \item{\code{func_pos}}{function(function word) position}
#'  \item{\code{score}}{dependency score}
#'  }
#' @examples
#' library(RjaNLP)
#' example <- JaNLP$new(text = "すもももももももものうち")
#' res.cabocha <- example$cabocha()
NULL

