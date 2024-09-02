//+------------------------------------------------------------------+
//|                                                         Sali.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+

int OnInit()
  {
//--- create timer
   //EventSetTimer(60);
   
   ObjectsDeleteAll();
   
   
   
   
   
   
   
   /*for(int i=0;i<100;i++) {
   
   
   
    if(TimeDayOfWeek(Time[i])==2 ) {
    
    ObjectCreate(ChartID(),"VLINE"+i,OBJ_VLINE,0,Time[i],Ask);
    
    
    }
    
    }*/
   
   
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
datetime ctime;

void OnTick()
  {
//---

if ( ctime != Time[1] ) {

double high_price=-1;
double low_price=1000000000;
int high_shift=0;
int low_shift=0;

for(int i=2;i<=12;i++) {
if ( High[i] > high_price ) {
high_price=High[i];
high_shift=i;
}

if ( Low[i] < low_price ) {
low_price=Low[i];
low_shift=i;
}

}



if ( Close[1] > high_price && (high_price-low_price)/Point < 100 ) {

ObjectCreate(ChartID(),"Area"+Time[12],OBJ_RECTANGLE,0,Time[12],high_price,Time[2],low_price);

if ( Open[low_shift] < Close[low_shift] ) ObjectCreate(ChartID(),"AreaH"+Time[12],OBJ_TREND,0,Time[12],Close[high_shift],Time[2],Close[high_shift]);
if ( Open[low_shift] > Close[low_shift] ) ObjectCreate(ChartID(),"AreaH"+Time[12],OBJ_TREND,0,Time[12],Open[high_shift],Time[2],Open[high_shift]);

ObjectSetInteger(ChartID(),"AreaH"+Time[12],OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),"AreaH"+Time[12],OBJPROP_COLOR,clrWhite);

if ( Open[low_shift] > Close[low_shift] ) ObjectCreate(ChartID(),"AreaL"+Time[12],OBJ_TREND,0,Time[12],Close[low_shift],Time[2],Close[low_shift]);
if ( Open[low_shift] < Close[low_shift] )  ObjectCreate(ChartID(),"AreaL"+Time[12],OBJ_TREND,0,Time[12],Open[low_shift],Time[2],Open[low_shift]); 
ObjectSetInteger(ChartID(),"AreaL"+Time[12],OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),"AreaL"+Time[12],OBJPROP_COLOR,clrWhite);

//ObjectCreate(ChartID(),"Area"+Time[12],OBJ_TREND,0,Time[12],high_price,Time[2],high_price);
//ObjectSetInteger(ChartID(),"Area"+Time[12],OBJPROP_RAY,False);

OrderSend(Symbol(),OP_BUY,0.01,Ask,0,0,Ask+10*Point,"BUY",0,0,clrNONE);
OrderSend(Symbol(),OP_SELL,0.01,Bid,0,0,Bid-10*Point,"SELL",0,0,clrNONE);


}


if ( Close[1] < low_price && (high_price-low_price)/Point < 100 ) {

ObjectCreate(ChartID(),"Area"+Time[12],OBJ_RECTANGLE,0,Time[12],high_price,Time[2],low_price);
ObjectSetInteger(ChartID(),"Area"+Time[12],OBJPROP_COLOR,clrRed);

if ( Open[low_shift] < Close[low_shift] ) ObjectCreate(ChartID(),"AreaH"+Time[12],OBJ_TREND,0,Time[12],Close[high_shift],Time[2],Close[high_shift]);
if ( Open[low_shift] > Close[low_shift] ) ObjectCreate(ChartID(),"AreaH"+Time[12],OBJ_TREND,0,Time[12],Open[high_shift],Time[2],Open[high_shift]);

ObjectSetInteger(ChartID(),"AreaH"+Time[12],OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),"AreaH"+Time[12],OBJPROP_COLOR,clrWhite);

if ( Open[low_shift] > Close[low_shift] ) ObjectCreate(ChartID(),"AreaL"+Time[12],OBJ_TREND,0,Time[12],Close[low_shift],Time[2],Close[low_shift]);
if ( Open[low_shift] < Close[low_shift] )  ObjectCreate(ChartID(),"AreaL"+Time[12],OBJ_TREND,0,Time[12],Open[low_shift],Time[2],Open[low_shift]); 
ObjectSetInteger(ChartID(),"AreaL"+Time[12],OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),"AreaL"+Time[12],OBJPROP_COLOR,clrWhite);

//ObjectCreate(ChartID(),"Area"+Time[12],OBJ_TREND,0,Time[12],high_price,Time[2],high_price);
//ObjectSetInteger(ChartID(),"Area"+Time[12],OBJPROP_RAY,False);

OrderSend(Symbol(),OP_SELL,0.01,Bid,0,0,Bid-10*Point,"SELL",0,0,clrNONE);
OrderSend(Symbol(),OP_BUY,0.01,Ask,0,0,Ask+10*Point,"BUY",0,0,clrNONE);

}



ctime=Time[1];


}



   
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
