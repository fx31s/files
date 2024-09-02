//+------------------------------------------------------------------+
//|                                                  SkyperHedge.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict



//## Skyper Bomb 13-01-2024



bool skyper=false;

string last_select_object="Horizontal Line 46972";

double high_price;
double low_price;
int shift_1;
int shift_2;
double price_1;
double price_2;
bool lock=false;

bool fibo_tp_level=false;
color tp_level=clrBlack;



     long sinyal_charid=ChartID();
     long currChart=ChartID();
     
   string sym=Symbol();
   ENUM_TIMEFRAMES per=Period();
   
   
   
   
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
extern int MC_W=20;
/////////////////////////////////////////////////////////
double ma_high=-1;
double ma_low=1000000;


double ma_level[1001];


int swing_power=34;


double Ortalama;

datetime mnt;


double sell_entry;
double sell_tp;
double sell_sl;

double buy_entry;
double buy_tp;
double buy_sl;


//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer
   //EventSetTimer(60);
   
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


if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_TREND //&& StringFind(sparam,"Fib",0) != -1 && StringFind(sparam,"MAL",0) == -1 && lock == false && skyper == false

) {


last_select_object=sparam;
string last_select_object_ydk=last_select_object;



          int obj_typ = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TYPE);
          datetime obj_time1 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,0);
          datetime obj_time2 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,1);
          datetime obj_time3 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,2);
          double obj_prc = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE);
          double obj_prc1 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,0);
          double obj_prc2 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,1);
          double obj_prc3 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,2);
          bool obj_fiil = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_FILL);
          double obj_scale = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_SCALE);
          double obj_angle = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_ANGLE);
          bool obj_ray = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_RAY);
          color obj_color = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_COLOR);
          color obj_bgcolor = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_BGCOLOR);
          int obj_width = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_WIDTH);
          int obj_back = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_BACK);
          
          
          int shift1=iBarShift(Symbol(),Period(),obj_time1);
          int shift2=iBarShift(Symbol(),Period(),obj_time2);
          
          
          ObjectMove(ChartID(),last_select_object,1,Time[0],obj_prc1);
          
          double sell_profit;
          double buy_profit;
          
          
          if ( obj_prc1 >= buy_sl ) {
          buy_profit=obj_prc1-buy_entry;
          }
          
          
          if ( obj_prc1 <= sell_sl ) {
          sell_profit=sell_entry-obj_prc1;
          }   
                 
          
          if ( obj_prc1 < sell_tp ) {
          
          sell_profit=sell_entry-sell_tp;
          
          }
          
          if ( obj_prc1 > buy_tp ) {
          
          buy_profit=buy_tp-buy_entry;
          
          }
          

          if ( obj_prc1 <= buy_sl ) {
          
          buy_profit=buy_sl-buy_entry;
          
          }
          


          
                    
          
          
                    

          if ( obj_prc1 >= sell_sl ) {
          
          sell_profit=sell_entry-sell_sl;
          
          }
                 
                 
                           
          
          
          Comment("Price:",obj_prc1,"\n Sell Profit:",sell_profit,"\n Buy Profit:",buy_profit,"\n Profit:",buy_profit+sell_profit);
          
          
          
          
          
          last_select_object=last_select_object_ydk;

          
          
          }

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_RECTANGLE //&& StringFind(sparam,"Fib",0) != -1 && StringFind(sparam,"MAL",0) == -1 && lock == false && skyper == false

) {


last_select_object=sparam;
string last_select_object_ydk=last_select_object;



          int obj_typ = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TYPE);
          datetime obj_time1 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,0);
          datetime obj_time2 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,1);
          datetime obj_time3 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,2);
          double obj_prc = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE);
          double obj_prc1 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,0);
          double obj_prc2 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,1);
          double obj_prc3 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,2);
          bool obj_fiil = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_FILL);
          double obj_scale = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_SCALE);
          double obj_angle = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_ANGLE);
          bool obj_ray = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_RAY);
          color obj_color = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_COLOR);
          color obj_bgcolor = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_BGCOLOR);
          int obj_width = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_WIDTH);
          int obj_back = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_BACK);
          
          
          int shift1=iBarShift(Symbol(),Period(),obj_time1);
          int shift2=iBarShift(Symbol(),Period(),obj_time2);
          
          
if ( StringFind(last_select_object,"Sell",0) != -1 ) {

double alan=(obj_prc1-obj_prc2);


sell_tp=obj_prc2;
sell_sl=obj_prc1;

Comment("Sell:",alan/Point,"\n TP:",sell_tp,"\n SL,",sell_sl);


}      



if ( StringFind(last_select_object,"Buy",0) != -1 ) {

double alan=(obj_prc2-obj_prc1);



buy_tp=obj_prc2;
buy_sl=obj_prc1;

Comment("Buy:",alan/Point,"\n TP:",buy_tp,"\n SL,",buy_sl);


}      


    
          
          
          

last_select_object=last_select_object_ydk;



          
          
          }
          
          
          

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_HLINE //&& StringFind(sparam,"Fib",0) != -1 && StringFind(sparam,"MAL",0) == -1 && lock == false && skyper == false

) {


last_select_object=sparam;




          int obj_typ = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TYPE);
          datetime obj_time1 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,0);
          datetime obj_time2 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,1);
          datetime obj_time3 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,2);
          double obj_prc = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE);
          double obj_prc1 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,0);
          double obj_prc2 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,1);
          double obj_prc3 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,2);
          bool obj_fiil = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_FILL);
          double obj_scale = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_SCALE);
          double obj_angle = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_ANGLE);
          bool obj_ray = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_RAY);
          color obj_color = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_COLOR);
          color obj_bgcolor = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_BGCOLOR);
          int obj_width = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_WIDTH);
          int obj_back = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_BACK);
          
          
          int shift1=iBarShift(Symbol(),Period(),obj_time1);
          int shift2=iBarShift(Symbol(),Period(),obj_time2);
          
          
         // Alert("Sparam:",sparam,"/",obj_prc1);
          

ObjectDelete(ChartID(),last_select_object+"Prc");
ObjectCreate(ChartID(),last_select_object+"Prc",OBJ_TREND,0,Time[50],obj_prc-20000*Point,Time[20],obj_prc-20000*Point);
ObjectSetInteger(ChartID(),last_select_object+"Prc",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),last_select_object+"Prc",OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),last_select_object+"Prc",OBJPROP_RAY,True);


          

ObjectDelete(ChartID(),last_select_object+"Buy");
ObjectCreate(ChartID(),last_select_object+"Buy",OBJ_RECTANGLE,0,Time[50],obj_prc-10000*Point,Time[20],obj_prc+10000*Point);
ObjectSetInteger(ChartID(),last_select_object+"Buy",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),last_select_object+"Buy",OBJPROP_COLOR,clrBlue);
ObjectSetInteger(ChartID(),last_select_object+"Buy",OBJPROP_RAY,True);


ObjectDelete(ChartID(),last_select_object+"Sell");
ObjectCreate(ChartID(),last_select_object+"Sell",OBJ_RECTANGLE,0,Time[80],obj_prc+10000*Point,Time[50],obj_prc-10000*Point);
ObjectSetInteger(ChartID(),last_select_object+"Sell",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),last_select_object+"Sell",OBJPROP_COLOR,clrRed);
ObjectSetInteger(ChartID(),last_select_object+"Sell",OBJPROP_RAY,True);

           
sell_entry=obj_prc;
sell_tp=obj_prc-10000*Point;
sell_sl=obj_prc+10000*Point;

buy_entry=obj_prc;
buy_tp=obj_prc+10000*Point;
buy_sl=obj_prc-10000*Point;           

          
          
          
          }
          
   
  }
//+------------------------------------------------------------------+
