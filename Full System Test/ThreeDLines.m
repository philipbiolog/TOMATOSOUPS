function pos = ThreeDLines(pixelPosition,camInfo,n,t)

%loading in a struct of camInfo with n cameras in that struct, this allows you to understand
%how many cameras you have, and the properly name variables from there.
cam = fieldnames(camInfo);
pix = fieldnames(pixelPosition);

%% Stuff to test bearing lines

%% Camera values

cam_see = [];

iterator = 1;

for ii=1:n
    
    %conditional statement that if the camera cannot see the glider, do not
    %calculate the bearings line and move from there
    if isnan(pixelPosition.(pix{ii}).x(t))
        continue
    elseif pixelPosition.(pix{ii}).x(t) < 0 || pixelPosition.(pix{ii}).x(t) > camInfo.(cam{ii}).resolution(1)
        continue
    elseif pixelPosition.(pix{ii}).z(t) < 0 || pixelPosition.(pix{ii}).z(t) > camInfo.(cam{ii}).resolution(2)
        continue
    end

    %The next few lines are doing calculations to evaluate the direction of
    %the bearing line for that camera
    center = camInfo.(cam{ii}).resolution / 2;

    fx = center(1) / tand(camInfo.(cam{ii}).FOV_w / 2);
    fz = center(2) / tand(camInfo.(cam{ii}).FOV_l / 2);

    dx = (pixelPosition.(pix{ii}).x(t) - center(1)) / fx;
    dz = -(pixelPosition.(pix{ii}).z(t) - center(2)) / fz;

    x_bar.(cam{ii}) = [camInfo.(cam{ii}).X;camInfo.(cam{ii}).Y;camInfo.(cam{ii}).Z];

    d_temp = [dx , 1 , dz]';
    d_temp = d_temp / norm(d_temp);

    R = camInfo.(cam{ii}).R;

    %final direction vector calculated
    d.(cam{ii}) = R * d_temp;

    clear R;
    %this logs which cameras can see the glider for future use. So if cams
    %1,2,4,6,7 can see the glider cam_see will be a vector of length 5,
    %with the values 1,2,4,6,7. this should keep the next calculations
    %consistent
    cam_see(iterator) = ii;
    iterator = iterator+1;
    
end

if length(cam_see) < 2
    pos = NaN(3,1);
    return
end

%% Equations

%calling the system of equations function to get the full system of
%equations for the bearings line as an anonymous function
f = @(t) systemOfEquations(t, cam, cam_see, d, x_bar);

%% Solution

%setting an initial guess %%SUBJECT TO CHANGE%%
initial_guess = 10 * ones(length(cam_see),1);

%fsolve options, reducing the tolerance, and turning the display off
%options = optimoptions('lsqnonlin','OptimalityTolerance',1e-5,'Display','off');

%calling fsolve to solve for t
options = optimoptions("lsqnonlin",'FunctionTolerance',1e-5,'Display','off');
lb = -200 * ones(length(cam_see),1);
ub = 400 * ones(length(cam_see),1);

[t, ~] = lsqnonlin(f, initial_guess,lb,ub,options);

%finding position by finding the average of all the calculated position
%values from the value of t fsolve gave
sum = 0;
for m = 1:length(cam_see)
    sum = sum + t(m) * d.(cam{cam_see(m)}) + x_bar.(cam{cam_see(m)});
end

pos = sum / length(cam_see);



    function f = systemOfEquations(t, fld, cam_see, d, x_bar)
        % initializing the function vector
        f = [];
        
        % define the system of equations for all cameras that can see the
        % glider
        for j = 1:(length(cam_see)-1)
            for k = j+1:length(cam_see)  % compare each unique pair (avoid repetition)
                
                % extract the variables t1, t2 from the input vector t
                % where t1 is the first camera the functions are
                % evaluating, and t2 is the second camera
                t1 = t(j); 
                t2 = t(k);    
                
                % calculate the equation for the pair of cameras j, k
                % difference of camera positions
                x_bar_off = x_bar.(fld{cam_see(j)}) - x_bar.(fld{cam_see(k)}); 
                d1 = d.(fld{cam_see(j)}); 
                d2 = d.(fld{cam_see(k)}); 
                
                % define the equations f1 and f2 for the total system of
                % equations
                f1 = d1(1)*(t1*d1(1)-t2*d2(1) + x_bar_off(1)) + ...
                       d1(2)*(t1*d1(2)-t2*d2(2) + x_bar_off(2)) + ...
                       d1(3)*(t1*d1(3)-t2*d2(3) + x_bar_off(3));
                   
                f2 = d2(1)*(t1*d1(1)-t2*d2(1) + x_bar_off(1)) + ...
                       d2(2)*(t1*d1(2)-t2*d2(2) + x_bar_off(2)) + ...
                       d2(3)*(t1*d1(3)-t2*d2(3) + x_bar_off(3));
                   
                % appending the equations to the main function vector
                f = [f; f1; f2];
            end
        end
    end


end

