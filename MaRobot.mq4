//+------------------------------------------------------------------+
//|                                                      MaRobot.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

/////////////////////////////////////////////////////////
int ma_shift = 0; // Zaman
int shiftma  = 0;
int shift=0;

extern ENUM_MA_METHOD MaMethod=MODE_SMA;  // Method
extern ENUM_APPLIED_PRICE MaPrice=PRICE_CLOSE;// Ma Price


extern ENUM_TIMEFRAMES system_time_period = PERIOD_CURRENT;

extern ENUM_MA_METHOD MaMethods=MODE_SMA;  // Method
extern ENUM_APPLIED_PRICE MaPrices=PRICE_CLOSE;// Ma Price

extern ENUM_TIMEFRAMES MaTimeA = PERIOD_CURRENT;
extern ENUM_TIMEFRAMES MaTimeB = PERIOD_CURRENT;

//extern int MA_W=21;
//extern int MB_W=55;

extern int MA_W=50;
extern int MB_W=10;
/////////////////////////////////////////////////////////

   string sym=Symbol();
   ENUM_TIMEFRAMES per=Period();
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---

ObjectsDeleteAll();

// right

//for(int i=1;i<Bars-500;i++){
for(int i=1;i<50;i++){


double ma=iMA(sym, PERIOD_CURRENT, MA_W, ma_shift, MaMethod, MaPrice, i);
double mb=iMA(sym, PERIOD_CURRENT, MB_W, ma_shift, MaMethod, MaPrice, i);



if ( iClose(sym,per,i) > ma ) {

int left_say=0;
int shift=0;
bool find=false;
for(int b=i+1;b<i+65;b++) {

double mab=iMA(sym, PERIOD_CURRENT, MB_W, ma_shift, MaMethod, MaPrice, b);

if ( ma > mab && 
find==false && iClose(sym,per,b) < ma ) {
left_say=left_say+1;
shift=b;
} else {
find=true;
}

}


if ( left_say >= 15 ) {
ObjectCreate(ChartID(),"VLINE"+i,OBJ_VLINE,0,Time[i],Ask);
ObjectSetInteger(ChartID(),"VLINE"+i,OBJPROP_COLOR,clrLimeGreen);
}

}




if ( iClose(sym,per,i) < ma ) {

int left_say=0;
int shift=0;
bool find=false;
for(int b=i+1;b<i+65;b++) {

double mab=iMA(sym, PERIOD_CURRENT, MB_W, ma_shift, MaMethod, MaPrice, b);

if ( ma < mab && 
find==false && iClose(sym,per,b) > ma ) {
left_say=left_say+1;
shift=b;
} else {
find=true;
}

}


if ( left_say >= 15 ) {
ObjectCreate(ChartID(),"VLINE"+i,OBJ_VLINE,0,Time[i],Ask);
ObjectSetInteger(ChartID(),"VLINE"+i,OBJPROP_COLOR,clrRed);
}

}












//continue;


if ( iClose(sym,per,i) > mb ) {

int left_say=0;
int shift=0;
bool find=false;
for(int b=i+1;b<i+65;b++) {

double mab=iMA(sym, PERIOD_CURRENT, MB_W, ma_shift, MaMethod, MaPrice, b);

if ( //ma > mab && 
find==false && iClose(sym,per,b) < mab ) {
left_say=left_say+1;
shift=b;
} else {
find=true;
}

}


if ( left_say >= 15 ) {
ObjectCreate(ChartID(),"VLINE"+i,OBJ_VLINE,0,Time[i],Ask);
ObjectSetInteger(ChartID(),"VLINE"+i,OBJPROP_COLOR,clrLimeGreen);
}

}


if ( iClose(sym,per,i) < mb ) {

int left_say=0;
int shift=0;
bool find=false;
for(int b=i+1;b<i+65;b++) {

double mab=iMA(sym, PERIOD_CURRENT, MB_W, ma_shift, MaMethod, MaPrice, b);

if ( //ma < mab && 
find==false && iClose(sym,per,b) > mab ) {
left_say=left_say+1;
shift=b;
} else {
find=true;
}

}


if ( left_say >= 15 ) {
ObjectCreate(ChartID(),"VLINE"+i,OBJ_VLINE,0,Time[i],Ask);
ObjectSetInteger(ChartID(),"VLINE"+i,OBJPROP_COLOR,clrRed);
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
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
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
