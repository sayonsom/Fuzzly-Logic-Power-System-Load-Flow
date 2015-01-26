% delv=inv(B2)*delqv';
vc=0;
for iev=1:busno
   if(bustype(iev)==2)
      vc=vc+1;
      delv=fuzzy1(delq(vc),sumdelq,delqmax,sumdelqmax,delvmax);
      v(iev)=v(iev)+delv;
   end
end

