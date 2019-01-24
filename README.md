# Gossip

**TODO: Add description**

## Installation

Team Members:
Sai Tarun Damacharla(4174-0254)
Varun Reddy Regalla(4143-6018)

This code is about passing a message amoung a group of processes using both Gossip
and PushSum algorithems. Here this message communication is done using different types of topoligies like line, Full, imprefect line, reand2D, 3D Grid networks and finally comparing the results at the end.

Highest number of nodes executed are 2000 in gossip and 2300 in PushSum algorithems

Instruction of code execution:
-> mix escript.build for building the code
-> time ./gossip NumberOfNodes Topology Algorithem
The Ourput here displays the convergence time.

Topology:
Line, Full, ImpLine, Torus, 2DGrid, 3DGrid
Algorithem:
Gossip, PushSum

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `gossip` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:gossip, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/gossip](https://hexdocs.pm/gossip).
