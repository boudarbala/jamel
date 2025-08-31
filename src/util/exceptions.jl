"""
Custom exception types for Jamel.
These are Julia equivalents of the Java exception classes.
"""

"""
    NotUsedException

Exception thrown when a method that should not be used is called.
"""
struct NotUsedException <: Exception
    message::String
    NotUsedException(message::String="This method should not be used.") = new(message)
end

"""
    NotYetImplementedException

Exception thrown when a method is not yet implemented.
"""
struct NotYetImplementedException <: Exception
    message::String
    NotYetImplementedException(message::String="Not yet implemented.") = new(message)
end

# Make exceptions printable
Base.showerror(io::IO, e::NotUsedException) = print(io, "NotUsedException: ", e.message)
Base.showerror(io::IO, e::NotYetImplementedException) = print(io, "NotYetImplementedException: ", e.message)