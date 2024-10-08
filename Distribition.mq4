//+------------------------------------------------------------------+
//|                                              MsbDistribition.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
/*
#define OP_BUY 0           //Buy 
#define OP_SELL 1          //Sell 
#define OP_BUYLIMIT 2      //Pending order of BUY LIMIT type 
#define OP_SELLLIMIT 3     //Pending order of SELL LIMIT type 
#define OP_BUYSTOP 4       //Pending order of BUY STOP type 
#define OP_SELLSTOP 5      //Pending order of SELL STOP type 
//---
#define MODE_OPEN 0
#define MODE_CLOSE 3
#define MODE_VOLUME 4 
#define MODE_REAL_VOLUME 5
#define MODE_TRADES 0
#define MODE_HISTORY 1
#define SELECT_BY_POS 0
#define SELECT_BY_TICKET 1
//---
#define DOUBLE_VALUE 0
#define FLOAT_VALUE 1
#define LONG_VALUE INT_VALUE
//---
#define CHART_BAR 0
#define CHART_CANDLE 1
//---
#define MODE_ASCEND 0
#define MODE_DESCEND 1
//---
#define MODE_LOW 1
#define MODE_HIGH 2
#define MODE_TIME 5
#define MODE_BID 9
#define MODE_ASK 10
#define MODE_POINT 11
#define MODE_DIGITS 12
#define MODE_SPREAD 13
#define MODE_STOPLEVEL 14
#define MODE_LOTSIZE 15
#define MODE_TICKVALUE 16
#define MODE_TICKSIZE 17
#define MODE_SWAPLONG 18
#define MODE_SWAPSHORT 19
#define MODE_STARTING 20
#define MODE_EXPIRATION 21
#define MODE_TRADEALLOWED 22
#define MODE_MINLOT 23
#define MODE_LOTSTEP 24
#define MODE_MAXLOT 25
#define MODE_SWAPTYPE 26
#define MODE_PROFITCALCMODE 27
#define MODE_MARGINCALCMODE 28
#define MODE_MARGININIT 29
#define MODE_MARGINMAINTENANCE 30
#define MODE_MARGINHEDGED 31
#define MODE_MARGINREQUIRED 32
#define MODE_FREEZELEVEL 33

//#define MODE_MINLOT 34
//---
#define EMPTY -1

#include <MT4Orders.mqh> // åñëè åñòü #include <Trade/Trade.mqh>, âñòàâèòü ıòó ñòğî÷êó ÏÎÑËÅ
#include <MQL4_to_MQL5.mqh> // ÒÎËÜÊÎ äëÿ äàííîãî ïğèìåğà
*/

double Ortalama;
int carpan=8;
int carpans=2;
int carpann=10;



int buy_total=0;
int sell_total=0;
double buy_profit=0;
double sell_profit=0;
double buy_lot=0;
double sell_lot=0;
double buy_pen_lot=0;
double sell_pen_lot=0;

bool eq_order=false;
int eq_live_order=0;
int eq_pen_order=0;
bool eq_system=false; // Eq Sistem
int eq_lot_carpan=1;

bool lock_order_buy_total=0;
bool lock_order_sell_total=0;

string last_select_object="";

double price=0;

double sell_total_profit_loss=0;
double buy_total_profit_loss=0;

double sell_total_profit=0;
double buy_total_profit=0;

double sell_pen_total_profit_loss=0;
double buy_pen_total_profit_loss=0;

double sell_pen_total_profit=0;
double buy_pen_total_profit=0;


double last_buy_lot;
double last_sell_lot;

double buy_orders[50,4];
double sell_orders[50,4];



   string sym=Symbol();
   ENUM_TIMEFRAMES per=Period();
   
   int buy_ticket;
   int sell_ticket;
   double Lot=0.03;
   double buy_lots=1;
   double sell_lots=1;
   int magic=0;
   

   double high_price=-1;
   double low_price=-1;
   double sell_price;
   double buy_price;
   
   double multiplier=2;
   
   input double profit=5;
   int distance=250;
   
   datetime buy_time;
   datetime sell_time;

double buy_order_price=-1;
double sell_order_price=-1;

double buy_sl_price=-1;
double sell_sl_price=-1;

bool sl_clear=false;

input bool auto_sl=false;
input bool live=true; // Bar Live Close

input bool ma_close=false;
input bool profit_close=false;
input bool bar_close=true;


input int manuel_distance=0;
input int manuel_sl_distance=0;

// Altın 15 5 1


int buy_timehour=-1;
int sell_timehour=-1;

int OrderTotal=0;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
//////////////////////////////////////////////////////////////////////////////////////
      //if ( ChartGetInteger(ChartID(),CHART_BRING_TO_TOP) == 1 ) {
      int cevap=0;
      if ( int(TimeHour(TimeCurrent())) >= 23 ) {
      if( OrderCommets("BUY")>0 || OrderCommets("SELL")>0 ) {
      cevap=MessageBox(Symbol()+" Do I close the order? ","Order Close Grid",4); //  / Spread:"+Spread_Yuzde+"%"
      if ( cevap == 6 ) CloseAllPenOrdersMix();
      }
      }
      //}
////////////////////////////////////////////////////////////////////////////////////////
      






OrderTotal=OrdersTotal();

   FeAnaliz(); 

//ObjectsDeleteAll(ChartID(),-1,-1);


ObjectsDeleteAlls(ChartID(),"Distribition",-1,-1);
ObjectsDeleteAlls(ChartID(),"Sweet",-1,-1);

   dPt = Point;
   if(Digits==3||Digits==5){
      dPt=dPt*10;
   } 
   
   if ( StringFind(Symbol(),"XAUUSD",0) != -1 ) dPt=dPt*10;
   if ( StringFind(Symbol(),"ETHUSD",0) != -1 ) dPt=dPt*100;
   if ( StringFind(Symbol(),"US30",0) != -1 ) dPt=dPt*100;
   if ( StringFind(Symbol(),"SP500",0) != -1 ) dPt=dPt*10;
   if ( StringFind(Symbol(),"USDZAR",0) != -1 ) dPt=dPt*100;
   if ( StringFind(Symbol(),"USDMXN",0) != -1 ) dPt=dPt*100;
   if ( StringFind(Symbol(),"USDJPY",0) != -1 ) dPt=dPt*10;
   if ( StringFind(Symbol(),"NAS100",0) != -1 ) dPt=dPt*100;
   if ( StringFind(Symbol(),"GER30",0) != -1 ) dPt=dPt*100;
   if ( StringFind(Symbol(),"EURMXN",0) != -1 ) dPt=dPt*100;
   
   
   if ( StringFind(AccountCompany(),"Robo",0) != -1 ) {
   
   
   if ( StringFind(Symbol(),"DE40",0) != -1 ) dPt=dPt*10;
   //if ( StringFind(Symbol(),"ETHUSD",0) != -1 ) dPt=dPt*0.1;
   //if ( StringFind(Symbol(),"ETHUSD",0) != -1 ) dPt=1;
   if ( StringFind(Symbol(),"ETHUSD",0) != -1 ) dPt=Point*100;
   if ( StringFind(Symbol(),"USTECH",0) != -1 ) dPt=dPt*100;
   if ( StringFind(Symbol(),"US500",0) != -1 ) dPt=dPt*10;
   if ( StringFind(Symbol(),"BTC",0) != -1 ) dPt=dPt*100;
   if ( StringFind(Symbol(),"BNB",0) != -1 ) dPt=dPt*10;
   }
   
   //Alert(Point*100);
  
   Ict();
   Ict250();
   
   
   
   
   
   


double d1_high_price=iHigh(Symbol(),PERIOD_D1,1);
double d1_low_price=iLow(Symbol(),PERIOD_D1,1);
double d1_fark=d1_high_price-d1_low_price;
double d1_yuzde=DivZero(d1_fark,100);
double d1_eq_price=d1_low_price+d1_yuzde*25;
double d1_eqs_price=d1_low_price+d1_yuzde*75;
double d1_close_price=iClose(Symbol(),PERIOD_D1,1);
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


ObjectDelete(ChartID(),"D1Close1");
ObjectCreate(ChartID(),"D1Close1",OBJ_TREND,0,iTime(Symbol(),PERIOD_D1,0),d1_close_price,iTime(Symbol(),PERIOD_D1,0)+PeriodSeconds(PERIOD_D1),d1_close_price);
ObjectSetInteger(ChartID(),"D1Close1",OBJPROP_COLOR,clrWhite);



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






///////////////////////////////////////////////////////////////////////////////////



int c=0;
double sum=0;
double AvgRange=0;
double AvgRgHigh, AvgRgLow, TodaysRange;
int NumOfDays=14;
double hi,lo;

for (int i=1; i<Bars-1; i++)  {
    double hi = iHigh(sym,PERIOD_D1,i);
    double lo = iLow(sym,PERIOD_D1,i);
    datetime dt = iTime(sym,PERIOD_D1,i);
    if (TimeDayOfWeek(dt) > 0 && TimeDayOfWeek(dt) < 6)  {
      sum += hi - lo;
      c++;  
         
      AvgRange = AvgRange + (iHigh(sym, PERIOD_D1, i) - iLow(sym, PERIOD_D1, i));
      
      if (c>=NumOfDays) break;    
  } }
  hi = iHigh(sym,PERIOD_D1,0);
  lo = iLow(sym,PERIOD_D1,0);
  


 AvgRange = AvgRange / NumOfDays;

 TodaysRange = (hi-lo);
  
  
   AvgRgHigh = NormalizeDouble(lo + AvgRange, MarketInfo(sym,MODE_DIGITS)-1);
   AvgRgLow =  NormalizeDouble(hi - AvgRange, MarketInfo(sym,MODE_DIGITS)-1);
   
    
  int AvgRgHigh_Fark = DivZero(((lo + AvgRange)-MarketInfo(sym,MODE_BID)),MarketInfo(sym,MODE_POINT));
  int AvgRgLow_Fark = DivZero((MarketInfo(sym,MODE_BID)-(hi - AvgRange)),MarketInfo(sym,MODE_POINT));
  

double AvgRhYuzde=DivZero((AvgRgHigh-AvgRgLow),100);
double AvgRgLevel=DivZero(AvgRgLow_Fark,(AvgRhYuzde/MarketInfo(sym,MODE_POINT)));


  double AvgRgOpenHigh = NormalizeDouble(d1_close_price + AvgRange, MarketInfo(sym,MODE_DIGITS)-1);
   double AvgRgOpenLow =  NormalizeDouble(d1_close_price - AvgRange, MarketInfo(sym,MODE_DIGITS)-1);
   
/////////////////////////////////////////////////////////////////////////////////////

ObjectDelete(ChartID(),"D1AdrOpenHigh");
ObjectCreate(ChartID(),"D1AdrOpenHigh",OBJ_TREND,0,iTime(Symbol(),PERIOD_D1,0),AvgRgOpenHigh,iTime(Symbol(),PERIOD_D1,0)+PeriodSeconds(PERIOD_D1),AvgRgOpenHigh);
ObjectSetInteger(ChartID(),"D1AdrOpenHigh",OBJPROP_COLOR,clrDarkOrange);

ObjectDelete(ChartID(),"D1AdrOpenLow");
ObjectCreate(ChartID(),"D1AdrOpenLow",OBJ_TREND,0,iTime(Symbol(),PERIOD_D1,0),AvgRgOpenLow,iTime(Symbol(),PERIOD_D1,0)+PeriodSeconds(PERIOD_D1),AvgRgOpenLow);
ObjectSetInteger(ChartID(),"D1AdrOpenLow",OBJPROP_COLOR,clrDarkOrange);

ObjectDelete(ChartID(),"D1AdrHigh");
ObjectCreate(ChartID(),"D1AdrHigh",OBJ_TREND,0,iTime(Symbol(),PERIOD_D1,0),AvgRgHigh,iTime(Symbol(),PERIOD_D1,0)+PeriodSeconds(PERIOD_D1),AvgRgHigh);
ObjectSetInteger(ChartID(),"D1AdrHigh",OBJPROP_COLOR,clrDarkOrange);
ObjectSetInteger(ChartID(),"D1AdrHigh",OBJPROP_STYLE,STYLE_DOT);

ObjectDelete(ChartID(),"D1AdrLow");
ObjectCreate(ChartID(),"D1AdrLow",OBJ_TREND,0,iTime(Symbol(),PERIOD_D1,0),AvgRgLow,iTime(Symbol(),PERIOD_D1,0)+PeriodSeconds(PERIOD_D1),AvgRgLow);
ObjectSetInteger(ChartID(),"D1AdrLow",OBJPROP_COLOR,clrDarkOrange);
ObjectSetInteger(ChartID(),"D1AdrLow",OBJPROP_STYLE,STYLE_DOT);





c=0;
//double sum=0;
AvgRange=0;
//double AvgRgHigh, AvgRgLow, PresentRange;
int NumOfPeriods=14;

ENUM_TIMEFRAMES ATRPeriod=PERIOD_W1;

for (int i=1; i<Bars-1; i++)  {
    //double hi = iHigh(sym,ATRPeriod,i);
    //double lo = iLow(sym,ATRPeriod,i);
    //datetime dt = iTime(sym,ATRPeriod,i);
    {
      //sum += hi - lo;
      c++;  
         
      AvgRange = AvgRange + (iHigh(sym, ATRPeriod, i) - iLow(sym, ATRPeriod, i));
      
      if (c>=NumOfPeriods) break;    
  } }
  hi = iHigh(sym,ATRPeriod,0);
  lo = iLow(sym,ATRPeriod,0);
  


 AvgRange = AvgRange / NumOfPeriods;

 //PresentRange = (hi-lo);
  
 
  
   AvgRgHigh = NormalizeDouble(lo + AvgRange, MarketInfo(sym,MODE_DIGITS)-1);
   AvgRgLow =  NormalizeDouble(hi - AvgRange, MarketInfo(sym,MODE_DIGITS)-1);
   
  AvgRgOpenHigh = NormalizeDouble(d1_close_price + AvgRange, MarketInfo(sym,MODE_DIGITS)-1);
   AvgRgOpenLow =  NormalizeDouble(d1_close_price - AvgRange, MarketInfo(sym,MODE_DIGITS)-1);
   
   /*
ObjectDelete(ChartID(),"D1AtrOpenHigh");
ObjectCreate(ChartID(),"D1AtrOpenHigh",OBJ_TREND,0,iTime(Symbol(),PERIOD_D1,0),AvgRgOpenHigh,iTime(Symbol(),PERIOD_D1,0)+PeriodSeconds(PERIOD_D1),AvgRgOpenHigh);
ObjectSetInteger(ChartID(),"D1AtrOpenHigh",OBJPROP_COLOR,clrBisque);

ObjectDelete(ChartID(),"D1AtrOpenLow");
ObjectCreate(ChartID(),"D1AtrOpenLow",OBJ_TREND,0,iTime(Symbol(),PERIOD_D1,0),AvgRgOpenLow,iTime(Symbol(),PERIOD_D1,0)+PeriodSeconds(PERIOD_D1),AvgRgOpenLow);
ObjectSetInteger(ChartID(),"D1AtrOpenLow",OBJPROP_COLOR,clrBisque);


ObjectDelete(ChartID(),"D1AtrHigh");
ObjectCreate(ChartID(),"D1AtrHigh",OBJ_TREND,0,iTime(Symbol(),PERIOD_D1,0),AvgRgHigh,iTime(Symbol(),PERIOD_D1,0)+PeriodSeconds(PERIOD_D1),AvgRgHigh);
ObjectSetInteger(ChartID(),"D1AtrHigh",OBJPROP_COLOR,clrBisque);

ObjectDelete(ChartID(),"D1AtrLow");
ObjectCreate(ChartID(),"D1AtrLow",OBJ_TREND,0,iTime(Symbol(),PERIOD_D1,0),AvgRgLow,iTime(Symbol(),PERIOD_D1,0)+PeriodSeconds(PERIOD_D1),AvgRgLow);
ObjectSetInteger(ChartID(),"D1AtrLow",OBJPROP_COLOR,clrBisque);

*/







   
   ChartRedraw(ChartID());
   
   AvarageSystem(0);
   
   return(INIT_SUCCEEDED);


//Print(TimeDay(TimeCurrent()));

   string sym=Symbol();
   ENUM_TIMEFRAMES per=Period();
   Ortalama=BarOrtalama(1,300,sym,per);
   //timeday=int(TimeDay(TimeCurrent()));
   
   Comment(Ortalama);
   
   
   int limit=50;

for (int i=Bars-500;i>0;i--) {


double high_price=iHigh(sym,per,i);
double low_price=iLow(sym,per,i);

bool low_find=false;
for (int s=i+1;s<i+limit;s++) {
if ( low_price > iLow(sym,per,s) ) low_find=true;
}

bool low_find_right=false;
for (int s=i-1;s>i-limit;s--) {
if ( s < 0 ) continue;
if ( low_price > iLow(sym,per,s) ) low_find_right=true;
}


if ( low_find == false && low_find_right == false ) {
ObjectCreate(ChartID(),"Distribition-Low"+i,OBJ_TREND,0,Time[i],low_price,Time[i]+100*PeriodSeconds(),low_price);
ObjectSetInteger(ChartID(),"Distribition-Low"+i,OBJPROP_COLOR,clrLimeGreen);
ObjectSetInteger(ChartID(),"Distribition-Low"+i,OBJPROP_RAY,False);



int big_find=0;
for (int si=i-1;si>i-limit;si--) {
if ( si < 0 ) continue;

int sonuc=BigBarControl(si,sym,per);

if ( sonuc == 0 && big_find < 2 && iLow(sym,per,si) > high_price ) {

ObjectCreate(ChartID(),"Distribition-V"+si,OBJ_TREND,0,Time[si],High[si],Time[si],Low[si]);
ObjectSetInteger(ChartID(),"Distribition-V"+si,OBJPROP_COLOR,clrLimeGreen);
ObjectSetInteger(ChartID(),"Distribition-V"+si,OBJPROP_RAY,False);
big_find=big_find+1;
ObjectSetString(ChartID(),"V"+si,OBJPROP_TOOLTIP,big_find);

if ( big_find == 2 ) {

ObjectCreate(ChartID(),"Distribition-Vi"+si,OBJ_TREND,0,Time[si-1],Low[si-1],Time[si-1]+15*PeriodSeconds(),Low[si-1]);
ObjectSetInteger(ChartID(),"Distribition-Vi"+si,OBJPROP_COLOR,clrYellow);
ObjectSetInteger(ChartID(),"Distribition-Vi"+si,OBJPROP_RAY,False);


}




}

}



}



bool high_find=false;
for (int s=i+1;s<i+limit;s++) {
if ( high_price < iHigh(sym,per,s) ) high_find=true;
}

bool high_find_right=false;
for (int s=i-1;s>i-limit;s--) {
if ( s < 0 ) continue;
if ( high_price < iHigh(sym,per,s) ) high_find_right=true;
}


if ( high_find == false && high_find_right == false ) {
ObjectCreate(ChartID(),"Distribition-High"+i,OBJ_TREND,0,Time[i],high_price,Time[i]+100*PeriodSeconds(),high_price);
ObjectSetInteger(ChartID(),"Distribition-High"+i,OBJPROP_COLOR,clrBlue);
ObjectSetInteger(ChartID(),"Distribition-High"+i,OBJPROP_RAY,False);

int big_find=0;
for (int si=i-1;si>i-limit;si--) {
if ( si < 0 ) continue;

int sonuc=BigBarControl(si,sym,per);

if ( sonuc == 1 && big_find < 2 && iHigh(sym,per,si) < low_price ) {

ObjectCreate(ChartID(),"Distribition-V"+si,OBJ_TREND,0,Time[si],High[si],Time[si],Low[si]);
ObjectSetInteger(ChartID(),"Distribition-V"+si,OBJPROP_COLOR,clrRed);
ObjectSetInteger(ChartID(),"Distribition-V"+si,OBJPROP_RAY,False);
big_find=big_find+1;

if ( big_find == 2 ) {

ObjectCreate(ChartID(),"Distribition-Vi"+si,OBJ_TREND,0,Time[si-1],High[si-1],Time[si-1]+15*PeriodSeconds(),High[si-1]);
ObjectSetInteger(ChartID(),"Distribition-Vi"+si,OBJPROP_COLOR,clrYellow);
ObjectSetInteger(ChartID(),"Distribition-Vi"+si,OBJPROP_RAY,False);


}



}

}





}






/*
int sonuc=BigBarControl(i,sym,per);

if ( sonuc == 0 ) {

ObjectCreate(ChartID(),"V"+i,OBJ_VLINE,0,Time[i],Ask);
ObjectSetInteger(ChartID(),"V"+i,OBJPROP_COLOR,clrLimeGreen);


}

if ( sonuc == 1 ) {
ObjectCreate(ChartID(),"V"+i,OBJ_VLINE,0,Time[i],Ask);
ObjectSetInteger(ChartID(),"V"+i,OBJPROP_COLOR,clrCrimson);
}


*/



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

double acc_margin;
int OrderToplam=-1;//OrdersTotal();
void OnTick()
  {
//---



if ( OrderTotal!=OrdersTotal()){
//Alert("Selam");
OrderTotal=OrdersTotal();
AutoSL();   
}



//---
   if ( OrderToplam!=OrdersTotal() ) {   
   OrderToplam=OrdersTotal();
   ObjectsDeleteAlls(ChartID(),"FeOrder",0,-1);
   FeAnaliz();   
   }
   
   if ( per!=Period() ) {
   OrderToplam=OrdersTotal();
   ObjectsDeleteAlls(ChartID(),"FeOrder",0,-1);
   FeAnaliz();   
   per=Period();
   
   }
   
   
   


bool harpoon=OrderCommetssTypeMulti(Symbol());

double daily_open=iOpen(sym,PERIOD_D1,0);
double daily_close=iClose(sym,PERIOD_D1,0);
double daily_high=iOpen(sym,PERIOD_D1,0);
double daily_low=iClose(sym,PERIOD_D1,0);

//daily_high-daily_open
//daily_open-daily_low
string daily_reports="";
if ( daily_open-daily_low > daily_high-daily_open ) daily_reports="-";
if ( daily_high-daily_open > daily_open-daily_low ) daily_reports="+";


string daily_report="";

int daily_pips=MathAbs((daily_open-daily_close)/Point);
int daily_pips_ol=MathAbs((daily_open-daily_low)/Point);
int daily_pips_ho=MathAbs((daily_high-daily_open)/Point);



if ( daily_open > daily_close ) daily_report = daily_pips_ol+" "+daily_reports+"SHORT";
if ( daily_open < daily_close ) daily_report = daily_pips_ho+" "+daily_reports+"LONG";


Comment("Buy Profit:",buy_profit,"/","Sell Profit:",sell_profit,"\n Buy Lot:",buy_lot,"/ Sell Lot:",sell_lot,"\n Daily:",daily_report," ",daily_pips);


if ( buy_total+sell_total > 1 ) {
if ( acc_margin!=AccountMargin() ) {
AvarageSystem(0);
acc_margin=AccountMargin();
}
}

     string LabelChart="SpreadBilgisi";
     if ( ObjectFind(ChartID(),LabelChart) == -1 ) {
     
     ObjectCreate(ChartID(),LabelChart, OBJ_LABEL,0 , 0, 0);
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,MarketInfo(Symbol(),MODE_SPREAD));
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_CORNER, 1);
     ObjectSetString(ChartID(),LabelChart, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 30);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_COLOR, clrBlack);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 16);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_XDISTANCE, 35);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_YDISTANCE, 10); 
     } else {     
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,MarketInfo(Symbol(),MODE_SPREAD));
     }
     
   
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

Print(sparam);


if ( sparam == 48 ) {
CloseAllBuyOrders();
}

if ( sparam == 31 ) {
CloseAllSellOrders();
}


if ( sparam == 46 ) {

CloseAllOrdersMix();

}


////////////////////////////////////////////////////////////////////////////////////////
// TRADE LEVEL
///////////////////////////////////////////////////////////////////////////////////////
  if ( sparam == 20 ) { // t
  if ( ChartGetInteger(ChartID(),CHART_SHOW_TRADE_LEVELS,0) == true ) {  
  ChartSetInteger(ChartID(),CHART_SHOW_TRADE_LEVELS,false);
  //ChartSetInteger(ChartID(),CHART_SHOW_TRADE_HISTORY,false);
  } else { 
  ChartSetInteger(ChartID(),CHART_SHOW_TRADE_LEVELS,true);
  //ChartSetInteger(ChartID(),CHART_SHOW_TRADE_HISTORY,true);
  }
  
  //ObjectsDeleteAll(ChartID(),-1,OBJ_TEXT);
  
  ChartRedraw(ChartID());
  
  //Comment("History:",ChartGetInteger(ChartID(),CHART_SHOW_TRADE_HISTORY));

  }   
  

if ( sparam == 45 ) {

   Ict();
   Ict250();
   ChartRedraw(ChartID());

}



if ( sparam == 38 ) {

Print(ChartGetInteger(ChartID(),CHART_MODE,CHART_LINE));

if ( ChartGetInteger(ChartID(),CHART_MODE) == CHART_LINE ) {
ChartSetInteger(ChartID(),CHART_MODE,CHART_CANDLES);
} else {
ChartSetInteger(ChartID(),CHART_MODE,CHART_LINE);
}


ChartRedraw();

}









  if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_ARROW ) {
  
  //Alert("Sparam",sparam);
  
////////////////////////////////////////////////////////////////////////////      
   string sym_line="";
   string ord="";
   
   //if ( sym_periyod == "" ) {  
   string sep=" ";                // A separator as a character
   ushort u_sep;                  // The code of the separator character
   string results[];               // An array to get strings
   //--- Get the separator code
   u_sep=StringGetCharacter(sep,0);
   //--- Split the string to substrings
   
   //string ButtonSinyalTip = "";
   
   int k=StringSplit(sparam,u_sep,results);
   //Print("k",k);
   
   if(k>1) {
   //sym_line = results[0];
   ord = results[0]; 
   
   int indextic = StringFind(sparam,"#", 0);
   int indexsym = StringFind(sparam,Symbol(), 0);
   
   if ( indextic != -1 && indexsym != -1 ) {
   
   int replaced=StringReplace(ord,"#",""); 
   
   //Alert(ord); 
   
   
long sinyal_charid;
string tpl_files=ord;
//int replaced=StringReplace(tpl_files,"-Load","");    
    /*if(FileIsExist(tpl_files +".tpl",1)) {
    tpl_files = "\\Files\\"+tpl_files +".tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    //sinyal_charid=ChartOpen(Symbol(),Period());    
    //ChartApplyTemplate(sinyal_charid,tpl_files);
    //ChartSetSymbolPeriod(sinyal_charid,Symbol(),Period());
    }  */
    
    if(FileIsExist(tpl_files +"-1-.tpl",1)  && Period() == 1) {
    tpl_files = "\\Files\\"+tpl_files +"-1-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_M1);
    } 
        
    if(FileIsExist(tpl_files +"-5-.tpl",1)  && Period() == 5) {
    tpl_files = "\\Files\\"+tpl_files +"-5-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_M5);
    }     
    
    if(FileIsExist(tpl_files +"-15-.tpl",1)  && Period() == 15) {
    tpl_files = "\\Files\\"+tpl_files +"-15-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_M15);
    }     
            

    if(FileIsExist(tpl_files +"-30-.tpl",1)  && Period() == 30) {
    tpl_files = "\\Files\\"+tpl_files +"-30-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_M30);
    }     
    
    if(FileIsExist(tpl_files +"-60-.tpl",1)  && Period() == 60) {
    tpl_files = "\\Files\\"+tpl_files +"-60-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_H1);
    }     
    
    if(FileIsExist(tpl_files +"-240-.tpl",1)  && Period() == 240) {
    tpl_files = "\\Files\\"+tpl_files +"-240-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_H4);
    } 
    
    if(FileIsExist(tpl_files +"-1440-.tpl",1)  && Period() == 1440) {
    tpl_files = "\\Files\\"+tpl_files +"-1440-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_D1);
    } 

    if(FileIsExist(tpl_files +"-10080-.tpl",1) && Period() == 10080) {
    tpl_files = "\\Files\\"+tpl_files +"-10080-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_W1);
    } 

    if(FileIsExist(tpl_files +"-43200-.tpl",1)  && Period() == 43200) {
    tpl_files = "\\Files\\"+tpl_files +"-43200-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_MN1);
    } 
        
        
      ObjectDelete("FeOrderLoad"+ord);
      ObjectDelete("FeOrderSave"+ord);
      ObjectDelete("FeOrderDelete"+ord);  
      ObjectsDeleteAlls(ChartID(),"FeOrder",0,-1);          
      Sleep(100);
      FeAnaliz();

   
     
   }  
     
   }
   
   
   
   //}
       
   //Print(sym,"/",sym_line);  
///////////////////////////////////////////////////////////////////////////   
  }
  
  
  
  
  
  
  
  
//---
   
//Print("Sparam",sparam,"/",id);
//////////////////////////////////////////////////////////////////////
int indexfel = StringFind(sparam,"FeOrderLoad", 0);
int indexfes = StringFind(sparam,"FeOrderSave", 0);
int indexfed = StringFind(sparam,"FeOrderDelete", 0);

// Normal çalışması için OrderTicket yerine Symbol konulabilinir.

if ( indexfes != -1 && id==1) {

//Alert("Selam");

         string ord = sparam;
      int replacedz = StringReplace(ord,"FeOrderSave","");
      
    
       string tpl_files = ord +"-"+Period()+"-.tpl";
//Alert("TPL:",tpl_files);

      ObjectDelete("FeOrderLoad"+ord);
      ObjectDelete("FeOrderSave"+ord);
      ObjectDelete("FeOrderDelete"+ord);
      ObjectsDeleteAlls(ChartID(),"FeOrder",0,-1);

      //FileDelete("\\Files\\"+tpl_files,1);
      FileDelete(tpl_files,1);
      Sleep(100);
      //ChartSaveTemplate(ChartID(),"\\Files\\"+tpl_files);
      ChartSaveTemplate(ChartID(),"\\Files\\"+tpl_files);
      
               
      Print("OrderTicket",ord);
      
      //ObjectDelete("FeOrderLoad"+ord);
      //ObjectDelete("FeOrderSave"+ord);
      //ObjectDelete("FeOrderDelete"+ord);
      Sleep(100);
      FeAnaliz();
      
      
}




if ( indexfed != -1 && id==1) {



         string ord = sparam;
      int replacedz = StringReplace(ord,"FeOrderDelete","");
      
      Print("OrderTicket",ord);
      
long sinyal_charid;
string tpl_files=ord;

//Alert("Delete",tpl_files);
    
    if(FileIsExist(tpl_files +"-1-.tpl",1) && Period() == 1 ) {
    tpl_files = tpl_files +"-1-.tpl";
    FileDelete(tpl_files,1);
    } 
        
    if(FileIsExist(tpl_files +"-5-.tpl",1)  && Period() == 5) {
    tpl_files = tpl_files +"-5-.tpl";
    FileDelete(tpl_files,1);
    }     
    
    if(FileIsExist(tpl_files +"-15-.tpl",1) && Period() == 15) {
    tpl_files = tpl_files +"-15-.tpl";
    FileDelete(tpl_files,1);
    }     
                

    if(FileIsExist(tpl_files +"-30-.tpl",1) && Period() == 30) {
    tpl_files = tpl_files +"-30-.tpl";
    FileDelete(tpl_files,1);
    }     
        
    if(FileIsExist(tpl_files +"-60-.tpl",1)  && Period() == 60) {
    tpl_files = tpl_files +"-60-.tpl";
    FileDelete(tpl_files,1);
    }     
    
    if(FileIsExist(tpl_files +"-240-.tpl",1)  && Period() == 240) {
    tpl_files = tpl_files +"-240-.tpl";
    FileDelete(tpl_files,1);
    } 
    
    if(FileIsExist(tpl_files +"-1440-.tpl",1) && Period() == 1440 ) {
    tpl_files = tpl_files +"-1440-.tpl";
    FileDelete(tpl_files,1);
    } 

    if(FileIsExist(tpl_files +"-10080-.tpl",1)  && Period() == 10080) {
    tpl_files = tpl_files +"-10080-.tpl";
    FileDelete(tpl_files,1);
    } 

    if(FileIsExist(tpl_files +"-43200-.tpl",1)  && Period() == 43200) {
    tpl_files = tpl_files +"-43200-.tpl";
    FileDelete(tpl_files,1);
    } 
        
        
      ObjectDelete("FeOrderLoad"+ord);
      ObjectDelete("FeOrderSave"+ord);
      ObjectDelete("FeOrderDelete"+ord);
      ObjectsDeleteAlls(ChartID(),"FeOrder",0,-1);          
      Sleep(100);
      FeAnaliz();
      
      
}



if ( indexfel != -1 && id==1) {

         string ord = sparam;
      int replacedz = StringReplace(ord,"FeOrderLoad","");
      
      Print("OrderTicket",ord);
      
long sinyal_charid;
string tpl_files=ord;
//int replaced=StringReplace(tpl_files,"-Load","");    
    /*if(FileIsExist(tpl_files +".tpl",1)) {
    tpl_files = "\\Files\\"+tpl_files +".tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    //sinyal_charid=ChartOpen(Symbol(),Period());    
    //ChartApplyTemplate(sinyal_charid,tpl_files);
    //ChartSetSymbolPeriod(sinyal_charid,Symbol(),Period());
    }  */
    
    if(FileIsExist(tpl_files +"-1-.tpl",1)  && Period() == 1) {
    tpl_files = "\\Files\\"+tpl_files +"-1-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_M1);
    } 
        
    if(FileIsExist(tpl_files +"-5-.tpl",1)  && Period() == 5) {
    tpl_files = "\\Files\\"+tpl_files +"-5-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_M5);
    }     
    
    if(FileIsExist(tpl_files +"-15-.tpl",1)  && Period() == 15) {
    tpl_files = "\\Files\\"+tpl_files +"-15-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_M15);
    }     
            

    if(FileIsExist(tpl_files +"-30-.tpl",1)  && Period() == 30) {
    tpl_files = "\\Files\\"+tpl_files +"-30-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_M30);
    }     
    
    if(FileIsExist(tpl_files +"-60-.tpl",1)  && Period() == 60) {
    tpl_files = "\\Files\\"+tpl_files +"-60-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_H1);
    }     
    
    if(FileIsExist(tpl_files +"-240-.tpl",1)  && Period() == 240) {
    tpl_files = "\\Files\\"+tpl_files +"-240-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_H4);
    } 
    
    if(FileIsExist(tpl_files +"-1440-.tpl",1)  && Period() == 1440) {
    tpl_files = "\\Files\\"+tpl_files +"-1440-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_D1);
    } 

    if(FileIsExist(tpl_files +"-10080-.tpl",1) && Period() == 10080) {
    tpl_files = "\\Files\\"+tpl_files +"-10080-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_W1);
    } 

    if(FileIsExist(tpl_files +"-43200-.tpl",1)  && Period() == 43200) {
    tpl_files = "\\Files\\"+tpl_files +"-43200-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_MN1);
    } 
        
        
      ObjectDelete("FeOrderLoad"+ord);
      ObjectDelete("FeOrderSave"+ord);
      ObjectDelete("FeOrderDelete"+ord);  
      ObjectsDeleteAlls(ChartID(),"FeOrder",0,-1);          
      Sleep(100);
      FeAnaliz();
      
      
}
////////////////////////////////////////////////////////////////////////////















   
  }
//+------------------------------------------------------------------+




int BigBarControl(int bi,string sym,string per) {

int sonuc=-1;

  // string select_sym=Symbol();
  // int select_per=Period();
   
    
    
    //Comment("Ortalam:",Ortalama/Point);
    
   //for ( int i=1000;i>0;i--) {
   
   
   if ( (iHigh(sym,per,bi) - iLow(sym,per,bi) ) >= Ortalama*carpans ) {
   
   //ObjectCreate(ChartID(),"VLINE"+Time[i],OBJ_VLINE,0,iTime(select_sym,select_per,i),0);
   //Print(i);   
   }
   
   if ( (iClose(sym,per,bi) - iOpen(sym,per,bi) ) >= Ortalama*carpans ) {
   
   //ObjectCreate(ChartID(),"VLINE"+Time[i],OBJ_VLINE,0,iTime(sym,per,i),0);
   //ObjectSetInteger(ChartID(),"VLINE"+Time[i],OBJPROP_BACK,true);
   //Print(i);   
   sonuc=0;
   }
      
   if ( (iOpen(sym,per,bi) - iClose(sym,per,bi) ) >= Ortalama*carpans ) {
   
   //ObjectCreate(ChartID(),"VLINE"+Time[i],OBJ_VLINE,0,iTime(sym,per,i),0);
   //ObjectSetInteger(ChartID(),"VLINE"+Time[i],OBJPROP_BACK,true);
   sonuc=1;
   //Print(i);   
   }
   
         
   
   
   
   //}
   
   
  
   
   
   return sonuc;
   
   
   }
   
   

   int ortalama_last_bar= -1;

 
double BarOrtalama(int StartVisibleBar,int FinishVisibleBarLenght,string Sym,int Per) { 

///FinishVisibleBarLenght=PERIOD_W1/Period();
//Print("FinishVisibleBarLenght",FinishVisibleBarLenght);
///if ( FinishVisibleBarLenght > Bars ) FinishVisibleBarLenght=Bars;



if ( ortalama_last_bar == WindowFirstVisibleBar() && StartVisibleBar == -1 ) return Ortalama;


if ( ortalama_last_bar != WindowFirstVisibleBar() ) {
ortalama_last_bar = WindowFirstVisibleBar();
}

//Print("FinishVisibleBarLenght2",FinishVisibleBarLenght);


int mumanaliz_shift;
int mumanaliz_shiftb;

   if ( WindowFirstVisibleBar()-WindowBarsPerChart() > 0 ) {
   mumanaliz_shift=WindowFirstVisibleBar()-WindowBarsPerChart();
   } else {
   mumanaliz_shift=0;
   }
   mumanaliz_shiftb=WindowFirstVisibleBar();
   
   
   
   if ( StartVisibleBar != -1 ) mumanaliz_shift=StartVisibleBar;
   
   if ( FinishVisibleBarLenght != -1 ) mumanaliz_shiftb=mumanaliz_shift+FinishVisibleBarLenght;
   
   
   int bar_toplam = mumanaliz_shiftb-mumanaliz_shift;
   double bar_pip = 0;
   double bar_ortalama=0;
   
   for (int t=mumanaliz_shift;t<=mumanaliz_shiftb;t++) {
   
   //bar_pip = bar_pip + MathAbs(Close(select_sym,select_per,t)-Open(select_sym,select_per,t));
   ///bar_pip = bar_pip + MathAbs(Close(select_sym,select_per,t)-Open(select_sym,select_per,t));
   bar_pip = bar_pip + MathAbs(iClose(Sym,Per,t)-iOpen(Sym,Per,t));
   
   }
  
   
   bar_ortalama = bar_pip / bar_toplam;
   
   return bar_ortalama;

}

/*
// Finito
int WindowFirstVisibleBar(){
int WFB = ChartGetInteger(ChartID(),CHART_FIRST_VISIBLE_BAR,0);
return WFB;
}


double WindowPriceMax() {
double WPM=ChartGetDouble(0,CHART_PRICE_MAX,0);
return WPM;
}

double WindowPriceMin() {
double WPMM = ChartGetDouble(0,CHART_PRICE_MIN,0);
return WPMM;
}

int WindowBarsPerChart(){
int WPC=ChartGetInteger(ChartID(),CHART_VISIBLE_BARS,0);
return WPC;
}
*/

int OrderCommets(string cmt){
int com = 0;


//int cnt = 0;
for(int cnts=OrdersTotal()-1;cnts>=0;cnts--){

if(!OrderSelect(cnts, SELECT_BY_POS, MODE_TRADES))continue;
//Sonuna Rakam Ekledik Hangi Tutar Kazanıyor diye onun için instr veya indexof yapıp comment içinde arama yapıyoruz.
int index=StringFind(OrderComment(), cmt, 0);

//Alert(OrderType(),"/",OrderComment(),"/",cmt,"/",index);
//if ( OrderType() == OP_BUY || OrderType() == OP_SELL ) {
if(index!=-1 && OrderSymbol() == Symbol()){com++;}; // Hatali Calisiyor
//if(OrderComment()==cmt){com++;};
if(OrderComment()=="" && cmt=="" && OrderSymbol() == Symbol()){com++;};
//}
}



return com;
};




extern int LinesAboveBelow= 10;
color LineColorMain= Black;
color LineColorSub= DarkGray;

double dPt;


double open_order=false;
double first_question=false;

void Ict() {


static datetime timelastupdate= 0;
   static datetime lasttimeframe= 0;
   
    
   // no need to update these buggers too often   
   if (CurTime()-timelastupdate < 600 && Period()==lasttimeframe)
      return;
      
   int i, ssp1, style, ssp;
   double ds1;
   color linecolor;
   
   ssp1= Bid / dPt;
   ssp1= ssp1 - ssp1%50;

   for (i= -LinesAboveBelow; i<LinesAboveBelow; i++) {
      ssp= ssp1+(i*50); 
      
      if (ssp%100==0) {
         style= STYLE_SOLID;
         linecolor= LineColorMain;
      }
      else {
         style= STYLE_DOT;
         linecolor= LineColorSub;
      }
      
      ds1= ssp*dPt;
            
      
      if ( int(TimeHour(TimeCurrent())) < 23 && ChartGetInteger(ChartID(),CHART_BRING_TO_TOP) == 1 && ssp%100==0 ) {
      int cevap=0;
      if ( first_question == false ) {cevap=MessageBox(Symbol()+" Do I open the order? ","Order Open Grid",4); //  / Spread:"+Spread_Yuzde+"%"
      first_question=true;
      }
      if ( cevap == 6 ) {      
      open_order=true;
      }  
      if ( open_order == true ) {
      double grid_price=NormalizeDouble(ds1,Digits);
      string grid_cmt="";
      double grid_lot=0.01;
      if ( Bid < ds1 && ds1-Bid >= 250*Point ) {
      grid_cmt="SELL"+DoubleToString(grid_price,Digits);
      if( OrderCommets(grid_cmt)==0) OrderSend(Symbol(),OP_SELLLIMIT,grid_lot,ds1,0,0,0,grid_cmt,0,0,clrNONE);
      }

      if ( Ask > ds1 && Ask-ds1 >= 250*Point ) {
      grid_cmt="BUY"+DoubleToString(grid_price,Digits);
      if( OrderCommets(grid_cmt)==0) OrderSend(Symbol(),OP_BUYLIMIT,grid_lot,ds1,0,0,0,grid_cmt,0,0,clrNONE);
      } 
      }
      }
      
      
         
      SetLevel(DoubleToStr(ds1,Digits), ds1,  linecolor, style, Time[10]);
   }
   
   
}


void Ict250() {


static datetime timelastupdate= 0;
   static datetime lasttimeframe= 0;
   
    
   // no need to update these buggers too often   
   if (CurTime()-timelastupdate < 600 && Period()==lasttimeframe)
      return;
      
   int i, ssp1, style, ssp;
   double ds1;
   color linecolor;
   
   ssp1= Bid / dPt;
   ssp1= ssp1 - ssp1%25;

   for (i= -LinesAboveBelow; i<LinesAboveBelow; i++) {
      ssp= ssp1+(i*25); 
      
      if (ssp%100==0) {
         style= STYLE_SOLID;
         linecolor= LineColorMain;
      }
      else {
         style= STYLE_DOT;
         linecolor= LineColorSub;
      }
      
      ds1= ssp*dPt;
      SetLevel(DoubleToStr(ds1,Digits), ds1,  clrLightSkyBlue, STYLE_DASHDOTDOT, Time[10]);
   }
   
   
}



void SetLevel(string text, double level, color col1, int linestyle, datetime startofday)
{
   int digits= Digits;
   string linename= "[SweetSpot] " + text + " Line",
          pricelabel; 

   // create or move the horizontal line   
   if (ObjectFind(ChartID(),linename) != 0) {
      ObjectCreate(ChartID(),linename, OBJ_HLINE, 0, 0, level);
      ObjectSetInteger(ChartID(),linename, OBJPROP_STYLE, linestyle);
      ObjectSetInteger(ChartID(),linename, OBJPROP_COLOR, col1);
      ObjectSetInteger(ChartID(),linename, OBJPROP_WIDTH, 0);
   }
   else {
      ObjectMove(ChartID(),linename, 0, Time[0], level);
   }
}



void ObjectsDeleteAlls(long oda_charid,string oda_wilcard,int oda_window,int oda_type) {


//return;

             int obj_total=ObjectsTotal(oda_charid,oda_window,oda_type)-1;
    for(int i=ObjectsTotal(oda_charid,oda_window,oda_type);i>=0;i--)
        {
        string name = ObjectName(oda_charid,i,oda_window,oda_type);
        
  int index = StringFind(name,oda_wilcard, 0); 


  if ( index != -1 ) {
  Sleep(100);
  ObjectDelete(ChartID(),name);
   }  
   
  }


}

/////////////////////////////////////////////////////////////////////////////////////////
// Divide Zero Hatası için formül.
/////////////////////////////////////////////////////////////////////////////////////////
double DivZero(double n, double d)
{
if (d==0) return(0);  else return(n/d);
} 
//////////////////////////////////////////////////////////////////////} 



void CloseAllPenOrdersMix()
{
   for (int m=OrdersTotal(); m>=0; m--)
   {
      if ( OrderSelect(m, SELECT_BY_POS))
      {
         if(OrderSymbol() == Symbol() && OrderMagicNumber() == magic )
         {
            OrderDelete(OrderTicket(),clrNONE);
         }
      }
    }
}





void CloseAllOrdersMix()
{
   for (int m=OrdersTotal(); m>=0; m--)
   {
      if ( OrderSelect(m, SELECT_BY_POS))
      {
         if(OrderSymbol() == Symbol() && OrderMagicNumber() == magic )
         {
            RefreshRates();
            bool success = OrderClose(OrderTicket(), OrderLots(), OrderClosePrice(), 0, Blue);
         }
      }
    }
}


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

void CloseAllOrders()
{
   CloseAllBuyOrders();
   CloseAllSellOrders();
}



/////////////////////////////////////////////////////////////////////////////////////////////////////////
bool OrderCommetssTypeMulti(string sym){

bool sonuc=false;

buy_total=0;
sell_total=0;
buy_profit=0;
sell_profit=0;
buy_lot=0;
sell_lot=0;

eq_live_order=0;
eq_pen_order=0;


lock_order_buy_total=0;
lock_order_sell_total=0;

sell_total_profit_loss=0;
buy_total_profit_loss=0;

sell_total_profit=0;
buy_total_profit=0;

sell_pen_total_profit_loss=0;
buy_pen_total_profit_loss=0;

sell_pen_total_profit=0;
buy_pen_total_profit=0;

buy_pen_lot=0;
sell_pen_lot=0;



//int cnt = 0;
for(int cnts=OrdersTotal()-1;cnts>=0;cnts--){




if ( OrderSymbol() == sym && OrderMagicNumber() == magic+1 && ( OrderType() == OP_BUYLIMIT || OrderType() == OP_SELLLIMIT ) ) {
eq_pen_order=eq_pen_order+1;
//buy_profit=buy_profit+OrderProfit();
}



if(!OrderSelect(cnts, SELECT_BY_POS, MODE_TRADES))continue;

if ( OrderMagicNumber() != magic ) continue;

//Print(OrderTicket());


//Sonuna Rakam Ekledik Hangi Tutar Kazaniyor diye onun icin instr veya indexof yapip comment icinde arama yapiyoruz.
//int index=StringFind(OrderComment(), cmt, 0);

if ( OrderSymbol() == sym && OrderMagicNumber() == magic+1 ) {
eq_live_order=eq_live_order+1;
//buy_profit=buy_profit+OrderProfit();
}
/*
////////////////////////////////////////////////////
if ( OrderSymbol() == sym && OrderType() == OP_BUY && OrderMagicNumber() == magic && OrderComment() == "HEDGE" ) {
//hedge_buy_profit=OrderProfit();
lock_order_buy_total=lock_order_buy_total+1;
}

if ( OrderSymbol() == sym && OrderType() == OP_SELL && OrderMagicNumber() == magic && OrderComment() == "HEDGE" ) {
//hedge_sell_profit=OrderProfit();
lock_order_sell_total=lock_order_sell_total+1;
}
////////////////////////////
*/



//Alert(OrderType(),"/",OrderComment(),"/",cmt,"/",index);
//if ( OrderType() == OP_BUY || OrderType() == OP_SELL ) {
if ( OrderSymbol() == sym && OrderType() == OP_BUY //&& OrderMagicNumber() == magic 
//if ( OrderType() == OP_BUY //&& OrderMagicNumber() == magic 
) {
buy_total=buy_total+1;
buy_profit=buy_profit+OrderProfit();
buy_profit=buy_profit+OrderCommission();
buy_lot=buy_lot+OrderLots();


buy_orders[buy_total,0]=OrderTicket();
buy_orders[buy_total,1]=OrderProfit()+OrderCommission();
buy_orders[buy_total,2]=OrderLots();
buy_orders[buy_total,3]=OrderOpenPrice();



if ( price < OrderOpenPrice() ) {
   int fiboset_Fark=(OrderOpenPrice()-price)/Point;
   double Pips_Price_valued = PipPrice(sym,0,fiboset_Fark,OrderLots());
   buy_total_profit_loss=buy_total_profit_loss+Pips_Price_valued;
   //Comment(Pips_Price_valued);
}   
  
   
if ( price > OrderOpenPrice() ) {
   int fiboset_Fark=(price-OrderOpenPrice())/Point;
   double Pips_Price_valued = PipPrice(sym,0,fiboset_Fark,OrderLots());
   buy_total_profit=buy_total_profit+Pips_Price_valued;
   //Comment(Pips_Price_valued);
}  



}





if ( OrderSymbol() == sym && ( OrderType() == OP_BUYLIMIT || OrderType() == OP_BUYSTOP )  //&& OrderMagicNumber() == magic 
) {/*
buy_total=buy_total+1;
buy_profit=buy_profit+OrderProfit();
*/
buy_pen_lot=buy_pen_lot+OrderLots();


if ( price < OrderOpenPrice() ) {
   int fiboset_Fark=(OrderOpenPrice()-price)/Point;
   double Pips_Price_valued = PipPrice(sym,0,fiboset_Fark,OrderLots());
   buy_pen_total_profit_loss=buy_pen_total_profit_loss+Pips_Price_valued;
   //Comment(Pips_Price_valued);
}   
  
   
if ( price > OrderOpenPrice() ) {
   int fiboset_Fark=(price-OrderOpenPrice())/Point;
   double Pips_Price_valued = PipPrice(sym,0,fiboset_Fark,OrderLots());
   buy_pen_total_profit=buy_pen_total_profit+Pips_Price_valued;
   //Comment(Pips_Price_valued);
}  



}




if ( OrderSymbol() == sym && OrderType() == OP_SELL //&& OrderMagicNumber() == magic 
//if ( OrderType() == OP_SELL //&& OrderMagicNumber() == magic 
 ) {
sell_total=sell_total+1;
sell_profit=sell_profit+OrderProfit();
sell_profit=sell_profit+OrderCommission();
sell_lot=sell_lot+OrderLots();


sell_orders[sell_total,0]=OrderTicket();
sell_orders[sell_total,1]=OrderProfit()+OrderCommission();
sell_orders[sell_total,2]=OrderLots();
sell_orders[sell_total,3]=OrderOpenPrice();



if ( price > OrderOpenPrice() ) {

   int fiboset_Fark=(price-OrderOpenPrice())/Point;
   double Pips_Price_valued = PipPrice(sym,0,fiboset_Fark,OrderLots());
   sell_total_profit_loss=sell_total_profit_loss+Pips_Price_valued;
}   
  

if ( price < OrderOpenPrice() ) {

   int fiboset_Fark=(OrderOpenPrice()-price)/Point;
   double Pips_Price_valued = PipPrice(sym,0,fiboset_Fark,OrderLots());
   sell_total_profit=sell_total_profit+Pips_Price_valued;
}   
  

   //Comment(Pips_Price_valued);


}



if ( OrderSymbol() == sym && (OrderType() == OP_SELLLIMIT || OrderType() == OP_SELLSTOP )//&& OrderMagicNumber() == magic 
 ) {
 

//sell_total=sell_total+1;
//sell_profit=sell_profit+OrderProfit();
sell_pen_lot=sell_pen_lot+OrderLots();



if ( price > OrderOpenPrice() ) {

   int fiboset_Fark=(price-OrderOpenPrice())/Point;
   double Pips_Price_valued = PipPrice(sym,0,fiboset_Fark,OrderLots());
   sell_pen_total_profit_loss=sell_pen_total_profit_loss+Pips_Price_valued;
}   
  

if ( price < OrderOpenPrice() ) {

   int fiboset_Fark=(OrderOpenPrice()-price)/Point;
   double Pips_Price_valued = PipPrice(sym,0,fiboset_Fark,OrderLots());
   sell_pen_total_profit=sell_pen_total_profit+Pips_Price_valued;
}   
  

   //Comment(Pips_Price_valued);


}








}

sonuc=true;

/*
if ( lock_order_buy_total == 0 ) lock_order_buy = false;
if ( lock_order_sell_total == 0 ) lock_order_sell = false;
*/
return sonuc;
};
////////////////////////////////////////////////////////////////////////////
// Pip - Price Fonksiyonu  ? 100 pip kazansa 0.01 bu kur ne kazandirir ?
////////////////////////////////////////////////////////////////////////////

double PipPrice(string sym,double fiyat,int pips,double lots) {



string OrderSymbols = sym;
double sonuc = 0;

if ( MarketInfo(OrderSymbols,MODE_SPREAD) == 0 ) return sonuc;

          int BS_spread = MarketInfo(OrderSymbols,MODE_SPREAD);
              BS_spread = 1;
    double BS_tickvalue = MarketInfo(OrderSymbols,MODE_TICKVALUE);
     double BS_ticksize = MarketInfo(OrderSymbols,MODE_TICKSIZE);
 double BS_spread_price = MarketInfo(OrderSymbols,MODE_MARGINREQUIRED)*BS_spread;
        BS_spread_price = (1/MarketInfo(OrderSymbols,MODE_POINT))*(BS_spread*(MarketInfo(OrderSymbols,MODE_TICKVALUE)*MarketInfo(OrderSymbols,MODE_TICKSIZE)));
        
   double BS_spread_one = (BS_spread_price / BS_spread)*lots;     
    double Order_Profit = pips*BS_spread_one;   
    //Alert(Order_Profit);
    
    
    if ( BS_spread_one == 0 ) {//Alert("BS_spread_one Hatasi:",OrderSymbols);
    return sonuc;}
         
         //Print("OrderSymbols",OrderSymbols,"Fiyat",fiyat,"BS_spread_one",BS_spread_one,"BS_spread_price",BS_spread_price);
         
         int Order_Pips = fiyat/BS_spread_one;   


if ( fiyat != 0 ) {
//Alert(fiyat," $ kac piptir ?",BS_spread_one,"/",IntegerToString(Order_Pips,0)," pip");
sonuc =  Order_Pips;
}

////////////////////////

if ( pips != 0 ) {
//Alert(pips," pip kac $ kazandirir ?",DoubleToString(Order_Profit,2),"$");
sonuc =  DoubleToString(Order_Profit,2);
}




return sonuc;


}


int active_magic_buy=0;
int active_magic_sell=0;


double last_avarage_buy=0; 
double last_avarage_sell=0; 

double last_avarage_buy_profit_price=0;
double last_avarage_sell_profit_price=0;

void AvarageSystem(int mgc) {

if ( ChartGetInteger(ChartID(),CHART_BRING_TO_TOP) == 1 ) {


///////////////////////////////////////////////////////////////////////////////////////////////
// Lot Gösterici
///////////////////////////////////////////////////////////////////////////////////////////////
if ( OrdersTotal() > 0 ) {

double margin_buylot=0;
double margin_selllot=0;
double margin_buyprofit=0;
double margin_sellprofit=0;
double avarage = 0;
double avarage_total = 0;
double islem_sayisi = 0;
double islem_sayisi_buy = 0;
double islem_sayisi_sell = 0;


double avarage_total_buy = 0;
double avarage_total_sell = 0;

double avarage_buy = 0;
double avarage_sell = 0;


       for(int i=0; i<OrdersTotal(); i++) {
        if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) {
           if (OrderSymbol()==Symbol() && OrderMagicNumber() == mgc ) {
           
           //Alert("OrderTicket:",OrderTicket());
           
           //Print(OrderTicket(),"/",OrderMagicNumber());
           
           
           
           
        //if ( OrderType() == OP_BUY || OrderType() == OP_BUYSTOP ) {
        if ( OrderType() == OP_BUY  ) {
        
           margin_buylot = margin_buylot + OrderLots();
           
           islem_sayisi=islem_sayisi+(OrderLots()*100);
           avarage_total=avarage_total+(OrderOpenPrice()*(OrderLots()*100));           
           
           islem_sayisi_buy=islem_sayisi_buy+(OrderLots()*100);
           avarage_total_buy=avarage_total_buy+(OrderOpenPrice()*(OrderLots()*100));           
        }
        
        //if ( OrderType() == OP_SELL || OrderType() == OP_SELLSTOP ) {
        if ( OrderType() == OP_SELL  ) {
        
           margin_selllot = margin_selllot + OrderLots();
           
           islem_sayisi=islem_sayisi+(OrderLots()*100);
           avarage_total=avarage_total+(OrderOpenPrice()*(OrderLots()*100));
           
           islem_sayisi_sell=islem_sayisi_sell+(OrderLots()*100);
           avarage_total_sell=avarage_total_sell+(OrderOpenPrice()*(OrderLots()*100));           
        }
        
        
       if ( OrderType() == OP_BUY && OrderProfit() < 0 ) {
        
        margin_buyprofit = margin_buyprofit +  OrderProfit(); 
        
        } 
        
       if ( OrderType() == OP_SELL && OrderProfit() < 0 ) {
        
        margin_sellprofit = margin_sellprofit +  OrderProfit(); 
        
        } 
        
        



}
}
}

if ( avarage_total == 0 ) return;


//////////////////////////////////////////////////////////////////////////////////////////////
// AVARAGE SİSTEMİ
//////////////////////////////////////////////////////////////////////////////////////////////        
        avarage=DivZero(avarage_total,islem_sayisi);
        
        avarage_buy=DivZero(avarage_total_buy,islem_sayisi_buy);
        avarage_sell=DivZero(avarage_total_sell,islem_sayisi_sell);
        
        Comment("avarage_buy:",avarage_buy,"\n avarage_sell:",avarage_sell);
        
        double avarage_fark=avarage_buy-avarage_sell;
        

double avarage_buy_profit_price=avarage_buy+avarage_fark;
double avarage_sell_profit_price=avarage_sell-avarage_fark;

        
if ( last_avarage_buy_profit_price != avarage_buy_profit_price ) {        
if ( ObjectFind(ChartID(),"AvarageBuyp") == -1 ) {        
ObjectCreate(ChartID(),"AvarageBuyp",OBJ_HLINE,0,0,avarage_buy_profit_price);
ObjectSetInteger(ChartID(),"AvarageBuyp",OBJPROP_COLOR,clrLimeGreen);        
ObjectSetInteger(ChartID(),"AvarageBuyp",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),"AvarageBuyp",OBJPROP_SELECTABLE,true);
ObjectSetInteger(ChartID(),"AvarageBuyp",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),"AvarageBuyp",OBJPROP_STYLE,STYLE_DOT);
} else {
ObjectSetDouble(ChartID(),"AvarageBuyp",OBJPROP_PRICE,avarage_buy_profit_price);
last_avarage_buy_profit_price=avarage_buy_profit_price;
}  
}

if ( last_avarage_sell_profit_price != avarage_sell_profit_price ) {        
if ( ObjectFind(ChartID(),"AvarageSellp") == -1 ) {        
ObjectCreate(ChartID(),"AvarageSellp",OBJ_HLINE,0,0,avarage_sell_profit_price);
ObjectSetInteger(ChartID(),"AvarageSellp",OBJPROP_COLOR,clrLimeGreen);        
ObjectSetInteger(ChartID(),"AvarageSellp",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),"AvarageSellp",OBJPROP_SELECTABLE,true);
ObjectSetInteger(ChartID(),"AvarageSellp",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),"AvarageSellp",OBJPROP_STYLE,STYLE_DOT);
} else {
ObjectSetDouble(ChartID(),"AvarageSellp",OBJPROP_PRICE,avarage_sell_profit_price);
last_avarage_sell_profit_price=avarage_sell_profit_price;
}  
}



        
        
        
        ///Print("avarage",avarage,"/",islem_sayisi,"/",avarage_total);

if ( mgc == active_magic_buy ) {

if ( last_avarage_buy != avarage_buy ) {        
if ( ObjectFind(ChartID(),"AvarageBuy") == -1 ) {        
ObjectCreate(ChartID(),"AvarageBuy",OBJ_HLINE,0,0,avarage_buy);
ObjectSetInteger(ChartID(),"AvarageBuy",OBJPROP_COLOR,clrSandyBrown);        
ObjectSetInteger(ChartID(),"AvarageBuy",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),"AvarageBuy",OBJPROP_SELECTABLE,true);
ObjectSetInteger(ChartID(),"AvarageBuy",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),"AvarageBuy",OBJPROP_STYLE,STYLE_DASHDOT);
} else {
ObjectSetDouble(ChartID(),"AvarageBuy",OBJPROP_PRICE,avarage_buy);
last_avarage_buy=avarage_buy;
}   

if ( ObjectFind(ChartID(),"AvarageBuy") != -1 && islem_sayisi_buy == 0 ) ObjectDelete(ChartID(),"AvarageBuy");

}


if ( last_avarage_sell != avarage_sell ) {        
if ( ObjectFind(ChartID(),"AvarageSell") == -1 ) {        
ObjectCreate(ChartID(),"AvarageSell",OBJ_HLINE,0,0,avarage_sell);
ObjectSetInteger(ChartID(),"AvarageSell",OBJPROP_COLOR,clrCrimson);        
ObjectSetInteger(ChartID(),"AvarageSell",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),"AvarageSell",OBJPROP_SELECTABLE,true);
ObjectSetInteger(ChartID(),"AvarageSell",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),"AvarageSell",OBJPROP_STYLE,STYLE_DASHDOT);
} else {
ObjectSetDouble(ChartID(),"AvarageSell",OBJPROP_PRICE,avarage_sell);
last_avarage_sell=avarage_sell;
}   

if ( ObjectFind(ChartID(),"AvarageSell") != -1 && islem_sayisi_sell == 0 ) ObjectDelete(ChartID(),"AvarageSell");

}








}

///////////////////////////////////////////////////////////////////////////////////////////////////////     
if ( mgc == active_magic_sell ) {

if ( last_avarage_sell != avarage ) {        
if ( ObjectFind(ChartID(),"AvarageSell") == -1 ) {        
ObjectCreate(ChartID(),"AvarageSell",OBJ_HLINE,0,0,avarage_sell);
ObjectSetInteger(ChartID(),"AvarageSell",OBJPROP_COLOR,clrCrimson);        
ObjectSetInteger(ChartID(),"AvarageSell",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),"AvarageSell",OBJPROP_SELECTABLE,true);
ObjectSetInteger(ChartID(),"AvarageSell",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),"AvarageSell",OBJPROP_STYLE,STYLE_DASHDOT);
} else {
ObjectSetDouble(ChartID(),"AvarageSell",OBJPROP_PRICE,avarage_sell);
last_avarage_sell=avarage_sell;
}   

if ( ObjectFind(ChartID(),"AvarageSell") != -1 && islem_sayisi_sell == 0 ) ObjectDelete(ChartID(),"AvarageSell");

}


if ( last_avarage_buy != avarage_buy ) {        
if ( ObjectFind(ChartID(),"AvarageBuy") == -1 ) {        
ObjectCreate(ChartID(),"AvarageBuy",OBJ_HLINE,0,0,avarage_buy);
ObjectSetInteger(ChartID(),"AvarageBuy",OBJPROP_COLOR,clrSandyBrown);        
ObjectSetInteger(ChartID(),"AvarageBuy",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),"AvarageBuy",OBJPROP_SELECTABLE,true);
ObjectSetInteger(ChartID(),"AvarageBuy",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),"AvarageBuy",OBJPROP_STYLE,STYLE_DASHDOT);
} else {
ObjectSetDouble(ChartID(),"AvarageBuy",OBJPROP_PRICE,avarage_buy);
last_avarage_buy=avarage_buy;
}   

if ( ObjectFind(ChartID(),"AvarageBuy") != -1 && islem_sayisi_buy == 0 ) ObjectDelete(ChartID(),"AvarageBuy");

}







}

///////////////////////////////////////////////////////////////////////////////////////////////////////     
  
  
    
  
  
  
  
  
  
}
}


}




void FeAnaliz() {



  int totalii = OrdersTotal();
  
  //Alert(OrdersTotal());
  
  for(int iii=0;iii<=OrdersTotal()-1;iii++)
  {
    OrderSelect(iii, SELECT_BY_POS);
           int typei = OrderType();
    string commentsi = OrderComment();
    
    
    if ( Symbol() == OrderSymbol() ) {
    
    //Print(OrderTicket(),"/",ObjectFind("Order"+OrderTicket()));
    
    string OrderLine="FeOrderSave"+OrderTicket();
    if ( ObjectFind("FeOrderSave"+OrderTicket()) == -1 ) {
    
    //int      right_bound=WindowFirstVisibleBar()-WindowBarsPerChart();
    
  datetime left;
  int      right_bound;
  if ( WindowFirstVisibleBar() > -1 ) {
  //left=Time[WindowFirstVisibleBar()];
  right_bound=WindowFirstVisibleBar()-WindowBarsPerChart();}
  else{
  //left=TimeCurrent();
  right_bound=WindowFirstVisibleBar()-WindowBarsPerChart();
  }



bool tpl_files_per_find=false;
bool tpl_files_find=false;
string tpl_files=OrderTicket();
string tpl_files_time = "";

if(FileIsExist(tpl_files +"-"+Period()+"-.tpl",1)) {
    //tpl_files_find=true;
    tpl_files_per_find=true;
    } 
    

//Alert("Delete",tpl_files);
    
    if(FileIsExist(tpl_files +"-1-.tpl",1)) {
    tpl_files_time="M1";
    } 
        
    if(FileIsExist(tpl_files +"-5-.tpl",1)) {
    if ( tpl_files_time != "" ) tpl_files_time=tpl_files_time+" ";
    tpl_files_time=tpl_files_time+"M5";
    }         
    
    if(FileIsExist(tpl_files +"-15-.tpl",1)) {
    if ( tpl_files_time != "" ) tpl_files_time=tpl_files_time+" ";
    tpl_files_time=tpl_files_time+"M15";
    }         

    if(FileIsExist(tpl_files +"-30-.tpl",1)) {
    if ( tpl_files_time != "" ) tpl_files_time=tpl_files_time+" ";
    tpl_files_time=tpl_files_time+"M30";
    }     
        
    if(FileIsExist(tpl_files +"-60-.tpl",1)) {
    if ( tpl_files_time != "" ) tpl_files_time=tpl_files_time+" ";
    tpl_files_time=tpl_files_time+"H1";
    }     
    
    if(FileIsExist(tpl_files +"-240-.tpl",1)) {
    if ( tpl_files_time != "" ) tpl_files_time=tpl_files_time+" ";
    tpl_files_time=tpl_files_time+"H4";
    } 
    
    if(FileIsExist(tpl_files +"-1440-.tpl",1)) {
    if ( tpl_files_time != "" ) tpl_files_time=tpl_files_time+" ";
    tpl_files_time=tpl_files_time+"D1";
    } 

    if(FileIsExist(tpl_files +"-10080-.tpl",1)) {
    if ( tpl_files_time != "" ) tpl_files_time=tpl_files_time+" ";
    tpl_files_time=tpl_files_time+"W1";
    } 

    if(FileIsExist(tpl_files +"-43200-.tpl",1)) {
    if ( tpl_files_time != "" ) tpl_files_time=tpl_files_time+" ";
    tpl_files_time=tpl_files_time+"MN1";
    } 
        
    if ( tpl_files_time != "" ) tpl_files_find=true;
      
    
    //Alert(right_bound,"/",WindowFirstVisibleBar());
    
//datetime right=Time[right_bound]+Period()*60;
//shift=iBarShift(ChartSymbol(ChartID()),ChartPeriod(ChartID()),right);   
//shift = (shift+carpan)*-1;
    //datetime right=Time[right_bound]+Period()*60;
    ObjectDelete(OrderLine);
    //ObjectCreate(ChartID(),OrderLine,OBJ_TREND,0,Time[WindowFirstVisibleBar()],OrderOpenPrice(),Time[WindowFirstVisibleBar()]+5*PeriodSeconds(),OrderOpenPrice());
    //ObjectSetInteger(ChartID(),OrderLine,OBJPROP_RAY_RIGHT,0);
    //ObjectSetInteger(ChartID(),OrderLine,OBJPROP_WIDTH,2);
    //ObjectCreate(ChartID(),OrderLine,OBJ_HLINE,0,Time[0],OrderOpenPrice());
      //datetime OrderTime=Time[WindowFirstVisibleBar()]+5*PeriodSeconds();
      datetime OrderTime=Time[WindowFirstVisibleBar()-5];
      ObjectCreate(ChartID(),OrderLine,OBJ_ARROW,0,0,0,0,0);          // Create an arrow
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_ARROWCODE,108);    // Set the arrow code
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_TIME,OrderTime);        // Set time
      ObjectSetDouble(ChartID(),OrderLine,OBJPROP_PRICE,OrderOpenPrice());// Set price
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_ANCHOR,ANCHOR_UPPER);    // Set the arrow code
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_FONTSIZE,8); 
         //ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER);
      OrderLine="FeOrderLoad"+OrderTicket();
      OrderTime=Time[WindowFirstVisibleBar()-20];
      ObjectCreate(ChartID(),OrderLine,OBJ_ARROW,0,0,0,0,0);          // Create an arrow
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_ARROWCODE,108);    // Set the arrow code
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_TIME,OrderTime);        // Set timeOrderTime+20*PeriodSeconds()
      ObjectSetDouble(ChartID(),OrderLine,OBJPROP_PRICE,OrderOpenPrice());// Set price
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_ANCHOR,ANCHOR_UPPER);    // Set the arrow code
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_FONTSIZE,8); 
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_COLOR,clrAliceBlue);      
      if ( tpl_files_find ) ObjectSetInteger(ChartID(),OrderLine,OBJPROP_COLOR,clrDarkGreen);
      if ( tpl_files_per_find ) ObjectSetInteger(ChartID(),OrderLine,OBJPROP_COLOR,clrLimeGreen);
      if ( tpl_files_find ) ObjectSetString(ChartID(),OrderLine,OBJPROP_TEXT,tpl_files_time);
      
         //ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER);

      OrderLine="FeOrderDelete"+OrderTicket();
      OrderTime=Time[WindowFirstVisibleBar()-40];
      ObjectCreate(ChartID(),OrderLine,OBJ_ARROW,0,0,0,0,0);          // Create an arrow
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_ARROWCODE,108);    // Set the arrow code
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_TIME,OrderTime);        // Set timeOrderTime+40*PeriodSeconds()
      ObjectSetDouble(ChartID(),OrderLine,OBJPROP_PRICE,OrderOpenPrice());// Set price
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_ANCHOR,ANCHOR_UPPER);    // Set the arrow code
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_FONTSIZE,8); 
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_COLOR,clrBlack);
         //ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER);
         
                           
         
         
      ChartRedraw(ChartID()); 
      
          
    
    }
    
    }
    
    
    
  
    
    
    }

}



void AutoSL()
{

return;

   for (int m=OrdersTotal(); m>=0; m--)
   {
      if ( OrderSelect(m, SELECT_BY_POS))
      {
         if(OrderSymbol() == Symbol() && OrderMagicNumber() == magic && OrderStopLoss() == 0)
         {
         
         if ( OrderType() == OP_BUY ) {
         OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice()-500*Point,OrderTakeProfit(),-1,clrNONE);
         }
         
         
         if ( OrderType() == OP_SELL ) {
         OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice()+500*Point,OrderTakeProfit(),-1,clrNONE);
         }          
            //RefreshRates();
            //bool success = OrderClose(OrderTicket(), OrderLots(), OrderClosePrice(), 0, Blue);
         }
      }
    }
}
