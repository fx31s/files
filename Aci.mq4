//+------------------------------------------------------------------+
//|                                                          Aci.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

bool skyper=true;

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


if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_TREND && StringFind(sparam,"Exp",0) == -1 && StringFind(sparam,"MAL",0) == -1 && lock == false && skyper == true) {


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
          

ObjectMove(ChartID(),last_select_object,0,Time[shift1],Low[shift1]);
ObjectMove(ChartID(),last_select_object,1,Time[shift2],Low[shift2]);

          obj_time1 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,0);
          obj_time2 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,1);
          
          obj_prc1 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,0);
          obj_prc2 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,1);

          
         
          
if ( obj_prc1 > obj_prc2 ) {

string level="Chn";
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_CHANNEL,0,obj_time1,obj_prc1,obj_time2,obj_prc2,obj_time1+5*PeriodSeconds(),obj_prc1+50*Point());
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrYellow);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BGCOLOR,clrYellow);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);

level="Rec";
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_RECTANGLE,0,obj_time1,obj_prc1,obj_time1-100*PeriodSeconds(),obj_prc1+50*Point());
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrYellow);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BGCOLOR,clrYellow);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);




      double trend_angle = 0;
      
      uint i=24;
      int x2,y2,x1,y1;
      ChartTimePriceToXY(ChartID(),0,obj_time2,obj_prc2,x2,y2);
      ChartTimePriceToXY(ChartID(),0,obj_time1,obj_prc1,x1,y1);
      double base    = x1-x2;
      double height = y1-y2;
      double degrees = MathArctan(DivZero(height,base))*(DivZero(360,(2*M_PI)));
      Sleep(100);
      trend_angle = MathMod((360-degrees),360);
         
         
         double trend_angle_prc=DivZero((obj_prc1-obj_prc2),(360-trend_angle));
         trend_angle_prc=DivZero((obj_prc1-obj_prc2),(300-trend_angle));
         trend_angle_prc=DivZero((obj_prc1-obj_prc2),(360-trend_angle));
   
   ObjectSetString(ChartID(),last_select_object,OBJPROP_TOOLTIP,trend_angle);
   
   //ObjectMove(ChartID(),last_select_object,1,Time[shift2],trend_angle_prc);
   
   ObjectSetDouble(ChartID(),last_select_object,OBJPROP_PRICE,1,obj_prc1-((37)*trend_angle_prc));
   
   
   

 Comment("Açı:",trend_angle,"/",trend_angle_prc,"/",degrees);

}
          
/*
if ( obj_prc2 > obj_prc1 ) {


      double trend_angle = 0;
      
      uint i=24;
      int x2,y2,x1,y1;
      ChartTimePriceToXY(ChartID(),0,obj_time1,obj_prc1,x2,y2);
      ChartTimePriceToXY(ChartID(),0,obj_time2,obj_prc2,x1,y1);
      double base    = x1-x2;
      double height = y1-y2;
      double degrees = MathArctan(DivZero(height,base))*(DivZero(360,(2*M_PI)));
      Sleep(100);
      trend_angle = MathMod((360-degrees),360);
         
   
   ObjectSetString(ChartID(),last_select_object,OBJPROP_TOOLTIP,trend_angle);
   
   
   

 Comment("Açı:",trend_angle);

}
          
      */ 
         
       
       
          
          
          
          
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
