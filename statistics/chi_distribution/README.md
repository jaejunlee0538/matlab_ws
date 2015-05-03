
## meaning of inverse chi-square cumulative distribution

from [chi2inv document][1]

Find a value that exceeds `95%`` of the samples from a chi-square distribution with 10 degrees of freedom.

```matlab
  x = chi2inv(0.95,10)
  x =
    18.3070
```

You would observe values greater than `18.3` only `5%`` of the time by chance.

`18.3` and `5%` correspond to the value with a **significant level** with `0.005` and `10 dof` in **chi square table**.

## chi square table
![image_chi_table]

image **[source][image_chi_table]**



[1]: http://kr.mathworks.com/help/stats/chi2inv.html#syntax
[image_chi_table]: http://www.di-mgt.com.au/images/chisquare-menez-table.gif
