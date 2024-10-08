//+------------------------------------------------------------------+
//|                                                        AdrEa.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict



extern int      NumOfDays             = 14;

extern color   LineTargetColor  = DarkOrange;
extern color   LineExceededColor  = DarkOrange;
extern color   TextColor  = Silver;
extern int     ShiftLabel = 9;
extern bool    FullScreenLines = false;
extern string  FSL = "If false, lines start at current bar";
extern int     Line_Length = 17;
extern int     ADR_Alert_Pip = 50;
extern bool ADR_AlertSignal = false;
datetime ADR_Alert;


extern int      NumOfPeriods             = 14;
extern int      ATRPeriod              = PERIOD_W1;

//extern color   LineTargetColor  = DarkOrange;
//extern color   LineExceededColor  = DarkOrange;
//extern color   TextColor  = Silver;
//extern int     ShiftLabel = 9;
//extern bool    FullScreenLines = false;
//extern string  FSL = "If false, lines start at current bar";
//extern int     Line_Length = 17;
extern int     ATR_Alert_Pip = 50;
extern bool ATR_AlertSignal = false;
datetime ATR_Alert;


color LineColor;

string Period_Text, LineLabel, AvgRgLine, PeriodTxt;
int    LineType;
int multiplier;

double pnt;
int    dig;


double atr_high_price;
double atr_low_price;
double adr_high_price;
double adr_low_price;

datetime ea_start_time;


int magic=666;
double Lot=0.01;

int buy_total=0;
int sell_total=0;
double buy_profit=0;
double sell_profit=0;

int eq_live_order=0;
int eq_pen_order=0;


double order_buy_tp=0;
double order_sell_tp=0;

int order_day=-1;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
  
  // Monday
  // Pw Day
  // Pw Week
  
  
//--- create timer
   //EventSetTimer(1);
   
   ea_start_time=iTime(NULL,PERIOD_D1,1);
   

  pnt = MarketInfo(Symbol(),MODE_POINT);
  dig = MarketInfo(Symbol(),MODE_DIGITS);
  if (dig == 3 || dig == 5) {
    pnt *= 10;
  }    
  
  
  ATR();
  ADR();
     
   

  datetime adr_start_time=iTime(NULL,PERIOD_D1,0);
  datetime adr_end_time=Time[0];
  

   string name="ADRBox";
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,adr_start_time,adr_high_price,adr_end_time,adr_low_price);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,"ADRBOX");
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);
   ObjectSetInteger(ChartID(),name,OBJPROP_FILL,false);
      
   
   
   
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//--- destroy timer
DeleteLines();
   EventKillTimer();
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+

   double high_price=0;
   double low_price=0; 
   
   double sell_price=0;
   double buy_price=0; 
   double order_percent=0;
   

datetime monday_time;   

void OnTick()
  {
//---




  if ( ea_start_time!=iTime(NULL,PERIOD_D1,0) ) {

  ATR();
  ADR();
  
   high_price=adr_high_price;
   low_price=adr_low_price;
  /* 
// Pw Day
  /* high_price=iHigh(NULL,PERIOD_D1,1);
   low_price=iLow(NULL,PERIOD_D1,1);
      

// Pw Week
   high_price=iHigh(NULL,PERIOD_W1,1);
   low_price=iLow(NULL,PERIOD_W1,1);*/
   /*
// Monday

int weekday=TimeDayOfWeek(iTime(NULL,PERIOD_D1,0));   
  
if ( weekday == 2  ) {
// Monday
   monday_time=iTime(NULL,PERIOD_D1,1);
   high_price=iHigh(NULL,PERIOD_D1,1);
   low_price=iLow(NULL,PERIOD_D1,1);
}

if ( weekday <= 1 ) {
high_price=0;
low_price=0;
return;}

   

// Pw Month
   high_price=iHigh(NULL,PERIOD_MN1,1);
   low_price=iLow(NULL,PERIOD_MN1,1);   
    */  
   
double yuzde = DivZero(high_price-low_price, 100);   
double eq=low_price+yuzde*50; // 50
double level75=low_price+yuzde*75; // 50
double level25=low_price+yuzde*25; // 50   
   
  datetime start_time=iTime(NULL,PERIOD_D1,0);
  //datetime end_time=Time[0]+500*PeriodSeconds();
  datetime end_time=iTime(NULL,PERIOD_D1,0)+PeriodSeconds(PERIOD_D1);
  datetime end_times=iTime(NULL,PERIOD_D1,0)+PeriodSeconds(PERIOD_D1)*2;




/*
////////////////////////////////////////////////////////////////////
// Pw Day
  start_time=iTime(NULL,PERIOD_D1,1);
  //datetime end_time=Time[0]+500*PeriodSeconds();
  end_time=iTime(NULL,PERIOD_D1,1)+PeriodSeconds(PERIOD_D1);
  end_times=iTime(NULL,PERIOD_D1,1)+PeriodSeconds(PERIOD_D1)*3;
////////////////////////////////////////////////////////////////////////  

////////////////////////////////////////////////////////////////////
// Pw Week
  start_time=iTime(NULL,PERIOD_W1,1);
  //datetime end_time=Time[0]+500*PeriodSeconds();
  end_time=iTime(NULL,PERIOD_W1,1)+PeriodSeconds(PERIOD_W1);
  end_times=iTime(NULL,PERIOD_W1,1)+PeriodSeconds(PERIOD_W1)*2;
////////////////////////////////////////////////////////////////////////  

   
////////////////////////////////////////////////////////////////////
// Monday
  start_time=monday_time;
  //datetime end_time=Time[0]+500*PeriodSeconds();
  end_time=monday_time+PeriodSeconds(PERIOD_D1)*4;
  end_times=monday_time+PeriodSeconds(PERIOD_D1)*5;
////////////////////////////////////////////////////////////////////////  


////////////////////////////////////////////////////////////////////
// Pw Month
  start_time=iTime(NULL,PERIOD_MN1,1);
  //datetime end_time=Time[0]+500*PeriodSeconds();
  end_time=iTime(NULL,PERIOD_MN1,1)+PeriodSeconds(PERIOD_MN1);
  end_times=iTime(NULL,PERIOD_MN1,1)+PeriodSeconds(PERIOD_MN1)*2;
////////////////////////////////////////////////////////////////////////  
   */
      
      


  

   string name="ADRBox";
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,start_time,high_price,end_time,low_price);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,"ADRBOX");
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);
   ObjectSetInteger(ChartID(),name,OBJPROP_FILL,false);      


   name="ADRBoxH"+start_time;
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,start_time,high_price,end_times,high_price);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrKhaki);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,"ADRBOX");
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false); 

   name="ADRBoxL"+start_time;
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,start_time,low_price,end_times,low_price);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrKhaki);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,"ADRBOX");
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false); 
   
   name="ADRBoxEq"+start_time;
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,start_time,eq,end_times,eq);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrKhaki);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,"ADRBOX");
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false); 
         
   


  name="AdrLevel";
  double level;   
  string levels; 
  ObjectDelete(ChartID(),name+"Eq");
  ObjectCreate(ChartID(),name+"Eq",OBJ_TREND,0,start_time,eq,end_time,eq);
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_COLOR,clrLightGray);   
  ObjectSetString(ChartID(),name+"Eq",OBJPROP_TOOLTIP,"TOKYO EQ");   
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_STYLE,STYLE_DOT);   
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_WIDTH,4); 
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_ZORDER,1);  
  
  
  level=level25;
  levels="25";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,start_time,level,end_time,level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrDarkGray);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);
 
   
  level=level75;
  levels="75";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,start_time,level,end_time,level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrDarkGray);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);  
  
  ea_start_time=iTime(NULL,PERIOD_D1,0);
  
  }
     
  
  
  if ( high_price == 0 || low_price == 0 ) return;
   


   
  datetime start_time=iTime(NULL,PERIOD_D1,0);
  datetime end_time=Time[0]+500*PeriodSeconds();   


double yuzde = DivZero(high_price-low_price, 100);   
double eq=low_price+yuzde*50; // 50
double level75=low_price+yuzde*75; // 50
double level25=low_price+yuzde*25; // 50
   
   

    
  
  
  
   bool order_result=OrderCommetssTypeMulti(Symbol());
   
int OrderTotals=buy_total+sell_total;   
   


  //int AvgRgHigh_Fark = ((lo + AvgRange)-Bid)/Point;
  //int AvgRgLow_Fark = (Bid-(hi - AvgRange))/Point;
  
  int high_fark_yuzde=(high_price-Bid)/yuzde;
  int low_fark_yuzde=(Bid-low_price)/yuzde;
  
  
  
  //Comment("High Fark Yüzde:",high_fark_yuzde,"\n Low Fark Yüzde:",low_fark_yuzde);
  

///////////////////////////////////////////////////////////////////////////////////////  
  if ( OrderTotals == 0 && int(TimeHour(TimeCurrent())) >= 10 && int(TimeHour(TimeCurrent())) <= 23 && order_day != DayOfWeek() ) { // İşlem kapanınca aynı gün tekrar işlem açmasın
  
  sell_price=0;
  buy_price=0;
  order_percent=0;
  order_buy_tp=0;
  order_sell_tp=0;
  
  if ( (high_price-Bid)/yuzde < 10  ) {
  
  string cmt="SELL";
  int ticket=OrderSend(Symbol(),OP_SELL,Lot,Bid,0,0,level75,cmt,magic,0,clrNONE);
  sell_price=Bid;
  //order_percent=(high_price-Bid)/yuzde;
  order_percent=yuzde*10;
  //order_percent=(high_price-Bid);
  order_sell_tp=level75;
  order_day=DayOfWeek();
  }
     

  if ( (Bid-low_price)/yuzde < 10  ) {

  string cmt="BUY";  
  int ticket=OrderSend(Symbol(),OP_BUY,Lot,Ask,0,0,level25,cmt,magic,0,clrNONE);  
  buy_price=Ask;
  //order_percent=(Bid-low_price)/yuzde;
  order_percent=yuzde*10;
  //order_percent=(Bid-low_price);
  order_buy_tp=level25;
  order_day=DayOfWeek();
  }

  }
////////////////////////////////////////////////////////////////////////////////////  
if ( OrderTotals > 0 && int(TimeHour(TimeCurrent())) >= 10 && int(TimeHour(TimeCurrent())) <= 23  ) {


//bool order_result=OrderCommetssTypeMulti(Symbol());


if ( sell_price != 0 ) {

  if ( (Bid-sell_price) >= order_percent ) {  
  string cmt="SELL";
  int ticket=OrderSend(Symbol(),OP_SELL,Lot*sell_total,Bid,0,0,order_sell_tp,cmt,magic,0,clrNONE);
  sell_price=Bid;  
  }
  
  }
  

if ( buy_price != 0 ) {  
  
  if ( (buy_price-Ask) >= order_percent  ) {

  string cmt="BUY";  
  int ticket=OrderSend(Symbol(),OP_BUY,Lot*buy_total,Ask,0,0,order_buy_tp,cmt,magic,0,clrNONE);  
  buy_price=Ask;  
  
  }
  
  }
  




}
////////////////////////////////////////////////



string sym=Symbol();
ENUM_TIMEFRAMES per=Period();



Comment("Sell Total:",sell_total,"\n Buy Total:",buy_total,"\n High Price:",high_price,"\n Low Price:",low_price,"\nOrder_percent",order_percent/Point,"High Fark Yüzde:",high_fark_yuzde,"\n Low Fark Yüzde:",low_fark_yuzde," \n AdrEA \nbuy profit:",buy_profit,"\n sell profit:",sell_profit,"\n Total:",buy_profit+sell_profit,"\nSym:",sym,"\nPer:",per,"\nLot:",Lot);   


if ( sell_total >= 5  && sell_profit >= 2 ) {
CloseAllSellOrders();
}


if ( buy_total >= 5  && buy_profit >= 2 ) {
CloseAllBuyOrders();
}
   /*
/////////////////////////////////////////////////
// Montly
////////////////////////////////////////////////
if ( sell_total >= 1  && sell_profit >= 10 ) {
CloseAllSellOrders();
}


if ( buy_total >= 1  && buy_profit >= 10 ) {
CloseAllBuyOrders();
}
////////////////////////////////////////////////   
 */     

  // }
   
  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//---

//Print("SElam");

   
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
void DrawLine(string LineLabel, string LineText, string AvgRgLine, int LineType, color LineColor, double LinePrice, double TodaysRange, double AvgRange)
   {
      /*if(ObjectFind(LineLabel) != 0)
      {
         ObjectCreate(LineLabel, OBJ_TEXT, 0, Time[0]+Period()*60*ShiftLabel, LinePrice);
         ObjectSetText(LineLabel, LineText, 8, "Verdana", TextColor);
      }
      else
      {
         ObjectMove(LineLabel, 0, Time[0]+Period()*60*ShiftLabel, LinePrice);
         ObjectSetText(LineLabel, LineText, 8, "Verdana", TextColor);
      }*/

   int Style, Width;
   {
      Style = STYLE_DOT;
      Width = 1;
   }

      if(ObjectFind(AvgRgLine) != 0)
      
      {
         ObjectCreate(AvgRgLine, LineType, 0, Time[1]+Period()*60, LinePrice, Time[0]+Period()*60*Line_Length, LinePrice);
         ObjectSet(AvgRgLine, OBJPROP_STYLE, Style);
         ObjectSet(AvgRgLine, OBJPROP_COLOR, LineColor);
         ObjectSet(AvgRgLine, OBJPROP_WIDTH, Width);
        ObjectSet(AvgRgLine, OBJPROP_RAY, false);
       
      }
      else
      {

         ObjectMove(AvgRgLine, 0, Time[1]+Period()*60, LinePrice);
         ObjectMove(AvgRgLine, 1, Time[0]+Period()*60*Line_Length, LinePrice);
    }
   }
//---------------------------------------------------------



void DeleteLines(){

  int    obj_total=ObjectsTotal();
  string ObjName;
  
  for(int i = ObjectsTotal() - 1; i > -1; i--)
    {
         
     ObjName=ObjectName(i); 
     if (StringFind(ObjName,"ADR ",0) == 0) ObjectDelete(ObjName);
     if (StringFind(ObjName,"ATR ",0) == 0) ObjectDelete(ObjName);
    }
}
//+------------------------------------------------------------------+



int ADR() {


double hi;
double lo;


//---- exit if period is greater than hourly charts
   if(Period() > PERIOD_D1)
   {
      return(-1); // then exit
   }

   
int c=0;
double sum=0;
double AvgRange=0;
double AvgRgHigh, AvgRgLow, TodaysRange;

for (int i=1; i<Bars-1; i++)  {
    hi = iHigh(NULL,PERIOD_D1,i);
    lo = iLow(NULL,PERIOD_D1,i);
    datetime dt = iTime(NULL,PERIOD_D1,i);
    if (TimeDayOfWeek(dt) > 0 && TimeDayOfWeek(dt) < 6)  {
      sum += hi - lo;
      c++;  
         
      AvgRange = AvgRange + (iHigh(NULL, PERIOD_D1, i) - iLow(NULL, PERIOD_D1, i));
      
      if (c>=NumOfDays) break;    
  } }
  hi = iHigh(NULL,PERIOD_D1,0);
  lo = iLow(NULL,PERIOD_D1,0);
  


 AvgRange = AvgRange / NumOfDays;

 TodaysRange = (hi-lo);
  
  

   AvgRgHigh = NormalizeDouble(lo + AvgRange, Digits-1);
   AvgRgLow =  NormalizeDouble(hi - AvgRange, Digits-1);
   
   Comment("ADR:",AvgRgHigh,"/",AvgRgLow);
   
   adr_high_price=AvgRgHigh;
   adr_low_price=AvgRgLow;
   
    
  int AvgRgHigh_Fark = ((lo + AvgRange)-Bid)/Point;
  int AvgRgLow_Fark = (Bid-(hi - AvgRange))/Point;
  
/////////////////////////////////////////////////////////////////////////////////////
/*if ( ADR_AlertSignal ) {



if ( ADR_Alert != Time[1] ) {
if ( AvgRgHigh_Fark < ADR_Alert_Pip && AvgRgHigh_Fark > 0 ) {Alert(Symbol()+" ADR High "+AvgRgHigh_Fark+" pip yakınlaştı");
ADR_Alert=Time[1];
}
if ( AvgRgLow_Fark < ADR_Alert_Pip  && AvgRgLow_Fark > 0  ) {Alert(Symbol()+" ADR Low "+AvgRgLow_Fark+" pip yakınlaştı");
ADR_Alert=Time[1];
}

}
}*/
////////////////////////////////////////////////////////////////////////////////////
//-----------------------------------------------------------------------   

   
   if(FullScreenLines)
      LineType = OBJ_HLINE;
   else
      LineType = OBJ_TREND;
      
   //---- Set line labels on chart window

   if(TodaysRange > AvgRange)
      LineColor = LineExceededColor;
   else
      LineColor = LineTargetColor;

   string HighName = "ADR "+"High";
   string LowName = "ADR "+"Low";
   string HighText = HighName+": "+DoubleToStr(AvgRgHigh,Digits-1)+"("+AvgRgHigh_Fark+")";
   string LowText = LowName+": "+DoubleToStr(AvgRgLow,Digits-1)+"("+AvgRgLow_Fark+")";
   string HighLabel = HighName+" Label";
   string LowLabel = LowName+" Label";

   DrawLine(HighLabel, HighText, HighName, LineType, LineColor, AvgRgHigh, TodaysRange, AvgRange);
   DrawLine(LowLabel, LowText, LowName, LineType, LineColor, AvgRgLow, TodaysRange, AvgRange);
   //---- End Of Program
   
   return(0);

}

////////////////////////////////////////////////////////


int ATR()
{



   //---- exit if period is greater than chosen ADR Period
   if(Period() > ATRPeriod)
   {
      return(-1); // then exit
   }

   
int c=0;
double sum=0;
double AvgRange=0;
double AvgRgHigh, AvgRgLow, PresentRange;

double hi;
double lo;


for (int i=1; i<Bars-1; i++)  {
    hi = iHigh(NULL,ATRPeriod,i);
    lo = iLow(NULL,ATRPeriod,i);
    datetime dt = iTime(NULL,ATRPeriod,i);
    {
      sum += hi - lo;
      c++;  
         
      AvgRange = AvgRange + (iHigh(NULL, ATRPeriod, i) - iLow(NULL, ATRPeriod, i));
      
      if (c>=NumOfPeriods) break;    
  } }
  hi = iHigh(NULL,ATRPeriod,0);
  lo = iLow(NULL,ATRPeriod,0);
  


 AvgRange = AvgRange / NumOfPeriods;

 PresentRange = (hi-lo);
  
  

   AvgRgHigh = NormalizeDouble(lo + AvgRange, Digits-1);
   AvgRgLow =  NormalizeDouble(hi - AvgRange, Digits-1);
   
   atr_high_price=AvgRgHigh;
   atr_low_price=AvgRgLow;   
   
   //Alert("ATR:",AvgRgHigh,"/",AvgRgLow);

  int AvgRgHigh_Fark = ((lo + AvgRange)-Bid)/Point;
  int AvgRgLow_Fark = (Bid-(hi - AvgRange))/Point;
  

  
  
  /*
if ( ATR_AlertSignal ) {



if ( ATR_Alert != Time[1] ) {
if ( AvgRgHigh_Fark < ATR_Alert_Pip && AvgRgHigh_Fark > 0 ) {Alert(Symbol()+" ATR High "+AvgRgHigh_Fark+" pip yakınlaştı");
ATR_Alert=Time[1];
}
if ( AvgRgLow_Fark < ATR_Alert_Pip  && AvgRgLow_Fark > 0 ) {Alert(Symbol()+" ATR Low "+AvgRgLow_Fark+" pip yakınlaştı");
ATR_Alert=Time[1];
}

}



}
*/

//-----------------------------------------------------------------------   

   
   if(FullScreenLines)
      LineType = OBJ_HLINE;
   else
      LineType = OBJ_TREND;
      
   //---- Set line labels on chart window

   if(PresentRange > AvgRange)
      LineColor = LineExceededColor;
   else
      LineColor = LineTargetColor;

   //string HighName = "ATR "+TFtoStr(ATRPeriod)+" / "+ DoubleToStr (NumOfPeriods,0);
   //string LowName = "ATR "+TFtoStr(ATRPeriod)+" / "+ DoubleToStr (NumOfPeriods,0);

   string HighName = "ATR "+DoubleToStr(ATRPeriod,0)+" / "+ DoubleToStr (NumOfPeriods,0)+" High";
   string LowName = "ATR "+DoubleToStr(ATRPeriod,0)+" / "+ DoubleToStr (NumOfPeriods,0)+"Low";
      
   string HighText = HighName+": "+DoubleToStr(AvgRgHigh,Digits-1)+"High ("+AvgRgHigh_Fark+")";
   string LowText = LowName+": "+DoubleToStr(AvgRgLow,Digits-1)+"Low ("+AvgRgLow_Fark+")";
   string HighLabel = HighName+" Label";
   string LowLabel = LowName+" Label";

   DrawLine(HighLabel, HighText, HighName, LineType, LineColor, AvgRgHigh, PresentRange, AvgRange);
   DrawLine(LowLabel, LowText, LowName, LineType, LineColor, AvgRgLow, PresentRange, AvgRange);
   //---- End Of Program
   return(0);
}

////////////////////////////////////////////////////////////////


string TFtoStr(int period) {
 switch(period) {
  case 1     : return("M1");  break;
  case 5     : return("M5");  break;
  case 15    : return("M15"); break;
  case 30    : return("M30"); break;
  case 60    : return("H1");  break;
  case 240   : return("H4");  break;
  case 1440  : return("D1");  break;
  case 10080 : return("W1");  break;
  case 43200 : return("MN1"); break;
  default    : return(DoubleToStr(period,0));
 }
 return("UNKNOWN");
}//string TFtoStr(int period) {
//end stuff by fxdaytrader

/////////////////////////////////////////////////////////////////////////////////////////
// Divide Zero Hatası için formül.
/////////////////////////////////////////////////////////////////////////////////////////
double DivZero(double n, double d)
{
if (d==0) return(0);  else return(n/d);
} 
//////////////////////////////////////////////////////////////////////} 



//////////////////////////////////////////////////
// Canli islem Sembol Kontrollu 
//////////////////////////////////////////////////
bool OrderCommetssTypeMulti(string sym){

bool sonuc=false;

buy_total=0;
sell_total=0;
buy_profit=0;
sell_profit=0;

eq_live_order=0;
eq_pen_order=0;


//int cnt = 0;
for(int cnts=OrdersTotal()-1;cnts>=0;cnts--){


if ( OrderSymbol() == sym && OrderMagicNumber() == magic+1 && ( OrderType() == OP_BUYLIMIT || OrderType() == OP_SELLLIMIT ) ) {
eq_pen_order=eq_pen_order+1;
//buy_profit=buy_profit+OrderProfit();
}



if(!OrderSelect(cnts, SELECT_BY_POS, MODE_TRADES))continue;
//Sonuna Rakam Ekledik Hangi Tutar Kazaniyor diye onun icin instr veya indexof yapip comment icinde arama yapiyoruz.
//int index=StringFind(OrderComment(), cmt, 0);

if ( OrderSymbol() == sym && OrderMagicNumber() == magic+1 ) {
eq_live_order=eq_live_order+1;
//buy_profit=buy_profit+OrderProfit();
}



//Alert(OrderType(),"/",OrderComment(),"/",cmt,"/",index);
//if ( OrderType() == OP_BUY || OrderType() == OP_SELL ) {
if ( OrderSymbol() == sym && OrderType() == OP_BUY && OrderMagicNumber() == magic ) {
buy_total=buy_total+1;
buy_profit=buy_profit+OrderProfit();
}

if ( OrderSymbol() == sym && OrderType() == OP_SELL && OrderMagicNumber() == magic ) {
sell_total=sell_total+1;
sell_profit=sell_profit+OrderProfit();
}





}

sonuc=true;

return sonuc;
};



//////////////////////////////////////////////////
// Canli islem Sembol Kontrollu 
//////////////////////////////////////////////////
int OrderCommetssType(string cmt,string sym,int typ){
int com = 0;


//int cnt = 0;
for(int cnts=OrdersTotal()-1;cnts>=0;cnts--){

if(!OrderSelect(cnts, SELECT_BY_POS, MODE_TRADES))continue;
//Sonuna Rakam Ekledik Hangi Tutar Kazaniyor diye onun icin instr veya indexof yapip comment icinde arama yapiyoruz.
int index=StringFind(OrderComment(), cmt, 0);

//Alert(OrderType(),"/",OrderComment(),"/",cmt,"/",index);
//if ( OrderType() == OP_BUY || OrderType() == OP_SELL ) {
if ( OrderSymbol() == sym && OrderType() == typ && OrderMagicNumber() == magic ) {
com++;
}
}

return com;
};


//+------------------------------------------------------------------+
// CloseAllBuyOrders()
// closes all open buy orders
//+------------------------------------------------------------------+
void CloseAllBuyOrders()
{
   for (int m=OrdersTotal(); m>=0; m--)
   {
      if ( OrderSelect(m, SELECT_BY_POS))
      {
         if(OrderType() == OP_BUY && OrderSymbol() == Symbol() && OrderMagicNumber() == magic )
         {
            RefreshRates();
            bool success = OrderClose(OrderTicket(), OrderLots(), Bid, 0, Blue);
         }
      }
    }
}

void CloseAllPenOrders(int ord_typ)
{
   for (int m=OrdersTotal(); m>=0; m--)
   {
      if ( OrderSelect(m, SELECT_BY_POS))
      {
         if(OrderType() == ord_typ && OrderSymbol() == Symbol() && OrderMagicNumber() == magic )
         {
            RefreshRates();
            bool success = OrderDelete(OrderTicket(),clrNONE);
         }
      }
    }
}




//+------------------------------------------------------------------+
// CloseAllSellOrders()
// closes all open sell orders
//+------------------------------------------------------------------+
void CloseAllSellOrders()
{
   for (int h=OrdersTotal();h>=0;h--)
   {
      if ( OrderSelect(h,SELECT_BY_POS) )
      {
         if(OrderType() == OP_SELL && OrderSymbol() == Symbol() && OrderMagicNumber() == magic )
         {
            RefreshRates();
            bool success =OrderClose(OrderTicket(), OrderLots(), Ask, 0, Red);
         }
      }
   }
}


//+------------------------------------------------------------------+
// CloseAllOrders()
// closes all orders
//+------------------------------------------------------------------+
void CloseAllOrders()
{
   CloseAllBuyOrders();
   CloseAllSellOrders();
}

void CloseOrders(string cmt,int ord_type)
{
   for (int m=OrdersTotal(); m>=0; m--)
   {
      if ( OrderSelect(m, SELECT_BY_POS))
      {
         if( (( cmt !="" && StringFind(OrderComment(),cmt,0) != -1 ) || cmt == "" ) &&   OrderType() == ord_type && OrderSymbol() == Symbol() //&& OrderMagicNumber() == magicbuy
         )
         {
            RefreshRates();
            bool success = OrderClose(OrderTicket(), OrderLots(), Bid, 0, Blue);
         }
      }
    }
}
