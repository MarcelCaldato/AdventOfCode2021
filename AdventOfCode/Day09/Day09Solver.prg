using System
using System.Collections.Generic
using System.Text
using System.Linq

class Day09Solver inherit SolverBase

    // Private field to store the parsed data
    private _Data as List<List<int>>
    private AlredyCounted as List<Tuple<Int,Int>>
    
    protected override method Parse(data as List<string>) as void
        // Parse the List of strings into the _Data field
        AlredyCounted := List<Tuple<Int,Int>>{}
        _Data := data.Select({ x => x.ToList().Select({ c => c - '0' }).ToList()}).ToList()
        return

    private method isLow(indexX as int,IndexY as int,v as int) as logic 
        var temp := _Data.ElementAt(indexY)
        var lRet := (indexX == 0 .or. temp.ElementAt(indexX-1) > v ) .and. (indexX == temp.count-1 .or. temp.ElementAt(indexX+1) > v )
        if lRet .and. IndexY != 0
            temp := _Data.ElementAt(indexY-1)
            lRet := temp.ElementAt(indexX) > v
        endif
        if lRet .and. IndexY != _Data.count-1
            temp := _Data.ElementAt(indexY+1)
            lRet := temp.ElementAt(indexX) > v
        endif
        return lRet

    private method BasinCount(indexX as int,IndexY as int, oldVal as int) as int
        var tempTuple := Tuple.Create(IndexX,IndexY)
        if IndexY < 0 .or. IndexY >= _Data.count .or. IndexX < 0 .or. IndexX >= _Data.ElementAt(IndexY).count 
            return 0
        endif
        var val := _Data.ElementAt(IndexY).ElementAt(IndexX)
        if AlredyCounted.Contains(tempTuple) .or. val == 9 .or. val < oldVal
            return 0
        endif
        AlredyCounted.Add(tempTuple)
        var size := 1
        size += self:BasinCount(IndexX-1,IndexY,val)
        size += self:BasinCount(IndexX+1,IndexY,val)
        size += self:BasinCount(IndexX,IndexY-1,val)
        size += self:BasinCount(IndexX,IndexY+1,val)
        return size
    
    protected override method Solve1() as object
        var temp := _Data.Select({ x,IndexY => x.where({v,indexX => self:isLow(IndexX,IndexY,v)}).Select({ v => v+1}).Sum() }).ToList()
        return  temp.Sum() // Use the _Data field to solve the 1th puzzle and return the result
    
    protected override method Solve2() as object
        var temp := _Data.Select({ x,IndexY => x.Select({v,indexX => iif(self:isLow(IndexX,IndexY,v),self:BasinCount(IndexX,IndexY,-1),0)}).ToList() }).SelectMany({x => x}).where({ v => v != 0}).ToList()
        temp.Sort({x, y => y - x})
        return temp.where({ v,index => index < 3}).Aggregate({a, x => a * x }) // Use the _Data field to solve the 1th puzzle and return the result

end class
