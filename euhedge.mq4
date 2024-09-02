//+------------------------------------------------------------------+
//|                                                      euhedge.mq4 |
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
   
   
   HedgeEngine();
   
   
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

void HedgeEngine() {

// Define symbol and timeframe
string symbol = Symbol();//"EURUSD";
ENUM_TIMEFRAMES timeframe = PERIOD_D1;

// Define the parameters of the Price Time Series function
datetime start_time = TimeCurrent() - PERIOD_D1 * 90;
int count = 90;
double prices[];
datetime times[];

// Request the price time series
if (!CopyTime(symbol, timeframe, start_time, count, times)) {
    Print("Failed to copy price time series: ", GetLastError());
    return;
}

// Define the desired time of day
datetime desiredTime = StrToTime("12:00");

// Find the latest price at the desired time of day
double latestPrice;
datetime latestPriceTime;
for (int i = ArraySize(times) - 1; i >= 0; i--) {
    datetime time = Time[i];
    if (TimeHour(time) == TimeHour(desiredTime) && TimeMinute(time) == TimeMinute(desiredTime)) {
        //latestPrice = prices[i];
        latestPriceTime = time;
        Print(time);
        //break;
    }

}

}