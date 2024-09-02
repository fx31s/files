//+------------------------------------------------------------------+
//|                                                       Supdem.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
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

  int mBoxTime;
  
  
  if(Time[0] > mBoxTime)
   {
     for(int i = ObjectsTotal()-1; i >= 0; i--)
       if(ObjectType(ObjectName(i)) == OBJ_RECTANGLE && ObjectName(i) == sparam )
         ObjectSet(ObjectName(i), OBJPROP_TIME2, Time[0]+1000*PeriodSeconds());

      mBoxTime = Time[0];
   }
   
   
   

if ( sparam == 45 ) {

ObjectsDeleteAll();

}

if(id==CHARTEVENT_CLICK )  {     

      int      x     =(int)lparam;
      int      y     =(int)dparam;
      datetime dt    =0;
      double   price =0;
      int      window=0;
      //--- Convert the X and Y coordinates in terms of date/time
      if(ChartXYToTimePrice(0,x,y,window,dt,price))
        {
        
        
        
        
        int shift=iBarShift(Symbol(),Period(),dt);
        
        Print(price,"/",shift);
        
        if ( Close[shift] > Open[shift] ) {
        
        if ( price >= Close[shift] && price <=High[shift] ) {
        ObjectCreate(ChartID(),"SUPDEMUP"+Time[shift],OBJ_RECTANGLE,0,Time[shift],High[shift],Time[shift]+100*PeriodSeconds(),Close[shift]);          
        ObjectSetInteger(ChartID(),"SUPDEMUP"+Time[shift],OBJPROP_BACK,true);
        ObjectSetInteger(ChartID(),"SUPDEMUP"+Time[shift],OBJPROP_COLOR,clrBisque);
        }     
        
        }
        
        if ( Close[shift] < Open[shift] ) {
        
        if ( price <= Close[shift] && price >=Low[shift] ) {
        ObjectCreate(ChartID(),"SUPDEMUP"+Time[shift],OBJ_RECTANGLE,0,Time[shift],Low[shift],Time[shift]+100*PeriodSeconds(),Close[shift]);          
        ObjectSetInteger(ChartID(),"SUPDEMUP"+Time[shift],OBJPROP_BACK,true);
        ObjectSetInteger(ChartID(),"SUPDEMUP"+Time[shift],OBJPROP_COLOR,clrBisque);
        }     
        
        }
        
            
        if ( Close[shift] < Open[shift] ) {
        
        if ( price >= Open[shift] && price <=High[shift] ) {
        ObjectCreate(ChartID(),"SUPDEMUP"+Time[shift],OBJ_RECTANGLE,0,Time[shift],High[shift],Time[shift]+100*PeriodSeconds(),Open[shift]);          
        ObjectSetInteger(ChartID(),"SUPDEMDOWN"+Time[shift],OBJPROP_BACK,true);
        ObjectSetInteger(ChartID(),"SUPDEMDOWN"+Time[shift],OBJPROP_COLOR,clrLightSlateGray);
        }     
        
        }
        
        if ( Close[shift] > Open[shift] ) {
        
        if ( price <= Close[shift] && price >=Low[shift] ) {
        ObjectCreate(ChartID(),"SUPDEMDOWN"+Time[shift],OBJ_RECTANGLE,0,Time[shift],Low[shift],Time[shift]+100*PeriodSeconds(),Open[shift]);          
        ObjectSetInteger(ChartID(),"SUPDEMDOWN"+Time[shift],OBJPROP_BACK,true);
        ObjectSetInteger(ChartID(),"SUPDEMDOWN"+Time[shift],OBJPROP_COLOR,clrLightSlateGray);
        }     
        
        }
        
                    
                
        

        
        }
        }
        
   
  }
//+------------------------------------------------------------------+
