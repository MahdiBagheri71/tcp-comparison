# NS-2 TCP Comparison Simulation

This repository contains a Network Simulator 2 (NS-2) simulation script for TCP comparison analysis. The simulation is containerized using Docker for easy deployment and reproducibility.

## Prerequisites

- Docker installed on your system
- Basic understanding of Docker commands
- The TCP comparison simulation script (`tcp-comparison.tcl`)

## Project Structure

```
.
├── Dockerfile
├── README.md
└── tcp-comparison.tcl
```

## Installation

1. Clone this repository or create a new directory with the following files:
   - Dockerfile
   - tcp-comparison.tcl

2. Build the Docker image:
```bash
docker build -t ns2-simulation .
```

## Usage

### Running the Simulation

To run the simulation with default parameters:
```bash
docker run --rm ns2-simulation
```

### Interactive Mode

To enter interactive mode and run commands manually:
```bash
docker run -it --rm ns2-simulation bash
```

Then inside the container:
```bash
ns tcp-comparison.tcl
```

### Saving Output Files

If your simulation generates output files (like NAM traces or graphs), mount a volume to save them:
```bash
docker run --rm -v $(pwd)/results:/app/results ns2-simulation
```

## Troubleshooting

### Common Issues and Solutions

1. **"invalid command name 'new'" error**
   - Make sure NS-2 is properly installed in the container
   - Verify that the simulation script has correct NS-2 syntax

2. **Missing output files**
   - Ensure you've mounted a volume for results
   - Check file paths in your TCL script

3. **Permission issues**
   - Run Docker commands with sudo if needed
   - Check folder permissions for mounted volumes

## Container Specifications

The Docker container includes:
- Ubuntu 20.04 as base image
- NS-2 (Network Simulator 2)
- NAM (Network Animator)
- TCL/TK

## Development

To modify the simulation:
1. Edit the `tcp-comparison.tcl` file
2. Rebuild the Docker image
3. Run the new container

## Notes

- The container is configured to run non-interactively by default
- Use the interactive mode for debugging purposes
- Output files should be saved to the mounted volume path
- The container is automatically removed after execution (`--rm` flag)

## Contributing

Feel free to fork this repository and submit pull requests for any improvements.

## License

This project is open-source and available under the MIT License.