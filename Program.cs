using System.Collections.Generic;
using System.Linq;

namespace ConsoleApplication3841
{
    class Program
    {
        static void Main(string[] args)
        {
            var yvals = new List<float>() { 1, 2, 3, 3, 3,
                                            4, 1, 6, 9, 21,
                                            18, 13, 10, 7, 6,
                                            5, 4, 2, 3, 4 };
            int midpointOffset = 2;
            var centredMovingAverage = Enumerable
                                         .Range(0, yvals.Count - (2 * midpointOffset + 1) + 1)
                                         .Select(n => yvals.Skip(n).Take((2 * midpointOffset + 1)).Average())
                                          .ToList();
        }
    }
}