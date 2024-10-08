//+------------------------------------------------------------------+
//|                                                      Trinity.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

bool skyper=false;

string last_select_object="";

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


//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer
   //EventSetTimer(60);
   
     /////////////////////////////////
  mnt=Time[0]+1000*PeriodSeconds();
  
  if ( Period() == PERIOD_MN1 ) {
  
  mnt=Time[0];
  
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

if ( sparam == 45 ) ObjectsDeleteAll();

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_TREND) {

string last_select_objectr=sparam;


          int obj_typ = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_TYPE);
          datetime obj_time1 = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_TIME,0);
          datetime obj_time2 = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_TIME,1);
          datetime obj_time3 = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_TIME,2);
          double obj_prc1 = ObjectGetDouble(ChartID(),last_select_objectr,OBJPROP_PRICE,0);
          double obj_prc2 = ObjectGetDouble(ChartID(),last_select_objectr,OBJPROP_PRICE,1);
          double obj_prc3 = ObjectGetDouble(ChartID(),last_select_objectr,OBJPROP_PRICE,2);
          bool obj_fiil = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_FILL);
          double obj_scale = ObjectGetDouble(ChartID(),last_select_objectr,OBJPROP_SCALE);
          double obj_angle = ObjectGetDouble(ChartID(),last_select_objectr,OBJPROP_ANGLE);
          bool obj_ray = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_RAY);
          color obj_color = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_COLOR);
          color obj_bgcolor = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_BGCOLOR);
          int obj_width = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_WIDTH);
          int obj_back = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_BACK);
          
          
          int shift1=iBarShift(Symbol(),Period(),obj_time1);
          int shift2=iBarShift(Symbol(),Period(),obj_time2);
          
          
          
          if ( obj_prc2 > obj_prc1 && StringFind(last_select_objectr,"ExpC",0) == -1 ) {
          

//Alert("Selam");

ObjectMove(ChartID(),last_select_objectr,0,Time[shift1],Low[shift1]);
ObjectMove(ChartID(),last_select_objectr,1,Time[shift2],High[shift2]);

ChartRedraw();

ObjectDelete(ChartID(),last_select_objectr+"ExpC");
ObjectCreate(ChartID(),last_select_objectr+"ExpC",OBJ_TREND,0,Time[shift2],High[shift2],Time[shift2],obj_prc2-((obj_prc2-obj_prc1)/2));
ObjectSetInteger(ChartID(),last_select_objectr+"ExpC",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),last_select_objectr+"ExpC",OBJPROP_COLOR,clrRed);
ObjectSetInteger(ChartID(),last_select_objectr+"ExpC",OBJPROP_RAY,False);

high_price=High[shift2];
low_price=Low[shift1];

double yuzde=DivZero(high_price-low_price,100);
double level=61.8*yuzde;


ObjectDelete(ChartID(),last_select_objectr+"ExpF");
ObjectCreate(ChartID(),last_select_objectr+"ExpF",OBJ_TREND,0,Time[shift2],high_price-level,Time[shift2]+(shift1-shift2)*PeriodSeconds(),high_price-level);
ObjectSetInteger(ChartID(),last_select_objectr+"ExpF",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),last_select_objectr+"ExpF",OBJPROP_COLOR,clrDarkGray);
ObjectSetInteger(ChartID(),last_select_objectr+"ExpF",OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_objectr+"ExpF",OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_objectr+"ExpF",OBJPROP_SELECTED,False);







level=70.7*yuzde;

ObjectDelete(ChartID(),last_select_objectr+"ExpF7");
ObjectCreate(ChartID(),last_select_objectr+"ExpF7",OBJ_TREND,0,Time[shift2],high_price-level,Time[shift2]+(shift1-shift2)*PeriodSeconds(),high_price-level);
ObjectSetInteger(ChartID(),last_select_objectr+"ExpF7",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),last_select_objectr+"ExpF7",OBJPROP_COLOR,clrDarkGray);
ObjectSetInteger(ChartID(),last_select_objectr+"ExpF7",OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_objectr+"ExpF7",OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_objectr+"ExpF7",OBJPROP_SELECTED,False);

level=88.6*yuzde;

ObjectDelete(ChartID(),last_select_objectr+"ExpF8");
ObjectCreate(ChartID(),last_select_objectr+"ExpF8",OBJ_TREND,0,Time[shift2],high_price-level,Time[shift2]+(shift1-shift2)*PeriodSeconds(),high_price-level);
ObjectSetInteger(ChartID(),last_select_objectr+"ExpF8",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),last_select_objectr+"ExpF8",OBJPROP_COLOR,clrDarkGray);
ObjectSetInteger(ChartID(),last_select_objectr+"ExpF8",OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_objectr+"ExpF8",OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_objectr+"ExpF8",OBJPROP_SELECTED,False);







          }
          

          if ( obj_prc1 > obj_prc2 && StringFind(last_select_objectr,"ExpC",0) != -1 ) {
          

//Alert("Selam");

ObjectMove(ChartID(),last_select_objectr,0,Time[shift1],High[shift1]);
ObjectMove(ChartID(),last_select_objectr,1,Time[shift2],Low[shift2]);

ChartRedraw();

double yuzde=DivZero(high_price-low_price,100);

double level=DivZero(high_price-Low[shift2],yuzde);

Comment(level);

double yuzdes=DivZero(High[shift1]-Low[shift2],100);




if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_SELECTED) == True ) {


ObjectDelete(ChartID(),last_select_objectr+"ExpFn");
ObjectCreate(ChartID(),last_select_objectr+"ExpFn",OBJ_TREND,0,Time[shift2],high_price+level*yuzde,Time[shift2]+(1000)*PeriodSeconds(),high_price+level*yuzde);
ObjectSetInteger(ChartID(),last_select_objectr+"ExpFn",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),last_select_objectr+"ExpFn",OBJPROP_COLOR,clrDarkGray);
ObjectSetInteger(ChartID(),last_select_objectr+"ExpFn",OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_objectr+"ExpFn",OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_objectr+"ExpFn",OBJPROP_SELECTED,False);

double c=high_price+(level*yuzde);
double x=low_price;
double yuzdec=DivZero(c-x,100);

ObjectDelete(ChartID(),last_select_objectr+"ExpD");
ObjectCreate(ChartID(),last_select_objectr+"ExpD",OBJ_TREND,0,Time[shift2],x,Time[shift2]+(shift1-shift2)*PeriodSeconds(),x-level*yuzdec);
ObjectSetInteger(ChartID(),last_select_objectr+"ExpD",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),last_select_objectr+"ExpD",OBJPROP_COLOR,clrLimeGreen);
ObjectSetInteger(ChartID(),last_select_objectr+"ExpD",OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_objectr+"ExpD",OBJPROP_BACK,True);

ObjectDelete(ChartID(),last_select_objectr+"ExpDd");
ObjectCreate(ChartID(),last_select_objectr+"ExpDd",OBJ_TREND,0,Time[shift2]+(shift1-shift2)*PeriodSeconds(),x-level*yuzdec,Time[shift2]+(1000)*PeriodSeconds(),x-level*yuzdec);
ObjectSetInteger(ChartID(),last_select_objectr+"ExpDd",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),last_select_objectr+"ExpDd",OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),last_select_objectr+"ExpDd",OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_objectr+"ExpDd",OBJPROP_BACK,True);




ObjectDelete(ChartID(),last_select_objectr+"ExpR");
ObjectCreate(ChartID(),last_select_objectr+"ExpR",OBJ_TREND,0,Time[shift2],Low[shift2],Time[shift2]+(shift1-shift2)*PeriodSeconds(),Low[shift2]+level*yuzdes);
ObjectSetInteger(ChartID(),last_select_objectr+"ExpR",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),last_select_objectr+"ExpR",OBJPROP_COLOR,clrBlue);
ObjectSetInteger(ChartID(),last_select_objectr+"ExpR",OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_objectr+"ExpR",OBJPROP_BACK,True);




}




          }
          
          
          
          
          
          
          
          
          
          
          }
          
   
  }
//+------------------------------------------------------------------+
/////////////////////////////////////////////////////////////////////////////////////////
// Divide Zero Hatası için formül.
/////////////////////////////////////////////////////////////////////////////////////////
double DivZero(double n, double d)
{
if (d==0) return(0);  else return(n/d);
} 