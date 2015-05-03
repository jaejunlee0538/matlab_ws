function xd = spline_vel( t )
global coeff_

T1 = t;
T2 = T1*T1;
T3 = T2*T1;
T4 = T3*T1;


xd = coeff_(2) + ...
    2.0*T1 * coeff_(3) + ...
    3.0*T2 * coeff_(4) + ...
    4.0*T3 * coeff_(5) + ...
    5.0*T4 * coeff_(6);


end

