//+------------------------------------------------------------------+
//|                                                   SkyperBomb.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict



string last_select_object;

double high_price;
double low_price;
int shift_1;
int shift_2;
double price_1;
double price_2;
bool lock=false;

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





if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_TREND && StringFind(sparam,"Exp41.40",0) != -1 && StringFind(sparam,"MAL",0) == -1 && lock == false ) {

string last_select_object_backup=last_select_object;
last_select_object=sparam;

//Alert("Selam");




          int obj_typ = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TYPE);
          datetime obj_time1 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,0);
          datetime obj_time2 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,1);
          datetime obj_time3 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,2);
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
          
          shift_1=shift1;
          shift_2=shift2;
          
          price_1=obj_prc1;
          price_2=obj_prc2;
          
         ObjectSetInteger(ChartID(),last_select_object,OBJPROP_SELECTABLE,True);
         ObjectSetInteger(ChartID(),last_select_object,OBJPROP_SELECTED,True);
         
          

if ( price_1 > price_2 ) {          
         // Alert("Selam");
          
double low_price=Low[shift2];
double high_price=High[shift1];
          

for (int i=shift2;i<shift1;i++) {
//for (int i=shift2;i>shift1;i--) {

//if ( High[i] > high_price ) {high_price=High[i];shift2=i;}
if ( Low[i] < low_price ) {low_price=Low[i];shift2=i;}

}


ObjectMove(ChartID(),last_select_object,1,Time[shift2],low_price);



last_select_object=last_select_object_backup;




double levels=41.5;
string level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,Time[0],low_price);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);


          obj_time1 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,0);
          obj_time2 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,1);
          int shifts1=iBarShift(Symbol(),Period(),obj_time1);
          int shifts2=iBarShift(Symbol(),Period(),obj_time2);

          obj_prc1 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,0);
          obj_prc2 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,1);
          
          
levels=41.6;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_CHANNEL,0,Time[shifts2],obj_prc2,Time[shift2],low_price,Time[shifts2],obj_prc2+20*Point);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrYellow);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);


levels=41.7;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_RECTANGLE,0,Time[shifts2]+500*PeriodSeconds(),obj_prc2,Time[shifts2+500],obj_prc2+20*Point);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_RECTANGLE,0,Bars,obj_prc2,Time[0],obj_prc2+20*Point);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrYellow);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);

          
levels=41.9;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shifts1],obj_prc1,Time[shift2],low_price);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrLimeGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);




          

         
          
          }
          


          
          
          
          
          }
          
          
          
          



if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_TREND && StringFind(sparam,"Exp21.00",0) != -1 && StringFind(sparam,"MAL",0) == -1 && lock == false ) {

string last_select_object_backup=last_select_object;
last_select_object=sparam;




          int obj_typ = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TYPE);
          datetime obj_time1 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,0);
          datetime obj_time2 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,1);
          datetime obj_time3 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,2);
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
          
          shift_1=shift1;
          shift_2=shift2;
          
          price_1=obj_prc1;
          price_2=obj_prc2;
          

if ( price_2 > price_1 ) {          
         // Alert("Selam");
          
double low_price=Low[shift1];
double high_price=High[shift2];
          

for (int i=shift2;i<shift1;i++) {
//for (int i=shift2;i>shift1;i--) {

if ( High[i] > high_price ) {high_price=High[i];shift2=i;}
//if ( Low[i] < low_price ) {low_price=Low[i];shift2=i;}

}


ObjectMove(ChartID(),last_select_object,1,Time[shift2],high_price);

double yuzde = DivZero(high_price-low_price, 100);



double high_prices=high_price;//low_price+(levels*yuzde);
double low_prices=low_price;

double yuzdes = DivZero(high_prices-low_prices, 100);


last_select_object=last_select_object_backup;


double levels=41.4;
string level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],high_prices,Time[shift2]+30*PeriodSeconds(),low_prices-(levels*yuzdes));
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);

levels=41.5;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_prices-(levels*yuzdes),Time[0],low_prices-(levels*yuzdes));
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);

levels=41.8;
level=DoubleToString(levels,2);
levels=41.4;
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_prices-(levels*yuzdes),Time[0],low_prices-(levels*yuzdes));
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrBlue);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);

levels=88.6;
level=DoubleToString(levels,2);
//levels=41.4;
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_prices-(levels*yuzdes),Time[0],low_prices-(levels*yuzdes));
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);


levels=161.8;
level=DoubleToString(levels,2);
//levels=41.4;
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_prices-(levels*yuzdes),Time[0],low_prices-(levels*yuzdes));
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrMaroon);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);

levels=241.4;
level=DoubleToString(levels,2);
//levels=41.4;
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_prices-(levels*yuzdes),Time[0],low_prices-(levels*yuzdes));
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrMaroon);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);

         
          
          }
          


          
          
          
          
          }
          
          
          


if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_TREND && StringFind(sparam,"Exp",0) == -1 && StringFind(sparam,"MAL",0) == -1 && lock == false ) {


last_select_object=sparam;


          int obj_typ = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TYPE);
          datetime obj_time1 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,0);
          datetime obj_time2 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,1);
          datetime obj_time3 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,2);
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
          
          shift_1=shift1;
          shift_2=shift2;
          
          price_1=obj_prc1;
          price_2=obj_prc2;
          

          
          
if ( obj_prc1 > obj_prc2 ) {


ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrLimeGreen);


low_price=Low[shift2];
high_price=High[shift1];


//Alert(low_price,"/",shift2);

//Sleep(100);

for (int i=shift1;i>shift2;i--) {
//for (int i=shift2;i<shift1;i++) {

if ( High[i] > high_price ) {high_price=High[i];shift1=i;}
//if ( Low[i] < low_price ) {low_price=Low[i];shift2=i;}

}

//for (int i=shift1;i>shift2;i--) {
for (int i=shift2;i<shift1;i++) {

//if ( High[i] > high_price ) {high_price=High[i];shift1=i;}
if ( Low[i] < low_price ) {low_price=Low[i];shift2=i;}

}







ObjectMove(ChartID(),last_select_object,0,Time[shift1],High[shift1]);
ObjectMove(ChartID(),last_select_object,1,Time[shift2],Low[shift2]);


double yuzde = DivZero(high_price-low_price, 100);


double levels=21;
string level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,Time[shift2]+30*PeriodSeconds(),low_price+(levels*yuzde));
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);

double high_prices=low_price+(levels*yuzde);
double low_prices=low_price;

double yuzdes = DivZero(high_prices-low_prices, 100);


levels=41.4;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2]+30*PeriodSeconds(),high_prices,Time[shift2]+50*PeriodSeconds(),low_prices-(levels*yuzdes));
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);

levels=41.5;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2]+30*PeriodSeconds(),low_prices-(levels*yuzdes),Time[0],low_prices-(levels*yuzdes));
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);

levels=41.9;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);


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
