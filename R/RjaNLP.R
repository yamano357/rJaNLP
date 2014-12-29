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
#'  rJava
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
    kuromoji_jar = NA,
    initialize = function(text, kuromoji_jar) {
      if (!missing(text)) {
        self$text <- text
      } else {
        self$text <- ""
      }
      if (!missing(kuromoji_jar)) {
        self$kuromoji_jar <- kuromoji_jar
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
    },
    kuromoji = function(set.mode = NULL) {
      if (is.na(self$kuromoji_jar)) {
        
      } else {
        if (!is.na(self$text)) {
          executeKuromoji(str = self$text, set.mode, jar.path = self$kuromoji_jar)
        } else {
          executeKuromoji(str = "", set.mode, jar.path = self$kuromoji_jar)
        }
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


#' Japanese Part-of-Speech and Morphological Analyze using Kuromoji
#'
#' The \code{kuromoji} method of \code{jaNLP} class for Japanese PoS tagging and morphological analyze
#'
#' "Kuromoji is an open source Japanese morphological analyzer written in Java." \cr \url{http://www.atilika.org}
#'
#' @name kuromoji
#' @aliases kuromoji
#' @rdname kuromoji
#' @docType methods
#'
#' @usage \S4method{kuromoji}{jaNLP}(str = "", set.mode = NULL, jar.path = NULL)
#' @param \code{str} input single character vector for Kuromoji analysis
#' @param \code{set.mode} set Kuromoji's segmentation modes (default: "Normal"). See \url{http://www.atilika.org}[Kuromoji] "Designed for search"
#' @param \code{jar.path} kuromoji.jar file path (default: "./libs/kuromoji-0.7.7.jar")
#' @return  
#'  \describe{
#'  \item{\code{surface}}{表層形}
#'  \item{\code{feature}}{品詞,品詞細分類1,品詞細分類2,品詞細分類3,活用形,活用型,原形,読み,発音}
#'  \item{\code{is_know}}{"Returns true if this token is known word"}
#'  \item{\code{is_unk}}{"Returns true if this token is unknown word"}
#'  \item{\code{is_user}}{"Returns true if this token is defined in user dictionary"}
#'  \item{\code{mode}}{segmentation modes}
#'  }
#' @examples
#' library(RjaNLP)
#' example <- JaNLP$new(
#'  text = "日本経済新聞でモバゲーの記事を読んだ",
#'  kuromoji_jar = "./libs/kuromoji-0.7.7.jar"
#' )
#' normal.res <- example$kuromoji()
#' search.res <- example$kuromoji(set.mode = "SEARCH")
#' extend.res <- example$kuromoji(set.mode = "EXTENDED")
NULL

