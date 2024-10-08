//+------------------------------------------------------------------+
//|                                                  TrendSupdem.mq4 |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

string last_select_object="";
bool lock=false;

double tprice_1;
double tprice_2;

bool ray=false;

int points=1;
int carpan=1;


//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer
   //EventSetTimer(60);
   
   //ObjectsDeleteAll();
   
   Comment("Last Select Object:",last_select_object);
   
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

if ( sparam == 52 ) {

carpan=carpan+1;

if ( carpan == 11 ) {carpan=1;}


Comment("Çarpan:",carpan,"Points:",points);

}









if ( StringToInteger(sparam) >= 2 && StringToInteger(sparam) <= 10 ) {

//int carpan=1;
if ( Period() >= PERIOD_H4 ) carpan = 10;

points=StringToInteger(sparam)*carpan;

Comment("Çarpan:",carpan,"Points:",points);

}



if ( sparam == 19 || sparam == 48 ) {

if ( ray == false ) {

ObjectSetInteger(ChartID(),last_select_object,OBJPROP_RAY,True);
ObjectSetInteger(ChartID(),last_select_object+"Sd",OBJPROP_RAY,True);
ObjectSetInteger(ChartID(),last_select_object+"Sdh",OBJPROP_RAY,True);
ObjectSetInteger(ChartID(),last_select_object+"Sdu",OBJPROP_RAY,True);
ObjectSetInteger(ChartID(),last_select_object+"Sdl",OBJPROP_RAY,True);

ray=true;

} else {

ObjectSetInteger(ChartID(),last_select_object,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Sd",OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Sdh",OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Sdu",OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Sdl",OBJPROP_RAY,False);
ray=false;

}


}

if ( sparam == 38 ) {
lock=false;
Comment("Lock:",lock);
ObjectSetInteger(ChartID(),last_select_object,OBJPROP_SELECTABLE,True);
}


if ( sparam == 45 ) {
ObjectsDeleteAll();


}


if ( sparam == 49 ) {

          double obj_prc2 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE2);
          double obj_sdprc2 = ObjectGetDouble(ChartID(),last_select_object+"Sd",OBJPROP_PRICE2);

Print(last_select_object," Prc:",obj_prc2,"/",obj_prc2-1*Point);


ObjectSetDouble(ChartID(),last_select_object,OBJPROP_PRICE2,obj_prc2+points*Point);
ObjectSetDouble(ChartID(),last_select_object+"Sd",OBJPROP_PRICE2,obj_sdprc2+points*Point);

ChartRedraw();


}

if ( sparam == 50 ) {




          double obj_prc2 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE2);
          double obj_sdprc2 = ObjectGetDouble(ChartID(),last_select_object+"Sd",OBJPROP_PRICE2);

Print(last_select_object," Prc:",obj_prc2,"/",obj_prc2-2*Point);

ObjectSetDouble(ChartID(),last_select_object,OBJPROP_PRICE2,obj_prc2-points*Point);
ObjectSetDouble(ChartID(),last_select_object+"Sd",OBJPROP_PRICE2,obj_sdprc2-points*Point);

ChartRedraw();


}


if ( ObjectType(sparam) == OBJ_TREND && StringFind(sparam,"Sd",0) == -1 && lock==false) {


last_select_object=sparam;

          int obj_typ = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TYPE);
          datetime obj_time1 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME1);
          datetime obj_time2 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME2);
          datetime obj_time3 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME3);
          double obj_prc1 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE1);
          double obj_prc2 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE2);
          double obj_prc3 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE3);
          bool obj_fiil = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_FILL);
          double obj_scale = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_SCALE);
          double obj_angle = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_ANGLE);
          bool obj_ray = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_RAY);
          color obj_color = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_COLOR);
          color obj_bgcolor = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_BGCOLOR);
          int obj_width = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_WIDTH);
          int obj_back = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_BACK);
          
          ObjectSetInteger(ChartID(),last_select_object,OBJPROP_COLOR,clrChartreuse);
          ObjectSetInteger(ChartID(),last_select_object,OBJPROP_SELECTABLE,False);
          
          lock=true;
          
 int shift=iBarShift(Symbol(),Period(),obj_time1);
 
 double high_price=iHigh(Symbol(),Period(),shift);
 double close_price=iClose(Symbol(),Period(),shift);
 double open_price=iOpen(Symbol(),Period(),shift);
 double low_price=iLow(Symbol(),Period(),shift);
 double up_price;
 double down_price;
 
 bool up_supdem=false;
 bool down_supdem=false;
 
 if ( high_price-obj_prc1 < obj_prc1-low_price ) up_supdem=true;
 if ( obj_prc1-low_price < high_price-obj_prc1 ) down_supdem=true;
 
 
 
 
 if ( open_price > close_price ) { 
 up_price=open_price;
 down_price=close_price;
 }
 
 if ( close_price > open_price ) { 
 up_price=close_price;
 down_price=open_price;
 
 }
 
 
 if ( up_supdem == true ) {
 //Alert("UpSupdem");
 ObjectSetDouble(ChartID(),last_select_object,OBJPROP_PRICE1,up_price);
 ObjectSetDouble(ChartID(),last_select_object,OBJPROP_PRICE2,up_price);
 
 tprice_1=up_price;
 tprice_2=high_price;
 
 ObjectDelete(ChartID(),last_select_object+"Sd");
 ObjectCreate(ChartID(),last_select_object+"Sd",OBJ_TREND,0,obj_time1,high_price,obj_time2,high_price);
 ObjectSetInteger(ChartID(),last_select_object+"Sd",OBJPROP_RAY,False);
 ObjectSetInteger(ChartID(),last_select_object+"Sd",OBJPROP_SELECTABLE,False);
 

ObjectDelete(ChartID(),last_select_object+"Sdl");
 ObjectCreate(ChartID(),last_select_object+"Sdl",OBJ_TREND,0,obj_time1,low_price,obj_time2,low_price);
 ObjectSetInteger(ChartID(),last_select_object+"Sdl",OBJPROP_RAY,False);
 ObjectSetInteger(ChartID(),last_select_object+"Sdl",OBJPROP_SELECTABLE,False); 
 
 
 if ( close_price > open_price ) { 
 
 ObjectDelete(ChartID(),last_select_object+"Sdu");
 ObjectCreate(ChartID(),last_select_object+"Sdu",OBJ_TREND,0,obj_time1,open_price,obj_time2,open_price);
 ObjectSetInteger(ChartID(),last_select_object+"Sdu",OBJPROP_RAY,False);
 ObjectSetInteger(ChartID(),last_select_object+"Sdu",OBJPROP_SELECTABLE,False);
   
 }
 
  if ( close_price < open_price ) { 
 
 ObjectDelete(ChartID(),last_select_object+"Sdu");
 ObjectCreate(ChartID(),last_select_object+"Sdu",OBJ_TREND,0,obj_time1,close_price,obj_time2,close_price);
 ObjectSetInteger(ChartID(),last_select_object+"Sdu",OBJPROP_RAY,False);
 ObjectSetInteger(ChartID(),last_select_object+"Sdu",OBJPROP_SELECTABLE,False);
   
 }
 
 
 
 
 
 }
 
  if ( down_supdem == true ) {
 //Alert("DownSupdem");
 
 
 
ObjectSetDouble(ChartID(),last_select_object,OBJPROP_PRICE1,down_price);
ObjectSetDouble(ChartID(),last_select_object,OBJPROP_PRICE2,down_price);
 
 ObjectDelete(ChartID(),last_select_object+"Sd");
 ObjectCreate(ChartID(),last_select_object+"Sd",OBJ_TREND,0,obj_time1,low_price,obj_time2,low_price);
 ObjectSetInteger(ChartID(),last_select_object+"Sd",OBJPROP_RAY,False);
 ObjectSetInteger(ChartID(),last_select_object+"Sd",OBJPROP_SELECTABLE,False);
 
 tprice_1=down_price;
 tprice_2=low_price;
 
 
 ObjectDelete(ChartID(),last_select_object+"Sdh");
 ObjectCreate(ChartID(),last_select_object+"Sdh",OBJ_TREND,0,obj_time1,high_price,obj_time2,high_price);
 ObjectSetInteger(ChartID(),last_select_object+"Sdh",OBJPROP_RAY,False);
 ObjectSetInteger(ChartID(),last_select_object+"Sdh",OBJPROP_SELECTABLE,False); 
 
 
 if ( close_price > open_price ) { 
 
 ObjectDelete(ChartID(),last_select_object+"Sdu");
 ObjectCreate(ChartID(),last_select_object+"Sdu",OBJ_TREND,0,obj_time1,close_price,obj_time2,close_price);
 ObjectSetInteger(ChartID(),last_select_object+"Sdu",OBJPROP_RAY,False);
 ObjectSetInteger(ChartID(),last_select_object+"Sdu",OBJPROP_SELECTABLE,False);
   
 }
 
  if ( close_price < open_price ) { 
 
 ObjectDelete(ChartID(),last_select_object+"Sdu");
 ObjectCreate(ChartID(),last_select_object+"Sdu",OBJ_TREND,0,obj_time1,open_price,obj_time2,open_price);
 ObjectSetInteger(ChartID(),last_select_object+"Sdu",OBJPROP_RAY,False);
 ObjectSetInteger(ChartID(),last_select_object+"Sdu",OBJPROP_SELECTABLE,False);
   
 }
 
 
 
 }
 
 
 
 
 
 
          
          
          }
          
   
  }
//+------------------------------------------------------------------+
