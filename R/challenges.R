#' @title First function
#' @description
#' Given a square matrix, calculates the average over the sum of row averages and column averages
#'
#' @param m a square matrix with no missing values
#' @return Single numerical value
#' @examples
#' m <- matrix(seq(16), nrow = 4)
#' un(m)
#' @export
un <- function(m) {
  mean(apply(m, 1, mean) + apply(m, 2, mean))
}

# fastest
un22 <- Rcpp::cppFunction("
double unCpp2(NumericVector x) {
    double total = 0;
    int n = x.size();
    for(int i = 0; i < n; ++i) {
      total += x[i];
    }
    total = total * 2 / n;
    return total;
}")

un23 <- Rcpp::cppFunction("
double unCpp3(NumericMatrix m) {
  int n = m.nrow();
  int p = m.ncol();  // Number of columns
  double sum = 0;
  for (int i = 0; i < n; i++) {
    double row_mean = 0;
    for (int j = 0; j < p; j++) {
      row_mean += m(i, j);
    }
    sum += row_mean / p;  // Divide by number of columns
  }
  return sum / 500;
}")
un2 <- function(m) {
  mean(rowMeans(m) + colMeans(m))
}
un3 <- function(m) {
  mm <- nrow(m)
  mean(.rowMeans(m, mm, mm) + .colMeans(m, mm, mm))
}
un4 <- function(m) {
  mm <- nrow(m)^2
  sum(m) * 2 / mm
}
un5 <- function(m) {
  mm <- nrow(m)^2
  sumCpp(m) * 2 / mm
}
un6 <- function(m) {
  unCpp(m)
}
un7 <- function(m) {
  sumCpp(m) * 2 / length(m)
}
# un8 <- function(m) {
#   sumCpp2(m) * 2 / length(m)
# }



#' @title Second
#' @description
#' Given a vector gives the longest continuous increasing subset
#'
#' @param vec Numerical vector with no missing values
#' @return A numerical vector containing the longest continuous increasing subset
#' @export
deux <- function(vec) {
  longest_seq <- c(vec[1]) # Longest increasing subsequence found
  current_seq <- c(vec[1]) # Current increasing subsequence

  for (i in 2:length(vec)) {
    if (vec[i] > vec[i - 1]) {
      # Continue current increasing subsequence
      current_seq <- c(current_seq, vec[i])
    } else {
      # Compare and reset current subsequence
      if (length(current_seq) > length(longest_seq)) {
        longest_seq <- current_seq
      }
      current_seq <- c(vec[i]) # Start a new subsequence
    }
  }

  if (length(current_seq) > length(longest_seq)) {
    longest_seq <- current_seq
  }

  return(longest_seq)
}

#' @title Third
#' @description
#' Given a vector return the count of each unique element
#'
#' Hint: Try looking into `tabulate`, `fastmatch::fastmatch`
#' @param vec Numerical vector
#' @return A single numerical vector with counts of each unique element
#'
#' @export
trois <- function(vec) {
  table(vec)
}
