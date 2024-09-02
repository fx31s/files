//+------------------------------------------------------------------+
//|                                                  SkyperMeter.mq4 |
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
   EventSetTimer(60);
   
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
  
  bool high_low=true;
  
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//---
//Print(lparam);



      
      double obj_prc = ObjectGetDouble(ChartID(),sparam,OBJPROP_PRICE,0);
      
      Print(obj_prc);
      
      
      

if ( sparam == 45 ) {ObjectsDeleteAll();}

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_TREND && StringFind(sparam,"Pr",0) == -1//&& StringFind(sparam,"Fib",0) != -1 //&& StringFind(sparam,"MAL",0) == -1 && lock == false && skyper == false

) {


   int x = (int)lparam;
   int y = (int)dparam;

   int window  = 0;
   datetime dt = 0;
   double   p  = 0;


   if (ChartXYToTimePrice(0, x, y, window, dt, p))
      Print(p);
      



last_select_object=sparam;
string last_select_object_ydk=last_select_object;

ObjectSetInteger(ChartID(),last_select_object,OBJPROP_SELECTABLE,True);
ObjectSetInteger(ChartID(),last_select_object,OBJPROP_SELECTED,True);

//Sleep(500);



          int obj_typ = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TYPE);
          datetime obj_time1 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,0);
          datetime obj_time2 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,1);
          datetime obj_time3 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,2);
          //double obj_prc = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE);
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
          
          int shiftdt=iBarShift(Symbol(),Period(),dt);
          
          
          
         // ObjectMove(ChartID(),last_select_object,1,Time[0],obj_prc1);
         
         
         double yuzde=DivZero(High[shift1]-Low[shift1],100);
         
     
         //shift1 == shiftdt && 
         //if ( ( p < Low[shift1] ||  p < Low[shift_1]+(yuzde*50) ) ) {
         
         
         //if ( ( obj_prc1 < Low[shift1] ||  obj_prc1 < Low[shift_1]+(yuzde*50) ) ) {
         
         if ( high_low == false ) { 
         
         
         high_low=true;
         
         
         
         
         //if ( obj_prc1 < obj_prc2 ) {
         
         //if ( Open[shift1] > Close[shift1] ) {
         
         //Alert("Selam");
         
         ObjectMove(ChartID(),last_select_object,0,Time[shift1],Low[shift1]);
         ObjectMove(ChartID(),last_select_object,1,Time[shift2],High[shift2]);
         
         
         double low_price=Low[shift1];
         double low_priceb=low_price;
         
         double hlbody;
         double ocbody;
         
         for(int i=shift1-1;i>=shift2;i--) {
         
         
         //low_price=low_price-(High[i]-Low[i]);
         //low_priceb=low_price-MathAbs(Open[i]-Close[i]);
         
         hlbody=hlbody+(High[i]-Low[i]);
         ocbody=ocbody+MathAbs(Open[i]-Close[i]);
         
         
         
         //ObjectCreate(ChartID(),"V"+i,OBJ_VLINE,0,Time[i],Ask);
        
         }
         
         low_priceb=low_priceb-ocbody;
         low_price=low_price-hlbody;
         

ObjectDelete(ChartID(),last_select_object+"Prl");
ObjectCreate(ChartID(),last_select_object+"Prl",OBJ_TREND,0,Time[shift1],Low[shift1],Time[shift2]+1000*PeriodSeconds(),Low[shift1]);
ObjectSetInteger(ChartID(),last_select_object+"Prl",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),last_select_object+"Prl",OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),last_select_object+"Prl",OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Prl",OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Prl",OBJPROP_SELECTED,False);

         

ObjectDelete(ChartID(),last_select_object+"Prc");
ObjectCreate(ChartID(),last_select_object+"Prc",OBJ_TREND,0,Time[shift1+100],low_price,Time[0],low_price);
ObjectSetInteger(ChartID(),last_select_object+"Prc",OBJPROP_WIDTH,5);
ObjectSetInteger(ChartID(),last_select_object+"Prc",OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),last_select_object+"Prc",OBJPROP_RAY,True);


ObjectDelete(ChartID(),last_select_object+"Prb");
ObjectCreate(ChartID(),last_select_object+"Prb",OBJ_TREND,0,Time[shift1+100],low_priceb,Time[0],low_priceb);
ObjectSetInteger(ChartID(),last_select_object+"Prb",OBJPROP_WIDTH,5);
ObjectSetInteger(ChartID(),last_select_object+"Prb",OBJPROP_COLOR,clrGreen);
ObjectSetInteger(ChartID(),last_select_object+"Prb",OBJPROP_RAY,True);

return;

         
         
         }
         
         
         
         
         
         //if ( ( p > High[shift1] ||  p > Low[shift_1]+(yuzde*50) ) ) {
         //if ( ( obj_prc1 > High[shift1] ||  obj_prc1 > Low[shift_1]+(yuzde*50) ) ) {
         
         if ( high_low == true ) {
         
         high_low=false;
         
         
         
         //if ( obj_prc1 < obj_prc2 ) {
         
         //if ( Open[shift1] > Close[shift1] ) {
         
         //Alert("Selam");
         
         ObjectMove(ChartID(),last_select_object,0,Time[shift1],High[shift1]);
         ObjectMove(ChartID(),last_select_object,1,Time[shift2],Low[shift2]);
         
         
         double low_price=Low[shift2];
         double low_priceb=low_price;
         
         double high_price=High[shift1];
         double high_priceb=low_price;         
         
         
         double hlbody;
         double ocbody;
         
         for(int i=shift1-1;i>=shift2;i--) {
         
         
         //low_price=low_price-(High[i]-Low[i]);
         //low_priceb=low_price-MathAbs(Open[i]-Close[i]);
         
         hlbody=hlbody+(High[i]-Low[i]);
         ocbody=ocbody+MathAbs(Open[i]-Close[i]);
         
         
         
         //ObjectCreate(ChartID(),"V"+i,OBJ_VLINE,0,Time[i],Ask);
        
         }
         
         high_priceb=high_priceb+ocbody;
         high_price=high_price+hlbody;
         

ObjectDelete(ChartID(),last_select_object+"Prl");
ObjectCreate(ChartID(),last_select_object+"Prl",OBJ_TREND,0,Time[shift1],High[shift1],Time[shift2]+1000*PeriodSeconds(),High[shift1]);
ObjectSetInteger(ChartID(),last_select_object+"Prl",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),last_select_object+"Prl",OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),last_select_object+"Prl",OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Prl",OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Prl",OBJPROP_SELECTED,False);

         

ObjectDelete(ChartID(),last_select_object+"Prc");
ObjectCreate(ChartID(),last_select_object+"Prc",OBJ_TREND,0,Time[shift1+100],high_price,Time[0],high_price);
ObjectSetInteger(ChartID(),last_select_object+"Prc",OBJPROP_WIDTH,5);
ObjectSetInteger(ChartID(),last_select_object+"Prc",OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),last_select_object+"Prc",OBJPROP_RAY,True);


ObjectDelete(ChartID(),last_select_object+"Prb");
ObjectCreate(ChartID(),last_select_object+"Prb",OBJ_TREND,0,Time[shift1+100],high_priceb,Time[0],high_priceb);
ObjectSetInteger(ChartID(),last_select_object+"Prb",OBJPROP_WIDTH,5);
ObjectSetInteger(ChartID(),last_select_object+"Prb",OBJPROP_COLOR,clrGreen);
ObjectSetInteger(ChartID(),last_select_object+"Prb",OBJPROP_RAY,True);


         
         
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
//////////////////////////////////////////////////////////////////////} 

