//' @useDynLib RjaNLP
//' @importFrom Rcpp evalCpp

// [[Rcpp::depends(Rcpp11)]]
// [[Rcpp::depends(BH)]]

#define RCPP11_DISABLE_AUTOMATIC_USING_NAMESPACE
#include <Rcpp.h>
#include <stdio.h>
#include <string>
#include <vector>
#include <mecab.h>

#include <boost/range/irange.hpp>

using namespace Rcpp;
using namespace MeCab;


// [[Rcpp::export]]
DataFrame executeMecab(SEXP str) {

  std::string input = Rcpp::as<std::string>(str);
  
  std::vector<std::string> surface, feature;
  std::vector<unsigned short> posid, wcost;
  std::vector<unsigned long> cost;
  std::vector<unsigned char> char_type, stat;
  std::vector<float> alpha, beta, prob;
  
  // MeCabタガーを生成して、入力文の形態素解析結果を受け取る
  MeCab::Tagger *tagger = MeCab::createTagger("-l 2");
  const MeCab::Node* node = tagger->parseToNode(input.c_str());

  std::vector<std::string> strs;
  for (; node; node = node->next) {
      if (node->stat == MECAB_NOR_NODE || node->stat == MECAB_UNK_NODE) {
        surface.push_back(std::string(node->surface, node->length));
        feature.push_back(std::string(node->feature));
                
        posid.push_back(node->posid);
        cost.push_back(node->cost);
        wcost.push_back(node->wcost);
        char_type.push_back(node->char_type);
        stat.push_back(node->stat);
        
        alpha.push_back(node->alpha);
        beta.push_back(node->beta);
        prob.push_back(node->prob);        

      }
  }  

  // Rcpp::Dataframe::createだとエラー
  // Rcpp::List::createをwrapsしてDataFrameで返す
  return wrap(
    Rcpp::List::create(
      Rcpp::Named("surface") = surface,
      Rcpp::Named("posid") = posid,
      Rcpp::Named("feature") = feature,
      Rcpp::Named("char_type") = char_type,
      Rcpp::Named("stat") = stat,
      Rcpp::Named("cost") = cost,
      Rcpp::Named("wcost") = wcost,
      Rcpp::Named("alpha") = alpha,
      Rcpp::Named("beta") = beta,
      Rcpp::Named("prob") = prob
    )
  );
}
