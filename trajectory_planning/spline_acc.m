function xdd = spline_acc( t )
global coeff_

T1 = t;
T2 = T1*T1;
T3 = T2*T1;
T4 = T3*T1;


xdd = 2.0 * coeff_(3) + ...
    6.0*T1 * coeff_(4) + ...
    12.0*T2 * coeff_(5) + ...
    20.0*T3 * coeff_(6);


end

