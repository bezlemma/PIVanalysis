function [V_mean, V_stderr] = func_find_mean_vel(u_orig,v_orig,scale,framerate)
  for i = 1:length(u_orig)
 u = cell2mat(u_orig(i));
  v = cell2mat(v_orig(i));
      V_arr=sqrt(u.*u + v.*v);
      V_mean(i)   = nanmean(nanmean(V_arr))   * scale / framerate;
      V_stderr(i) = nanstd(nanstd(V_arr))./sqrt(length(V_arr)) * scale / framerate; 
  end
end