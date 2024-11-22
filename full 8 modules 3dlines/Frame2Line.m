function pos = Frame2Line(framePos, Camera, t)
    
    center = (Camera.resolution / 2); % Center of the frame / Camera frame origin
    x = framePos(1) - center(1); % pos of the object relative to new camera frame origin ^ 
    z = center(2) - framePos(2);
    p = x / Camera.resolution(1) * deg2rad(Camera.FOV_w); % inside tan -> x_n / res * FOV = ang_size
    q = z / Camera.resolution(2) * deg2rad(Camera.FOV_l);
    
    x_bar = [Camera.X Camera.Y Camera.Z]'; % Vertical vector of offset
    R = RotationMatrix321( deg2rad(Camera.attitude()) );
    d = R \ [tan(p), 1, tan(q)]'; % Vertical vector of direction (no t value)
    pos = t.*d + x_bar;

    if framePos(3) == 0
        pos = NaN(length(t));
    end
end