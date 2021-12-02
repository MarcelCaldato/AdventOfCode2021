using System
using System.Collections.Generic
using System.Text
using System.Linq

class Day02Solver inherit SolverBase

    // Private field to store the parsed data
    private class movements
        CONSTRUCTOR (s as string)
            super()
            var temp := s.Split(' ')
            
            self:direction := temp[1]
            self:times := int32.parse(temp[2])
            return
    
        public property direction as string auto get set
        public property times as int auto get set
    end class
    
    private _Data as List<movements>

    private method getSum(direction as string) as int
        return _Data.Where({item => String.Equals(item:direction,direction, StringComparison.OrdinalIgnoreCase)}).Sum({item => item.times})
    
    protected override method Parse(data as List<string>) as void
        // Parse the List of strings into the _Data field
        _Data := data.Select({s => movements{s}}).ToList()
        return
    
    protected override method Solve1() as object
        var dirX := self:getSum("forward")
        var dirY := self:getSum("down") - self:getSum("up")
        return dirX * dirY // Use the _Data field to solve the 1th puzzle and return the result
    
    protected override method Solve2() as object
        var dirX := 0
        var dirY := 0
        var aim := 0
        foreach var item in _Data
          if String.Equals(item:direction,"down", StringComparison.OrdinalIgnoreCase)
              aim += item.times
          elseif String.Equals(item:direction,"up", StringComparison.OrdinalIgnoreCase)
              aim -= item.times
          elseif String.Equals(item:direction,"forward", StringComparison.OrdinalIgnoreCase)
              dirX += item.times
              dirY += (aim*item.times)
          endif
        next
        return dirX*dirY // Use the _Data field to solve the 1th puzzle and return the result
    
end class
