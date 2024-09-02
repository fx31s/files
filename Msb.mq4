//+------------------------------------------------------------------+
//|                                                          Msb.mq4 |
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
   
   //ObjectsDeleteAll();
   
   int left_limit=50;
   
   
   string sym=Symbol();
   ENUM_TIMEFRAMES per=Period();
   
   double high_price;
   double low_price;
   
   for (int i=1550;i>0;i--) {
   
   
   high_price=iHigh(sym,per,i);
   low_price=iLow(sym,per,i);
   
   bool left_up=true;
   bool right_up=true;

   bool left_down=true;
   bool right_down=true;   
   
   for (int l=i+1;l<i+left_limit;l++){   
   double highs_price=iHigh(sym,per,l);   
   if ( high_price < highs_price ) left_up=false;   
   
   double lows_price=iLow(sym,per,l);   
   if ( low_price > lows_price ) left_down=false;   
      
   
   }   
   
   if ( left_up == true ) {
   /*ObjectCreate(ChartID(),"UP"+Time[i],OBJ_TREND,0,iTime(sym,per,i),high_price,iTime(sym,per,i)+100*PeriodSeconds(),high_price);
   ObjectSetInteger(ChartID(),"UP"+Time[i],OBJPROP_RAY,false);*/

   }

   if ( left_down == true ) {
   /*ObjectCreate(ChartID(),"DOWN"+Time[i],OBJ_TREND,0,iTime(sym,per,i),low_price,iTime(sym,per,i)+100*PeriodSeconds(),low_price);
   ObjectSetInteger(ChartID(),"DOWN"+Time[i],OBJPROP_RAY,false);*/

   }
      
   
   for (int l=i-1;l>i-left_limit;l--){ 
   
     
   double highs_price=iHigh(sym,per,l);   
   if ( high_price < highs_price ) right_up=false;   
   
   double lows_price=iLow(sym,per,l);   
   if ( low_price > lows_price ) right_down=false;   
      
   
   }   
   
   if ( right_up == true ) {
   /*ObjectCreate(ChartID(),"UPR"+Time[i],OBJ_TREND,0,iTime(sym,per,i),high_price,iTime(sym,per,i)+100*PeriodSeconds(),high_price);
   ObjectSetInteger(ChartID(),"UPR"+Time[i],OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),"UPR"+Time[i],OBJPROP_WIDTH,2);
   ObjectSetInteger(ChartID(),"UPR"+Time[i],OBJPROP_BACK,true);
   ObjectSetInteger(ChartID(),"UPR"+Time[i],OBJPROP_COLOR,clrBlue);*/

   }

   if ( right_down == true ) {
   /*ObjectCreate(ChartID(),"UPR"+Time[i],OBJ_TREND,0,iTime(sym,per,i),low_price,iTime(sym,per,i)+100*PeriodSeconds(),low_price);
   ObjectSetInteger(ChartID(),"UPR"+Time[i],OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),"UPR"+Time[i],OBJPROP_WIDTH,2);
   ObjectSetInteger(ChartID(),"UPR"+Time[i],OBJPROP_BACK,true);
   ObjectSetInteger(ChartID(),"UPR"+Time[i],OBJPROP_COLOR,clrBlue);*/

   }
   
      

   if ( left_up == true && right_up == true ) {
   ObjectCreate(ChartID(),"UPLR"+Time[i],OBJ_TREND,0,iTime(sym,per,i),high_price,iTime(sym,per,i)+100*PeriodSeconds(),high_price);
   ObjectSetInteger(ChartID(),"UPLR"+Time[i],OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),"UPLR"+Time[i],OBJPROP_WIDTH,4);
   ObjectSetInteger(ChartID(),"UPLR"+Time[i],OBJPROP_BACK,true);
   ObjectSetInteger(ChartID(),"UPLR"+Time[i],OBJPROP_COLOR,clrLightGray);
   
   low_price=iLow(sym,per,i);
   
   double msb_low_price=low_price;
   bool find=false;
   
   for (int l=i+1;l<i+left_limit;l++) {
   
   double lows_price=iLow(sym,per,l);
   double lown_price=iLow(sym,per,l+1);
   double closen_price=iClose(sym,per,l+1);
   
   if ( lows_price < low_price && lown_price > lows_price && closen_price > lows_price && find == false ) {
   msb_low_price=lows_price;
   find=true;
   
   ObjectCreate(ChartID(),"DOWN"+Time[i],OBJ_TREND,0,iTime(sym,per,l),msb_low_price,iTime(sym,per,l)+100*PeriodSeconds(),msb_low_price);
   ObjectSetInteger(ChartID(),"DOWN"+Time[i],OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),"DOWN"+Time[i],OBJPROP_COLOR,clrLightGray);
   ObjectSetInteger(ChartID(),"DOWN"+Time[i],OBJPROP_STYLE,STYLE_DOT);
   

   ObjectCreate(ChartID(),"EQ"+Time[i],OBJ_TREND,0,iTime(sym,per,l),msb_low_price+((high_price-msb_low_price)/2),iTime(sym,per,l)+100*PeriodSeconds(),msb_low_price+((high_price-msb_low_price)/2));
   ObjectSetInteger(ChartID(),"EQ"+Time[i],OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),"EQ"+Time[i],OBJPROP_COLOR,clrBlack);
   ObjectSetInteger(ChartID(),"EQ"+Time[i],OBJPROP_STYLE,STYLE_DOT);
   

   for (int ll=i-1;ll>0;ll--){ 
   
   double lowf_price=iLow(sym,per,ll-1);
   
   bool find=false;
   if ( msb_low_price > lowf_price && find == false ) {   
   find=true;
   
   ObjectCreate(ChartID(),"PR"+Time[i],OBJ_TREND,0,iTime(sym,per,ll),msb_low_price,iTime(sym,per,ll),high_price);
   ObjectSetInteger(ChartID(),"PR"+Time[i],OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),"PR"+Time[i],OBJPROP_COLOR,clrBlack);
   ObjectSetInteger(ChartID(),"PR"+Time[i],OBJPROP_STYLE,STYLE_DOT);
   
   
   }
      
   
   } 

   
      
   }

   
   }
 
   
   
   

   }      
   

   if ( left_down == true && right_down == true ) {
   ObjectCreate(ChartID(),"DOWNLR"+Time[i],OBJ_TREND,0,iTime(sym,per,i),low_price,iTime(sym,per,i)+100*PeriodSeconds(),low_price);
   ObjectSetInteger(ChartID(),"DOWNLR"+Time[i],OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),"DOWNLR"+Time[i],OBJPROP_WIDTH,4);
   ObjectSetInteger(ChartID(),"DOWNLR"+Time[i],OBJPROP_BACK,true);
   ObjectSetInteger(ChartID(),"DOWNLR"+Time[i],OBJPROP_COLOR,clrLightBlue);
   
   
   high_price=iHigh(sym,per,i);
   
   double msb_high_price=high_price;
   bool find=false;
   
   for (int l=i+1;l<i+left_limit;l++) {
   
   double highs_price=iHigh(sym,per,l);
   double highn_price=iHigh(sym,per,l+1);
   double closen_price=iClose(sym,per,l+1);
   
   if ( highs_price > high_price && highn_price < highs_price && closen_price < highs_price && find == false ) {
   msb_high_price=highs_price;
   find=true;
   
   ObjectCreate(ChartID(),"UP"+Time[i],OBJ_TREND,0,iTime(sym,per,l),msb_high_price,iTime(sym,per,l)+100*PeriodSeconds(),msb_high_price);
   ObjectSetInteger(ChartID(),"UP"+Time[i],OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),"UP"+Time[i],OBJPROP_COLOR,clrLightBlue);
   ObjectSetInteger(ChartID(),"UP"+Time[i],OBJPROP_STYLE,STYLE_DOT);

   ObjectCreate(ChartID(),"EQ"+Time[i],OBJ_TREND,0,iTime(sym,per,l),low_price+((msb_high_price-low_price)/2),iTime(sym,per,l)+100*PeriodSeconds(),low_price+((msb_high_price-low_price)/2));
   ObjectSetInteger(ChartID(),"EQ"+Time[i],OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),"EQ"+Time[i],OBJPROP_COLOR,clrBlack);
   ObjectSetInteger(ChartID(),"EQ"+Time[i],OBJPROP_STYLE,STYLE_DOT);
   

   for (int ll=i-1;ll>0;ll--){ 
   
   double highf_price=iHigh(sym,per,ll-1);
   
   bool find=false;
   if ( msb_high_price < highf_price && find == false ) {   
   find=true;
   
   ObjectCreate(ChartID(),"PR"+Time[i],OBJ_TREND,0,iTime(sym,per,ll),msb_high_price,iTime(sym,per,ll),low_price);
   ObjectSetInteger(ChartID(),"PR"+Time[i],OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),"PR"+Time[i],OBJPROP_COLOR,clrBlack);
   ObjectSetInteger(ChartID(),"PR"+Time[i],OBJPROP_STYLE,STYLE_DOT);
   
   
   }
      
   
   } 

   
   
   
   }


   }

   }     
   
   
   //Print(i);
   
   
   
   
   
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
   
  }
//+------------------------------------------------------------------+
