defmodule Package1 do
    use GenServer

    def start_link do
        GenServer.start_link(__MODULE__, [])
    end

    def execute(receiver_id, i) do
        GenServer.cast(receiver_id, {:asy_package, i})
    end

    def handle_cast({:asy_package, i}, state) do
        me=self()
        IO.inspect(me)
        {:noreply, state}
    end
end
