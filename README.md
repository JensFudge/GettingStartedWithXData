# Getting Started with XData

This repository contains the source code accompanying the book  
**Getting Started with XData** by Jens Fudge.

The examples demonstrate how to build a REST API using TMS XData and Delphi, and how to create a Delphi VCL client that communicates with it.

> **Repository status:** This repository is currently being prepared.
> The source code is being added progressively to preserve the development
> history that accompanies the examples in the book.

## Repository Structure

### DatabaseCreate

Contains the utility used to create the InterBase database used throughout the examples.

### XDataDemo

Contains the main example application:

- **Server** – the TMS XData REST server
- **Client** – the Delphi VCL client
- **Common** – types and code shared between the server and client

## Following the Book

The application is developed step by step throughout the book.

The latest version of the repository contains the completed example. If you are following the book and want to see the code at an earlier stage, use the Git commit history.

The commits represent significant stages in the development of the example, making it possible to see how the application evolves as new concepts are introduced.

## Requirements

The examples are written in Delphi and use TMS XData.

Some examples also use FireDAC and InterBase.

TMS XData is part of TMS Business.

## License

The source code in this repository is provided under the MIT License.

See [LICENSE](LICENSE) for details.

## About the Book

*Getting Started with XData* introduces TMS XData by building a small client-server application step by step.

The focus is on getting a working system up and running while keeping the examples simple and removing unnecessary complexity.
