function set_profile_duration( pos1, vel1, acc1, pos2, vel2, acc2, duration )

global coeff_

T1 = duration;
T2 = T1*T1;
T3 = T2 * T1;
T4 = T3 * T1;
T5 = T4 * T1;

coeff_(1) = pos1;
coeff_(2) = vel1;
coeff_(3) = 0.5 * acc1;
coeff_(4) = (-20.0 * pos1 + 20.0*pos2 - 3.0*acc1*T2 + acc2*T2 - 12.0*vel1*T1 - 8.0*vel2*T1)/(2.0*T3);
coeff_(5) = (30.0*pos1 - 30.0*pos2 + 3.0*acc1*T2 - 2.0*acc2*T2 + 16.0*vel1*T1 + 14.0*vel2*T1)/(2.0*T4);
coeff_(6) = (-12.0*pos1 + 12.0*pos2 - acc1*T2 + acc2*T2 - 6.0*vel1*T1 - 6.0*vel2*T1)/(2.0*T5);

end

