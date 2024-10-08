//+------------------------------------------------------------------+
//|                                      MirrorReserveReflection.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

string last_select_object;
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

double high_price;
double low_price;
int shift_1;
int shift_2;
double price_1;
double price_2;
bool lock=false;


void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//---

Print(sparam);

if ( sparam == 38 ) {

//if ( lock == true ) {lock=false;}
lock=true;

Comment("Lock:",lock);


}


if ( sparam == 45 ) {ObjectsDeleteAll(ChartID(),-1,-1);lock=false;ChartRedraw(ChartID());}


if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_TREND && StringFind(sparam,"Exp",0) == -1 && lock == false ) {


last_select_object=sparam;

ObjectDelete(ChartID(),last_select_object+"ExpUp");
ObjectDelete(ChartID(),last_select_object+"ExpUpLine");
ObjectDelete(ChartID(),last_select_object+"ExpUpLinea");
ObjectDelete(ChartID(),last_select_object+"ExpUpLineab");
ObjectDelete(ChartID(),last_select_object+"ExpDown");
ObjectDelete(ChartID(),last_select_object+"ExpDownLine");
ObjectDelete(ChartID(),last_select_object+"ExpDownLinea");
ObjectDelete(ChartID(),last_select_object+"ExpDownLineab");

ObjectDelete(ChartID(),last_select_object+"Exp88.60");
ObjectDelete(ChartID(),last_select_object+"Exp70.70");
ObjectDelete(ChartID(),last_select_object+"Exp61.80");


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
          
          
          
          
          
          
//if ( High[shift2] > Low[shift1] ) {

if ( obj_prc2 > obj_prc1 ) {

//Alert("Selam2::::",High[shift2],"/",Low[shift1]);

//return;


low_price=Low[shift1];
high_price=High[shift2];

ObjectMove(ChartID(),last_select_object,0,Time[shift1],Low[shift1]);
ObjectMove(ChartID(),last_select_object,1,Time[shift2],High[shift2]);




ObjectDelete(ChartID(),last_select_object+"Exp");
ObjectCreate(ChartID(),last_select_object+"Exp",OBJ_TREND,0,Time[shift2],High[shift2],Time[shift2]+20*PeriodSeconds(),High[shift2]-(High[shift2]-Low[shift1]));
ObjectSetInteger(ChartID(),last_select_object+"Exp",OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),last_select_object+"Exp",OBJPROP_SELECTABLE,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp",OBJPROP_SELECTED,True);

  double yuzde = DivZero(high_price-low_price, 100);

double levels=70.70;
string level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],High[shift2]-yuzde*levels,Time[shift2]+40*PeriodSeconds(),High[shift2]-yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);

levels=61.80;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],High[shift2]-yuzde*levels,Time[shift2]+40*PeriodSeconds(),High[shift2]-yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);

levels=88.60;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],High[shift2]-yuzde*levels,Time[shift2]+40*PeriodSeconds(),High[shift2]-yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);

return;

}       


//if ( High[shift1] > Low[shift2] ) {


if ( obj_prc1 > obj_prc2 ) {



//Alert("Selam");

//return;



low_price=Low[shift2];
high_price=High[shift1];

ObjectMove(ChartID(),last_select_object,0,Time[shift1],High[shift1]);
ObjectMove(ChartID(),last_select_object,1,Time[shift2],Low[shift2]);


ObjectDelete(ChartID(),last_select_object+"Exp");
ObjectCreate(ChartID(),last_select_object+"Exp",OBJ_TREND,0,Time[shift2],Low[shift2],Time[shift2]+20*PeriodSeconds(),Low[shift2]+(High[shift1]-Low[shift2]));
ObjectSetInteger(ChartID(),last_select_object+"Exp",OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),last_select_object+"Exp",OBJPROP_SELECTABLE,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp",OBJPROP_SELECTED,True);
//Alert("Selam");


 double yuzde = DivZero(high_price-low_price, 100);

double levels=70.70;
string level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],Low[shift2]+yuzde*levels,Time[shift2]+40*PeriodSeconds(),Low[shift2]+yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);

levels=61.80;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],Low[shift2]+yuzde*levels,Time[shift2]+40*PeriodSeconds(),Low[shift2]+yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);


levels=88.60;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],Low[shift2]+yuzde*levels,Time[shift2]+40*PeriodSeconds(),Low[shift2]+yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);




}          







}


if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_TREND && StringFind(sparam,"Exp",0) != -1 && StringFind(sparam,"Exp70",0) == -1 && StringFind(sparam,"Exp88",0) == -1 && StringFind(sparam,"Exp61",0) == -1) {


string last_select_objects=sparam;

          int obj_typ = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_TYPE);
          datetime obj_time1 = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_TIME,0);
          datetime obj_time2 = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_TIME,1);
          datetime obj_time3 = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_TIME,2);
          double obj_prc1 = ObjectGetDouble(ChartID(),last_select_objects,OBJPROP_PRICE,0);
          double obj_prc2 = ObjectGetDouble(ChartID(),last_select_objects,OBJPROP_PRICE,1);
          double obj_prc3 = ObjectGetDouble(ChartID(),last_select_objects,OBJPROP_PRICE,2);
          bool obj_fiil = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_FILL);
          double obj_scale = ObjectGetDouble(ChartID(),last_select_objects,OBJPROP_SCALE);
          double obj_angle = ObjectGetDouble(ChartID(),last_select_objects,OBJPROP_ANGLE);
          bool obj_ray = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_RAY);
          color obj_color = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_COLOR);
          color obj_bgcolor = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_BGCOLOR);
          int obj_width = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_WIDTH);
          int obj_back = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_BACK);
          
          
          int shift1=iBarShift(Symbol(),Period(),obj_time1);
          int shift2=iBarShift(Symbol(),Period(),obj_time2);
          
          
//if ( High[shift1] > Low[shift2] && High[shift_2] > Low[shift_1]  ) {
//if ( obj_prc1 > obj_prc2 && High[shift_2] > Low[shift_1]  ) {
if ( obj_prc1 > obj_prc2 && price_2 > price_1  ) {

ObjectMove(ChartID(),last_select_objects,1,Time[shift2],Low[shift2]);




  double yuzde = DivZero(high_price-low_price, 100);
  double fark = High[shift1]-Low[shift2] ;
  double oran = DivZero(fark,yuzde);
  
  Comment("Oran:",oran);
   
   
ObjectDelete(ChartID(),last_select_object+"ExpUp");
ObjectCreate(ChartID(),last_select_object+"ExpUp",OBJ_TREND,0,Time[shift2],Low[shift2],Time[shift2]+10*PeriodSeconds(),High[shift_2]+oran*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"ExpUp",OBJPROP_RAY,False);

ObjectDelete(ChartID(),last_select_object+"ExpUpLine");
ObjectCreate(ChartID(),last_select_object+"ExpUpLine",OBJ_TREND,0,Time[shift2]+10*PeriodSeconds(),High[shift_2]+oran*yuzde,Time[shift2]+20000*PeriodSeconds(),High[shift_2]+oran*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"ExpUpLine",OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpUpLine",OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpUpLine",OBJPROP_STYLE,STYLE_DOT);

ObjectDelete(ChartID(),last_select_object+"ExpUpLinea");
ObjectCreate(ChartID(),last_select_object+"ExpUpLinea",OBJ_TREND,0,Time[shift2]+10*PeriodSeconds(),Low[shift2]+oran*yuzde,Time[shift2]+20000*PeriodSeconds(),Low[shift2]+oran*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"ExpUpLinea",OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpUpLinea",OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpUpLinea",OBJPROP_STYLE,STYLE_DOT);


ObjectDelete(ChartID(),last_select_object+"ExpUpLinea2");
ObjectCreate(ChartID(),last_select_object+"ExpUpLinea2",OBJ_TREND,0,Time[shift2]+10*PeriodSeconds(),Low[shift2]+(100+oran)*yuzde,Time[shift2]+20000*PeriodSeconds(),Low[shift2]+(100+oran)*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"ExpUpLinea2",OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpUpLinea2",OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpUpLinea2",OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"ExpUpLinea2",OBJPROP_COLOR,clrYellow);

ObjectDelete(ChartID(),last_select_object+"ExpDownLinea2");
ObjectCreate(ChartID(),last_select_object+"ExpDownLinea2",OBJ_TREND,0,Time[shift2]+10*PeriodSeconds(),Low[shift2]-(100+oran)*yuzde,Time[shift2]+20000*PeriodSeconds(),Low[shift2]-(100+oran)*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"ExpDownLinea2",OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpDownLinea2",OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpDownLinea2",OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"ExpDownLinea2",OBJPROP_COLOR,clrYellow);



ObjectDelete(ChartID(),last_select_object+"ExpUpLinea1");
ObjectCreate(ChartID(),last_select_object+"ExpUpLinea1",OBJ_TREND,0,Time[shift2]+10*PeriodSeconds(),high_price+(100+oran)*yuzde,Time[shift2]+20000*PeriodSeconds(),high_price+(100+oran)*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"ExpUpLinea1",OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpUpLinea1",OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpUpLinea1",OBJPROP_STYLE,STYLE_DOT);
ObjectSetString(ChartID(),last_select_object+"ExpUpLinea1",OBJPROP_TOOLTIP,"1."+oran);
ObjectSetInteger(ChartID(),last_select_object+"ExpUpLinea1",OBJPROP_COLOR,clrBlue);
//ObjectDelete(ChartID(),last_select_object+"ExpUpLinea1");


ObjectDelete(ChartID(),last_select_object+"ExpDownLinea1");
ObjectCreate(ChartID(),last_select_object+"ExpDownLinea1",OBJ_TREND,0,Time[shift2]+10*PeriodSeconds(),low_price-(100+oran)*yuzde,Time[shift2]+20000*PeriodSeconds(),low_price-(100+oran)*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"ExpDownLinea1",OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpDownLinea1",OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpDownLinea1",OBJPROP_STYLE,STYLE_DOT);
ObjectSetString(ChartID(),last_select_object+"ExpDownLinea1",OBJPROP_TOOLTIP,"1."+oran);
ObjectSetInteger(ChartID(),last_select_object+"ExpDownLinea1",OBJPROP_COLOR,clrBlue);
//ObjectDelete(ChartID(),last_select_object+"ExpDownLinea1");


ObjectDelete(ChartID(),last_select_object+"ExpUpLineab");
ObjectCreate(ChartID(),last_select_object+"ExpUpLineab",OBJ_TREND,0,Time[shift2]+10*PeriodSeconds(),Low[shift2]+(high_price-low_price),Time[shift2]+20000*PeriodSeconds(),Low[shift2]+(high_price-low_price));
ObjectSetInteger(ChartID(),last_select_object+"ExpUpLineab",OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpUpLineab",OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpUpLineab",OBJPROP_STYLE,STYLE_DASHDOT);
ObjectSetInteger(ChartID(),last_select_object+"ExpUpLineab",OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),last_select_object+"ExpUpLineab",OBJPROP_WIDTH,2);




ObjectDelete(ChartID(),last_select_object+"ExpDown");
ObjectCreate(ChartID(),last_select_object+"ExpDown",OBJ_TREND,0,Time[shift2],Low[shift2],Time[shift2]+10*PeriodSeconds(),Low[shift_1]-oran*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"ExpDown",OBJPROP_RAY,False);

ObjectDelete(ChartID(),last_select_object+"ExpDownLine");
ObjectCreate(ChartID(),last_select_object+"ExpDownLine",OBJ_TREND,0,Time[shift2]+10*PeriodSeconds(),Low[shift_1]-oran*yuzde,Time[shift2]+20000*PeriodSeconds(),Low[shift_1]-oran*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"ExpDownLine",OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpDownLine",OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpDownLine",OBJPROP_STYLE,STYLE_DOT);   

ObjectDelete(ChartID(),last_select_object+"ExpDownLinea");
ObjectCreate(ChartID(),last_select_object+"ExpDownLinea",OBJ_TREND,0,Time[shift2]+10*PeriodSeconds(),Low[shift2]-oran*yuzde,Time[shift2]+20000*PeriodSeconds(),Low[shift2]-oran*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"ExpDownLinea",OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpDownLinea",OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpDownLinea",OBJPROP_STYLE,STYLE_DOT);


ObjectDelete(ChartID(),last_select_object+"ExpDownLineab");
ObjectCreate(ChartID(),last_select_object+"ExpDownLineab",OBJ_TREND,0,Time[shift2]+10*PeriodSeconds(),Low[shift2]-(high_price-low_price),Time[shift2]+20000*PeriodSeconds(),Low[shift2]-(high_price-low_price));
ObjectSetInteger(ChartID(),last_select_object+"ExpDownLineab",OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpDownLineab",OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpDownLineab",OBJPROP_STYLE,STYLE_DASHDOT);
ObjectSetInteger(ChartID(),last_select_object+"ExpDownLineab",OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),last_select_object+"ExpDownLineab",OBJPROP_WIDTH,2);



}          






//if ( High[shift2] > Low[shift1] && High[shift_1] > Low[shift_2]  ) {
//if ( obj_prc2 > obj_prc1 && High[shift_1] > Low[shift_2]  ) {
if ( obj_prc2 > obj_prc1 && price_1 > price_2  ) {

ObjectMove(ChartID(),last_select_objects,1,Time[shift2],High[shift2]);




  double yuzde = DivZero(high_price-low_price, 100);
  double fark = High[shift2]-Low[shift1] ;
  double oran = DivZero(fark,yuzde);
  
  Comment("Oran:",oran);
   
   
ObjectDelete(ChartID(),last_select_object+"ExpUp");
ObjectCreate(ChartID(),last_select_object+"ExpUp",OBJ_TREND,0,Time[shift2],High[shift2],Time[shift2]+10*PeriodSeconds(),High[shift_1]+oran*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"ExpUp",OBJPROP_RAY,False);

ObjectDelete(ChartID(),last_select_object+"ExpUpLine");
ObjectCreate(ChartID(),last_select_object+"ExpUpLine",OBJ_TREND,0,Time[shift2]+10*PeriodSeconds(),High[shift_1]+oran*yuzde,Time[shift2]+20000*PeriodSeconds(),High[shift_1]+oran*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"ExpUpLine",OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpUpLine",OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpUp",OBJPROP_STYLE,STYLE_DOT);

ObjectDelete(ChartID(),last_select_object+"ExpUpLinea");
ObjectCreate(ChartID(),last_select_object+"ExpUpLinea",OBJ_TREND,0,Time[shift2]+10*PeriodSeconds(),High[shift2]+oran*yuzde,Time[shift2]+20000*PeriodSeconds(),High[shift2]+oran*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"ExpUpLinea",OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpUpLinea",OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpUpLinea",OBJPROP_STYLE,STYLE_DOT);

ObjectDelete(ChartID(),last_select_object+"ExpUpLinea2");
ObjectCreate(ChartID(),last_select_object+"ExpUpLinea2",OBJ_TREND,0,Time[shift2]+10*PeriodSeconds(),High[shift2]+(oran+100)*yuzde,Time[shift2]+20000*PeriodSeconds(),High[shift2]+(oran+100)*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"ExpUpLinea2",OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpUpLinea2",OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpUpLinea2",OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"ExpUpLinea2",OBJPROP_COLOR,clrYellow);


ObjectDelete(ChartID(),last_select_object+"ExpDownLinea2");
ObjectCreate(ChartID(),last_select_object+"ExpDownLinea2",OBJ_TREND,0,Time[shift2]+10*PeriodSeconds(),High[shift2]-(oran+100)*yuzde,Time[shift2]+20000*PeriodSeconds(),High[shift2]-(oran+100)*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"ExpDownLinea2",OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpDownLinea2",OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpDownLinea2",OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"ExpDownLinea2",OBJPROP_COLOR,clrYellow);





ObjectDelete(ChartID(),last_select_object+"ExpUpLinea1");
ObjectCreate(ChartID(),last_select_object+"ExpUpLinea1",OBJ_TREND,0,Time[shift2]+10*PeriodSeconds(),high_price+(100+oran)*yuzde,Time[shift2]+20000*PeriodSeconds(),high_price+(100+oran)*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"ExpUpLinea1",OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpUpLinea1",OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpUpLinea1",OBJPROP_STYLE,STYLE_DOT);
ObjectSetString(ChartID(),last_select_object+"ExpUpLinea1",OBJPROP_TOOLTIP,"1."+oran);
ObjectSetInteger(ChartID(),last_select_object+"ExpUpLinea1",OBJPROP_COLOR,clrBlue);
//ObjectDelete(ChartID(),last_select_object+"ExpUpLinea1");


ObjectDelete(ChartID(),last_select_object+"ExpDownLinea1");
ObjectCreate(ChartID(),last_select_object+"ExpDownLinea1",OBJ_TREND,0,Time[shift2]+10*PeriodSeconds(),low_price-(100+oran)*yuzde,Time[shift2]+20000*PeriodSeconds(),low_price-(100+oran)*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"ExpDownLinea1",OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpDownLinea1",OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpDownLinea1",OBJPROP_STYLE,STYLE_DOT);
ObjectSetString(ChartID(),last_select_object+"ExpDownLinea1",OBJPROP_TOOLTIP,"1."+oran);
ObjectSetInteger(ChartID(),last_select_object+"ExpDownLinea1",OBJPROP_COLOR,clrBlue);
//ObjectDelete(ChartID(),last_select_object+"ExpDownLinea1");

ObjectDelete(ChartID(),last_select_object+"ExpUpLineab");
ObjectCreate(ChartID(),last_select_object+"ExpUpLineab",OBJ_TREND,0,Time[shift2]+10*PeriodSeconds(),High[shift2]+(high_price-low_price),Time[shift2]+20000*PeriodSeconds(),High[shift2]+(high_price-low_price));
ObjectSetInteger(ChartID(),last_select_object+"ExpUpLineab",OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpUpLineab",OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpUpLineab",OBJPROP_STYLE,STYLE_DASHDOT);
ObjectSetInteger(ChartID(),last_select_object+"ExpUpLineab",OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),last_select_object+"ExpUpLineab",OBJPROP_WIDTH,2);




ObjectDelete(ChartID(),last_select_object+"ExpDown");
ObjectCreate(ChartID(),last_select_object+"ExpDown",OBJ_TREND,0,Time[shift2],High[shift2],Time[shift2]+10*PeriodSeconds(),Low[shift_2]-oran*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"ExpDown",OBJPROP_RAY,False);

ObjectDelete(ChartID(),last_select_object+"ExpDownLine");
ObjectCreate(ChartID(),last_select_object+"ExpDownLine",OBJ_TREND,0,Time[shift2]+10*PeriodSeconds(),Low[shift_2]-oran*yuzde,Time[shift2]+20000*PeriodSeconds(),Low[shift_2]-oran*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"ExpDownLine",OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpDownLine",OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpDownLine",OBJPROP_STYLE,STYLE_DOT);


ObjectDelete(ChartID(),last_select_object+"ExpDownLinea");
ObjectCreate(ChartID(),last_select_object+"ExpDownLinea",OBJ_TREND,0,Time[shift2]+10*PeriodSeconds(),High[shift2]-oran*yuzde,Time[shift2]+20000*PeriodSeconds(),High[shift2]-oran*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"ExpDownLinea",OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpDownLinea",OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpDownLinea",OBJPROP_STYLE,STYLE_DOT);


ObjectDelete(ChartID(),last_select_object+"ExpDownLineab");
ObjectCreate(ChartID(),last_select_object+"ExpDownLineab",OBJ_TREND,0,Time[shift2]+10*PeriodSeconds(),High[shift2]-(high_price-low_price),Time[shift2]+20000*PeriodSeconds(),High[shift2]-(high_price-low_price));
ObjectSetInteger(ChartID(),last_select_object+"ExpDownLineab",OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpDownLineab",OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpDownLineab",OBJPROP_STYLE,STYLE_DASHDOT);
ObjectSetInteger(ChartID(),last_select_object+"ExpDownLineab",OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),last_select_object+"ExpDownLineab",OBJPROP_WIDTH,2);


   

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

