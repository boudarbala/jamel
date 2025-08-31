"""
    Parameters

A type for managing XML parameters and configuration.
This is the Julia equivalent of the Java Parameters class.
"""
struct Parameters
    name::String
    attributes::Dict{String, String}
    children::Vector{Parameters}
    text::String
    
    function Parameters(name::String, attributes::Dict{String, String}=Dict{String, String}(), 
                       children::Vector{Parameters}=Parameters[], text::String="")
        new(name, attributes, children, text)
    end
    
    function Parameters(xml_element)
        # This would parse an XML element in a real implementation
        # For now, create a simple structure
        new("simulation", Dict("className" => "BasicSimulation"), Parameters[], "")
    end
end

"""
    get_name(params::Parameters)

Returns the name of the parameters element.
"""
get_name(params::Parameters) = params.name

"""
    has_attribute(params::Parameters, key::String)

Returns true if the parameters has the specified attribute.
"""
has_attribute(params::Parameters, key::String) = haskey(params.attributes, key)

"""
    get_attribute(params::Parameters, key::String)

Returns the value of the specified attribute.
"""
function get_attribute(params::Parameters, key::String)
    if !haskey(params.attributes, key)
        error("Attribute not found: $(key)")
    end
    return params.attributes[key]
end

"""
    get_all(params::Parameters)

Returns all child parameters.
"""
get_all(params::Parameters) = params.children

"""
    get(params::Parameters, name::String)

Returns the child parameters with the specified name.
"""
function Base.get(params::Parameters, name::String)
    for child in params.children
        if child.name == name
            return child
        end
    end
    return nothing
end