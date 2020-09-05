using Test, BenchmarkTools, LinearAlgebra
import PAAD

function bench_tr_mul_base(x1, x2)
    z1 = x1 * x2
    z2 = tr(z1)

    grad_z1 = Matrix{eltype(z1)}(I, size(z1))
    grad_z1 * transpose(x2), transpose(x1) * grad_z1
end
#
# function bench_tr_mul_base(x1, x2)
#     z1 = x1 * x2
#     z2 = tr(z1)
#
#     grads = PAAD.gradient(tr, one(eltype(x1)), z2, z1)
#     PAAD.gradient(*, first(grads), z1, x1, x2)
# end

function bench_tr_mul_paad(x1, x2)
    z = tr(x1 * x2)
    PAAD.backward(z)
    x1.grad, x2.grad
end

function bench_tr_mul_paad_static(z, x1, x2)
    PAAD.forward(z)
    PAAD.backward(z)
    x1.grad, x2.grad
end

xv, yv = rand(30, 30), rand(30, 30)

paad_x = PAAD.Variable(xv)
paad_y = PAAD.Variable(yv)

@benchmark bench_tr_mul_paad(paad_x, paad_y)

z = tr(paad_x * paad_y)
PAAD.forward(z)

@benchmark bench_tr_mul_paad_static(z, paad_x, paad_y)

@benchmark bench_tr_mul_base(xv, yv)

println("----------------------------------------------------------------------")
println("PAAD:")
display(@benchmark bench_tr_mul_paad(paad_x, paad_y))
println()


function bench_tr_mul_paad(x1, x2)
    forward(z)
    PAAD.backward(z)
    x1.grad, x2.grad
end

x = Variable(rand(100, 100))
y = Variable(rand(100, 100))

z = tr(x * y)
@profiler for i in 1:100000
    bench_tr_mul_paad(z, x, y)
end
