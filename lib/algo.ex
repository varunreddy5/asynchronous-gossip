defmodule Algo do
    def gossipAlgo(nodeli, randNode, time) do
        len = length(nodeli)
        #IO.puts "#{len} hello length"
        Package1.proStateCount(randNode, len, time)
        Package1.adjGossipAlgo(randNode, len, time)
    end

    def pushSumAlgo(nodeli, randNode, time) do
        len = length(nodeli)
        Package1.adjPushSum(randNode, 0, 0, time, len)
    end
end
