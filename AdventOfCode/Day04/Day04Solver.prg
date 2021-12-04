using System
using System.Collections.Generic
using System.Text
using System.Linq

class Day04Solver inherit SolverBase
    private class board 
        property lines as list<List<int>> auto get Set := List<List<int>>{}
        property rows as list<List<int>> auto get Set
        property allNumbers as List<int> auto get set := List<int>{}
        
        public method addLine(line as string) as void
            var tempNum := line.split(' ').Where({x => !string.isNullOrWhitespace(x)}).Select({ x => int32.Parse(x)}).ToList()
            self:allNumbers.AddRange(tempNum)
            self:lines.add(tempNum)
            self:rows := self:lines[0].Select({x,index => self:lines.Select({x1 => x1.ElementAt(index)}):ToList()}).ToList()
            return
            
        private method Check(list1 as list<List<int>>,list as List<int>) as logic strict
            foreach var l in list1
              if l.Intersect(list).ToList().Count == l.Count
                  return true
              endif
            next
            return false
            
        public method CheckBoard(list as List<int>) as logic strict
            if list:count < self:lines.Count
                return false
            endif
            var lRet := self:Check(self:lines,list)//self:lines.where({ x => x.Intersect(list).ToList().Count == 5}).ToList().Count > 1
            if !lRet
                lRet :=  self:Check(self:rows,list) // self:rows.where({ x => x.Intersect(list).ToList().Count == 5}).ToList().Count  > 1
            endif
            return lRet
    end class

    // Private field to store the parsed data
    private Numbers as List<int>
    private Boards as List<board>
    
    protected override method Parse(data as List<string>) as void
        // Parse the List of strings into the _Data field
        Numbers := List<int>{}
        Boards := List<board>{}
        local tempBoard as board
        foreach var line in data
            if line.contains(",")
                Numbers.AddRange( line.split(',').Select({s => Int32.Parse(s) }).ToList() )
            elseif string.isNullOrWhitespace(line)
                tempBoard := board{}
                Boards.Add(tempBoard)
            else
                if tempBoard == NULL 
                    tempBoard := board{}
                    Boards.Add(tempBoard)
                endif
                tempBoard.addLine(line)
            endif
        next
        return
    
    protected override method Solve1() as object
        var tempNumbers := List<int>{}
        foreach var n in Numbers
            tempNumbers.Add(n)
            foreach var b in Boards
                if b.CheckBoard(tempNumbers)
                    var sum := B:allNumbers.Except(tempNumbers).sum()
                    return sum * n
                endif
            next
        next
        return 0 
    
    protected override method Solve2() as object
        Numbers.Reverse()
        var tempList := Numbers.ToList()
        foreach var n in Numbers
            foreach var b in Boards
                tempList.Remove(n)
                if !b.CheckBoard(tempList)
                    var sum := B:allNumbers.Except(tempList).sum() - n
                    return sum * n
                endif
            next
        next
        return 0 // Use the _Data field to solve the 1th puzzle and return the result

end class
