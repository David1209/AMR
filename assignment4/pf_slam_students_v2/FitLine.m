%---------------------------------------------------------------------
% This function computes the parameters (r, alpha) of a line passing
% through input points that minimize the total-least-square error.
%
% Input:   XY - [2,N] : Input points
%          
% Output:  r, alpha: paramters of the fitted line

function [r, alpha] = FitLine(XY)
  
  % Compute the centroid of the point set (xmw, ymw) considering that 
  % the centroid of a finite set of points can be computed as
  % the arithmetic mean of each coordinate of the points.

  % XY(1,:) contains x position of the points
  % XY(2,:) contains y position of the points
  points = size(XY, 2);
  xmw_temp = 0;
  ymw_temp = 0;
  
  for i = 1:points
      xmw_temp = xmw_temp + XY(1, i);
      ymw_temp = ymw_temp + XY(2, i);
  end
  xmw = xmw_temp / points
  ymw = ymw_temp / points

  % compute parameter alpha (see exercise pages)
  nom = 0;
  denom = 0;
  for i = 1:points
      nom = nom + ((XY(1, i) - xmw) * (XY(2, i) - ymw));
      denom = denom + ((XY(2, i) - ymw)^2 - (XY(1, i) - xmw)^2);
  end
  nom = -2 * nom;

  alpha = 0.5 * atan2(nom, denom);
  
  % compute parameter r (see exercise pages)
  r = xmw * cos(alpha) + ymw * sin(alpha);
  
  % Eliminate negative radii
  if r < 0,
    alpha = alpha + pi;
    if alpha > pi, alpha = alpha - 2 * pi; end
    r = -r;
  end;
  
  return  % function FitLine
