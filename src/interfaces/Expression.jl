"""
    Expression

Abstract type representing an expression that can be evaluated to get a numerical value.
This is the Julia equivalent of the Java Expression interface.
"""
abstract type Expression end

"""
    get_value(expr::Expression)

Returns the numerical value of this expression.
"""
function get_value(expr::Expression)
    error("get_value not implemented for $(typeof(expr))")
end

# Convenience method for calling get_value
(expr::Expression)() = get_value(expr)

"""
    ConstantExpression

A simple expression that returns a constant value.
"""
struct ConstantExpression <: Expression
    value::Float64
end

get_value(expr::ConstantExpression) = expr.value

"""
    FunctionExpression

An expression that evaluates a function to get its value.
"""
struct FunctionExpression <: Expression
    func::Function
end

get_value(expr::FunctionExpression) = expr.func()

# String representation
Base.string(expr::ConstantExpression) = string(expr.value)
Base.string(expr::FunctionExpression) = "function_expression"
Base.show(io::IO, expr::Expression) = print(io, string(expr))