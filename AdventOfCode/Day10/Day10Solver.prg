using System
using System.Collections.Generic
using System.Text
using System.Linq

class Day10Solver inherit SolverBase

    // Private field to store the parsed data
    private _Data as List<string>
    private Map as dictionary<char,char>
    
    protected override method Parse(data as List<string>) as void
        // Parse the List of strings into the _Data field
        _Data := data
        
        Map := dictionary<char,char>{}{{'(',')'},{'[',']'},{'{','}'},{'<','>'}}
         
        return
    
    protected override method Solve1() as object
        var points := dictionary<char,int>{}{{')',3},{']',57},{'}',1197},{'>',25137}}
        var errors := List<char>{}
        foreach var l in _Data
            var st := Stack<char>{}
            foreach var c in l
                if Map.ContainsKey(c)
                    st.Push(Map[c])   
                elseif st.Peek() == c
                    st.Pop()
                else
                    errors.Add(c)
            exit
                endif
            next
        next
        return errors.Select({x => points[x]}).Sum() // Use the _Data field to solve the 1th puzzle and return the result
    
    protected override method Solve2() as object
        var p := List<int64>{}
        var points := dictionary<char,int>{}{{')',1},{']',2},{'}',3},{'>',4}}
        foreach var l in _Data
            var st := Stack<char>{}
            foreach var c in l
                if Map.ContainsKey(c)
                    st.Push(Map[c])   
                elseif st.Peek() == c
                    st.Pop()
                else
                    st.clear()
            exit
                endif
            next
            local total as int64
            total := 0
            do while st.Count > 0
                var c := st.Pop()
                total := (total * 5) + points[c]
            end do
            if total > 0
                p.Add(total)    
            endif
        next
        p := p.OrderBy({x => x}).ToList()
        return p.ElementAT((p.count/2)) // Use the _Data field to solve the 1th puzzle and return the result

end class
