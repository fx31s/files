//+------------------------------------------------------------------+
//|                                                        Wedge.mq4 |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+

bool left_engine(int b,int limit,string typs,ENUM_TIMEFRAMES p,string s) {

bool sonuc=true;

double high_price=iHigh(s,p,b);
double low_price=iLow(s,p,b);

for (int x=b+1;x<b+limit;x++) {

double high_pricex=iHigh(s,p,x);
double low_pricex=iLow(s,p,x);

if ( typs == "UP" ) {

if ( high_price < high_pricex ) {
return false;
}

}

if ( typs == "DOWN" ) {

if ( low_price > low_pricex ) {
return false;
}

}

}





return sonuc;

}





int right_engine(int b,int limit,string typs,ENUM_TIMEFRAMES p,string s) {

bool sonuc=false;
int bottom=0;

double high_price=iHigh(s,p,b);
double low_price=iLow(s,p,b);


for (int x=b-1;x>b-limit;x--) {

double high_pricex=iHigh(s,p,x);
double low_pricex=iLow(s,p,x);

if ( typs == "UP" ) {

if ( high_price > high_pricex ) {
bottom=bottom+1;
} else {
return bottom;
}
}



if ( typs == "DOWN" ) {

if ( low_price < low_pricex ) {
bottom=bottom+1;
} else {
return bottom;
}
}






}

return sonuc;

}



int OnInit()
  {
  
  
  //Alert("Selam");
  
  ObjectsDeleteAll();
  
//--- create timer
   //EventSetTimer(60);
   
   ENUM_TIMEFRAMES per=Period();
   string sym=Symbol();
   
   for (int i=Bars-500;i>0;i--) {
   
   bool durum=left_engine(i,50,"UP",per,sym);
   
   
   bool durums=left_engine(i,50,"DOWN",per,sym);
   
   

 if ( durums == true ) {
   
   //ObjectCreate(ChartID(),"V"+i,OBJ_VLINE,0,Time[i],Ask);
   
   int bottom=0;
   int shift=i;
   bool find=false;
   for ( int b=i-1;b>0;b--) {
   
   if ( b < 0 ) continue;
   
   if ( find == false ) {
   if ( iLow(sym,per,b) < iLow(sym,per,i) ) {
   
   find=true;
   shift=b;
   } else {
   bottom=bottom+1;
   }
   }
   }
   
   //int sfp=right_engine(i,50,"UP",per,sym);
   
   //Print(sfp);
   
   //ObjectCreate(ChartID(),"VDS"+i,OBJ_VLINE,0,Time[i+sfp],Ask);
   //ObjectSetInteger(ChartID(),"VDS"+i,OBJPROP_COLOR,clrBlue);
   
   int sfp=shift;
   
   if ( sfp != 0 && bottom >= 10 ) {
   ObjectCreate(ChartID(),"W"+i,OBJ_TREND,0,Time[i],Low[i],Time[sfp],Low[i]);
   ObjectSetInteger(ChartID(),"W"+i,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),"W"+i,OBJPROP_COLOR,clrBlack);
   
   ObjectCreate(ChartID(),"WL"+i,OBJ_TREND,0,Time[i],Low[i],Time[sfp],Low[sfp]);
   ObjectSetInteger(ChartID(),"WL"+i,OBJPROP_RAY,false);
   
   }
   
   
      
   
   
   
   }
   
   
   
   
   
   
   if ( durum == true ) {
   
   //ObjectCreate(ChartID(),"V"+i,OBJ_VLINE,0,Time[i],Ask);
   
   int bottom=0;
   int shift=i;
   bool find=false;
   for ( int b=i-1;b>0;b--) {
   
   if ( b < 0 ) continue;
   
   if ( find == false ) {
   if ( iHigh(sym,per,b) > iHigh(sym,per,i) ) {
   
   find=true;
   shift=b;
   } else {
   bottom=bottom+1;
   }
   }
   }
   
   //int sfp=right_engine(i,50,"UP",per,sym);
   
   //Print(sfp);
   
   //ObjectCreate(ChartID(),"VDS"+i,OBJ_VLINE,0,Time[i+sfp],Ask);
   //ObjectSetInteger(ChartID(),"VDS"+i,OBJPROP_COLOR,clrBlue);
   
   int sfp=shift;
   
   if ( sfp != 0 && bottom >= 10 ) {
   ObjectCreate(ChartID(),"W"+i,OBJ_TREND,0,Time[i],High[i],Time[sfp],High[i]);
   ObjectSetInteger(ChartID(),"W"+i,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),"W"+i,OBJPROP_COLOR,clrBlack);
   
   ObjectCreate(ChartID(),"WL"+i,OBJ_TREND,0,Time[i],High[i],Time[sfp],High[sfp]);
   ObjectSetInteger(ChartID(),"WL"+i,OBJPROP_RAY,false);
   
   }
   
   
      
   
   
   
   }
   
   
   
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
   
  }
//+------------------------------------------------------------------+
