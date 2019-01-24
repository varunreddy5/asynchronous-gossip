defmodule Package1 do
    use GenServer

    def start_link do
        GenServer.start_link(__MODULE__, :ok, [])
    end

    def init(:ok) do
        {:ok, {0,0,[],1}}
    end

    def processIndex(pid, x) do
        GenServer.cast(pid, {:processId, x})
    end

    def handle_cast({:processId, x}, state) do
        {id,count,list,wt} = state
        state={x,count,list,wt}
        {:noreply, state}
    end

    def nodeCurrentCont(pid) do
        GenServer.call(pid, {:currentCount})
    end

    def handle_call({:currentCount}, _from, state) do
        count = elem(state, 1)
        id = elem(state,0)
        #IO.puts "Process #{id}: Count: #{count}"
        {:reply, count, state}
    end

    def nodeAdjList(pid) do
        GenServer.call(pid, {:nodeAdjLi})
    end

    def handle_call({:nodeAdjLi}, _from, state) do
        lis= elem(state, 2)
        {:reply, lis, state}
    end


    def proStateCount(randNode, len, time) do
        GenServer.call(randNode, {:proCount, len, time})
    end

    def handle_call({:proCount, len, time}, _from, state) do
        {id,count,list,wt} = state
        if count == 1 do
            #IO.puts "#{count} hello -------------------- #{id}"
            tableCount = :ets.update_counter(:table, "nodeCount", {2,1})
            #IO.puts "#{tableCount} tableCount"
            if tableCount == len do
                terminateFun(time,tableCount)
            end
        end
        cont = count+1
        state = {id, cont, list, wt}
        {:reply, cont, state}
    end

    def adjNodeLi(pid, adjList) do
        GenServer.cast(pid, {:adjNodeList, adjList})
    end

    def handle_cast({:adjNodeList, adjList}, state) do
        {id,count,list,wt} = state
        state = {id, count, adjList, wt}
        #IO.inspect adjList
        {:noreply, state}
    end

    def terminateFun(time,tableCount) do
        finalTime = System.monotonic_time(:millisecond) - time
        IO.puts "final convergence time = #{finalTime} Table Count: #{tableCount}"
        System.halt(1)
    end

    def adjGossipAlgo(randNode, len, time) do
        currentCount = nodeCurrentCont(randNode)
        cond do
           currentCount < 11 ->
            adjLi = nodeAdjList(randNode)
            randAdjNode = Enum.random(adjLi)

            if randAdjNode != nil do
                Task.start(Package1, :nodeMessenger, [randAdjNode, len, time])
                adjGossipAlgo(randNode, len, time)
            end
            # else
            #     IO.puts "current count is greater than 10"
            #     adjNodeLi(randNode, adjLi -- [randAdjNode])
            # end
          true ->
            #IO.puts "current count is greater than 10"
            Process.exit(randNode, :normal)
        end
        adjGossipAlgo(randNode, len, time)
    end

    def nodeMessenger(pid, len, time) do
        proStateCount(pid, len, time)
        adjGossipAlgo(pid, len, time)
    end

    def adjPushSum(pid, s, w, time, len) do
        GenServer.cast(pid, {:pushSumMessenger, s, w, time, len})
    end

    def handle_cast({:pushSumMessenger, msgS, msgW, time, len}, state) do
        #IO.puts "In handle cast"
        {s,count,nibList,wt} = state
        curS = s + msgS
        curW = wt + msgW
        d = abs((curS/curW) - (s/wt))
        #IO.puts "#{d} diff"
        if(d < :math.pow(10,-10) && count == 2) do
            #IO.puts "inide pow #{count}"
            tableCount = :ets.update_counter(:table, "nodeCount", {2,1})
            if tableCount == len do
                terminateFun(time,tableCount)
            end
        end

        count = if d < :math.pow(10,-10) && count < 2 do
                  #IO.puts "inide pow #{count}"
                    count + 1
                  else
                    0
                end
        # count = if d > :math.pow(10,-10) do
        #           IO.puts "inide pow #{count}"
        #             0
        #         end
        state = {curS/2, count, nibList, curW/2}
        randNode = Enum.random(nibList)
        #IO.inspect randNode
        adjPushSum(randNode, curS/2, curW/2, time, len)

        #IO.inspect adjList
        {:noreply, state}
    end
end
