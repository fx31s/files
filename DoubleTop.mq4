//+------------------------------------------------------------------+
//|                                                    DoubleTop.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Alpc Software 2023"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property icon "ss.ico"
#property strict


//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+

datetime top_time[5000];
datetime top_times[5000];
double up_prices[5000];
double down_prices[5000];
double h_prices[5000];
double l_prices[5000];
int top_total=-1;
int top_totals=-1;

int control_bar=6;

bool first_time_work=true;


int OnInit()
  {
  
  
if ( first_time_work == false ) {
      int cevap=MessageBox(Symbol()+" Yeniden Çizilem mi patron","Bölge Çizimi",4); //  / Spread:"+Spread_Yuzde+"%"
      if ( cevap != 6 ) {      
      return(INIT_SUCCEEDED);            
      }
      }
     
        
        
first_time_work=false;        
  
  
  for ( int u=0;u<5000;u++) {
  
top_time[u]=-1;
top_times[u]=-1;
up_prices[u]=-1;
down_prices[u]=-1;
h_prices[u]=-1;
l_prices[u]=-1;
top_total=-1;
top_totals=-1;
  
  
  
  }
  
  
  
//--- create timer
   //EventSetTimer(60);
   
   ObjectsDeleteAll();
   
   
   string sym=Symbol();
   ENUM_TIMEFRAMES per=Period();
   
   for (int i=Bars-500;i>7;i--) {
   //for (int i=500;i>7;i--) {
   
   ////////////////////////////
   // Left
   ////////////////////////////
   
   double high_price=iHigh(sym,per,i);
   double op_price=iOpen(sym,per,i);
   double cl_price=iClose(sym,per,i);
   double low_price=iLow(sym,per,i);
   
   double up_price;
   double down_price;
   
   if ( cl_price >= op_price ) {up_price=cl_price;down_price=op_price;};
   if ( cl_price < op_price ) {up_price=op_price;down_price=cl_price;};
   
   bool find=false;
   bool find_left=false;
   bool find_right=false;
   
   
   
      for (int r=i-1;r>i-control_bar;r--) {
      
      if (find_right==true)continue;
      
      double h_p=iHigh(sym,per,r);            
      if ( high_price < h_p ) {
      find_right=true;
      }
      
      }
      

      for (int r=i+1;r<i+control_bar;r++) {
      
      if (find_left==true)continue;
      
      double h_p=iHigh(sym,per,r);            
      if ( high_price < h_p ) {
      find_left=true;
      }
      
      }
      
      
            
      
      
     /* for (int r=i-21;r<i+40;r++) {
      
      if ( r==i ) continue;
      if ( find == true ) continue;
      
      double h_p=iHigh(sym,per,r);            
      if ( high_price > h_p ) {
      find=false;
      } else {
      find=true;
      }
  

      }*/
      
   
      if ( find_right==false && find_left == false) {
     /* ObjectCreate(ChartID(),"VUP"+i,OBJ_VLINE,0,Time[i],Ask);  
      ObjectSetInteger(ChartID(),"VUP"+i,OBJPROP_BACK,true);  
      ObjectSetInteger(ChartID(),"VUP"+i,OBJPROP_STYLE,STYLE_DOT);  
      ObjectSetInteger(ChartID(),"VUP"+i,OBJPROP_COLOR,clrBlack);*/
  /*
      ObjectCreate(ChartID(),"RUP"+i,OBJ_RECTANGLE,0,Time[i],high_price,Time[i]+10*PeriodSeconds(),up_price);  
      ObjectSetInteger(ChartID(),"RUP"+i,OBJPROP_BACK,true);  
      ObjectSetInteger(ChartID(),"RUP"+i,OBJPROP_STYLE,STYLE_DOT);  
      ObjectSetInteger(ChartID(),"RUP"+i,OBJPROP_COLOR,clrLightSlateGray);  */    

      top_total=top_total+1;
      top_time[top_total]=iTime(sym,per,i);
      up_prices[top_total]=up_price;
      h_prices[top_total]=high_price;
      
        
      }            
         
   
   
   
   }
   
   
   
   
   
   
   
   for ( int i=top_total;i>0;i--){
   
   //Print(i,top_time[i]);
   
   
   int shift=iBarShift(sym,per,top_time[i]);
   int shifts=iBarShift(sym,per,top_time[i+1]);
   
   bool find=false;
   bool up_close=false;
   
   for ( int r=shift-15;r>1;r--) {
   
   if ( r < 0 ) continue;
   
   //if ( r < shifts ) continue;
   
   double high_price=iHigh(sym,per,r);
   double op_price=iOpen(sym,per,r);
   double cl_price=iClose(sym,per,r);
   double low_price=iLow(sym,per,r);  
   

   double high_pricer=iHigh(sym,per,r-1);
   double op_pricer=iOpen(sym,per,r-1);
   double cl_pricer=iClose(sym,per,r-1);
   double low_pricer=iLow(sym,per,r-1);  
   
   double high_pricerr=iHigh(sym,per,r-2);
   double op_pricerr=iOpen(sym,per,r-2);
   double cl_pricerr=iClose(sym,per,r-2);
   double low_pricerr=iLow(sym,per,r-2);     
   
      
   
   if ( high_price >= up_prices[i] && cl_price <= h_prices[i] && find==false && op_pricer > cl_pricer && op_pricerr > cl_pricerr && op_price < h_prices[i] && op_price < up_prices[i] ) {
   
/*
      ObjectCreate(ChartID(),"VUPT"+r,OBJ_VLINE,0,Time[r],Ask);  
      ObjectSetInteger(ChartID(),"VUPT"+r,OBJPROP_BACK,true);  
      ObjectSetInteger(ChartID(),"VUPT"+r,OBJPROP_STYLE,STYLE_DOT);  
      ObjectSetInteger(ChartID(),"VUPT"+r,OBJPROP_COLOR,clrBlue);*/ 
      
      ObjectCreate(ChartID(),"RUP"+i,OBJ_RECTANGLE,0,top_time[i],h_prices[i],iTime(sym,per,r),up_prices[i]);  
      ObjectSetInteger(ChartID(),"RUP"+i,OBJPROP_BACK,true);  
      ObjectSetInteger(ChartID(),"RUP"+i,OBJPROP_STYLE,STYLE_DOT);  
      ObjectSetInteger(ChartID(),"RUP"+i,OBJPROP_COLOR,clrLightSlateGray);         
      
      ObjectCreate(ChartID(),"RUPT"+i,OBJ_TREND,0,top_time[i],up_prices[i],iTime(sym,per,r),up_prices[i]);  
      ObjectSetInteger(ChartID(),"RUPT"+i,OBJPROP_BACK,true);  
      ObjectSetInteger(ChartID(),"RUPT"+i,OBJPROP_STYLE,STYLE_DOT);  
      ObjectSetInteger(ChartID(),"RUPT"+i,OBJPROP_COLOR,clrBlack);   
      ObjectSetInteger(ChartID(),"RUPT"+i,OBJPROP_RAY,False);      
        
        find=true; 
   
   }
   
   
   if ( cl_price > h_prices[i]  ) {
   up_close=true;
   }   
   
   
    }
    
    /*
      ObjectCreate(ChartID(),"VUP"+i,OBJ_VLINE,0,top_time[i],Ask);  
      ObjectSetInteger(ChartID(),"VUP"+i,OBJPROP_BACK,true);  
      ObjectSetInteger(ChartID(),"VUP"+i,OBJPROP_STYLE,STYLE_DOT);  
      ObjectSetInteger(ChartID(),"VUP"+i,OBJPROP_COLOR,clrBlack); */  
      
      

      if ( find==false && up_close == false ) {

      ObjectCreate(ChartID(),"RUPNEW"+i,OBJ_RECTANGLE,0,top_time[i],h_prices[i],top_time[i]+3000*PeriodSeconds(),up_prices[i]);  
      ObjectSetInteger(ChartID(),"RUPNEW"+i,OBJPROP_BACK,true);  
      ObjectSetInteger(ChartID(),"RUPNEW"+i,OBJPROP_STYLE,STYLE_DOT);  
      ObjectSetInteger(ChartID(),"RUPNEW"+i,OBJPROP_COLOR,clrLightSteelBlue);       
      
      
      }
      
         
      
      
      /*
      if ( i > 0 ) {
      ObjectCreate(ChartID(),"RUP"+i,OBJ_RECTANGLE,0,top_time[i],h_prices[i],top_time[i+1],up_prices[i]);  
      ObjectSetInteger(ChartID(),"RUP"+i,OBJPROP_BACK,true);  
      ObjectSetInteger(ChartID(),"RUP"+i,OBJPROP_STYLE,STYLE_DOT);  
      ObjectSetInteger(ChartID(),"RUP"+i,OBJPROP_COLOR,clrLightSlateGray);   
      }*/
           
   
  
   
      
   }
   
   
   
   
   
   /*
   //for ( int i=0;i<=top_total;i++){
   for ( int i=top_total;i>0;i--){
   
   Print(i,top_time[i]);
   
   
      ObjectCreate(ChartID(),"VUP"+i,OBJ_VLINE,0,top_time[i],Ask);  
      ObjectSetInteger(ChartID(),"VUP"+i,OBJPROP_BACK,true);  
      ObjectSetInteger(ChartID(),"VUP"+i,OBJPROP_STYLE,STYLE_DOT);  
      ObjectSetInteger(ChartID(),"VUP"+i,OBJPROP_COLOR,clrBlack);   
      
      if ( i > 0 ) {
      ObjectCreate(ChartID(),"RUP"+i,OBJ_RECTANGLE,0,top_time[i],h_prices[i],top_time[i+1],up_prices[i]);  
      ObjectSetInteger(ChartID(),"RUP"+i,OBJPROP_BACK,true);  
      ObjectSetInteger(ChartID(),"RUP"+i,OBJPROP_STYLE,STYLE_DOT);  
      ObjectSetInteger(ChartID(),"RUP"+i,OBJPROP_COLOR,clrLightSlateGray);   
      }
           
   
   }
   */
   
   Comment("top_total:",top_total);
   
   


   for (int i=Bars-100;i>7;i--) {
   //for (int i=500;i>7;i--) {
   
   ////////////////////////////
   // Left
   ////////////////////////////
   
   double high_price=iHigh(sym,per,i);
   double op_price=iOpen(sym,per,i);
   double cl_price=iClose(sym,per,i);
   double low_price=iLow(sym,per,i);
   
   double up_price;
   double down_price;
   
   if ( cl_price >= op_price ) {up_price=cl_price;down_price=op_price;};
   if ( cl_price < op_price ) {up_price=op_price;down_price=cl_price;};
   
   bool find=false;
   bool find_left=false;
   bool find_right=false;
   
   
   
      for (int r=i-1;r>i-control_bar;r--) {
      
      if (find_right==true)continue;
      
      double l_p=iLow(sym,per,r);            
      if ( low_price > l_p ) {
      find_right=true;
      }
      
      }
      

      for (int r=i+1;r<i+control_bar;r++) {
      
      if (find_left==true)continue;
      
      double l_p=iLow(sym,per,r);            
      if ( low_price > l_p ) {
      find_left=true;
      }
      
      }
      
      
            
      
      
     /* for (int r=i-21;r<i+40;r++) {
      
      if ( r==i ) continue;
      if ( find == true ) continue;
      
      double h_p=iHigh(sym,per,r);            
      if ( high_price > h_p ) {
      find=false;
      } else {
      find=true;
      }
  

      }*/
      
   
      if ( find_right==false && find_left == false) {
     /* ObjectCreate(ChartID(),"VUP"+i,OBJ_VLINE,0,Time[i],Ask);  
      ObjectSetInteger(ChartID(),"VUP"+i,OBJPROP_BACK,true);  
      ObjectSetInteger(ChartID(),"VUP"+i,OBJPROP_STYLE,STYLE_DOT);  
      ObjectSetInteger(ChartID(),"VUP"+i,OBJPROP_COLOR,clrBlack);*/
  /*
      ObjectCreate(ChartID(),"RUP"+i,OBJ_RECTANGLE,0,Time[i],high_price,Time[i]+10*PeriodSeconds(),up_price);  
      ObjectSetInteger(ChartID(),"RUP"+i,OBJPROP_BACK,true);  
      ObjectSetInteger(ChartID(),"RUP"+i,OBJPROP_STYLE,STYLE_DOT);  
      ObjectSetInteger(ChartID(),"RUP"+i,OBJPROP_COLOR,clrLightSlateGray);  */    

      top_totals=top_totals+1;
      top_times[top_totals]=iTime(sym,per,i);
      down_prices[top_totals]=down_price;
      l_prices[top_totals]=low_price;
      
        
      }            
         
   
   
   
   }
   
      
   




   
   for ( int i=top_totals;i>0;i--){
   
   //Print(i,top_times[i]);
   
   
   int shift=iBarShift(sym,per,top_times[i]);
   int shifts=iBarShift(sym,per,top_times[i+1]);
   
   bool find=false;
   bool down_close=false;
   
   for ( int r=shift-15;r>1;r--) {
   
   if ( r < 0 ) continue;
   
   //if ( r < shifts ) continue;
   
   double high_price=iHigh(sym,per,r);
   double op_price=iOpen(sym,per,r);
   double cl_price=iClose(sym,per,r);
   double low_price=iLow(sym,per,r);  
   

   double high_pricer=iHigh(sym,per,r-1);
   double op_pricer=iOpen(sym,per,r-1);
   double cl_pricer=iClose(sym,per,r-1);
   double low_pricer=iLow(sym,per,r-1);  
   
   double high_pricerr=iHigh(sym,per,r-2);
   double op_pricerr=iOpen(sym,per,r-2);
   double cl_pricerr=iClose(sym,per,r-2);
   double low_pricerr=iLow(sym,per,r-2);     
   
      
   
   if ( low_price <= down_prices[i] && cl_price >= l_prices[i] && find==false && op_pricer < cl_pricer && op_pricerr < cl_pricerr && op_price > l_prices[i] && op_price > down_prices[i] ) {
   
/*
      ObjectCreate(ChartID(),"VUPT"+r,OBJ_VLINE,0,Time[r],Ask);  
      ObjectSetInteger(ChartID(),"VUPT"+r,OBJPROP_BACK,true);  
      ObjectSetInteger(ChartID(),"VUPT"+r,OBJPROP_STYLE,STYLE_DOT);  
      ObjectSetInteger(ChartID(),"VUPT"+r,OBJPROP_COLOR,clrBlue);*/ 
      
      ObjectCreate(ChartID(),"RDOWN"+i,OBJ_RECTANGLE,0,top_times[i],l_prices[i],iTime(sym,per,r),down_prices[i]);  
      ObjectSetInteger(ChartID(),"RDOWN"+i,OBJPROP_BACK,true);  
      ObjectSetInteger(ChartID(),"RDOWN"+i,OBJPROP_STYLE,STYLE_DOT);  
      ObjectSetInteger(ChartID(),"RDOWN"+i,OBJPROP_COLOR,clrLightSlateGray);         
      
      ObjectCreate(ChartID(),"RDOWNT"+i,OBJ_TREND,0,top_times[i],down_prices[i],iTime(sym,per,r),down_prices[i]);  
      ObjectSetInteger(ChartID(),"RDOWNT"+i,OBJPROP_BACK,true);  
      ObjectSetInteger(ChartID(),"RDOWNT"+i,OBJPROP_STYLE,STYLE_DOT);  
      ObjectSetInteger(ChartID(),"RDOWNT"+i,OBJPROP_COLOR,clrRed);   
      ObjectSetInteger(ChartID(),"RDOWNT"+i,OBJPROP_RAY,False);        
        
        find=true; 
   
   }
   
   
   if ( cl_price < l_prices[i]  ) {
   down_close=true;
   }
   
   
   
   
   
   
   
    }
    
    
       
    
    
    /*
      ObjectCreate(ChartID(),"VUD"+i,OBJ_VLINE,0,top_times[i],Ask);  
      ObjectSetInteger(ChartID(),"VUD"+i,OBJPROP_BACK,true);  
      ObjectSetInteger(ChartID(),"VUD"+i,OBJPROP_STYLE,STYLE_DOT);  
      ObjectSetInteger(ChartID(),"VUD"+i,OBJPROP_COLOR,clrBlack);  */
      
      if ( find==false && down_close == false ) {



      ObjectCreate(ChartID(),"RDOWNEW"+i,OBJ_RECTANGLE,0,top_times[i],l_prices[i],top_times[i]+3000*PeriodSeconds(),down_prices[i]);  
      ObjectSetInteger(ChartID(),"RDOWNEW"+i,OBJPROP_BACK,true);  
      ObjectSetInteger(ChartID(),"RDOWNEW"+i,OBJPROP_STYLE,STYLE_DOT);  
      ObjectSetInteger(ChartID(),"RDOWNEW"+i,OBJPROP_COLOR,clrLightSteelBlue);       
      
      
      }
      
      
      
      
      
      
      /*
      if ( i > 0 ) {
      ObjectCreate(ChartID(),"RUP"+i,OBJ_RECTANGLE,0,top_time[i],h_prices[i],top_time[i+1],up_prices[i]);  
      ObjectSetInteger(ChartID(),"RUP"+i,OBJPROP_BACK,true);  
      ObjectSetInteger(ChartID(),"RUP"+i,OBJPROP_STYLE,STYLE_DOT);  
      ObjectSetInteger(ChartID(),"RUP"+i,OBJPROP_COLOR,clrLightSlateGray);   
      }*/
           
   
  
   
      
   }
   
      
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//--- destroy timer
   EventKillTimer();
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//---
   
  }
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//---

if ( sparam == 45 ) {

if ( control_bar == 6 ) {
control_bar=60;
} else {
control_bar=6;
}

OnInit();

}


if ( ObjectType(sparam) == OBJ_RECTANGLE ) {


if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_COLOR) == clrRed )


 {

ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrLightSteelBlue);
return;
}

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_COLOR) == clrLightSteelBlue ) {

ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrRed);

}





}


if(id==CHARTEVENT_CLICK )  {     

      int      x     =(int)lparam;
      int      y     =(int)dparam;
      datetime dt    =0;
      double   price =0;
      int      window=0;
      //--- Convert the X and Y coordinates in terms of date/time
      if(ChartXYToTimePrice(0,x,y,window,dt,price))
        {
        
        
        
        
        int shift=iBarShift(Symbol(),Period(),dt);
        
        Print(price,"/",shift);
        
        if ( Close[shift] > Open[shift] ) {
        
        if ( price >= Close[shift] && price <=High[shift] ) {
        ObjectCreate(ChartID(),"SUPDEMUP"+Time[shift],OBJ_RECTANGLE,0,Time[shift],High[shift],Time[shift]+100*PeriodSeconds(),Close[shift]);          
        ObjectSetInteger(ChartID(),"SUPDEMUP"+Time[shift],OBJPROP_BACK,true);
        ObjectSetInteger(ChartID(),"SUPDEMUP"+Time[shift],OBJPROP_COLOR,clrBisque);
        }     
        
        }
        
        if ( Close[shift] < Open[shift] ) {
        
        if ( price <= Close[shift] && price >=Low[shift] ) {
        ObjectCreate(ChartID(),"SUPDEMUP"+Time[shift],OBJ_RECTANGLE,0,Time[shift],Low[shift],Time[shift]+100*PeriodSeconds(),Close[shift]);          
        ObjectSetInteger(ChartID(),"SUPDEMUP"+Time[shift],OBJPROP_BACK,true);
        ObjectSetInteger(ChartID(),"SUPDEMUP"+Time[shift],OBJPROP_COLOR,clrBisque);
        }     
        
        }
        
            
        if ( Close[shift] < Open[shift] ) {
        
        if ( price >= Open[shift] && price <=High[shift] ) {
        ObjectCreate(ChartID(),"SUPDEMUP"+Time[shift],OBJ_RECTANGLE,0,Time[shift],High[shift],Time[shift]+100*PeriodSeconds(),Open[shift]);          
        ObjectSetInteger(ChartID(),"SUPDEMDOWN"+Time[shift],OBJPROP_BACK,true);
        ObjectSetInteger(ChartID(),"SUPDEMDOWN"+Time[shift],OBJPROP_COLOR,clrLightSlateGray);
        }     
        
        }
        
        if ( Close[shift] > Open[shift] ) {
        
        if ( price <= Close[shift] && price >=Low[shift] ) {
        ObjectCreate(ChartID(),"SUPDEMDOWN"+Time[shift],OBJ_RECTANGLE,0,Time[shift],Low[shift],Time[shift]+100*PeriodSeconds(),Open[shift]);          
        ObjectSetInteger(ChartID(),"SUPDEMDOWN"+Time[shift],OBJPROP_BACK,true);
        ObjectSetInteger(ChartID(),"SUPDEMDOWN"+Time[shift],OBJPROP_COLOR,clrLightSlateGray);
        }     
        
        }
        
                    
                
        

        
        }
        }
        

   
  }
//+------------------------------------------------------------------+
