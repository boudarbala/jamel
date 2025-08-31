"""
    Simulation

Abstract type representing a simulation.
This is the Julia equivalent of the Java Simulation interface.
"""
abstract type Simulation end

"""
    run!(simulation::Simulation)

Runs the simulation.
"""
function run!(simulation::Simulation)
    error("run! not implemented for $(typeof(simulation))")
end

"""
    get_period(simulation::Simulation)

Returns the current period of the simulation.
"""
function get_period(simulation::Simulation)
    error("get_period not implemented for $(typeof(simulation))")
end

"""
    get_sector(simulation::Simulation, name::String)

Returns the specified sector.
"""
function get_sector(simulation::Simulation, name::String)
    error("get_sector not implemented for $(typeof(simulation))")
end

"""
    get_random(simulation::Simulation)

Returns the random number generator for this simulation.
"""
function get_random(simulation::Simulation)
    error("get_random not implemented for $(typeof(simulation))")
end

"""
    get_file(simulation::Simulation)

Returns the scenario file.
"""
function get_file(simulation::Simulation)
    error("get_file not implemented for $(typeof(simulation))")
end

"""
    get_info(simulation::Simulation, query::String)

Returns information about the simulation based on the query.
"""
function get_info(simulation::Simulation, query::String)
    error("get_info not implemented for $(typeof(simulation))")
end

"""
    get_name(simulation::Simulation)

Returns the name of the simulation.
"""
function get_name(simulation::Simulation)
    error("get_name not implemented for $(typeof(simulation))")
end

"""
    get_duration(simulation::Simulation)

Returns an access to the simulation duration.
"""
function get_duration(simulation::Simulation)
    error("get_duration not implemented for $(typeof(simulation))")
end

"""
    get_speed(simulation::Simulation)

Returns an access to the simulation speed.
"""
function get_speed(simulation::Simulation)
    error("get_speed not implemented for $(typeof(simulation))")
end

"""
    get_time(simulation::Simulation)

Returns an access to the current period.
"""
function get_time(simulation::Simulation)
    error("get_time not implemented for $(typeof(simulation))")
end

"""
    is_paused(simulation::Simulation)

Returns true if the simulation is paused.
"""
function is_paused(simulation::Simulation)
    error("is_paused not implemented for $(typeof(simulation))")
end

"""
    pause!(simulation::Simulation)

Pauses the simulation.
"""
function pause!(simulation::Simulation)
    error("pause! not implemented for $(typeof(simulation))")
end

"""
    display_error_message(simulation::Simulation, title::String, message::String)

Displays an error message.
"""
function display_error_message(simulation::Simulation, title::String, message::String)
    error("display_error_message not implemented for $(typeof(simulation))")
end