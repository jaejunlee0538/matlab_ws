function x = spline_pos( t )
global coeff_

T1 = t;
T2 = T1*T1;
T3 = T2*T1;
T4 = T3*T1;
T5 = T4*T1;

x = coeff_(1) + ...
    T1 * coeff_(2) + ...
    T2 * coeff_(3) + ...
    T3 * coeff_(4) + ...
    T4 * coeff_(5) + ...
    T5 * coeff_(6);



end

