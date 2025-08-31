#!/usr/bin/env julia

# Simple test script for the Jamel Julia translation

push!(LOAD_PATH, "/home/runner/work/jamel/jamel/src")

using Jamel

println("Testing Jamel Julia translation...")

# Test basic expression functionality
println("\n1. Testing expressions:")
const_expr = Jamel.ConstantExpression(42.0)
println("Constant expression value: $(Jamel.get_value(const_expr))")

func_expr = Jamel.FunctionExpression(() -> 3.14)
println("Function expression value: $(Jamel.get_value(func_expr))")

# Test timer
println("\n2. Testing timer:")
timer = Jamel.BasicTimer()
println("Initial period: $(Jamel.get_period(timer))")
Jamel.next!(timer)
println("After next!: $(Jamel.get_period(timer))")

# Test data structures
println("\n3. Testing data structures:")
keys = Jamel.DataKeys()
index1 = Jamel.get_index(keys, "test_key")
index2 = Jamel.get_index(keys, "another_key")
println("Key 'test_key' has index: $(index1)")
println("Key 'another_key' has index: $(index2)")
println("Index $(index1) has key: $(Jamel.get_key(keys, index1))")

# Test dataset
println("\n4. Testing dataset:")
dataset = Jamel.BasicDataset(keys)
Jamel.put!(dataset, "value1", 100.0)
Jamel.put!(dataset, "value2", 200.0)
println("Dataset value1: $(Jamel.get_data(dataset, "value1"))")
println("Dataset value2: $(Jamel.get_data(dataset, "value2"))")

# Test parameters
println("\n5. Testing parameters:")
params = Jamel.Parameters("test", Dict("attr1" => "value1"), Jamel.Parameters[], "")
println("Parameter name: $(Jamel.get_name(params))")
println("Has attribute 'attr1': $(Jamel.has_attribute(params, "attr1"))")
println("Attribute 'attr1' value: $(Jamel.get_attribute(params, "attr1"))")

println("\nAll basic tests passed!")