
executeKuromoji <- function (str, set.mode = NULL, jar.path) {
  library(rJava)
  if (is.null(str) || str == "") {
    return (
      data.frame(
        surface = "",
        feature = "",
        is_know = "",
        is_unk = "",
        is_user = "",
        mode = ""
      )[0, ]
    )
  }
  
  .jinit(classpath = "", force.init = FALSE)
  #  print (.jclassPath())
  .jaddClassPath(jar.path)

  mode <- J(class = "org.atilika.kuromoji.Tokenizer$Mode")
  builder <- J(class = "org.atilika.kuromoji.Tokenizer", method = "builder")
  if (!is.null(set.mode)) {
    if (set.mode == "SEARCH") {
      builder <- builder$mode(mode$SEARCH)
    } else if (set.mode == "EXTENDED") {
      builder <- builder$mode(mode$EXTENDED)      
    } else {
      set.mode <- "NORMAL"
    }
  } else {
    set.mode <- "NORMAL"
  }
  
  tokenizer <- builder$build()
  tokened <- tokenizer$tokenize(str)
    
  return (
    as.data.frame(
      do.call("rbind", lapply(as.list(tokened), function (token) {
        list(
          surface = token$getSurfaceForm(),
          feature = token$getAllFeatures(),
          is_know = token$isKnown(),
          is_unk = token$isUnknown(),
          is_user = token$isUser(),
          mode = set.mode
        )
      }
    ))
   )
  )
}
