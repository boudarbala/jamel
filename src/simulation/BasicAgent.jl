"""
    BasicAgent

A basic implementation of the Agent interface.
This is the Julia equivalent of Java agent classes.
"""
mutable struct BasicAgent <: Agent
    name::String
    simulation::Simulation
    dataset::BasicDataset
    sector::Union{Sector, Nothing}
    
    function BasicAgent(name::String, simulation::Simulation, sector::Union{Sector, Nothing}=nothing)
        keys = DataKeys()
        dataset = BasicDataset(keys, nothing, get_period(simulation))
        agent = new(name, simulation, dataset, sector)
        dataset.agent = agent  # Set circular reference
        return agent
    end
end

# Implement Agent interface methods

"""
    get_name(agent::BasicAgent)

Returns the name of the agent.
"""
get_name(agent::BasicAgent) = agent.name

"""
    get_data(agent::BasicAgent, key::String)

Returns the data associated with the given key.
"""
function get_data(agent::BasicAgent, key::String)
    return get_data(agent.dataset, key)
end

"""
    get_simulation(agent::BasicAgent)

Returns the simulation that contains this agent.
"""
get_simulation(agent::BasicAgent) = agent.simulation

"""
    get_dataset(agent::BasicAgent)

Returns the dataset for this agent.
"""
get_dataset(agent::BasicAgent) = agent.dataset

"""
    get_sector(agent::BasicAgent)

Returns the sector that contains this agent.
"""
get_sector(agent::BasicAgent) = agent.sector

"""
    set_data!(agent::BasicAgent, key::String, value::Float64)

Sets the data associated with the given key.
"""
function set_data!(agent::BasicAgent, key::String, value::Float64)
    put!(agent.dataset, key, value)
end

"""
    do_event!(agent::BasicAgent, event)

Executes the specified event on this agent.
"""
function do_event!(agent::BasicAgent, event)
    # In a full implementation, this would process different types of events
    # For now, this is a placeholder
    println("Agent $(agent.name) executing event")
end

"""
    update!(agent::BasicAgent)

Updates the agent's state for the current period.
"""
function update!(agent::BasicAgent)
    # Update the dataset period
    agent.dataset.period = get_period(agent.simulation)
end

# String representation
Base.string(agent::BasicAgent) = "BasicAgent($(agent.name))"
Base.show(io::IO, agent::BasicAgent) = print(io, string(agent))