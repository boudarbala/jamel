"""
    Agent

Abstract type representing an agent in the simulation.
This is the Julia equivalent of the Java Agent interface.
"""
abstract type Agent end

"""
    get_name(agent::Agent)

Returns the name of the agent.
"""
function get_name(agent::Agent)
    error("get_name not implemented for $(typeof(agent))")
end

"""
    get_data(agent::Agent, key::String)

Returns the data associated with the given key.
"""
function get_data(agent::Agent, key::String)
    error("get_data not implemented for $(typeof(agent))")
end

"""
    get_simulation(agent::Agent)

Returns the simulation that contains this agent.
"""
function get_simulation(agent::Agent)
    error("get_simulation not implemented for $(typeof(agent))")
end

"""
    get_dataset(agent::Agent)

Returns the dataset for this agent.
"""
function get_dataset(agent::Agent)
    error("get_dataset not implemented for $(typeof(agent))")
end

"""
    do_event!(agent::Agent, event)

Executes the specified event on this agent.
"""
function do_event!(agent::Agent, event)
    error("do_event! not implemented for $(typeof(agent))")
end