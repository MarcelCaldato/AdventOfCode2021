using System
using System.Collections.Generic
using System.Text
using System.Linq

class Day08Solver inherit SolverBase

    private class code 
        private digits as List<List<char>>
        private input as List<List<char>>

        private mapping as Dictionary<int,List<Char>>
        public result as List<int>

        
        CONSTRUCTOR( line as string )
            super()  
            var temp := line.split('|')
            digits := self:GetList(temp[0])
            input := self:GetList(temp[1])
            
            self:Map()
            self:Decode()
            return
            

        private method Map() as void
            mapping := Dictionary<int,List<Char>>{}

            mapping.Add(1,digits.FirstOrDefault({x => x.count == 2}))
            mapping.Add(4,digits.FirstOrDefault({x => x.count == 4}))
            mapping.Add(7,digits.FirstOrDefault({x => x.count == 3}))
            mapping.Add(8,digits.FirstOrDefault({x => x.count == 7}))
            digits.RemoveAll({x => mapping.ContainsValue(x)})
            
            mapping.Add(9,digits.FirstOrDefault({x => x.count == 6 .and. mapping[4].Intersect(x).ToList().Count == mapping[4].Count }))
            digits.Remove(mapping[9])
            mapping.Add(0,digits.FirstOrDefault({x => x.count == 6 .and. mapping[1].Intersect(x).ToList().Count == mapping[1].Count }))
            digits.Remove(mapping[0])
            mapping.Add(6,digits.FirstOrDefault({x => x.count == 6}))
            digits.Remove(mapping[6])
            
            mapping.Add(5,digits.FirstOrDefault({x => x.count == 5 .and. mapping[6].Intersect(x).ToList().Count == x.Count }))
            digits.Remove(mapping[5])
            mapping.Add(3,digits.FirstOrDefault({x => x.count == 5 .and. mapping[7].Intersect(x).ToList().Count == mapping[7].Count }))
            digits.Remove(mapping[3])
            mapping.Add(2,digits.FirstOrDefault({x => x.count == 5}))
            return

            
        private method Decode() as void
            result := input.Select({ x => mapping.FirstOrDefault({y => Enumerable.SequenceEqual(x,y.value) }).Key }).ToList()
            return
            
       
        private method GetList( s as string) as List<List<char>>
            return s.Split(' ').Select({x => List<char>{ x.OrderBy({c => c}) }}).ToList()

            
        public method count(numbers as List<int>) as int
            return result.where({ y => numbers.IndexOf(y) != -1 }).ToList().count


        public method GetNum() as int
            var total := 0
            foreach var n in result
                total := 10 * total + n
            next
            return total
            
        public method ToString() as string
            return self:GetNum().ToString()
    end class

    // Private field to store the parsed data
    private _Data as List<code>
    
    protected override method Parse(data as List<string>) as void
        // Parse the List of strings into the _Data field
        _Data := data.Select({x => code{x}}).ToList()
        return
    
    protected override method Solve1() as object
        var tempList := List<int>{}
        tempList.Add(1)
        tempList.Add(4)
        tempList.Add(7)
        tempList.Add(8)
        return _Data.Select({ x =>  x.count(tempList)}).sum()
    
    protected override method Solve2() as object
        return _Data.Select({x => x.getNum()}).sum()

end class
