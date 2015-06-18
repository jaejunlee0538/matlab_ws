function [xd_m_, Es_in_, Es_out_] = TDPA_slave(xd_m, f_s, Em_in, dt)
persistent first_run
persistent Es_in
persistent Es_out

%% initialize TDPA master
if isempty(first_run)
    first_run = false;
    
    Es_in = 0;
    Es_out = 0;
end

%%
delta_Es = xd_m*f_s*dt;

if delta_Es > 0
    Es_in = Es_in + delta_Es;
    
else
    Es_out = Es_out - delta_Es;

    if Es_out - Em_in > 0
        % active.
        Es_out = Es_out + delta_Es;
        xd_m = (Es_out - Em_in)/(f_s*dt);
        Es_out = Em_in;
    end
end

%% copy the result
xd_m_ = xd_m;
Es_in_ = Es_in;
Es_out_ = Es_out;
end

