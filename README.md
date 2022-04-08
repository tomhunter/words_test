# words_test

## Two Approaches

[lib/sequencer.rb](lib/sequencer.rb) - Coded up a quick proof of concept to accomplish task. Contains some debugging output for testing. I was initially curious about overall processing time, but this ran within seconds locally using the larger dictionary. Therefore performance/algorithm optimizaiton seems premature at this point.  If this were a one-off script or data migration, I would call it done.  I'm a firm believer in pragmmatic programming.  A task should only require as much time and complexity as it needs in order to complete the task, and no more.

[lib/sequencer2.rb](lib/sequencer1.rb) - In the spirit of the exercise, I broke this out into a more object-oriented approach, although it is still a bit contrived.

## Additional Considerations

If this task contained performance requirements, or the dictionary given was a small sample size for a larger report, there would be additional considerations:

a) How quickly is response desired? Can it be completed with a background task?  

b) Are there exceptional memory and/or lookup implications with large datasets that cannot be accounted for using #each_line & hash keys?   

c) Likely a quick Google search would uncover some academic study of this type of problem, and the most efficient way for solving it. With this knowledge, the algorithm could be potentially improved to produce better results.   

d) If the result is still not satisfactory, or the final direction unclear, benchmarking could easily be performed for various solutions on multiple platforms / hardware.  Producing hard data to compare results and if necessary inform stakeholders of technically feasible results.   

```
require ‘benchmark'

Benchmark.bm do |x|
  x.report { Approach1.call(filename) }
  x.report { Approach2.call(filename) }
  x.report { Approach3.call(filename) }
end
```


