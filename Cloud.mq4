//+------------------------------------------------------------------+
//|                                                        Cloud.mq4 |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
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
          
          
          
          if ( obj_prc2 > obj_prc1 ) {
          
          //Alert("Selam");
          
string name=last_select_objectr+"UP"+Time[1];          
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[shift2],Low[shift2],Time[shift2]+30*PeriodSeconds(),Low[shift2]);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlue);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,False);

name=last_select_objectr+"UPHigh"+Time[1];          
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[shift2],High[shift2],Time[shift2]+30*PeriodSeconds(),High[shift2]);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlue);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,False);
           
name=last_select_objectr+"DOWN"+Time[1];          
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[shift1],High[shift1],Time[shift1]+30*PeriodSeconds(),High[shift1]);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlue);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,False);
    
name=last_select_objectr+"DOWNLow"+Time[1];          
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[shift1],Low[shift1],Time[shift1]+30*PeriodSeconds(),Low[shift1]);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlue);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,False);
    

name=last_select_objectr+"REC"+Time[1];          
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[shift1],High[shift1],Time[shift2]+30*PeriodSeconds(),Low[shift2]);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBisque);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,False);


          
          
          } else {
          
          

         
string name=last_select_objectr+"UP"+Time[1];          
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[shift2],Low[shift2],Time[shift2]+30*PeriodSeconds(),Low[shift2]);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlue);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,False);

name=last_select_objectr+"UPHigh"+Time[1];          
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[shift2],High[shift2],Time[shift2]+30*PeriodSeconds(),High[shift2]);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlue);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,False);
           
name=last_select_objectr+"DOWN"+Time[1];          
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[shift1],High[shift1],Time[shift1]+30*PeriodSeconds(),High[shift1]);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlue);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,False);
    
name=last_select_objectr+"DOWNLow"+Time[1];          
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[shift1],Low[shift1],Time[shift1]+30*PeriodSeconds(),Low[shift1]);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlue);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,False);
    

name=last_select_objectr+"REC"+Time[1];          
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[shift1],Low[shift1],Time[shift2]+30*PeriodSeconds(),High[shift2]);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBisque);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,False);

          
          
          }
          
          
          
          
          
          
          
          }
   
  }
//+------------------------------------------------------------------+
