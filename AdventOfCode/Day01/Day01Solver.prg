using System
using System.Collections.Generic
using System.Text
using System.Linq

class Day01Solver inherit SolverBase

    // Private field to store the parsed data
    private _Data as List<int>
    
    protected override method Parse(data as List<string>) as void
        // Parse the List of strings into the _Data field
        _Data := data.Select({s => Int32.Parse(s)}).ToList()
        return
    
    protected override method Solve1() as object
        return _data.Where({ o,index => index != 0 .and. o > _data.ElementAt(index-1)}):ToList():count
    
    protected override method Solve2() as object
        var tempList := _Data:Where({ o,index => index+2<_Data:count}).Select({o,index => o+_data.ElementAt(index+1)+_data.ElementAt(index+2)}):ToList()
        return tempList.Where({ o,index => index != 0 .and. o > tempList.ElementAt(index-1)}):ToList():count

end class
