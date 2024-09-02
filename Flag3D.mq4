//+------------------------------------------------------------------+
//|                                                       Flag3D.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

double high_price;
double low_price;
int shift_1;
int shift_2;
double price_1;
double price_2;

double highs_price;
double lows_price;
int shifts_1;
int shifts_2;
double prices_1;
double prices_2;

bool lock=false;

string last_select_object;
string last_select_objects;

string last_object;
int ObjTotal = ObjectsTotal();

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

if ( sparam == 45 ) ObjectsDeleteAll();

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_TREND && StringFind(sparam,"Exp",0) == -1 && StringFind(sparam,"Line",0) == -1 && StringFind(sparam,"Flag",0) == -1 && lock == false ) {

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

low_price=Low[shift2];
high_price=High[shift1];

ObjectMove(ChartID(),last_select_object,0,Time[shift1],High[shift1]);
ObjectMove(ChartID(),last_select_object,1,Time[shift2],Low[shift2]);

if ( ObjectFind(ChartID(),last_select_object+"Exp") == -1 ) {

ObjectDelete(ChartID(),last_select_object+"Exp");
ObjectCreate(ChartID(),last_select_object+"Exp",OBJ_TREND,0,Time[shift1-1],High[shift1],Time[shift2-1],Low[shift2]);
ObjectSetInteger(ChartID(),last_select_object+"Exp",OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),last_select_object+"Exp",OBJPROP_SELECTABLE,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp",OBJPROP_SELECTED,True);

}


}

if ( obj_prc2 > obj_prc1 ) {

low_price=Low[shift1];
high_price=High[shift2];

ObjectMove(ChartID(),last_select_object,0,Time[shift1],Low[shift1]);
ObjectMove(ChartID(),last_select_object,1,Time[shift2],High[shift2]);

if ( ObjectFind(ChartID(),last_select_object+"Exp") == -1 ) {

ObjectDelete(ChartID(),last_select_object+"Exp");
ObjectCreate(ChartID(),last_select_object+"Exp",OBJ_TREND,0,Time[shift1-1],Low[shift1],Time[shift2-1],High[shift2]);
ObjectSetInteger(ChartID(),last_select_object+"Exp",OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),last_select_object+"Exp",OBJPROP_SELECTABLE,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp",OBJPROP_SELECTED,True);

}


}

}

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_TREND && StringFind(sparam,"Exp",0) != -1 && StringFind(sparam,"Line",0) == -1 && StringFind(sparam,"Flag",0) == -1 && lock == false ) {


last_select_objects=sparam;

          last_select_object=sparam;
          int rplc=StringReplace(last_select_object,"Exp","");
          
          //Alert(last_select_object);
          
          Print(last_select_object);

//////////////////////////////////////////////////

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
          
          
low_price=Low[shift2];
high_price=High[shift1];

          
//////////////////////////////////////////////////////



string last_select_objects=sparam;

          obj_typ = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_TYPE);
          obj_time1 = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_TIME,0);
          obj_time2 = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_TIME,1);
          obj_time3 = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_TIME,2);
          obj_prc1 = ObjectGetDouble(ChartID(),last_select_objects,OBJPROP_PRICE,0);
          obj_prc2 = ObjectGetDouble(ChartID(),last_select_objects,OBJPROP_PRICE,1);
          obj_prc3 = ObjectGetDouble(ChartID(),last_select_objects,OBJPROP_PRICE,2);
          obj_fiil = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_FILL);
          obj_scale = ObjectGetDouble(ChartID(),last_select_objects,OBJPROP_SCALE);
          obj_angle = ObjectGetDouble(ChartID(),last_select_objects,OBJPROP_ANGLE);
          obj_ray = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_RAY);
          obj_color = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_COLOR);
          obj_bgcolor = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_BGCOLOR);
          obj_width = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_WIDTH);
          obj_back = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_BACK);
          
          
          shift1=iBarShift(Symbol(),Period(),obj_time1);
          shift2=iBarShift(Symbol(),Period(),obj_time2);

          shifts_1=shift1;
          shifts_2=shift2;
          
          prices_1=obj_prc1;
          prices_2=obj_prc2;
         

if ( obj_prc1 > obj_prc2 ) {

lows_price=Low[shifts_2];
highs_price=High[shifts_1];

ObjectMove(ChartID(),last_select_objects,0,Time[shifts_1],High[shifts_1]);
ObjectMove(ChartID(),last_select_objects,1,Time[shifts_2],Low[shifts_2]);


ObjectDelete(ChartID(),last_select_object+"LineH");
ObjectCreate(ChartID(),last_select_object+"LineH",OBJ_TREND,0,Time[shift_1],High[shift_1],Time[shifts_1],High[shifts_1]);
ObjectSetInteger(ChartID(),last_select_object+"LineH",OBJPROP_RAY,True);
ObjectSetInteger(ChartID(),last_select_object+"LineH",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),last_select_object+"LineH",OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"LineH",OBJPROP_SELECTED,False);

ObjectDelete(ChartID(),last_select_object+"LineL");
ObjectCreate(ChartID(),last_select_object+"LineL",OBJ_TREND,0,Time[shift_2],Low[shift_2],Time[shifts_2],Low[shifts_2]);
ObjectSetInteger(ChartID(),last_select_object+"LineL",OBJPROP_RAY,True);
ObjectSetInteger(ChartID(),last_select_object+"LineL",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),last_select_object+"LineL",OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"LineL",OBJPROP_SELECTED,False);


ObjectDelete(ChartID(),last_select_object+"LineHL");
ObjectCreate(ChartID(),last_select_object+"LineHL",OBJ_TREND,0,Time[shift_1],High[shift_1],Time[shifts_2],Low[shifts_2]);
ObjectSetInteger(ChartID(),last_select_object+"LineHL",OBJPROP_RAY,True);
ObjectSetInteger(ChartID(),last_select_object+"LineHL",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),last_select_object+"LineHL",OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"LineHL",OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"LineHL",OBJPROP_STYLE,STYLE_DOT);

ObjectDelete(ChartID(),last_select_object+"LineLH");
ObjectCreate(ChartID(),last_select_object+"LineLH",OBJ_TREND,0,Time[shift_2],Low[shift_2],Time[shifts_1],High[shifts_1]);
ObjectSetInteger(ChartID(),last_select_object+"LineLH",OBJPROP_RAY,True);
ObjectSetInteger(ChartID(),last_select_object+"LineLH",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),last_select_object+"LineLH",OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"LineLH",OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"LineLH",OBJPROP_STYLE,STYLE_DOT);

int Fark=int((highs_price-lows_price)/Point);
int PipFark=int((highs_price-lows_price)/Point);
   //int mum=low_shift-high_shift;
   
   double tepe_fiyats=highs_price;
   double dip_fiyats=lows_price;
   
       Fark=(((tepe_fiyats-dip_fiyats)*12)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat11=tepe_fiyats-Fark*Point;

       Fark=(((tepe_fiyats-dip_fiyats)*12.236)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat11236=tepe_fiyats-Fark*Point;


   string name = "Flag11Lows";

   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[l],fiyat5,Time[l]+100*PeriodSeconds(),fiyat5236);
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[shifts_1],fiyat11,Time[shifts_1]+100*PeriodSeconds(),fiyat11);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlue);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,11);   
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);   
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true); 
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT); 
   
   
       Fark=(((tepe_fiyats-dip_fiyats)*4)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat4=tepe_fiyats-Fark*Point;

       Fark=(((tepe_fiyats-dip_fiyats)*4.236)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat4236=tepe_fiyats-Fark*Point;


   name = "Flag4Lows";

   //
   ObjectDelete(ChartID(),name);
   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[shifts_1],fiyat6,Time[shifts_1]+10000*PeriodSeconds(),fiyat6236);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[shifts_1],fiyat4,Time[shifts_1]+100*PeriodSeconds(),fiyat4);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrRed);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,3);   
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);   
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true); 
   //ObjectDelete(ChartID(),name);

       Fark=(((tepe_fiyats-dip_fiyats)*6)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat6=tepe_fiyats-Fark*Point;

       Fark=(((tepe_fiyats-dip_fiyats)*6.236)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat6236=tepe_fiyats-Fark*Point;


   name = "Flag5Lows";

   //
   ObjectDelete(ChartID(),name);
   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[shifts_1],fiyat6,Time[shifts_1]+10000*PeriodSeconds(),fiyat6236);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[shifts_1],fiyat6,Time[shifts_1]+100*PeriodSeconds(),fiyat6);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlack);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,5);   
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);   
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true); 
   //ObjectDelete(ChartID(),name);
  
       Fark=(((tepe_fiyats-dip_fiyats)*9)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat9=tepe_fiyats-Fark*Point;

       Fark=(((tepe_fiyats-dip_fiyats)*9.236)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat9236=tepe_fiyats-Fark*Point;


   name = "Flag8Lows";

   
   ObjectDelete(ChartID(),name);
   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[shifts_1],fiyat9,Time[shifts_1]+10000*PeriodSeconds(),fiyat9236);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[shifts_1],fiyat9,Time[shifts_1]+100*PeriodSeconds(),fiyat9);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrCrimson);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,8);   
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);   
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true); 
   //ObjectDelete(ChartID(),name);
   
   
 high_price=High[shift_1];
 low_price=Low[shift_2];

Fark=int((high_price-low_price)/Point);
PipFark=int((high_price-low_price)/Point);
   //int mum=low_shift-high_shift;
   
   tepe_fiyats=high_price;
   dip_fiyats=low_price;
   
       Fark=(((tepe_fiyats-dip_fiyats)*12)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
fiyat11=tepe_fiyats-Fark*Point;

       Fark=(((tepe_fiyats-dip_fiyats)*12.236)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
fiyat11236=tepe_fiyats-Fark*Point;


   name = "Flag11Low";

   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[l],fiyat5,Time[l]+100*PeriodSeconds(),fiyat5236);
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[shift_1],fiyat11,Time[shift_1]+100*PeriodSeconds(),fiyat11);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlue);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,11);   
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);   
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true); 
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT); 

       Fark=(((tepe_fiyats-dip_fiyats)*4)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
fiyat4=tepe_fiyats-Fark*Point;

       Fark=(((tepe_fiyats-dip_fiyats)*4.236)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
fiyat4236=tepe_fiyats-Fark*Point;


   name = "Flag4Low";

   //
   ObjectDelete(ChartID(),name);
   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[shifts_1],fiyat6,Time[shifts_1]+10000*PeriodSeconds(),fiyat6236);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[shift_1],fiyat4,Time[shift_1]+100*PeriodSeconds(),fiyat4);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrRed);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,3);   
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);   
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true); 
   //ObjectDelete(ChartID(),name);

       Fark=(((tepe_fiyats-dip_fiyats)*6)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
fiyat6=tepe_fiyats-Fark*Point;

       Fark=(((tepe_fiyats-dip_fiyats)*6.236)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
fiyat6236=tepe_fiyats-Fark*Point;


   name = "Flag5Low";

   //
   ObjectDelete(ChartID(),name);
   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[shifts_1],fiyat6,Time[shifts_1]+10000*PeriodSeconds(),fiyat6236);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[shift_1],fiyat6,Time[shift_1]+100*PeriodSeconds(),fiyat6);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlack);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,5);   
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);   
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true); 
   //ObjectDelete(ChartID(),name);
      
   
   
       Fark=(((tepe_fiyats-dip_fiyats)*9)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
fiyat9=tepe_fiyats-Fark*Point;

       Fark=(((tepe_fiyats-dip_fiyats)*9.236)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
fiyat9236=tepe_fiyats-Fark*Point;


   name = "Flag8Low";

   
   ObjectDelete(ChartID(),name);
   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[shifts_1],fiyat9,Time[shifts_1]+10000*PeriodSeconds(),fiyat9236);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[shift_1],fiyat9,Time[shift_1]+100*PeriodSeconds(),fiyat9);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrCrimson);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,8);   
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);   
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true); 
   //ObjectDelete(ChartID(),name);

}

if ( obj_prc2 > obj_prc1 ) {

lows_price=Low[shifts_1];
highs_price=High[shifts_2];

ObjectMove(ChartID(),last_select_objects,0,Time[shifts_1],Low[shifts_1]);
ObjectMove(ChartID(),last_select_objects,1,Time[shifts_2],High[shifts_2]);

ObjectDelete(ChartID(),last_select_object+"LineH");
ObjectCreate(ChartID(),last_select_object+"LineH",OBJ_TREND,0,Time[shift_2],High[shift_2],Time[shifts_2],High[shifts_2]);
ObjectSetInteger(ChartID(),last_select_object+"LineH",OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"LineH",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),last_select_object+"LineH",OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"LineH",OBJPROP_SELECTED,False);

ObjectDelete(ChartID(),last_select_object+"LineL");
ObjectCreate(ChartID(),last_select_object+"LineL",OBJ_TREND,0,Time[shift_1],Low[shift_1],Time[shifts_1],Low[shifts_1]);
ObjectSetInteger(ChartID(),last_select_object+"LineL",OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"LineL",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),last_select_object+"LineL",OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"LineL",OBJPROP_SELECTED,False);

ObjectDelete(ChartID(),last_select_object+"LineLH");
ObjectCreate(ChartID(),last_select_object+"LineLH",OBJ_TREND,0,Time[shift_1],Low[shift_1],Time[shifts_2],High[shifts_2]);
ObjectSetInteger(ChartID(),last_select_object+"LineLH",OBJPROP_RAY,True);
ObjectSetInteger(ChartID(),last_select_object+"LineLH",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),last_select_object+"LineLH",OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"LineLH",OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"LineLH",OBJPROP_STYLE,STYLE_DOT);

ObjectDelete(ChartID(),last_select_object+"LineHL");
ObjectCreate(ChartID(),last_select_object+"LineHL",OBJ_TREND,0,Time[shift_2],High[shift_2],Time[shifts_1],Low[shifts_1]);
ObjectSetInteger(ChartID(),last_select_object+"LineHL",OBJPROP_RAY,True);
ObjectSetInteger(ChartID(),last_select_object+"LineHL",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),last_select_object+"LineHL",OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"LineHL",OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"LineHL",OBJPROP_STYLE,STYLE_DOT);

int Fark=int((highs_price-lows_price)/Point);
int PipFark=int((highs_price-lows_price)/Point);
   //int mum=low_shift-high_shift;
   
   double tepe_fiyats=highs_price;
   double dip_fiyats=lows_price;
   
       Fark=(((tepe_fiyats-dip_fiyats)*12)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat11=dip_fiyats+Fark*Point;

       Fark=(((tepe_fiyats-dip_fiyats)*12.236)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat11236=dip_fiyats+Fark*Point;


   string name = "Flag11Lows";

   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[l],fiyat5,Time[l]+100*PeriodSeconds(),fiyat5236);
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[shifts_1],fiyat11,Time[shifts_1]+100*PeriodSeconds(),fiyat11);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlue);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,11+"s");   
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);   
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true); 
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT); 

       Fark=(((tepe_fiyats-dip_fiyats)*4)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat4=tepe_fiyats+Fark*Point;

       Fark=(((tepe_fiyats-dip_fiyats)*4.236)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat4236=tepe_fiyats+Fark*Point;


   name = "Flag3Lows";

   //
   ObjectDelete(ChartID(),name);
   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[shifts_1],fiyat6,Time[shifts_1]+10000*PeriodSeconds(),fiyat6236);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[shifts_1],fiyat4,Time[shifts_1]+100*PeriodSeconds(),fiyat4);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrRed);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,3+"s");   
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);   
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true); 
   //ObjectDelete(ChartID(),name);

       Fark=(((tepe_fiyats-dip_fiyats)*6)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat6=tepe_fiyats+Fark*Point;

       Fark=(((tepe_fiyats-dip_fiyats)*6.236)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat6236=tepe_fiyats+Fark*Point;


   name = "Flag5Lows";

   //
   ObjectDelete(ChartID(),name);
   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[shifts_1],fiyat6,Time[shifts_1]+10000*PeriodSeconds(),fiyat6236);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[shifts_1],fiyat6,Time[shifts_1]+100*PeriodSeconds(),fiyat6);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlack);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,5+"s");   
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);   
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true); 
   //ObjectDelete(ChartID(),name);

       Fark=(((tepe_fiyats-dip_fiyats)*9)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat9=dip_fiyats+Fark*Point;

       Fark=(((tepe_fiyats-dip_fiyats)*9.236)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat9236=dip_fiyats+Fark*Point;


   name = "Flag8Lows";

   
   ObjectDelete(ChartID(),name);
   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[shifts_1],fiyat9,Time[shifts_1]+10000*PeriodSeconds(),fiyat9236);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[shifts_1],fiyat9,Time[shifts_1]+100*PeriodSeconds(),fiyat9);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrCrimson);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,8+"s");   
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);   
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true); 
   //ObjectDelete(ChartID(),name);

 high_price=High[shift_2];
 low_price=Low[shift_1];
 


Fark=int((high_price-low_price)/Point);
PipFark=int((high_price-low_price)/Point);
   //int mum=low_shift-high_shift;
   
   tepe_fiyats=high_price;
   dip_fiyats=low_price;
   
       Fark=(((tepe_fiyats-dip_fiyats)*12)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
fiyat11=dip_fiyats+Fark*Point;

       Fark=(((tepe_fiyats-dip_fiyats)*12.236)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
fiyat11236=dip_fiyats+Fark*Point;


   name = "Flag11Low";

   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[l],fiyat5,Time[l]+100*PeriodSeconds(),fiyat5236);
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[shift_1],fiyat11,Time[shift_1]+100*PeriodSeconds(),fiyat11);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlue);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,11);   
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);   
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true); 
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT); 

       Fark=(((tepe_fiyats-dip_fiyats)*4)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
fiyat4=dip_fiyats+Fark*Point;

       Fark=(((tepe_fiyats-dip_fiyats)*4.236)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
fiyat4236=dip_fiyats+Fark*Point;


   name = "Flag4Low";

   //
   ObjectDelete(ChartID(),name);
   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[shifts_1],fiyat6,Time[shifts_1]+10000*PeriodSeconds(),fiyat6236);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[shift_1],fiyat4,Time[shift_1]+100*PeriodSeconds(),fiyat4);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrRed);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,3);   
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);   
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true); 
   //ObjectDelete(ChartID(),name);

      
       Fark=(((tepe_fiyats-dip_fiyats)*6)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
fiyat6=dip_fiyats+Fark*Point;

       Fark=(((tepe_fiyats-dip_fiyats)*6.236)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
fiyat6236=dip_fiyats+Fark*Point;


   name = "Flag5Low";

   //
   ObjectDelete(ChartID(),name);
   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[shifts_1],fiyat6,Time[shifts_1]+10000*PeriodSeconds(),fiyat6236);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[shift_1],fiyat6,Time[shift_1]+100*PeriodSeconds(),fiyat6);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlack);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,5);   
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);   
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true); 
   //ObjectDelete(ChartID(),name);

       Fark=(((tepe_fiyats-dip_fiyats)*9)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
fiyat9=dip_fiyats+Fark*Point;

       Fark=(((tepe_fiyats-dip_fiyats)*9.236)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
fiyat9236=dip_fiyats+Fark*Point;


   name = "Flag8Low";

   
   ObjectDelete(ChartID(),name);
   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[shifts_1],fiyat9,Time[shifts_1]+10000*PeriodSeconds(),fiyat9236);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[shift_1],fiyat9,Time[shift_1]+100*PeriodSeconds(),fiyat9);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrCrimson);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,8);   
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);   
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true); 
   //ObjectDelete(ChartID(),name);
   
 }

}
   
  }
     
//+------------------------------------------------------------------+ King Of Rada