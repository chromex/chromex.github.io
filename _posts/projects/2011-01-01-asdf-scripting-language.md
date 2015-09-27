---
layout: project
title:  "ASDF Scripting Language"
excerpt: "A simple scripting language developed for embedding in C++ applications. Influenced by Lua and Python, ASDF provides a simple way to script function logic and provides a basic stack based calling mechanism."
categories: projects school
---

Created a simple but complete iterative scripting language which was integrated into a game engine of mine. The entire compiler pipeline was developed: lexical analyzer, parser, and compiler, as well as a virtual machine. Through a VM instance scripts can be executed in the game and can call back out to the engine. The language design was influenced by Python and Lua, taking features such as slices to maximize utility. Time was spent profiling the compiler tool chain and virtual machine to optimize for speed.

{% highlight lua %}
// Example recursive quicksort implementation
quicksort(vec)
{
    sz := size(vec);
    if(sz <= 1)
        return vec;
     
    idx := sz/2; // Index floored by VM
 
    pivot := vec[idx];
 
    // Remove the pivot from the vector
    vec := vec[:idx] # vec[idx+1:];
 
    sz := size(vec);
 
    lesser := [];
    greater := [];
    count := 0;
    while(count < sz)
    {
        if(vec[count] <= pivot)
            lesser #= [vec[count]];
        else
            greater #= [vec[count]];
        count += 1;
    }
 
    return quicksort(lesser) # [pivot] # quicksort(greater);
}
{% endhighlight %}
