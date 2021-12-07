using System
using System.Collections.Generic
using System.Text
using System.Linq

class Day07Solver inherit SolverBase

    // Private field to store the parsed data
    private _Data as List<int>
    
    protected override method Parse(data as List<string>) as void
        _Data := List<int>{}
        foreach var line in data
            _Data.AddRange( line.split(',').Select({s => int32.Parse(s) }).ToList() )
        next
        return
    
    protected override method Solve1() as object
        var num := Enumerable.Range(_Data.Min(),_Data.Max() - _Data.Min())
        return num.Select({x => _Data.Select({y => Math.Abs(y - x)}).Sum() } ).Min()
    
    private method GetNum( num as int ) as int 
        num := Math.Abs(num)
        num := num * (num + 1)
        num /= 2
        return num
        
    protected override method Solve2() as object
        var num := Enumerable.Range(_Data.Min(),_Data.Max() - _Data.Min())
        return num.Select({x => _Data.Select({y => self:GetNum(y-x)}).Sum() } ).Min()

end class
