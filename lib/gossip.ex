defmodule Gossip do

  def gossip(a, b) do
    IO.puts b
    num = case b do
            "Line" -> a
            "Full" -> a
            "ImpLine" -> a
            "Torus" -> a = nearPerfSquar(a)
            "2DGrid" -> a = nearPerfSquar(a)
            "3DGrid" -> a = nearCubeRoot(a)
    end
    li=Enum.map(1..num, fn(x) ->
      pid= Package1.start_link 
    elem(pid, 1) end)
    #{x, elem(pid, 1)} end)
    IO.inspect li
    # :timer.sleep(1000)
    # Enum.each(li, fn x ->
    #   IO.puts Process.alive?(elem(x, 1)) end)
    case b do
      "3DGrid" -> Calc.topo3DGrid(li)
    end
  end

  def main(args\\[]) do
    {i,""}=Integer.parse(Enum.at(args,0))
    j=Enum.at(args,1)
    #pid=spawn(Dosproj, :pmap, [i, j])
    gossip(i, j)
  end

  def nearThree(a) do
    i=rem(a,3)
    a+3-i
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
