Implementation of controller simulation introduced in [Bilateral Control of Master-Slave Manipulators for Ideal Kinethetic Coupling-Formulation and Expriment](http://ieeexplore.ieee.org/stamp/stamp.jsp?arnumber=326566).

3 different control schems were introduced.

Except case2, simulations were successfully reproduced.

# 1. case 1
  `image1`
# 2. case 2
  `image2`
# 3. case 3
  `image3`

You can run the simulation by running `simulation.m` file.

Before running it, choose which case you want to see.

Each `set_params_case**x**` contains system parameters(mass, spring, damper ...) and controllers.

```matlab
%% parameters setting ( Choose one of the 3 cases)
% set_params_case1
% set_params_case2
set_params_case3
```
