pc=0;
for(ipcal=1:busno)
   if(bustype(ipcal)~=1)
      pc=pc+1;
   	mul=v(ipcal)*exp(-j*delta(ipcal));
   	t=0;
   	for(k=1:busno)
     		t=t+ybus(ipcal,k)*(v(k)*exp(j*delta(k)));
   	end
   	pq=mul*t;
      calp=real(pq);
      pg=busdata(ipcal,6);
      pl=busdata(ipcal,4);
      p=pg-pl;
      delp(pc)=(p-calp);
      delpv(pc)=delp(pc)/v(ipcal);
      a(pc)=ipcal;
   end
end
[delpmax,p1]=max(abs(delp));

sumdelp=sum(delp);

if delpmax>abs(sumdelp)
    sumdelpmax=delpmax;
else
    sumdelpmax=abs(sumdelp);
end
max_p_error=delpmax+sumdelpmax;    
deldelmax=(1/B1(p1))*delpmax;
    
