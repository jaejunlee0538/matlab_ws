function [f_s_, Em_in_, Em_out_] = TDPA_master(xd_m, f_s, Es_in, dt)
persistent first_run
persistent Em_in
persistent Em_out

%% initialize TDPA master
if isempty(first_run)
    first_run = false;
    
    Em_in = 0;
    Em_out = 0;
end

%%
delta_Em = xd_m*f_s*dt;

if delta_Em > 0
    Em_in = Em_in + delta_Em;
    
else
    Em_out = Em_out - delta_Em;
    
    if Em_out - Es_in > 0
        % active.
        Em_out = Em_out + delta_Em;
        f_s = (Em_out - Es_in)/(xd_m*dt);
        Em_out = Es_in;
    end
end


%% copy the result
f_s_ = f_s;
Em_in_ = Em_in;
Em_out_ = Em_out;
end

