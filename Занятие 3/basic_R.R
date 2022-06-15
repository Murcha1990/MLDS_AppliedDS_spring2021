# Базовые операции в R

# ==== README ====
# If Cyrillic text is unreadable, go File -> Reopen with Encoding... -> UTF8
#
# To execute this file, go to 
# https://www.rstudio.com/products/rstudio/download/#download
# and install (1) R + (2) RStudio using the links there.

# ==== Базовые арифметические операции ====

2 + 2

3 + 3

2 - 3

2 * 4

sqrt(4)

# ==== Переменные ====

x = 3
x <- 3
3 -> x

a = 3.14 # numeric
c = TRUE # logical
d = "some string" # character

class(a)
class(c)
class(d)

# ==== Векторы и матрицы ====

my_vec = c(1, 2, 3)
my_other_vec = c(1, 2, 3, 4, 5)

my_vec[2] # индексация -- всегда с 1
my_other_vec[2:4]
my_other_vec[3:length(my_other_vec)]

sum(my_vec)
mean(my_vec)
var(my_vec)


a = c(1, 2, 3)
b = c(4, 5, 6)

a + b
a / b

seq(1, 5, 1)

a[a < 2]

A = matrix(seq(2, 10), nrow = 3, byrow = TRUE)
A
A[1, 2]
A[,1]
A[1,]

rowSums(A)
t(A)
solve(A)
B = A + diag(3)
solve(B)

A + B
A * B

A %*% B

# ==== Data Frames ====

name = c("A", "B", "C")
year = c(1991, 1992, 1993)
color = c("red", "green", "blue")

df = data.frame(name, year, color)
df

df$name
df[1:2, "year"]
df[df$year >= 1992, ]

# ==== Факторные переменные ====

age = c("Low", "Med", "High", "Low")
f_age = factor(age, ordered = TRUE, levels = c("Low", "Med", "High"))

# my_vec[3]
# lists[[3]], array

# ==== Условия и циклы ====

for (i in seq(1, 5, 1)) {
  print(i)
}

a = 0
while (a < 4) {
  a = a + rnorm(1)
  print(a)
}

if (a > 0) {
  print("yes")
} else {
  print("no")
}

# ==== Функции ====

my_sum_func = function(x, y) {
  return (x + y)
}

my_sum_func(3, 4)

# ==== Пакеты ====

install.packages("tseries") # CRAN
library(tseries)