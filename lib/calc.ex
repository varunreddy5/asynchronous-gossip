defmodule Calc do
    def nearThree(a) do
        i=rem(a,3)
        a+i
    end

    def nearPerfSquar(a) do
        if(:math.sqrt(a)==round(:math.sqrt(a))) do
            a
        else
            i=round(:math.ceil(:math.sqrt(a)))
            i*i
        end
    end

    def lineTopo(li) do
        len=Enum.count li
        Enum.each(li, fn(x) ->
            #pos=elem(x,0)
            pos = Enum.find_index(li, fn(y)-> y == x end)
            #IO.puts pos+1
            nibList=[]
            x1 = if(pos-1>=0) do
                Enum.at(li, pos-1)
                #nibList = nibList ++ [l1]
                #nibList = nibList ++ Enum.fetch!(li,pos-2)
            end
            x2 = if(pos+1<len) do
                Enum.at(li, pos+1)
                #nibList = nibList ++ [l2]
                #nibList = nibList ++ Enum.fetch!(li,pos)
            end
            nibList = [x1, x2]
            nibList = nibList -- [nil]
            #IO.inspect nibList
            Package1.adjNodeLi(x, nibList)
        end)
    end

    def imfLineTopo(li) do
        len=Enum.count li
        Enum.each(li, fn(x) ->
            #pos=elem(x,0)
            pos = Enum.find_index(li, fn(y)-> y == x end)
            #IO.puts pos+1
            nibList=[]
            x1 = if(pos-1>=0) do
                Enum.at(li, pos-1)
            end
            x2 = if(pos+1<len) do
                Enum.at(li, pos+1)
            end
            a=li -- [x,x1,x2]
            #IO.puts length(a)
            if length(a)!=0 do
                nibList = [x1, x2]++[Enum.random(a)]
                nibList = nibList -- [nil]
                #IO.inspect nibList
                Package1.adjNodeLi(x, nibList)
            else
                nibList = [x1,x2]
                nibList = nibList -- [nil]
                #IO.inspect nibList
                Package1.adjNodeLi(x, nibList)
            end
        end)
    end

    def adjFull(li) do
        Enum.each(li, fn(x) ->
            adjLi=li--[x]
            #IO.inspect adjLi
            Package1.adjNodeLi(x, adjLi)
        end)
    end

    def ram2DGrid(li) do
        Enum.each(li, fn(x) ->
            #adjLi = []
            num = round(:math.sqrt(length(li)))
            #IO.puts num
            pos = Enum.find_index(li, fn(y)-> y == x end)+1
            #IO.puts pos
            ro = round(:math.ceil(pos/num))
            cl = if rem(pos,num)!=0, do: rem(pos,num), else: 3
            p1 = corrList(ro-1,cl,num)
            p2 = corrList(ro,cl+1,num)
            p3 = corrList(ro+1,cl,num)
            p4 = corrList(ro,cl-1,num)
            pLi=Enum.uniq([p1,p2,p3,p4])--[-1]
            #IO.inspect pLi
            adjLi = Enum.map(pLi, fn(x) ->
                        Enum.at(li,x)
                    end)
            #IO.inspect adjLi
            a=li -- adjLi
            a=a -- [x]
            if length(a)!=0 do
                adjLi = adjLi++[Enum.random(a)]
                #IO.inspect adjLi
                Package1.adjNodeLi(x, adjLi)
            else
                #IO.inspect adjLi
                Package1.adjNodeLi(x, adjLi)
            end
        end)
    end

    def corrList(a,b,sqr) do
        if a>0 && b>0 && a<=sqr && b<=sqr do
            res=(a-1)*sqr+b
        else
            -1
        end
    end

    def torusList(li) do
        Enum.each(li, fn(x) ->
            #adjLi = []
            num = round(:math.sqrt(length(li)))
            #IO.puts num
            pos = Enum.find_index(li, fn(y)-> y == x end)+1
            #IO.puts pos
            ro = round(:math.ceil(pos/num))
            cl = if rem(pos,num)!=0, do: rem(pos,num), else: 3
            p1 = corrList(ro-1,cl,num)
            p2 = corrList(ro,cl+1,num)
            p3 = corrList(ro+1,cl,num)
            p4 = corrList(ro,cl-1,num)
            p5 = corrList(ro-(num-1),cl,num)
            p6 = corrList(ro,cl+(num-1),num)
            p7 = corrList(ro+(num-1),cl,num)
            p8 = corrList(ro,cl-(num-1),num)
            pLi=Enum.uniq([p1,p2,p3,p4,p5,p6,p7,p8])--[-1]
            #IO.inspect pLi
            adjLi = Enum.map(pLi, fn(x) ->
                        Enum.at(li,x)
                    end)
            Package1.adjNodeLi(x, adjLi)
        end)
    end

    def corrList3d(a,b,sqr,plain) do
        if a>sqr*(plain-1) && b>0 && a<=sqr+sqr*(plain-1) && b<=sqr do
            res=(a-1)*sqr+b
        else
            -1
        end
    end

    def topo3DGrid(li) do
        Enum.each(li, fn(x) ->
            #adjLi = []
            num = round(:math.pow(length(li),1/3))
            #IO.puts num
            pos = Enum.find_index(li, fn(y)-> y == x end)+1
            #IO.puts pos
            ro = round(:math.ceil(pos/num))
            cl = if rem(pos,num)!=0, do: rem(pos,num), else: num
            plain=round(:math.ceil(ro/num))
            #IO.puts plain
            p1 = corrList3d(ro-1,cl,num,plain)
            p2 = corrList3d(ro,cl+1,num,plain)
            p3 = corrList3d(ro+1,cl,num,plain)
            p4 = corrList3d(ro,cl-1,num,plain)
            p5 = if pos-num*num>0, do: pos-num*num, else: -1
            p6 = if pos+num*num<=length(li), do: pos+num*num, else: -1
            pLi=Enum.uniq([p1,p2,p3,p4,p5,p6])--[-1]
            IO.inspect pLi
            adjLi = Enum.map(pLi, fn(x) ->
                        Enum.at(li,x)
                    end)
            Package1.adjNodeLi(x, adjLi)
        end)
    end
end
