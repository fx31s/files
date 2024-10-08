//+------------------------------------------------------------------+
//|                                                          DHL.mq4 |
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
int OnInit()
  {
//--- create timer
   //EventSetTimer(60);
   
   ObjectsDeleteAll();
   
   
double d1_high_price=iHigh(Symbol(),PERIOD_D1,1);
double d1_low_price=iLow(Symbol(),PERIOD_D1,1);
double d1_fark=d1_high_price-d1_low_price;
double d1_yuzde=DivZero(d1_fark,100);
double d1_eq_price=d1_low_price+d1_yuzde*25;
double d1_eqs_price=d1_low_price+d1_yuzde*75;

int shift=iBarShift(Symbol(),Period(),iTime(Symbol(),PERIOD_D1,1));


ObjectDelete(ChartID(),"D1High1");
ObjectCreate(ChartID(),"D1High1",OBJ_TREND,0,iTime(Symbol(),PERIOD_D1,1),d1_high_price,iTime(Symbol(),PERIOD_D1,1)+PeriodSeconds(PERIOD_D1),d1_high_price);
ObjectSetInteger(ChartID(),"D1High1",OBJPROP_COLOR,clrYellow);

ObjectDelete(ChartID(),"D1Low1");
ObjectCreate(ChartID(),"D1Low1",OBJ_TREND,0,iTime(Symbol(),PERIOD_D1,1),d1_low_price,iTime(Symbol(),PERIOD_D1,1)+PeriodSeconds(PERIOD_D1),d1_low_price);
ObjectSetInteger(ChartID(),"D1Low1",OBJPROP_COLOR,clrYellow);

ObjectDelete(ChartID(),"D1HL1");
ObjectCreate(ChartID(),"D1HL1",OBJ_TREND,0,Time[shift],d1_high_price,Time[shift],d1_low_price);
ObjectSetInteger(ChartID(),"D1HL1",OBJPROP_COLOR,clrYellow);
ObjectSetInteger(ChartID(),"D1HL1",OBJPROP_RAY,False);

ObjectDelete(ChartID(),"D1Eq1");
ObjectCreate(ChartID(),"D1Eq1",OBJ_TREND,0,iTime(Symbol(),PERIOD_D1,1),d1_eq_price,iTime(Symbol(),PERIOD_D1,1)+PeriodSeconds(PERIOD_D1),d1_eq_price);
ObjectSetInteger(ChartID(),"D1Eq1",OBJPROP_COLOR,clrYellow);
ObjectSetInteger(ChartID(),"D1Eq1",OBJPROP_STYLE,STYLE_DOT);

ObjectDelete(ChartID(),"D1Eqs1");
ObjectCreate(ChartID(),"D1Eqs1",OBJ_TREND,0,iTime(Symbol(),PERIOD_D1,1),d1_eqs_price,iTime(Symbol(),PERIOD_D1,1)+PeriodSeconds(PERIOD_D1),d1_eqs_price);
ObjectSetInteger(ChartID(),"D1Eqs1",OBJPROP_COLOR,clrBlue);
ObjectSetInteger(ChartID(),"D1Eqs1",OBJPROP_STYLE,STYLE_DOT);






double d0_high_price=iHigh(Symbol(),PERIOD_D1,0);
double d0_low_price=iLow(Symbol(),PERIOD_D1,0);

shift=iBarShift(Symbol(),Period(),iTime(Symbol(),PERIOD_D1,0));



ObjectDelete(ChartID(),"D1High0");
ObjectCreate(ChartID(),"D1High0",OBJ_TREND,0,iTime(Symbol(),PERIOD_D1,0),d0_high_price,iTime(Symbol(),PERIOD_D1,0)+PeriodSeconds(PERIOD_D1),d0_high_price);
ObjectSetInteger(ChartID(),"D1High0",OBJPROP_COLOR,clrLightGray);

ObjectDelete(ChartID(),"D1Low0");
ObjectCreate(ChartID(),"D1Low0",OBJ_TREND,0,iTime(Symbol(),PERIOD_D1,0),d0_low_price,iTime(Symbol(),PERIOD_D1,0)+PeriodSeconds(PERIOD_D1),d0_low_price);
ObjectSetInteger(ChartID(),"D1Low0",OBJPROP_COLOR,clrLightGray);

ObjectDelete(ChartID(),"D1HL0");
ObjectCreate(ChartID(),"D1HL0",OBJ_TREND,0,Time[shift],d0_high_price,Time[shift],d0_low_price);
ObjectSetInteger(ChartID(),"D1HL0",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),"D1HL0",OBJPROP_RAY,False);


   
   
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
/////////////////////////////////////////////////////////////////////////////////////////
// Divide Zero Hatası için formül.
/////////////////////////////////////////////////////////////////////////////////////////
double DivZero(double n, double d)
{
if (d==0) return(0);  else return(n/d);
} 
//////////////////////////////////////////////////////////////////////} 
