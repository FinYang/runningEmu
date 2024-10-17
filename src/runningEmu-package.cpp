#include <Rcpp.h>
using namespace Rcpp;

double sumCpp(NumericVector x) {
    double total = 0;
    int n = x.size();
    for(int i = 0; i < n; ++i) {
      total += x[i];
    }
    return total;
  }

double unCpp(NumericVector x) {
    double total = 0;
    int n = x.size();
    for(int i = 0; i < n; ++i) {
      total += x[i];
    }
    total = total * 2 / n;
    return total;
  }