"""
    ExpressionFactory

Factory for creating and managing expressions.
This is the Julia equivalent of the Java ExpressionFactory class.
"""
mutable struct ExpressionFactory <: JamelObject
    simulation::Simulation
    
    ExpressionFactory(simulation::Simulation) = new(simulation)
end

get_simulation(factory::ExpressionFactory) = factory.simulation

"""
    clean_up(query::AbstractString)

Returns a query cleaned from useless parentheses and spaces.
"""
function clean_up(query::AbstractString)
    query = strip(query)
    
    if startswith(query, "+")
        return clean_up(query[2:end])
    elseif length(query) > 1 && query[1] == '(' && query[end] == ')'
        # Check if the parentheses are balanced and can be removed
        count = 1
        can_remove = true
        
        for i in 2:(length(query)-1)
            if query[i] == '('
                count += 1
            elseif query[i] == ')'
                count -= 1
                if count == 0
                    can_remove = false
                    break
                end
            end
        end
        
        if can_remove && count == 1
            return clean_up(query[2:end-1])
        end
    end
    
    return query
end

"""
    get_expression(factory::ExpressionFactory, query::AbstractString)

Returns the specified expression based on the query string.
"""
function get_expression(factory::ExpressionFactory, query::AbstractString)
    key = clean_up(query)
    
    # Try to parse as a number first
    try
        value = parse(Float64, key)
        return ConstantExpression(value)
    catch
        # Not a number, continue with other parsing
    end
    
    # Check for function calls
    if contains(key, "(") && endswith(key, ")")
        return get_function(factory, key)
    end
    
    # Check for arithmetic operations
    return parse_arithmetic(factory, key)
end

"""
    get_function(factory::ExpressionFactory, key::String)

Parses and returns a function expression.
"""
function get_function(factory::ExpressionFactory, key::String)
    if !occursin(r"\\w*\\(.*\\)", key)
        error("Bad key: '$(key)'")
    end
    
    parts = split(key, "(", limit=2)
    function_name = parts[1]
    arg_string = parts[2][1:end-1]  # Remove closing parenthesis
    
    if function_name == "isEqual"
        return get_test_equal(factory, arg_string)
    elseif function_name == "isNotEqual"
        return get_test_not_equal(factory, arg_string)
    elseif function_name == "val"
        return get_val(factory, arg_string)
    else
        error("Unknown function: '$(function_name)'")
    end
end

"""
    get_val(factory::ExpressionFactory, arg_string::String)

Creates a value expression that accesses sector or agent data.
"""
function get_val(factory::ExpressionFactory, arg_string::String)
    split_args = split(arg_string, ",", limit=2)
    sector_info = split(split_args[1], ".")
    
    sector_name = sector_info[1]
    sector = get_sector(factory.simulation, sector_name)
    
    if sector === nothing
        error("Sector not found: $(sector_name)")
    end
    
    args = split(split_args[2], ",")
    
    if length(sector_info) == 2
        # Request for specific agent data
        agent_id = sector_info[2]
        return get_individual_data_access(sector, agent_id, args)
    else
        # Request for aggregated data
        return get_data_access(sector, args)
    end
end

"""
    get_test_equal(factory::ExpressionFactory, arg_string::String)

Creates an equality test expression.
"""
function get_test_equal(factory::ExpressionFactory, arg_string::String)
    args = split(arg_string, ",")
    if length(args) != 2
        error("isEqual requires exactly 2 arguments")
    end
    
    expr1 = get_expression(factory, strip(args[1]))
    expr2 = get_expression(factory, strip(args[2]))
    
    return FunctionExpression(() -> get_value(expr1) == get_value(expr2) ? 1.0 : 0.0)
end

"""
    get_test_not_equal(factory::ExpressionFactory, arg_string::String)

Creates an inequality test expression.
"""
function get_test_not_equal(factory::ExpressionFactory, arg_string::String)
    args = split(arg_string, ",")
    if length(args) != 2
        error("isNotEqual requires exactly 2 arguments")
    end
    
    expr1 = get_expression(factory, strip(args[1]))
    expr2 = get_expression(factory, strip(args[2]))
    
    return FunctionExpression(() -> get_value(expr1) != get_value(expr2) ? 1.0 : 0.0)
end

"""
    parse_arithmetic(factory::ExpressionFactory, key::AbstractString)

Parses arithmetic expressions (+, -, *, /, %).
"""
function parse_arithmetic(factory::ExpressionFactory, key::AbstractString)
    # This is a simplified arithmetic parser
    # In a full implementation, you'd have proper operator precedence
    
    # Look for operators outside parentheses
    count = 0
    for (i, c) in enumerate(key)
        if c == '('
            count += 1
        elseif c == ')'
            count -= 1
        elseif count == 0 && i > 1
            if c == '+'
                left = get_expression(factory, key[1:i-1])
                right = get_expression(factory, key[i+1:end])
                return get_addition(left, right)
            elseif c == '-' && key[i-1] != '*' && key[i-1] != '/'
                left = get_expression(factory, key[1:i-1])
                right = get_expression(factory, key[i+1:end])
                return get_subtraction(left, right)
            elseif c == '*'
                left = get_expression(factory, key[1:i-1])
                right = get_expression(factory, key[i+1:end])
                return get_multiplication(left, right)
            elseif c == '/'
                left = get_expression(factory, key[1:i-1])
                right = get_expression(factory, key[i+1:end])
                return get_division(left, right)
            end
        end
    end
    
    # If no operators found, assume it's a variable or constant
    return ConstantExpression(0.0)  # Placeholder
end

"""
    get_addition(arg1::Expression, arg2::Expression)

Returns an addition expression.
"""
function get_addition(arg1::Expression, arg2::Expression)
    return FunctionExpression(() -> get_value(arg1) + get_value(arg2))
end

"""
    get_subtraction(arg1::Expression, arg2::Expression)

Returns a subtraction expression.
"""
function get_subtraction(arg1::Expression, arg2::Expression)
    return FunctionExpression(() -> get_value(arg1) - get_value(arg2))
end

"""
    get_multiplication(arg1::Expression, arg2::Expression)

Returns a multiplication expression.
"""
function get_multiplication(arg1::Expression, arg2::Expression)
    return FunctionExpression(() -> get_value(arg1) * get_value(arg2))
end

"""
    get_division(arg1::Expression, arg2::Expression)

Returns a division expression.
"""
function get_division(arg1::Expression, arg2::Expression)
    return FunctionExpression(() -> get_value(arg1) / get_value(arg2))
end