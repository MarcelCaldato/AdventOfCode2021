using System
using System.Collections.Generic
using System.Text
using System.Linq

class Day05Solver inherit SolverBase
    private class grid
        public property coordinates as Dictionary<Tuple<int,int>,int> auto get set := Dictionary<Tuple<int,int>,int>{}

        private method RangeList(num1 as int,num2 as int) as List<int>
            if num1<num2
                return Enumerable.Range(num1, num2-num1+1).ToList()
            elseif num1>num2
                return Enumerable.Range(num2, num1-num2+1).Reverse().ToList()
            endif
            var l := List<int>{}
            l.Add(num1)
            return l
            

        public method Add(x1 as int,y1 as int,x2 as int,y2 as int) as void
            var ListX := self:RangeList(x1,x2)
            var ListY := self:RangeList(y1,y2)
            local Anzahl := iif(ListX.count < ListY.count,ListY.count,ListX.count) as int
            for var n := 0 upto Anzahl-1
                var X := iif(ListX.count > n,ListX.ElementAt(n),ListX.ElementAt(ListX.count-1))
                var Y := iif(ListY.count > n,ListY.ElementAt(n),ListY.ElementAt(ListY.count-1))
                var TempKey := Tuple.Create(X,Y)
                if self:coordinates.ContainsKey(TempKey)
                    self:coordinates[TempKey] +=1
                else
                    self:coordinates.Add(TempKey,1)
                endif
            next
            return
    end class

    // Private field to store the parsed data
    private _Data as grid
    private _Data2 as grid
    
    protected override method Parse(data as List<string>) as void
        _Data := grid{}
        _Data2 := grid{}
        foreach var line in data
            var points := line.Replace(" ", "").Replace(">", "").Split('-')
            var p1 := points[0].Split(',')
            var p2 := points[1].Split(',')
            if p1[0]==p2[0] .or. p1[1]==p2[1]
                _Data.Add(int32.Parse(p1[0]),int32.Parse(p1[1]),int32.Parse(p2[0]),int32.Parse(p2[1]))
            endif
            if p1[0]==p2[0] .or. p1[1]==p2[1] .or. Math.Abs(int32.Parse(p1[0])-int32.Parse(p2[0])) == Math.Abs(int32.Parse(p1[1])-int32.Parse(p2[1]))
                _Data2.Add(int32.Parse(p1[0]),int32.Parse(p1[1]),int32.Parse(p2[0]),int32.Parse(p2[1]))
            endif
        next
        return
    
    protected override method Solve1() as object
        return _Data.coordinates.where({x => x.value>1}).ToList().count // Use the _Data field to solve the 1th puzzle and return the result
    
    protected override method Solve2() as object
        return _Data2.coordinates.where({x => x.value>1}).ToList().count // Use the _Data field to solve the 1th puzzle and return the result

end class
