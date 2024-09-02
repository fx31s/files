//+------------------------------------------------------------------+
//|                                                       Gamble.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property icon "fxgame.ico"
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+

extern int distance=100;
int level_total=-1;

int OnInit()
  {
//--- create timer
   //EventSetTimer(60);
   
   ObjectsDeleteAll();
   
   double max=WindowPriceMax();
   double min=WindowPriceMin();
   
   
   
   ObjectCreate(ChartID(),"HMAX",OBJ_HLINE,0,Time[0],max);
   ObjectCreate(ChartID(),"HMIN",OBJ_HLINE,0,Time[0],min);
   
   double level=((max-min)/Point)/distance;
   
   Comment(max,"/",min,"/",round(level));
   
   
   color renk=clrBlue;
   
   for(double i=0;i<round(level);i++) {
   
   
   
   double price=min+((distance*i)*Point);
   
   ObjectCreate(ChartID(),"HRec"+i,OBJ_RECTANGLE,0,Time[0],price,Time[0]+100*PeriodSeconds(),price+(distance-10)*Point);
   ObjectSetInteger(ChartID(),"HRec"+i,OBJPROP_BACK,true);
   ObjectSetInteger(ChartID(),"HRec"+i,OBJPROP_BORDER_COLOR,clrLightGray);
   
   
   ObjectSetInteger(ChartID(),"HRec"+i,OBJPROP_COLOR,renk);
   
   if ( renk == clrBlue ) { renk=clrRed;} else { renk=clrBlue;}
   
   level_total=round(level);
   
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

Print(sparam);


if ( sparam == 45 ) {


OnInit();

}

if ( ObjectType(sparam) == OBJ_RECTANGLE ) {

OnInit();

string last_select_object=sparam;

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


   color renk=obj_color;
   if ( renk == clrBlue ) { renk=clrRed;} else { renk=clrBlue;}
   
   ObjectSetInteger(ChartID(),last_select_object,OBJPROP_COLOR,clrBisque);
   Sleep(100);
   ObjectSetInteger(ChartID(),last_select_object,OBJPROP_COLOR,obj_color);
   
   int num = 0 + level_total*MathRand()/32768; // 1-10
   
   for(int i=0;i<100;i++) {
   
   int num = 0 + level_total*MathRand()/32768; // 1-10
   
   Print(num);
   
   }
   
   
   int price_box=0;
   
   Comment("Num:",num,"/",level_total);
   
   for (int t=5;t>0;t--) {
   for(int i=0;i<level_total;i++){
   color obj_color = ObjectGetInteger(ChartID(),"HRec"+i,OBJPROP_COLOR);
   ObjectSetInteger(ChartID(),"HRec"+i,OBJPROP_COLOR,clrBisque);
   ChartRedraw();
   Sleep(50*t);
   ObjectSetInteger(ChartID(),"HRec"+i,OBJPROP_COLOR,obj_color);        
   ChartRedraw();  
   
          obj_prc1 = ObjectGetDouble(ChartID(),"HRec"+i,OBJPROP_PRICE1);
          obj_prc2 = ObjectGetDouble(ChartID(),"HRec"+i,OBJPROP_PRICE2);   

       if ( Bid >= obj_prc1 && Bid <= obj_prc2 ) price_box=i;
          
          
   }
   }
   
   ObjectSetInteger(ChartID(),"HRec"+num,OBJPROP_COLOR,clrBisque);
   
   //num=9;
   
           obj_prc1 = ObjectGetDouble(ChartID(),"HRec"+num,OBJPROP_PRICE1);
          obj_prc2 = ObjectGetDouble(ChartID(),"HRec"+num,OBJPROP_PRICE2);
          
          int ord_type=-1;
          
          
          if ( Ask > obj_prc1 && Ask > obj_prc2 && Bid > obj_prc1 && Bid > obj_prc2 ) ord_type=OP_BUY;
          if ( Ask < obj_prc1 && Ask < obj_prc2 && Bid < obj_prc1 && Bid < obj_prc2 ) ord_type=OP_SELL;
   
   
           obj_prc1 = ObjectGetDouble(ChartID(),"HRec"+price_box,OBJPROP_PRICE1);
          obj_prc2 = ObjectGetDouble(ChartID(),"HRec"+price_box,OBJPROP_PRICE2);      
   ObjectSetInteger(ChartID(),"HRec"+price_box,OBJPROP_COLOR,clrBlack);    
             
             if ( price_box != num ) {
             
           obj_prc1 = ObjectGetDouble(ChartID(),"HRec"+(price_box-1),OBJPROP_PRICE1);
          obj_prc2 = ObjectGetDouble(ChartID(),"HRec"+(price_box+1),OBJPROP_PRICE2);
          
          if ( num == level_total-1 ) {
          obj_prc1 = ObjectGetDouble(ChartID(),"HRec"+(price_box-1),OBJPROP_PRICE1);
          obj_prc2 = ObjectGetDouble(ChartID(),"HRec"+(level_total-1),OBJPROP_PRICE2)+distance*Point;                              
          }
          
          if ( num == 0 ) {
          obj_prc1 = ObjectGetDouble(ChartID(),"HRec"+0,OBJPROP_PRICE1)-distance*Point;                              
          obj_prc2 = ObjectGetDouble(ChartID(),"HRec"+(price_box+1),OBJPROP_PRICE2);
          }
                    
                       
             
             if ( ord_type == OP_SELL ) OrderSend(Symbol(),OP_SELL,0.01,Bid,0,obj_prc2,obj_prc1,"NULL",0,0,clrNONE);
             if ( ord_type == OP_BUY ) OrderSend(Symbol(),OP_BUY,0.01,Ask,0,obj_prc1,obj_prc2,"NULL",0,0,clrNONE);
             }
          

}


   
  }
//+------------------------------------------------------------------+
