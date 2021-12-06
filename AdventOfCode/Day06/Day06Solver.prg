using System
using System.Collections.Generic
using System.Text
using System.Linq

class Day06Solver inherit SolverBase

    // Private field to store the parsed data
    private _Data as List<int>
    
    protected override method Parse(data as List<string>) as void
        // Parse the List of strings into the _Data field
        _Data := List<int>{}
        foreach var line in data
            _Data.AddRange( line.split(',').Select({s => int32.Parse(s) }).ToList() )
        next
        return
    
    
    private class GenDay
        public property tag as int auto get set
        public property Anzahl as int64 auto get set
        public property neu as int64 auto get set
            
        CONSTRUCTOR ( tag as int, anzahl as int64 , neu as int64 )
            super()
            
            self:tag := tag
            self:anzahl := anzahl
            self:neu := neu
            return
    end class
    
    
    private method resolve(days as int) as int64 strict
        var DayList := List<GenDay>{}
        DayList.Add(GenDay{9,1,1})
        local day := 18 as int
        do while day < (days + 9)
            local temp1 as int64
            temp1 := 0
            if DayList.Exists({x => x.tag == (day-9)})
                temp1 := DayList.Find({ x => x.tag == (day-9) }).neu
            endif
            local temp2 as int64
            temp2 := 0
            if DayList.Exists({x => x.tag == (day-7)})
                temp2 := DayList.Find({ x => x.tag == (day-7) }).neu
            endif
            if temp1 != 0 .or. temp2 != 0
                local anzahl as int64
                anzahl := Convert.toint64(DayList.last().anzahl)
                anzahl += temp1 
                anzahl += temp2
                DayList.Add(GenDay{day,anzahl ,temp1 + temp2})
            endif
            DayList.RemoveAll({x => x.tag < day - 9})
            day+= 1
        end do 
        return DayList.last().anzahl
    
    protected override method Solve1() as object
        return _data.Select({x => self:resolve(80+(9-x))}).toList<int64>().Sum()
    
    protected override method Solve2() as object
        return _data.Select({x => self:resolve(256+(9-x))}).toList<int64>().Sum()

end class
