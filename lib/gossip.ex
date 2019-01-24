defmodule Gossip do

  def gossip(a, b, c) do
    num = case b do
            "Line" -> a
            "Full" -> a
            "ImpLine" -> a
            "Torus" -> a = nearPerfSquar(a)
            "2DGrid" -> a = nearPerfSquar(a)
            "3DGrid" -> a = nearCubeRoot(a)
    end
    li=Enum.map(1..num, fn(x) ->
      {:ok, pid}= Package1.start_link
      Package1.processIndex(pid, x)
      pid
      end)

    table = :ets.new(:table, [:named_table, :public])
    :ets.insert(table, {"nodeCount", 1})

    case b do
      "Line" -> Calc.lineTopo(li)
      "Full" -> Calc.adjFull(li)
      "ImpLine" -> Calc.imfLineTopo(li)
      "Torus" -> Calc.torusList(li)
      "2DGrid" -> Calc.ram2DGrid(li)
      "3DGrid" -> Calc.topo3DGrid(li)
    end
    time = System.monotonic_time(:millisecond)
    randNode = Enum.random(li)

    case c do
        "Gossip" ->
          Algo.gossipAlgo(li, randNode, time)
        "PushSum" ->
          Algo.pushSumAlgo(li, randNode, time)
          liveFun(1)
    end

  end

  def main(args\\[]) do
    {i,""}=Integer.parse(Enum.at(args,0))
    j=Enum.at(args,1)
    k=Enum.at(args,2)
    #pid=spawn(Dosproj, :pmap, [i, j])
    gossip(i, j, k)
  end

  def nearThree(a) do
    i=rem(a,3)
    a+3-i
  end

  def liveFun(1) do
    liveFun(1)
  end

  def nearPerfSquar(a) do
      if(:math.sqrt(a)==round(:math.sqrt(a))) do
          a
      else
          i=round(:math.ceil(:math.sqrt(a)))
          i*i
      end
  end

  def nearCubeRoot(a) do
      if(:math.pow(a,1/3)==round(:math.pow(a,1/3))) do
          a
      else
          i=round(:math.ceil(:math.pow(a,1/3)))
          i*i*i
      end
  end
end
