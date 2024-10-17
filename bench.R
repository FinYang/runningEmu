bigM <- 1e6
m <- matrix(rnorm(bigM), nrow = as.integer(sqrt(bigM)))


devtools::load_all()
bench::mark(
  un(m),
  un22(m),
  un23(m),
  un3(m),
  un4(m),
  un5(m),
  un6(m),
  un7(m),
  # check = FALSE,
  iterations = 100
)

Rcpp::cppFunction("
double unCpp(NumericVector x) {
    double total = 0;
    int n = x.size();
    for(int i = 0; i < n; ++i) {
      total += x[i];
    }
    total = total * 2 / n;
    return total;
}
")
