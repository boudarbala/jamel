"""
    Phase

Abstract type representing a phase in the simulation.
This is the Julia equivalent of the Java Phase interface.
"""
abstract type Phase end

"""
    run!(phase::Phase)

Executes the phase.
"""
function run!(phase::Phase)
    error("run! not implemented for $(typeof(phase))")
end

"""
    get_name(phase::Phase)

Returns the name of the phase.
"""
function get_name(phase::Phase)
    error("get_name not implemented for $(typeof(phase))")
end