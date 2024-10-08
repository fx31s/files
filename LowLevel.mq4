//+------------------------------------------------------------------+
//|                                                     LowLevel.mq4 |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

/////////////////////////////////////////////////////////////////////////////////////////
// Divide Zero Hatası için formül.
/////////////////////////////////////////////////////////////////////////////////////////
double DivZero(double n, double d)
{
if (d==0) return(0);  else return(n/d);
} 
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---

ObjectsDeleteAll();



for ( int i=Bars-100;i>1;i--) {



if ( Close[i+4] < Open[i+4] && Close[i+3] < Open[i+3] && Close[i+2] < Open[i+2] && Open[i+1] < Close[i+1]

&& DivZero((Open[i+2]-Close[i+2]),(Open[i+3]-Close[i+3])) > 1.50


 ) {


ObjectDelete(ChartID(),"SELL"+Time[i]);
ObjectCreate(ChartID(),"SELL"+Time[i],OBJ_RECTANGLE,0,Time[i+4],Open[i+1],Time[i+1],Close[i+1]);
ObjectSetInteger(ChartID(),"SELL"+Time[i],OBJPROP_COLOR,clrOrangeRed);
ObjectSetInteger(ChartID(),"SELL"+Time[i],OBJPROP_RAY,False);

double yuzde=DivZero(Open[i+2]-Close[i+2],100);
double yuzdehl=DivZero(High[i+2]-Low[i+2],100);

double body=(Close[i+1]-Open[i+1]);

double body_yuzde=DivZero(body,yuzde);

ObjectSetString(ChartID(),"SELL"+Time[i],OBJPROP_TOOLTIP,"Sell-"+body_yuzde);

if ( body_yuzde > 50 ) ObjectSetInteger(ChartID(),"SELL"+Time[i],OBJPROP_COLOR,clrLimeGreen);


int w=1;

if ( body_yuzde/50 > 1 ) w=int(body_yuzde/50);

ObjectSetInteger(ChartID(),"SELL"+Time[i],OBJPROP_WIDTH,w);



}





if ( Close[i+4] > Open[i+4] && Close[i+3] > Open[i+3] && Close[i+2] > Open[i+2] && Open[i+1] > Close[i+1]

&& DivZero((Close[i+2] - Open[i+2]),(Close[i+3]-Open[i+3])) > 1.50


 ) {


ObjectDelete(ChartID(),"BUY"+Time[i]);
ObjectCreate(ChartID(),"BUY"+Time[i],OBJ_RECTANGLE,0,Time[i+4],Open[i+1],Time[i+1],Close[i+1]);
ObjectSetInteger(ChartID(),"BUY"+Time[i],OBJPROP_COLOR,clrLimeGreen);
ObjectSetInteger(ChartID(),"BUY"+Time[i],OBJPROP_RAY,False);

double yuzde=DivZero(Close[i+2]-Open[i+2],100);
double yuzdehl=DivZero(High[i+2]-Low[i+2],100);

double body=(Open[i+1]-Close[i+1]);

double body_yuzde=DivZero(body,yuzde);

ObjectSetString(ChartID(),"BUY"+Time[i],OBJPROP_TOOLTIP,"Buy-"+body_yuzde);

if ( body_yuzde > 50 ) ObjectSetInteger(ChartID(),"BUY"+Time[i],OBJPROP_COLOR,clrOrangeRed);


int w=1;

if ( body_yuzde/50 > 1 ) w=int(body_yuzde/50);

ObjectSetInteger(ChartID(),"BUY"+Time[i],OBJPROP_WIDTH,w);



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
