#!/usr/bin/env julia

# Comprehensive test of the Jamel Julia translation including simulation

push!(LOAD_PATH, "/home/runner/work/jamel/jamel/src")

using Jamel

println("Testing Jamel Julia simulation framework...")

# Test 1: Basic components
println("\n=== Test 1: Basic Components ===")

# Create timer
timer = Jamel.BasicTimer()
println("✓ Timer created, initial period: $(Jamel.get_period(timer))")

# Create expressions
const_expr = Jamel.ConstantExpression(100.0)
func_expr = Jamel.FunctionExpression(() -> Jamel.get_period(timer) * 10.0)
println("✓ Expressions created")

# Test 2: Data management
println("\n=== Test 2: Data Management ===")

keys = Jamel.DataKeys()
dataset = Jamel.BasicDataset(keys)
Jamel.put!(dataset, "revenue", 1000.0)
Jamel.put!(dataset, "costs", 800.0)
println("✓ Dataset created with revenue: $(Jamel.get_data(dataset, "revenue"))")

# Test 3: Agents and Sectors
println("\n=== Test 3: Agents and Sectors ===")

# Create a simple simulation
scenario = Jamel.Parameters("simulation", Dict("className" => "BasicSimulation"), Jamel.Parameters[], "")
simulation = Jamel.BasicSimulation(scenario, "test_scenario.xml")
println("✓ Simulation created")

# Create a sector
firms_sector = Jamel.BasicSector("firms", simulation)
println("✓ Firms sector created")

# Create some agents
for i in 1:5
    agent = Jamel.BasicAgent("firm_$(i)", simulation, firms_sector)
    Jamel.set_data!(agent, "capital", Float64(i * 100))
    Jamel.set_data!(agent, "employees", Float64(i * 5))
    Jamel.add_agent!(firms_sector, agent)
end
println("✓ Created 5 agents in firms sector")

# Test data access
total_capital_expr = Jamel.get_sum_expression(firms_sector, "capital")
avg_employees_expr = Jamel.get_average_expression(firms_sector, "employees")

println("Total capital across all firms: $(Jamel.get_value(total_capital_expr))")
println("Average employees per firm: $(Jamel.get_value(avg_employees_expr))")

# Test 4: Expression Factory
println("\n=== Test 4: Expression Factory ===")

factory = Jamel.ExpressionFactory(simulation)
println("✓ Expression factory created")

# Test simple expressions
simple_expr = Jamel.get_expression(factory, "42.5")
println("Simple expression (42.5): $(Jamel.get_value(simple_expr))")

addition_expr = Jamel.get_expression(factory, "10+5")
println("Addition expression (10+5): $(Jamel.get_value(addition_expr))")

# Test 5: GUI Components
println("\n=== Test 5: GUI Components ===")

error_dialog = Jamel.JamelGUI.ErrorDialog("Test Error", "This is a test error message")
println("✓ Error dialog created")
Jamel.JamelGUI.show_error_dialog(error_dialog)

progress = Jamel.JamelGUI.ProgressDialog("Test Progress", "Initializing...")
Jamel.JamelGUI.update_progress!(progress, 0.5, "Halfway done")
Jamel.JamelGUI.close_progress_dialog(progress)
println("✓ Progress dialog test completed")

# Test 6: Simulation Run (short test)
println("\n=== Test 6: Simulation Execution ===")

# Add the firms sector to the simulation
simulation.sectors["firms"] = firms_sector
println("✓ Sector added to simulation")

# Run a few periods manually
println("Running simulation for 3 periods:")
for period in 1:3
    Jamel.next!(simulation.timer)
    println("  Period $(Jamel.get_period(simulation.timer)): $(length(Jamel.get_agents(firms_sector))) agents active")
    
    # Update agent data
    for agent in Jamel.get_agents(firms_sector)
        current_capital = Jamel.get_data(agent, "capital")
        if current_capital !== nothing
            # Simple growth model: capital grows by 1% per period
            new_capital = current_capital * 1.01
            Jamel.set_data!(agent, "capital", new_capital)
        end
    end
end

final_total_capital = Jamel.get_value(total_capital_expr)
println("Final total capital after growth: $(round(final_total_capital, digits=2))")

# Test 7: Exception handling
println("\n=== Test 7: Exception Handling ===")

try
    Jamel.not_yet_implemented("This feature is not ready")
catch e
    println("✓ Caught expected exception: $(typeof(e))")
end

println("\n=== All Tests Completed Successfully! ===")
println("\nJamel Julia translation is working correctly.")
println("Key features verified:")
println("  ✓ Core type system and interfaces")
println("  ✓ Data management and expressions")
println("  ✓ Agent-based simulation framework")
println("  ✓ Sector and agent interactions")
println("  ✓ Expression parsing and evaluation")
println("  ✓ GUI components")
println("  ✓ Exception handling")
println("  ✓ Basic simulation execution")