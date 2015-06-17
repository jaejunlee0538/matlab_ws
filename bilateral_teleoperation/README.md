Implementation of controller simulation introduced in [Bilateral Control of Master-Slave Manipulators for Ideal Kinethetic Coupling-Formulation and Expriment](http://ieeexplore.ieee.org/stamp/stamp.jsp?arnumber=326566).

## Brief
3 different control schemes were introduced in this paper.

Except case2, simulations were successfully reproduced.

And ideal response was not implemented.

You can find the configurations of simulation at **VI -> D.Simulation** and simulation results at **Fig.8**.

## How to run the code?
You can run the simulation by running `simulation.m` file.

Before running it, choose which case you want to see.

Each `set_params_case'N'` contains system parameters(mass, spring, damper ...) and controllers.

#### code([simulation.m](https://github.com/jaejunlee0538/matlab_ws/blob/master/bilateral_teleoperation/simulation.m))
```matlab
  %% parameters setting ( Choose one of the 3 cases)
  % set_params_case1
  % set_params_case2
  set_params_case3
```

# 1. case 1
  ![screenshot](https://raw.github.com/jaejunlee0538/matlab_ws/master/bilateral_teleoperation/resource/result_case1.png)
# 2. case 2
  ![screenshot](https://raw.github.com/jaejunlee0538/matlab_ws/master/bilateral_teleoperation/resource/result_case2.png)
# 3. case 3
  ![screenshot](https://raw.github.com/jaejunlee0538/matlab_ws/master/bilateral_teleoperation/resource/result_case3.png)

## more...

#### Working version
This code reproduced same results with the paper. But if calculation order changed, simulation becomes unstable and diverges.

**Why??**


```matlab
% operator impedance => master dynamics works at every cases
% master dynamics => operator impedance works except 1st case.

% operator impedance model
f_m = tau_op - (m_op * xdd_m + b_op * xd_m + c_op * x_m);

% master dynamics
xdd_m = (tau_m + f_m - b_m * xd_m) / m_m;
xd_m = xd_m + xdd_m * dt;
x_m = x_m + xd_m * dt;
```
#### Diverging version

Anyway simulation diverged.

```matlab
% operator dynmacis => master impedance doesn't work at every cases
% master impedance => operator dynamics doesn't work at every cases

% master impedance model
f_m = m_m * xdd_m + b_m * xd_m - tau_m;

% operator dynamics
xdd_m = (tau_op - f_m - b_op * xd_m - c_op * x_m) / m_op;
xd_m = xd_m + xdd_m * dt;
x_m = x_m + xd_m * dt;
```

#### Modification about case2
For case2, we had different result compared to the paper. That's because `Equation 66` had wrong sign.

>**equation66**

>![equation66]

`-f_ms` at the end should be modified with `+f_ms`.

Then case2 result will become same with the paper.

[equation66]:https://raw.github.com/jaejunlee0538/matlab_ws/master/bilateral_teleoperation/resource/equation66.png

[case2_modified]:https://raw.github.com/jaejunlee0538/matlab_ws/master/bilateral_teleoperation/resource/result_case2_modified.png
