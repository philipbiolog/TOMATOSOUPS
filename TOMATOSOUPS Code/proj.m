function vec = proj(p, v)
% proj_v(p)

vec = (dot(p,v)/norm(v)^2)*v;
end