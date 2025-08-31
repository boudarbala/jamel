"""
    JamelObject

Abstract type representing a base object in the Jamel system.
This is the Julia equivalent of the Java JamelObject class.
"""
abstract type JamelObject end

"""
    get_simulation(obj::JamelObject)

Returns the simulation associated with this object.
"""
function get_simulation(obj::JamelObject)
    error("get_simulation not implemented for $(typeof(obj))")
end

"""
    get_period(obj::JamelObject)

Returns the current period from the simulation.
"""
function get_period(obj::JamelObject)
    simulation = get_simulation(obj)
    return get_period(simulation)
end

"""
    BasicJamelObject

A basic implementation of JamelObject that holds a reference to the simulation.
"""
mutable struct BasicJamelObject <: JamelObject
    simulation::Simulation
    
    BasicJamelObject(simulation::Simulation) = new(simulation)
end

"""
    get_simulation(obj::BasicJamelObject)

Returns the simulation for this basic Jamel object.
"""
get_simulation(obj::BasicJamelObject) = obj.simulation