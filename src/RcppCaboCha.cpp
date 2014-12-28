//' @useDynLib RjaNLP
//' @importFrom Rcpp evalCpp

// [[Rcpp::depends(Rcpp11)]]
// [[Rcpp::depends(BH)]]

#define RCPP11_DISABLE_AUTOMATIC_USING_NAMESPACE
#include <Rcpp.h>
#include <stdio.h>
#include <string>
#include <vector>
#include <cabocha.h>

#include <boost/range/irange.hpp>

using namespace Rcpp;
using namespace CaboCha;


// [[Rcpp::export]]
DataFrame executeCabocha(SEXP str) {
  
  std::string input = Rcpp::as<std::string>(str);
  
  std::vector<int> link;
  std::vector<unsigned short int> chunk_id, head_pos, func_pos;
  std::vector<std::string> surface, feature, ne;
  std::vector<float> score;
  
  // CaboChaパーサーを生成して、入力文の係り受け解析結果を受け取る
  CaboCha::Parser* parser = createParser("-f1 -n1");
  const CaboCha::Tree *tree = parser->parse(input.c_str());
  
//  std::cout << cabocha_sparse_tostr(cabocha_new2("-f1 -n1"), input.c_str()) << std::endl;
  
  int cid = -1;
  for (auto i : boost::irange(0, int(tree->size()))) {
      const CaboCha::Token *token = tree->token(i);
      
      surface.push_back(std::string(token->surface));
      feature.push_back(std::string(token->feature));
      ne.push_back(std::string(token->ne ? token->ne : "O"));

      if (token->chunk != NULL) {
        cid++;
        chunk_id.push_back(cid);
        link.push_back(token->chunk->link);
        head_pos.push_back(token->chunk->head_pos);
        func_pos.push_back(token->chunk->func_pos);
        score.push_back(token->chunk->score);
      } else {
        chunk_id.push_back(cid);
        link.push_back(link.back());
        head_pos.push_back(head_pos.back());
        func_pos.push_back(func_pos.back());
        score.push_back(score.back());
      }
  }
  
  // Rcpp::Dataframe::createだとエラー
  // Rcpp::List::createをwrapsしてDataFrameで返す
  return wrap(
    Rcpp::List::create(
      Rcpp::Named("chunk_id") = chunk_id,
      Rcpp::Named("link") = link,
      Rcpp::Named("surface") = surface,
      Rcpp::Named("feature") = feature,
      Rcpp::Named("ne") = ne,
      Rcpp::Named("head_pos") = head_pos,
      Rcpp::Named("func_pos") = func_pos,
      Rcpp::Named("score") = score
    )
  );
}

