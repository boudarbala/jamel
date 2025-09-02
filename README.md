# Jamel: Julia Agent-based MacroEconomic Laboratory

*Jamel (Julia Agent-based Macro-Economic Laboratory)* is an open source agent-based framework dedicated to the modeling, the simulation and the analysis of complex monetary economies.

**Note:** This version has been translated from Java to Julia.

## Julia Version Features

- **Core Framework**: Complete translation of the agent-based simulation framework
- **Modern Language**: Takes advantage of Julia's performance and expressiveness
- **Type System**: Uses Julia's type system for interfaces and implementations
- **Package Management**: Uses Julia's Pkg system for dependencies
- **Interactive**: Can be used interactively in Julia REPL or Jupyter notebooks

## Getting Started

### Prerequisites

- Julia 1.6 or higher
- Required packages (automatically installed via Project.toml):
  - Random, Dates, Printf, Statistics (standard library)

### Installation

1. Clone this repository
2. Navigate to the project directory
3. Start Julia and activate the project:

```julia
using Pkg
Pkg.activate(".")
Pkg.instantiate()
```

### Usage

```julia
using Jamel

# Run a simulation
Jamel.main()

# Or create components programmatically
simulation = Jamel.BasicSimulation(scenario, file)
Jamel.run!(simulation)
```

### Testing

Run the test suite:

```bash
julia test_jamel.jl
```

## Architecture

The framework consists of several key components:

- **Interfaces**: Core abstractions (Expression, Simulation, Agent, Sector)
- **Implementations**: Basic implementations of core interfaces
- **Data Management**: Dataset and expression evaluation system
- **GUI**: Simple graphical interface components
- **Utilities**: Helper classes and exception types

## Scenario Files

The framework uses XML scenario files to configure simulations. Example scenarios are available in the `src/jamel/models/` directory.

## Credits and Acknowledgments

This Julia version is a translation of the original Jamel (Java Agent-based MacroEconomic Laboratory) created by Pascal Seppecher and contributors.

**Original Author:** Pascal Seppecher  
**Original Project:** [http://p.seppecher.free.fr/jamel/](http://p.seppecher.free.fr/jamel/)

*Merci beaucoup* to Pascal Seppecher for creating this excellent framework for agent-based macroeconomic modeling and making it available to the research community.

## License

See LICENSE.txt for details.
