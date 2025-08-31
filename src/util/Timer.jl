"""
    Timer

Abstract type representing a timer.
This is the Julia equivalent of the Java Timer interface.
"""
abstract type Timer end

"""
    get_period(timer::Timer)

Returns the current period.
"""
function get_period(timer::Timer)
    error("get_period not implemented for $(typeof(timer))")
end

"""
    BasicTimer

A basic implementation of Timer.
"""
mutable struct BasicTimer <: Timer
    period::Int
    
    BasicTimer() = new(0)
    BasicTimer(period::Int) = new(period)
end

"""
    get_period(timer::BasicTimer)

Returns the current period of the basic timer.
"""
get_period(timer::BasicTimer) = timer.period

"""
    next!(timer::BasicTimer)

Advances to the next period.
"""
function next!(timer::BasicTimer)
    timer.period += 1
    return timer.period
end

"""
    reset!(timer::BasicTimer)

Resets the timer to period 0.
"""
function reset!(timer::BasicTimer)
    timer.period = 0
    return timer
end