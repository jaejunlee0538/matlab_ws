Implementation of controller simulation introduced in [Bilateral Control of Master-Slave Manipulators for Ideal Kinethetic Coupling-Formulation and Expriment](http://ieeexplore.ieee.org/stamp/stamp.jsp?arnumber=326566).

3 different control schems were introduced.

Except case2, simulations were successfully reproduced.

# 1. case 1
  ![screenshot](https://github.com/jaejunlee0538/matlab_ws/blob/master/bilateral_teleoperation/resource/result_case1.png)
# 2. case 2
  ![screenshot](https://github.com/jaejunlee0538/matlab_ws/blob/master/bilateral_teleoperation/resource/result_case1.png)
# 3. case 3
  ![screenshot](https://github.com/jaejunlee0538/matlab_ws/blob/master/bilateral_teleoperation/resource/result_case1.png)

You can run the simulation by running `simulation.m` file.

Before running it, choose which case you want to see.

Each `set_params_case'N'` contains system parameters(mass, spring, damper ...) and controllers.

```matlab
%% parameters setting ( Choose one of the 3 cases)
% set_params_case1
% set_params_case2
set_params_case3
```
