// This file was generated by Rcpp::compileAttributes
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <Rcpp.h>

using namespace Rcpp;

// executeCabocha
DataFrame executeCabocha(SEXP str);
RcppExport SEXP RjaNLP_executeCabocha(SEXP strSEXP) {
BEGIN_RCPP
    SEXP __sexp_result;
    {
        Rcpp::RNGScope __rngScope;
        Rcpp::traits::input_parameter< SEXP >::type str(strSEXP );
        DataFrame __result = executeCabocha(str);
        PROTECT(__sexp_result = Rcpp::wrap(__result));
    }
    UNPROTECT(1);
    return __sexp_result;
END_RCPP
}
// executeMecab
DataFrame executeMecab(SEXP str);
RcppExport SEXP RjaNLP_executeMecab(SEXP strSEXP) {
BEGIN_RCPP
    SEXP __sexp_result;
    {
        Rcpp::RNGScope __rngScope;
        Rcpp::traits::input_parameter< SEXP >::type str(strSEXP );
        DataFrame __result = executeMecab(str);
        PROTECT(__sexp_result = Rcpp::wrap(__result));
    }
    UNPROTECT(1);
    return __sexp_result;
END_RCPP
}