using System
using System.Collections
using System.Collections.Generic
using System.Text
using System.Linq

class Day03Solver inherit SolverBase

    // Private field to store the parsed data
    private _Data as List<List<int>> 
    
    protected override method Parse(data as List<string>) as void
        // Parse the List of strings into the _Data field
        _Data := List<List<int>>{}
        foreach var s in data
            var intlist := s.Select({c => int32.parse(c.ToString())}).ToList()
            _Data.Add(intlist)
        next 
        return
        
    method getCommonBit(l as List<List<int>>, pos as int) as int
        if l.count%2==0 .and. (l.count/2) == l.Select({x => x.ElementAt(pos)}).where({x => x==1}).ToList().COunt 
          return 1
        endif
        return  l.Select({x => x.ElementAt(pos)}).GroupBy({i=>i}).OrderByDescending({grp=>grp.Count()}).Select({grp=>grp.Key}).First()
    
    protected override method Solve1() as object

        var bit := string.Concat(_Data.ElementAt(0).Select({ i,index => self:getCommonBit(_Data,index)}) )
        var ibit := string.Concat(bit.Select({x => iif(x == '0','1','0')}))
        var num := Convert.ToInt32(bit, 2)
        var num2 := Convert.ToInt32(ibit, 2)
        return num * num2// Use the _Data field to solv5 the 1th puzzle and return the result
    
    method getBitCriteria(co2 as logic) as string
        var tempList := _Data
        var pos := 0
        do while tempList.count > 1
            var commonBit := self:getCommonBit(tempList,pos)
            if co2 
                tempList := tempList.where({x => x.ElementAt(pos)!=commonBit}).ToList()
            else
                tempList := tempList.where({x => x.ElementAt(pos)==commonBit}).ToList()
            endif
            pos+=1
        end do
        return string.Concat(tempList.First())
    
    protected override method Solve2() as object
        var num := Convert.ToInt32(self:getBitCriteria(false), 2)
        var num2 := Convert.ToInt32(self:getBitCriteria(true), 2)
        return num*num2 // Use the _Data field to solve the 1th puzzle and return the result

end class
