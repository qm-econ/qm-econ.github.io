using Plots
using Optim
#
beta = 0.9
x0 = 10
xstar1 = (beta + beta^2) * x0 / (1 + beta + beta^2)
xstar2 = (beta * xstar1) / (1 + beta)
#
function v1(x1, x0, beta)
    aux1 = log(x0 - x1)
    aux2 = beta * log(x1 / (1 + beta))
    aux3 = beta^2 * log((beta * x1) / (1 + beta))
    return aux1 + aux2 + aux3
end
function v2(x2, x1, beta)
    aux1 = log(x1 - x2)
    aux2 = beta * log(x2)
    return aux1 + aux2
end
## set b1 < x0 and b2 < x1
n = 100
a1 = 0
b1 = 9.99
h1 = (b1 - a1) / n
a2 = 0
b2 = 6
h2 = (b2 - a2) / n
ex1  = zeros(n)
ex2  = zeros(n)
vet1 = zeros(n)
vet2 = zeros(n)
for i = 1: n
    ex1[i]  = a1 + i * h1
    ex2[i]  = a2 + i * h2
    vet1[i] = v1(ex1[i], x0, beta)
    vet2[i] = v2(ex2[i], xstar1, beta)
end
c = 1
result1 = optimize(x -> -v1(x, x0, beta), a1, b1)
x1 = result1.minimizer
result2 = optimize(x -> -v2(x, xstar1, beta), a2, b2)
x2 = result2.minimizer
erro1 = abs(x1 - xstar1)
erro2 = abs(x2 - xstar2)
plot(ex1, vet1)
#plot(ex2, vet2)
