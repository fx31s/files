//+------------------------------------------------------------------+
//|                                                         SkEa.mq4 |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict


int left_bar_min=20;
int right_bar_min=10;
int end_bar=11;
double last_low_price=10000000;
double last_high_price=-1;

double gericekilme=21;
double gericekilme1=21;
double gericekilme2=13;

datetime mnt;

input bool highlow_mode=true;

datetime time_refresh=-1;



//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
  
  

     /////////////////////////////////
  mnt=Time[0]+1000*PeriodSeconds();
  
  if ( Period() == PERIOD_MN1 ) {
  
  mnt=Time[0];
  
  }
  ////////////////////////////
  
 
//--- create timer
   //EventSetTimer(60);
   

OnTick(); 

   
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

if ( time_refresh != Time[1] ) {

   ObjectsDeleteAll();
   
   ObjectDelete("Lable1");
   ObjectCreate("Lable1",OBJ_LABEL,0,0,1.0);
   ObjectSet("Lable1", OBJPROP_CORNER, 0);
   ObjectSet("Lable1", OBJPROP_XDISTANCE, 10);
   ObjectSet("Lable1", OBJPROP_YDISTANCE, 10);
   //txt1="Ne Vecime 1.0"+ "("+ kalan_gun+")";
   string txt1="NE VECİME Ultra Pro";
   ObjectSetText("Lable1",txt1,20,"Nirmala UI",Yellow);
//-------------------------
ObjectCreate("Lable",OBJ_LABEL,0,0,1.0);
   ObjectSet("Lable", OBJPROP_CORNER, 0);
   ObjectSet("Lable", OBJPROP_XDISTANCE, 10); 
   ObjectSet("Lable", OBJPROP_YDISTANCE, 75);
   string txt="METEHAN DURAN"; 
   ObjectSetText("Lable",txt,15,"Nirmala UI",Yellow); 
   ChartSetInteger(0,CHART_SHOW_GRID,false);
   

   if ( highlow_mode == true ) HighLow();
   if ( highlow_mode == false ) LowHigh();
   
time_refresh=Time[1];


}
   
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


void LowHigh() {


   int t=WindowFirstVisibleBar();
   
   for (int i=t;i>end_bar;i--) {
   
   //////////////////////////////////////////////////////////////
   
   double low_price=Low[i];
   bool low_find_left=false;
   bool low_find_right=false;
   last_high_price=-1;
   
   
   for (int l=i+1;l<i+left_bar_min;l++) {
   
   if ( low_price > Low[l] ) low_find_left=true;
   
   }
   
 /*
   if ( low_find_left == false ) {
   
   ObjectCreate(ChartID(),"V"+i,OBJ_VLINE,0,Time[i],Ask);
   
   }*/
   
   for (int l=i-1;l>i-right_bar_min;l--) {
   
   if ( low_price > Low[l] ) low_find_right=true;
   
   }
   
   /*
   if ( low_find_right == false ) {
   
   ObjectCreate(ChartID(),"V"+i,OBJ_VLINE,0,Time[i],Ask);
   
   }*/
   
   if ( low_find_left == false && low_find_right == false && low_price < last_low_price ) {
   
   last_low_price=low_price;
   
   //ObjectCreate(ChartID(),"V"+i,OBJ_VLINE,0,Time[i],Ask);
   //ObjectSetInteger(ChartID(),"V"+i,OBJPROP_BACK,True);
   
   ObjectDelete(ChartID(),"V");
   ObjectCreate(ChartID(),"V",OBJ_VLINE,0,Time[i],Ask);
   ObjectSetInteger(ChartID(),"V",OBJPROP_BACK,True);
   
   ObjectDelete(ChartID(),"H");
   ObjectCreate(ChartID(),"H",OBJ_HLINE,0,Time[i],low_price);
   ObjectSetInteger(ChartID(),"H",OBJPROP_BACK,True);
   
   
   ////////////////////////////////////////////////////////////////
   

   
   for (int ii=i;ii>end_bar;ii--) {
   
   double high_price=High[ii];
   bool high_find_left=false;
   bool high_find_right=false;   
   
  for (int l=ii+1;l<ii+left_bar_min;l++) {
   
   if ( high_price < High[l] ) high_find_left=true;
   
   }
   
   for (int l=ii-1;l>ii-right_bar_min;l--) {
   
   if ( high_price < High[l] ) high_find_right=true;
   
   }
   
   
   if ( high_find_left == false && high_find_right == false && high_price > last_high_price 
   ) {
   
   last_high_price=high_price;
   
   
   ObjectDelete(ChartID(),"Vh");
   ObjectCreate(ChartID(),"Vh",OBJ_VLINE,0,Time[ii],Ask);
   ObjectSetInteger(ChartID(),"Vh",OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"Vh",OBJPROP_COLOR,clrBlue);
   /*
   ObjectDelete(ChartID(),i+"Hh");
   ObjectCreate(ChartID(),i+"Hh",OBJ_HLINE,0,Time[ii],high_price);
   ObjectSetInteger(ChartID(),i+"Hh",OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),i+"Hh",OBJPROP_COLOR,clrBlue);
   
   
   ObjectDelete(ChartID(),i+"T");
   ObjectCreate(ChartID(),i+"T",OBJ_TREND,0,Time[i],low_price,Time[ii],high_price);
   ObjectSetInteger(ChartID(),i+"T",OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),i+"T",OBJPROP_COLOR,clrLightGray);
   ObjectSetInteger(ChartID(),i+"T",OBJPROP_RAY,False);   */

   ObjectDelete(ChartID(),"T");
   ObjectCreate(ChartID(),"T",OBJ_TREND,0,Time[i],low_price,Time[ii],high_price);
   ObjectSetInteger(ChartID(),"T",OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"T",OBJPROP_COLOR,clrLightGray);
   ObjectSetInteger(ChartID(),"T",OBJPROP_RAY,False);   
   
   
   double yuzde=DivZero(high_price-low_price,100);
   
   double yuzde21=yuzde*21;
   double yuzde13=yuzde*13;
   
double alan21=(high_price-low_price)-yuzde21;
double alan13=(high_price-low_price)-yuzde13;

double alan21yuzde=DivZero(alan21,100);
double alan13yuzde=DivZero(alan13,100);


string last_select_object="Trend";

double levels=66.7;
string level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[i],high_price-alan21yuzde*levels,mnt,high_price-alan21yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);


levels=61.8;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[i],high_price-alan21yuzde*levels,mnt,high_price-alan21yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);





levels=66.7;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Expi"+level);
ObjectCreate(ChartID(),last_select_object+"Expi"+level,OBJ_TREND,0,Time[i],high_price-alan13yuzde*levels,mnt,high_price-alan13yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Expi"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Expi"+level,OBJPROP_COLOR,clrDarkGray);
ObjectSetInteger(ChartID(),last_select_object+"Expi"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Expi"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Expi"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Expi"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Expi"+level,OBJPROP_WIDTH,2);


levels=61.8;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Expi"+level);
ObjectCreate(ChartID(),last_select_object+"Expi"+level,OBJ_TREND,0,Time[i],high_price-alan13yuzde*levels,mnt,high_price-alan13yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Expi"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Expi"+level,OBJPROP_COLOR,clrDarkGray);
ObjectSetInteger(ChartID(),last_select_object+"Expi"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Expi"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Expi"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Expi"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Expi"+level,OBJPROP_WIDTH,2);



levels=13.0;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Expi"+level);
ObjectCreate(ChartID(),last_select_object+"Expi"+level,OBJ_TREND,0,Time[i],low_price+yuzde*levels,mnt,low_price+yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Expi"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Expi"+level,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),last_select_object+"Expi"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Expi"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Expi"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Expi"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Expi"+level,OBJPROP_WIDTH,1);

levels=21.0;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Expi"+level);
ObjectCreate(ChartID(),last_select_object+"Expi"+level,OBJ_TREND,0,Time[i],low_price+yuzde*levels,mnt,low_price+yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Expi"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Expi"+level,OBJPROP_COLOR,clrLightGreen);
ObjectSetInteger(ChartID(),last_select_object+"Expi"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Expi"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Expi"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Expi"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Expi"+level,OBJPROP_WIDTH,1);
   
   
   
   }
   
   
   }
   ////////////////////////////////////////////////////////////////
   
   }
   
   
   
   
   
   
   
   
   //////////////////////////////////////////////////////////////
   
   
   
   
   }
   
   
   

}


void HighLow() {

int t=WindowFirstVisibleBar();
   
   for (int i=t;i>end_bar;i--) {
   
   //////////////////////////////////////////////////////////////
   
   double high_price=High[i];
   bool high_find_left=false;
   bool high_find_right=false;
   last_low_price=1000000;
   
   
   for (int l=i+1;l<i+left_bar_min;l++) {
   
   if ( high_price < High[l] ) high_find_left=true;
   
   }
   
 /*
   if ( low_find_left == false ) {
   
   ObjectCreate(ChartID(),"V"+i,OBJ_VLINE,0,Time[i],Ask);
   
   }*/
   
   for (int l=i-1;l>i-right_bar_min;l--) {
   
   if ( high_price < High[l] ) high_find_right=true;
   
   }
   
   /*
   if ( low_find_right == false ) {
   
   ObjectCreate(ChartID(),"V"+i,OBJ_VLINE,0,Time[i],Ask);
   
   }*/
   
   if ( high_find_left == false && high_find_right == false && high_price > last_high_price ) {
   
   last_high_price=high_price;
   
   //ObjectCreate(ChartID(),"V"+i,OBJ_VLINE,0,Time[i],Ask);
   //ObjectSetInteger(ChartID(),"V"+i,OBJPROP_BACK,True);
   
   ObjectDelete(ChartID(),"V");
   ObjectCreate(ChartID(),"V",OBJ_VLINE,0,Time[i],Ask);
   ObjectSetInteger(ChartID(),"V",OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"V",OBJPROP_WIDTH,1);
   
   ObjectDelete(ChartID(),"H");
   ObjectCreate(ChartID(),"H",OBJ_HLINE,0,Time[i],high_price);
   ObjectSetInteger(ChartID(),"H",OBJPROP_BACK,True);
   
   
   ////////////////////////////////////////////////////////////////
   

   
   for (int ii=i;ii>end_bar;ii--) {
   
   double low_price=Low[ii];
   bool low_find_left=false;
   bool low_find_right=false;   
   
  for (int l=ii+1;l<ii+left_bar_min;l++) {
   
   if ( low_price > Low[l] ) low_find_left=true;
   
   }
   
   for (int l=ii-1;l>ii-right_bar_min;l--) {
   
   if ( low_price > Low[l] ) low_find_right=true;
   
   }
   
   
   if ( low_find_left == false && low_find_right == false && low_price < last_low_price 
   ) {
   
   last_low_price=low_price;
   
   
   ObjectDelete(ChartID(),"Vh");
   ObjectCreate(ChartID(),"Vh",OBJ_VLINE,0,Time[ii],Ask);
   ObjectSetInteger(ChartID(),"Vh",OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"Vh",OBJPROP_COLOR,clrBlue);
   /*
   ObjectDelete(ChartID(),i+"Hh");
   ObjectCreate(ChartID(),i+"Hh",OBJ_HLINE,0,Time[ii],high_price);
   ObjectSetInteger(ChartID(),i+"Hh",OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),i+"Hh",OBJPROP_COLOR,clrBlue);
   
   
   ObjectDelete(ChartID(),i+"T");
   ObjectCreate(ChartID(),i+"T",OBJ_TREND,0,Time[i],low_price,Time[ii],high_price);
   ObjectSetInteger(ChartID(),i+"T",OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),i+"T",OBJPROP_COLOR,clrLightGray);
   ObjectSetInteger(ChartID(),i+"T",OBJPROP_RAY,False);   */

   ObjectDelete(ChartID(),"T");
   ObjectCreate(ChartID(),"T",OBJ_TREND,0,Time[i],high_price,Time[ii],low_price);
   ObjectSetInteger(ChartID(),"T",OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"T",OBJPROP_COLOR,clrLightGray);
   ObjectSetInteger(ChartID(),"T",OBJPROP_RAY,False);   
   
   
   double yuzde=DivZero(high_price-low_price,100);
   
   double yuzde21=yuzde*21;
   double yuzde13=yuzde*13;
   
double alan21=(high_price-low_price)-yuzde21;
double alan13=(high_price-low_price)-yuzde13;

double alan21yuzde=DivZero(alan21,100);
double alan13yuzde=DivZero(alan13,100);


string last_select_object="Trend";

double levels=66.7;
string level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[i],low_price+alan21yuzde*levels,mnt,low_price+alan21yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);


levels=61.8;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[i],low_price+alan21yuzde*levels,mnt,low_price+alan21yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);





levels=66.7;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Expi"+level);
ObjectCreate(ChartID(),last_select_object+"Expi"+level,OBJ_TREND,0,Time[i],low_price+alan13yuzde*levels,mnt,low_price+alan13yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Expi"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Expi"+level,OBJPROP_COLOR,clrDarkGray);
ObjectSetInteger(ChartID(),last_select_object+"Expi"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Expi"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Expi"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Expi"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Expi"+level,OBJPROP_WIDTH,2);


levels=61.8;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Expi"+level);
ObjectCreate(ChartID(),last_select_object+"Expi"+level,OBJ_TREND,0,Time[i],low_price+alan13yuzde*levels,mnt,low_price+alan13yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Expi"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Expi"+level,OBJPROP_COLOR,clrDarkGray);
ObjectSetInteger(ChartID(),last_select_object+"Expi"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Expi"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Expi"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Expi"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Expi"+level,OBJPROP_WIDTH,2);


levels=13.0;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Expi"+level);
ObjectCreate(ChartID(),last_select_object+"Expi"+level,OBJ_TREND,0,Time[i],high_price-yuzde*levels,mnt,high_price-yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Expi"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Expi"+level,OBJPROP_COLOR,clrDarkGray);
ObjectSetInteger(ChartID(),last_select_object+"Expi"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Expi"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Expi"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Expi"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Expi"+level,OBJPROP_WIDTH,1);

levels=21.0;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Expi"+level);
ObjectCreate(ChartID(),last_select_object+"Expi"+level,OBJ_TREND,0,Time[i],high_price-yuzde*levels,mnt,high_price-yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Expi"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Expi"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Expi"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Expi"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Expi"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Expi"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Expi"+level,OBJPROP_WIDTH,1);




   
   
   
   }
   
   
   }
   ////////////////////////////////////////////////////////////////
   
   }
   
   
   
   
   
   
   
   
   //////////////////////////////////////////////////////////////
   
   
   
   
   }
   
   
   
   

}