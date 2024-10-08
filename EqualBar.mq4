//+------------------------------------------------------------------+
//|                                                     EqualBar.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

datetime zaman;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer
   EventSetTimer(60);
   
   
   if ( zaman == Time[1] ) return(INIT_SUCCEEDED) ;
   
   
   zaman=Time[1];
   
   
   ObjectsDeleteAll();
   
   
   int Bar=1000;
   if ( Bars > 2000 ) {
   Bar=2000;
   }
   
   Bar=Bars-500;
   
   for (int i=1;i<Bar;i++) {

   
   double cl1=Close[i];
   double cl2=Close[i+1];

   double op1=Open[i];
   double op2=Open[i+1];   
   
   int p2;
   int p1;
   
   double up1;
   double up2;
   double down1;
   double down2;
   
   
   if ( cl2 > op2 ) {
   p2=(cl2-op2)/Point;
   up2=cl2;
   down2=op2;
   } else {
   p2=(op2-cl2)/Point;
   up2=op2;
   down2=cl2;
   }

   
   if ( cl1 > op1 ) {
   p1=(cl1-op1)/Point;
   up1=cl1;
   down1=op1;   
   } else {
   p1=(op1-cl1)/Point;
   up1=op1;
   down1=cl1;   
   }
   
   
   double yuzde1=DivZero(up1-down1,100);
   double yuzde2=DivZero(up2-down2,100);
   
   int x=15;
   
   
   
   //if ( up2 < up1 && up1-up2 < yuzde2*20 )  {
   if ( MathAbs(up1-up2) < yuzde2*20 && MathAbs(down2-down1) < yuzde2*20 )  {
   //ObjectCreate(ChartID(),"VLINE"+i,OBJ_VLINE,0,Time[i],Ask);   
   
   ObjectCreate(ChartID(),"Rec"+i,OBJ_RECTANGLE,0,Time[i+1],Open[i+1],Time[i],Close[i+1]);
   ObjectSetInteger(ChartID(),"Rec"+i,OBJPROP_COLOR,clrYellow);

   if ( cl2 > op2 ) {
   ObjectCreate(ChartID(),"RecU"+i,OBJ_TREND,0,Time[i+1],Open[i+1],Time[i+x],Open[i+1]);
   ObjectSetInteger(ChartID(),"RecU"+i,OBJPROP_COLOR,clrYellow);   
   ObjectSetInteger(ChartID(),"RecU"+i,OBJPROP_RAY,False); 
   
   ObjectCreate(ChartID(),"RecO"+i,OBJ_TREND,0,Time[i+1]+x*PeriodSeconds(),Open[i+1],Time[i],Open[i+1]);
   ObjectSetInteger(ChartID(),"RecO"+i,OBJPROP_COLOR,clrYellow);   
   ObjectSetInteger(ChartID(),"RecO"+i,OBJPROP_RAY,False);   
   ObjectSetInteger(ChartID(),"RecO"+i,OBJPROP_STYLE,STYLE_DOT);  
   
   ObjectCreate(ChartID(),"RecD"+i,OBJ_TREND,0,Time[i+1],Close[i+1],Time[i+x],Close[i+1]);
   ObjectSetInteger(ChartID(),"RecD"+i,OBJPROP_COLOR,clrYellow);   
   ObjectSetInteger(ChartID(),"RecD"+i,OBJPROP_RAY,False);   
   
   ObjectCreate(ChartID(),"RecC"+i,OBJ_TREND,0,Time[i+1]+x*PeriodSeconds(),Close[i+1],Time[i],Close[i+1]);
   ObjectSetInteger(ChartID(),"RecC"+i,OBJPROP_COLOR,clrYellow);   
   ObjectSetInteger(ChartID(),"RecC"+i,OBJPROP_RAY,False);   
   ObjectSetInteger(ChartID(),"RecC"+i,OBJPROP_STYLE,STYLE_DOT);   
   
      
      
   }else{

   ObjectCreate(ChartID(),"RecU"+i,OBJ_TREND,0,Time[i+1],Open[i+1],Time[i+x],Open[i+1]);
   ObjectSetInteger(ChartID(),"RecU"+i,OBJPROP_COLOR,clrYellow);   
   ObjectSetInteger(ChartID(),"RecU"+i,OBJPROP_RAY,False); 
   
   ObjectCreate(ChartID(),"RecO"+i,OBJ_TREND,0,Time[i+1]+x*PeriodSeconds(),Open[i+1],Time[i],Open[i+1]);
   ObjectSetInteger(ChartID(),"RecO"+i,OBJPROP_COLOR,clrYellow);   
   ObjectSetInteger(ChartID(),"RecO"+i,OBJPROP_RAY,False);   
   ObjectSetInteger(ChartID(),"RecO"+i,OBJPROP_STYLE,STYLE_DOT);     
   
   ObjectCreate(ChartID(),"RecD"+i,OBJ_TREND,0,Time[i+1],Close[i+1],Time[i+x],Close[i+1]);
   ObjectSetInteger(ChartID(),"RecD"+i,OBJPROP_COLOR,clrYellow);   
   ObjectSetInteger(ChartID(),"RecD"+i,OBJPROP_RAY,False);   
   
   ObjectCreate(ChartID(),"RecC"+i,OBJ_TREND,0,Time[i+1]+x*PeriodSeconds(),Close[i+1],Time[i],Close[i+1]);
   ObjectSetInteger(ChartID(),"RecC"+i,OBJPROP_COLOR,clrYellow);   
   ObjectSetInteger(ChartID(),"RecC"+i,OBJPROP_RAY,False);   
   ObjectSetInteger(ChartID(),"RecC"+i,OBJPROP_STYLE,STYLE_DOT);   
   }
   
   
      
   
   }
   
   
   
   
   
   /*
   if ( up1 == up2 && down1 == down2 ) {
  
   }*/
   
   
   
   
   
   /*
   if ( p1==p2 ) {
   ObjectCreate(ChartID(),"VLINE"+i,OBJ_VLINE,0,Time[i],Ask);
   }
   */
   

   
   
   
   
   
   
   
/*
double yuzde=DivZero(MathAbs((cl2-op2)/Point),100);

   Comment(yuzde);
   */
   
   
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

OnInit();


   
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

if ( sparam == 45 ) {

Sleep(100);
zaman=-1;
OnInit();


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
