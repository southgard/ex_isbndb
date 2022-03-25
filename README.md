# ExIsbndb 

[![.github/workflows/elixir_workflow.yaml](https://github.com/southgard/ex_isbndb/actions/workflows/elixir_workflow.yaml/badge.svg)](https://github.com/southgard/ex_isbndb/actions/workflows/elixir_workflow.yaml) [![Coverage Status](https://coveralls.io/repos/github/southgard/ex_isbndb/badge.svg?branch=main)](https://coveralls.io/github/southgard/ex_isbndb?branch=main)


`ExIsbndb` is the Elixir wrapper for the [ISBNdb API](https://isbndb.com/apidocs/v2).

It helps Elixir developers to request information to ISBNdb without the need of adding any 
HTTP client or know the specifications of the API itself.

## Installation

The package can be installed by adding `ex_isbndb` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_isbndb, "~> 0.1.0"}
  ]
end
```

## Usage

This library can be used in 2 different ways:

* Use modules like `ExIsbndb.Author` that contains functions that will check the given params and send the request for you (**Recommended**)
* Use `ExIsbndb.Client` to send the requests giving a method, path and params (**Not recommended**)

If you decide to continue with the recommended path, keep looking here to see the different features.

We provide the following modules to call the different endpoints of the ISBNdb API:

* `ExIsbndb.Author` - request information about authors
* `ExIsbndb.Book` - request information about books
* `ExIsbndb.Publisher` - request information about publishers
* `ExIsbndb.Search` - request information of any kind
* `ExIsbndb.Stats` - request database stats
* `ExIsbndb.Subject` - request information about subjects
