//+------------------------------------------------------------------+
//|                                                        Skyper5.0 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

bool skyper=false;
bool mode=false;
bool eqsys=true;

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
   
   

bool oto_system=false;

double mode_number=0;

   
   
   
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

double gericekilme=21;
double gericekilme1=21;
double gericekilme2=13;

bool auto_mode=false;


int mode_off_shift=-1;
int mode_hl_shift=-1;







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


int magic=0;


bool wick=false;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer
   //EventSetTimer(60);
   
   ChartSetInteger(ChartID(),CHART_SHOW_ASK_LINE,True);
   ChartSetInteger(ChartID(),CHART_SHOW_BID_LINE,True);   
   
        /////////////////////////////////
  mnt=Time[0]+1000*PeriodSeconds();
  
  if ( Period() == PERIOD_MN1 ) {
  
  mnt=Time[0];
  
  }
  ////////////////////////////
   
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


Print(sparam);


if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_TREND && StringFind(sparam,"MP",0) == -1 && StringFind(sparam,"HP",0) == -1 && StringFind(sparam,"LP",0) == -1 && StringFind(sparam,"CP",0) == -1 &&  StringFind(sparam,"Exp",0) == -1 && StringFind(sparam,"MAL",0) == -1 && lock == false && skyper == false && eqsys == true ) {

RefreshRates();
ChartRedraw();
WindowRedraw();


//if ( mode_off_shift != 0 && sparam != last_select_object ) mode=true;


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



ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrCrimson);

high_price=Low[shift2];
low_price=Low[shift1];





for (int i=shift1;i>shift2;i--) {
//for (int i=shift2;i<shift1;i++) {

//if ( High[i] > high_price ) {high_price=High[i];shift2=i;}
if ( Low[i] < low_price ) {low_price=Low[i];shift1=i;}

}


/*
//for (int i=shift1;i>shift2;i--) {
for (int i=shift2;i<shift1;i++) {

if ( High[i] > high_price ) {high_price=High[i];shift2=i;}
//if ( Low[i] < low_price ) {low_price=Low[i];shift2=i;}

}
*/

double yuzde=DivZero(high_price-low_price,100);



ObjectMove(ChartID(),last_select_object,0,Time[shift1],Low[shift1]);
ObjectMove(ChartID(),last_select_object,1,Time[shift2],Low[shift2]);



double levels=100;
string level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],high_price+levels*yuzde,mnt,high_price+levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);

levels=100.11;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],low_price+levels*yuzde,mnt,low_price+levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrGreenYellow);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,10);



levels=100.1;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],low_price+levels*yuzde,mnt,low_price+levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);



levels=79;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],high_price+levels*yuzde,mnt,high_price+levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);


levels=87;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],high_price+levels*yuzde,mnt,high_price+levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);



}   else {






ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrLimeGreen);

high_price=High[shift1];
low_price=High[shift2];





for (int i=shift1;i>shift2;i--) {
//for (int i=shift2;i<shift1;i++) {

if ( High[i] > high_price ) {high_price=High[i];shift1=i;}
//if ( Low[i] < low_price ) {low_price=Low[i];shift2=i;}

}
/*
//for (int i=shift1;i>shift2;i--) {
for (int i=shift2;i<shift1;i++) {

//if ( High[i] > high_price ) {high_price=High[i];shift1=i;}
if ( Low[i] < low_price ) {low_price=Low[i];shift2=i;}

}
*/




ObjectMove(ChartID(),last_select_object,0,Time[shift1],High[shift1]);
ObjectMove(ChartID(),last_select_object,1,Time[shift2],High[shift2]);



double yuzde=DivZero(high_price-low_price,100);       




double levels=100;
string level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],high_price-levels*yuzde,mnt,high_price-levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);

levels=100.11;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],high_price-levels*yuzde,mnt,high_price-levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrGreenYellow);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,10);



levels=100.1;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],low_price-levels*yuzde,mnt,low_price-levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);



levels=79;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],low_price-levels*yuzde,mnt,low_price-levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);

levels=87;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],low_price-levels*yuzde,mnt,low_price-levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);



}
          
          
}
          


if ( sparam == 18 ) {

if ( eqsys == false ) {
skyper=false;
eqsys=true;
} else {
if ( wick == false ) skyper=true;
eqsys=false;
}

Comment("EqSystem:",eqsys);


}


if ( sparam == 19 ) {

if ( ChartGetInteger(ChartID(),CHART_SHOW_TRADE_LEVELS,0) == True ) {ChartSetInteger(ChartID(),CHART_SHOW_TRADE_LEVELS,0,False); } else {ChartSetInteger(ChartID(),CHART_SHOW_TRADE_LEVELS,0,True);}

}


 if(id==CHARTEVENT_CLICK && wick==true)
     {
      //--- Prepare variables
      int      x     =(int)lparam;
      int      y     =(int)dparam;
      datetime dt    =0;
      double   price =0;
      int      window=0;
      //--- Convert the X and Y coordinates in terms of date/time
      if(ChartXYToTimePrice(0,x,y,window,dt,price))
        {
        
        
        

RefreshRates();
ChartRedraw();
WindowRedraw();


//if ( mode_off_shift != 0 && sparam != last_select_object ) mode=true;


last_select_object=sparam;



          datetime obj_time1 = dt;//ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME);
          
         int shift1=iBarShift(Symbol(),Period(),obj_time1);
         

          
          
          if ( Open[shift1] >= Close[shift1] && price >= Low[shift1] && price && price <= High[shift1] ) {
          
          double eqh=DivZero(High[shift1]-Open[shift1],2);
          double eql=DivZero(Close[shift1]-Low[shift1],2);
          

datetime levels=dt;
string level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"ExpWick"+level);
ObjectCreate(ChartID(),last_select_object+"ExpWick"+level,OBJ_TREND,0,Time[shift1],Low[shift1]+eql,mnt,Low[shift1]+eql);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_WIDTH,1);

levels=dt;
level=DoubleToString(levels,2)+"s";
ObjectDelete(ChartID(),last_select_object+"ExpWick"+level);
ObjectCreate(ChartID(),last_select_object+"ExpWick"+level,OBJ_TREND,0,Time[shift1],High[shift1]-eqh,mnt,High[shift1]-eqh);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_WIDTH,1);



          
          
         
          }
          

          if ( Close[shift1] > Open[shift1] && price >= Low[shift1] && price && price <= High[shift1] ) {
          
          double eqh=DivZero(High[shift1]-Close[shift1],2);
          double eql=DivZero(Open[shift1]-Low[shift1],2);
          

datetime levels=dt;//0;
string level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"ExpWick"+level);
ObjectCreate(ChartID(),last_select_object+"ExpWick"+level,OBJ_TREND,0,Time[shift1],Low[shift1]+eql,mnt,Low[shift1]+eql);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_WIDTH,1);

levels=dt;//1;
level=DoubleToString(levels,2)+"s";
ObjectDelete(ChartID(),last_select_object+"ExpWick"+level);
ObjectCreate(ChartID(),last_select_object+"ExpWick"+level,OBJ_TREND,0,Time[shift1],High[shift1]-eqh,mnt,High[shift1]-eqh);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_WIDTH,1);          
         
          }

         
         
         
         
         
         
        }
        
        }
        
        
        
if ( sparam == 16 ) { // Q

ObjectsDeleteAlls(ChartID(),"Wick",-1,-1);
wick=false;

}

if ( sparam == 17 ) {

if ( wick == true ) {wick=false;}else{wick=true;}

Comment("Wick:",wick);




}


        
        

if ( sparam == 45 ) ObjectsDeleteAll();


if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_TREND && StringFind(sparam,"MP",0) == -1 && StringFind(sparam,"HP",0) == -1 && StringFind(sparam,"LP",0) == -1 && StringFind(sparam,"CP",0) == -1 &&  StringFind(sparam,"Exp",0) == -1 && StringFind(sparam,"MAL",0) == -1 && lock == false && skyper == true) {

RefreshRates();
ChartRedraw();
WindowRedraw();


//if ( mode_off_shift != 0 && sparam != last_select_object ) mode=true;


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
          


if ( obj_prc2 > obj_prc1 ) {

//Alert("Selam");



ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrCrimson);

high_price=High[shift2];
low_price=Low[shift1];




/*
for (int i=shift2;i>=shift1;i--) {
//for (int i=shift2;i<shift1;i++) {

//if ( High[i] > high_price ) {high_price=High[i];shift2=i;}
if ( Low[i] < low_price ) {low_price=Low[i];shift1=i;}

}
*/



/*
//for (int i=shift1;i>shift2;i--) {
for (int i=shift2;i<shift1;i++) {

if ( High[i] > high_price ) {high_price=High[i];shift2=i;}
//if ( Low[i] < low_price ) {low_price=Low[i];shift2=i;}

}

*/
double yuzde=DivZero(high_price-low_price,100);



ObjectMove(ChartID(),last_select_object,1,Time[shift2],High[shift2]);
ObjectMove(ChartID(),last_select_object,0,Time[shift1],Low[shift1]);

double levels=61.8;
string level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],high_price+levels*yuzde,mnt,high_price+levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);

levels=38.2;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],high_price-levels*yuzde,mnt,high_price-levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrOrangeRed);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);




levels=122.4;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],high_price+levels*yuzde,mnt,high_price+levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);


levels=13;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],low_price-levels*yuzde,mnt,low_price-levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);


levels=0;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],low_price-levels*yuzde,mnt,low_price-levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);

levels=-100;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],low_price-levels*yuzde,mnt,low_price-levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);






        //if ( price2 > price1 ) {
        if ( obj_prc2 > obj_prc1 ) {
        
       double tepe_fiyats=High[shift2];
        double dip_fiyats=Low[shift1];
        
        



                 

//Alert("Selam");


  double high_price=tepe_fiyats;
   double low_price=dip_fiyats;
   double yuzde = DivZero(high_price-low_price, 100);
   
   
   double eq=low_price+yuzde*50; // 50
   
   double level45=low_price+yuzde*45; // 50
   double level55=low_price+yuzde*55; // 50
   
   double level70=low_price+yuzde*70; // 50
   double level79=low_price+yuzde*79; // 50
   double level21=low_price+yuzde*21; // 50
   double level30=low_price+yuzde*30; // 50

   double level168=yuzde*16.18; // 50
   double level130=yuzde*13; // 50
   double level272=yuzde*27.2; // 50
   double level414=yuzde*41.4; // 50
   double level618=yuzde*61.8; // 50 
   double level886=yuzde*88.6; // 50   
   
   double level0=0;
   double level100=0; 
  string namet=last_select_object;
  datetime time1=obj_time1;
  double level=level168;
  string levels="d168";       
  string names=namet +" Flag ";
  
  /*
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,low_price-level,Time[0],low_price-level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrYellow);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);   


  level=eq;
  levels="deq";    
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,eq,Time[0],eq);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrDarkGray);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);
     
  level=level130;
  levels="d130";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,low_price-level,Time[0],low_price-level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrRoyalBlue);

  level=level272;
  levels="d272";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,low_price-level,Time[0],low_price-level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrMediumBlue);

  level=level414;
  levels="d414";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,low_price-level,Time[0],low_price-level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrTurquoise);

  level=level618;
  levels="d618";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,low_price-level,Time[0],low_price-level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrMaroon);

  level=level886;
  levels="d886";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,low_price-level,Time[0],low_price-level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrBrown);
  

  level=level886;
  levels="d886sl";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,low_price-(level*2),Time[0],low_price-(level*2));
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrCrimson);*/

         string name=namet + " FE SL 200";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,dip_fiyats-200*Point,Time[0],dip_fiyats-200*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrRed); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,1);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0);
         ObjectSetInteger(0,name,OBJPROP_BACK,1);
         ObjectDelete(0,name);

        double Fark=(((tepe_fiyats-dip_fiyats)*12)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*4.5)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark);  
        //double prc110=dip_fiyats+Fark*Point;
        
        //double SL11=dip_fiyats+Fark*Point;       
         
         name=namet + " FE 11";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,dip_fiyats+Fark*Point,Time[0],dip_fiyats+Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrBlue); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_SOLID);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);
         ObjectDelete(0,name);

        Fark=(((tepe_fiyats-dip_fiyats)*9)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*4.5)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark);  
        //prc80=dip_fiyats+Fark*Point;
        
        //SL8=dip_fiyats+Fark*Point;       
         
         name=namet + " FE 8";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,dip_fiyats+Fark*Point,Time[0],dip_fiyats+Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrRed); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_SOLID);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);
         ObjectDelete(0,name);


        Fark=(((tepe_fiyats-dip_fiyats)*6)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*4.5)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark); 
        //prc50=dip_fiyats+Fark*Point;
        
        //SL5=dip_fiyats+Fark*Point;        
         
         name=namet + " FE 5";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,dip_fiyats+Fark*Point,Time[0],dip_fiyats+Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrBlack); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_SOLID);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);   
         ObjectDelete(0,name);


        Fark=(((tepe_fiyats-dip_fiyats)*4)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*4)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark);
        //TP4=tepe_fiyats-Fark;
        //prc30=dip_fiyats+Fark*Point;
        
        //ENTRY3=dip_fiyats+Fark*Point;
        
         name=namet + " FE 3.0";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,dip_fiyats+Fark*Point,Time[0],dip_fiyats+Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrRed); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,1);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);         
         ObjectDelete(0,name);
  
  }
  

}



if ( obj_prc1 > obj_prc2 ) {

//Alert("Selam");



ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrCrimson);

high_price=High[shift1];
low_price=Low[shift2];




/*
for (int i=shift2;i>=shift1;i--) {
//for (int i=shift2;i<shift1;i++) {

//if ( High[i] > high_price ) {high_price=High[i];shift2=i;}
if ( Low[i] < low_price ) {low_price=Low[i];shift1=i;}

}
*/



/*
//for (int i=shift1;i>shift2;i--) {
for (int i=shift2;i<shift1;i++) {

if ( High[i] > high_price ) {high_price=High[i];shift2=i;}
//if ( Low[i] < low_price ) {low_price=Low[i];shift2=i;}

}

*/
double yuzde=DivZero(high_price-low_price,100);



ObjectMove(ChartID(),last_select_object,0,Time[shift1],High[shift1]);
ObjectMove(ChartID(),last_select_object,1,Time[shift2],Low[shift2]);

double levels=61.8;
string level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],low_price-levels*yuzde,mnt,low_price-levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);


levels=38.2;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],low_price+levels*yuzde,mnt,low_price+levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrOrangeRed);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);




levels=122.4;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],low_price-levels*yuzde,mnt,low_price-levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);


levels=13;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],high_price+levels*yuzde,mnt,high_price+levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);


levels=0;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],high_price+levels*yuzde,mnt,high_price+levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);


levels=-100;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],high_price+levels*yuzde,mnt,high_price+levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);




        if ( obj_prc1 > obj_prc2 ) {
        
        
        
        double tepe_fiyats=High[shift1];
        double dip_fiyats=Low[shift2];
        
        

        
        //Alert("Selam");

   double high_price=tepe_fiyats;
   double low_price=dip_fiyats;
   double yuzde = DivZero(high_price-low_price, 100);
   
   
   double eq=low_price+yuzde*50; // 50
   
   double level45=low_price+yuzde*45; // 50
   double level55=low_price+yuzde*55; // 50
   
   double level70=low_price+yuzde*70; // 50
   double level79=low_price+yuzde*79; // 50
   double level21=low_price+yuzde*21; // 50
   double level30=low_price+yuzde*30; // 50

   double level168=yuzde*16.18; // 50
   double level130=yuzde*13; // 50
   double level272=yuzde*27.2; // 50
   double level414=yuzde*41.4; // 50
   double level618=yuzde*61.8; // 50 
   double level886=yuzde*88.6; // 50   
   
   double level0=0;
   double level100=0; 
  string namet=last_select_object;
  datetime time1=obj_time1;
  double level=level168;
  string levels="u168";       
  string names=namet +" Flag ";
  
/*
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,high_price+level,Time[0],high_price+level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrYellow);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);  
    
  
  level=eq;
  levels="ueq";    
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,eq,Time[0],eq);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrDarkGray);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);   
     
  level=level130;
  levels="u130";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,high_price+level,Time[0],high_price+level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrRoyalBlue);

  level=level272;
  levels="u272";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,high_price+level,Time[0],high_price+level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrMediumBlue);

  level=level414;
  levels="u414";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,high_price+level,Time[0],high_price+level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrTurquoise);

  level=level618;
  levels="u618";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,high_price+level,Time[0],high_price+level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrMaroon);

  level=level886;
  levels="u886";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,high_price+level,Time[0],high_price+level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrBrown);


  level=level886;
  levels="u886sl";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,high_price+(level*2),Time[0],high_price+(level*2));
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrCrimson);*/
  
  

         string name=namet + " FE SL 200";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,tepe_fiyats+200*Point,Time[0],tepe_fiyats+200*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrRed); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,1);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectDelete(0,name);

        double Fark=(((tepe_fiyats-dip_fiyats)*12)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*4.5)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark);         
         double prc110 = tepe_fiyats-Fark*Point;
         double SL11 = tepe_fiyats-Fark*Point;
         
         name=namet + " FE 11";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,tepe_fiyats-Fark*Point,Time[0],tepe_fiyats-Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrBlue); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_SOLID);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectDelete(0,name);

        Fark=(((tepe_fiyats-dip_fiyats)*9)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*4.5)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark);         
         //prc80 = tepe_fiyats-Fark*Point;
         //SL8 = tepe_fiyats-Fark*Point;
         
         name=namet + " FE 8";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,tepe_fiyats-Fark*Point,Time[0],tepe_fiyats-Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrRed); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_SOLID);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectDelete(0,name);
                             
        Fark=(((tepe_fiyats-dip_fiyats)*6)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*4.5)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark); 
        //prc50 = tepe_fiyats-Fark*Point;
        
         //SL5 = tepe_fiyats-Fark*Point;       
         
         name=namet + " FE 5";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,tepe_fiyats-Fark*Point,Time[0],tepe_fiyats-Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrBlack); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_SOLID);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectDelete(0,name);


        Fark=(((tepe_fiyats-dip_fiyats)*4)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*4)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark);
        //TP4=tepe_fiyats-Fark;
        //prc30 = tepe_fiyats-Fark*Point;
        
        //Alert("Selam");
        //ENTRY3=tepe_fiyats-Fark*Point;        
        
        
        
         name=namet + " FE 3.0";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,tepe_fiyats-Fark*Point,Time[0],tepe_fiyats-Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrRed); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,1);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0);          
         ObjectDelete(0,name);  
  
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
//////////////////////////////////////////////////////////////////////} 
// Thank You For Life 26.01.2024



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
