defmodule Lookup.Slow do
  @lookup %{
    "one" => 1,
    "two" => 2,
    "three" => 3,
    "four" => 4,
    "five" => 5
  }

  def int_for(str) do
    @lookup[str]
  end
end

defmodule Lookup.Fast do
  def int_for(str) do
    do_int_for(str)
  end

  def do_int_for("one"), do: 1
  def do_int_for("two"), do: 2
  def do_int_for("three"), do: 3
  def do_int_for("four"), do: 4
  def do_int_for("five"), do: 5
end

defmodule Lookup.Map do
  @lookup %{
    "one" => 1,
    "two" => 2,
    "three" => 3,
    "four" => 4,
    "five" => 5
  }

  def int_for(str) do
    Map.get(@lookup, str)
  end
end

defmodule Lookup.CasePattern do
  @lookup %{
    "one" => 1,
    "two" => 2,
    "three" => 3,
    "four" => 4,
    "five" => 5
  }

  def int_for(str) do
    case @lookup do
      %{^str => value} -> value
      _ -> nil
    end
  end
end

defmodule Lookup.Benchmark do
  def benchmark do
    Benchee.run(
      %{
        "Function Pattern Matching" => fn -> bench_func(Lookup.Fast) end,
        "Access Lookup" => fn -> bench_func(Lookup.Slow) end,
        "Map.get" => fn -> bench_func(Lookup.Map) end,
        "Case Pattern Matching" => fn -> bench_func(Lookup.CasePattern) end
      },
      time: 10,
      print: [fast_warning: false]
    )
  end

  def bench_func(module) do
    module.int_for("one")
    module.int_for("two")
    module.int_for("three")
    module.int_for("four")
    module.int_for("five")
    module.int_for("one")
    module.int_for("two")
    module.int_for("three")
    module.int_for("four")
    module.int_for("five")
    module.int_for("one")
    module.int_for("two")
    module.int_for("three")
    module.int_for("four")
    module.int_for("five")
  end
end

Lookup.Benchmark.benchmark()
