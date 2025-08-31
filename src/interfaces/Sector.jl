"""
    Sector

Abstract type representing a sector in the simulation.
This is the Julia equivalent of the Java Sector interface.
"""
abstract type Sector end

"""
    get_name(sector::Sector)

Returns the name of the sector.
"""
function get_name(sector::Sector)
    error("get_name not implemented for $(typeof(sector))")
end

"""
    get_simulation(sector::Sector)

Returns the simulation that contains this sector.
"""
function get_simulation(sector::Sector)
    error("get_simulation not implemented for $(typeof(sector))")
end

"""
    get_agents(sector::Sector)

Returns all agents in this sector.
"""
function get_agents(sector::Sector)
    error("get_agents not implemented for $(typeof(sector))")
end

"""
    get_agent(sector::Sector, name::String)

Returns the agent with the specified name.
"""
function get_agent(sector::Sector, name::String)
    error("get_agent not implemented for $(typeof(sector))")
end

"""
    do_event!(sector::Sector, event)

Executes the specified event on this sector.
"""
function do_event!(sector::Sector, event)
    error("do_event! not implemented for $(typeof(sector))")
end

"""
    get_data_access(sector::Sector, args::Vector{String})

Returns data access for aggregated operations.
"""
function get_data_access(sector::Sector, args::Vector{String})
    error("get_data_access not implemented for $(typeof(sector))")
end

"""
    get_individual_data_access(sector::Sector, agent_id::String, args::Vector{String})

Returns data access for a specific agent.
"""
function get_individual_data_access(sector::Sector, agent_id::String, args::Vector{String})
    error("get_individual_data_access not implemented for $(typeof(sector))")
end