% Check_convergence

   if delpmax<=tolerance
       kp=0;
   else
       kp=1;
   end
   if delqmax<=tolerance
       kq=0;
   else
       kq=1;
   end
   if(kp==0&kq==0)
       elapsed_time=toc(tstart);
       result
       break;
   end  

  
