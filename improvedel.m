% deldel=inv(B1)*delpv';
delc=0;
for idel=1:busno
   if(bustype(idel)~=1)
      delc=delc+1;
      deldel=fuzzy1(delp(delc),sumdelp,delpmax,sumdelpmax,deldelmax);
      delta(idel)=delta(idel)+deldel;
   end
end
