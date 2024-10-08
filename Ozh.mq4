//+------------------------------------------------------------------+
//|                                                          Ozh.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

     long sinyal_charid=ChartID();
     long currChart=ChartID();
     
     double Ortalama;
     
       string sym=Symbol();
  ENUM_TIMEFRAMES per=Period();
  
  datetime robotime;
  
  double Lot=0.01;
  int magic=11;
  
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer
   //EventSetTimer(60);
   
   robotime=Time[1];
   

   
   
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

datetime buy_time;
datetime sell_time;
double buy_price;
double sell_price;
double buy_tp;
double sell_tp;
double buy_sl;
double sell_sl;
bool sell_find=false;
bool buy_find=false;
datetime buy_times;
datetime sell_times;
datetime avrg_time;
bool safe=false;
//bool nosl=true;
bool nosl=false;
double buy_high_price;
string buy_high_name="";
datetime buy_high_time;
int buy_ticket=-1;
double buy_profit=0;
double buy_open_price;

double sell_low_price;
string sell_low_name="";
datetime sell_low_time;
int sell_ticket=-1;
double sell_profit=0;
double sell_open_price;

bool sell_smart=false;
bool buy_smart=false;
double sell_smart_profit=0;
double buy_smart_profit=0;
int sell_total=0;
int buy_total=0;
double sell_smart_op;
double buy_smart_op;

void OnTick()
  {
//---


sell_smart=false;
buy_smart=false;

double ma50=iMA(Symbol(), Period(), 50, 15, MODE_SMA, PRICE_OPEN, 1);



/////////////////////////////////////////////////////////////////////////////////////////////////////
sell_total=0;
buy_total=0;
buy_smart_profit=0;
sell_smart_profit=0;


   for (int h=OrdersTotal();h>=0;h--)
   {
      if ( OrderSelect(h,SELECT_BY_POS) )
      {
         if(OrderType() == OP_SELL && OrderSymbol() == Symbol() && OrderMagicNumber() == magic )
         {
         sell_total=sell_total+1;
         sell_profit=sell_profit+OrderProfit();
         
         if ( OrderComment() == "SELLSMART" ) {sell_smart=true;
         sell_smart_profit=sell_smart_profit+OrderProfit();
         sell_smart_op=OrderOpenPrice();
         }
         
         }
         
         if(OrderType() == OP_BUY && OrderSymbol() == Symbol() && OrderMagicNumber() == magic )
         {
         buy_total=buy_total+1;
         buy_profit=buy_profit+OrderProfit();
         
         if ( OrderComment() == "BUYSMART" ) {buy_smart=true;
         buy_smart_profit=buy_smart_profit+OrderProfit();
         buy_smart_op=OrderOpenPrice();
         }
         
         }
                  
         
      }
   }   
////////////////////////////////////////////////////////////////////////////////////////////////////   
   
   if ( buy_smart == false ) buy_ticket=-1;
   if ( sell_smart == false ) sell_ticket=-1;
   
   
   if ( buy_profit > 0.80 && buy_total > 1) {
   CloseAllBuyOrders();
   buy_find=false;
   buy_ticket=-1;
   }

   if ( sell_profit > 0.80 && sell_total > 1) {
   CloseAllSellOrders();
   sell_find=false;
   sell_ticket=-1;
   }
      
   
   
   
   
   if ( avrg_time != Time[1] ) {
   Ortalama=BarOrtalama(1,300,Symbol(),Period());
   Comment("BarOrtalama:",Ortalama);
   avrg_time=Time[1];
   }

int i=2;




     if ( iClose(sym,per,i)-iOpen(sym,per,i) > Ortalama*5 && Time[i] != buy_times 
     
     && iClose(sym,per,i-1) > iOpen(sym,per,i-1)
     
     //&& iHigh(sym,per,i) > iHigh(sym,per,i-1)
     && ((safe==true &&  iHigh(sym,per,i) > iHigh(sym,per,i-1)) || safe==false)
     
     && iClose(sym,per,i-1) > iHigh(sym,per,i+1)
     
     && buy_smart == false
     
     && Bid > ma50
     
     ) {
     
     double ort=DivZero(iClose(sym,per,i)-iOpen(sym,per,i),Ortalama);

     ObjectDelete(ChartID(),"MAL"+Time[i]);
     ObjectCreate(ChartID(),"MAL"+Time[i],OBJ_TREND,0,Time[i],Open[i],Time[i],Close[i]);
     ObjectSetInteger(ChartID(),"MAL"+Time[i],OBJPROP_RAY,False);
     //ObjectSetInteger(ChartID(),"MAL"+Time[i],OBJPROP_COLOR,clrDarkGreen);
     ObjectSetInteger(ChartID(),"MAL"+Time[i],OBJPROP_COLOR,clrLimeGreen);
     ObjectSetInteger(ChartID(),"MAL"+Time[i],OBJPROP_WIDTH,3);
     ObjectSetInteger(ChartID(),"MAL"+Time[i],OBJPROP_BACK,false);
     ObjectSetInteger(ChartID(),"MAL"+Time[i],OBJPROP_SELECTABLE,false);
     //ObjectSetString(ChartID(),"MAL"+Time[i],OBJPROP_TOOLTIP,TFtoStr(per));
     

     ObjectDelete(ChartID(),"MALL"+Time[i]);
     ObjectCreate(ChartID(),"MALL"+Time[i],OBJ_TREND,0,Time[i-1],Low[i-1],Time[i-1]+20*PeriodSeconds(),Low[i-1]);
     ObjectSetInteger(ChartID(),"MALL"+Time[i],OBJPROP_RAY,False);
     //ObjectSetInteger(ChartID(),"MAL"+Time[i],OBJPROP_COLOR,clrDarkGreen);
     ObjectSetInteger(ChartID(),"MALL"+Time[i],OBJPROP_COLOR,clrLimeGreen);
     ObjectSetInteger(ChartID(),"MALL"+Time[i],OBJPROP_WIDTH,3);
     ObjectSetInteger(ChartID(),"MALL"+Time[i],OBJPROP_BACK,false);
     ObjectSetInteger(ChartID(),"MALL"+Time[i],OBJPROP_SELECTABLE,false);
     //ObjectSetString(ChartID(),"MAL"+Time[i],OBJPROP_TOOLTIP,TFtoStr(per));


     ObjectDelete(ChartID(),"MALH"+Time[i]);
     ObjectCreate(ChartID(),"MALH"+Time[i],OBJ_TREND,0,Time[i-1],High[i-1],Time[i-1]+20*PeriodSeconds(),High[i-1]);
     ObjectSetInteger(ChartID(),"MALH"+Time[i],OBJPROP_RAY,False);
     //ObjectSetInteger(ChartID(),"MAL"+Time[i],OBJPROP_COLOR,clrDarkGreen);
     ObjectSetInteger(ChartID(),"MALH"+Time[i],OBJPROP_COLOR,clrLimeGreen);
     ObjectSetInteger(ChartID(),"MALH"+Time[i],OBJPROP_WIDTH,3);
     ObjectSetInteger(ChartID(),"MALH"+Time[i],OBJPROP_BACK,false);
     ObjectSetInteger(ChartID(),"MALH"+Time[i],OBJPROP_SELECTABLE,false);
     //ObjectSetString(ChartID(),"MAL"+Time[i],OBJPROP_TOOLTIP,TFtoStr(per));     
          
     
     buy_times=Time[i];
     double sl=Ask-100*Point;
     double tp=Ask+200*Point;
      sl=iLow(sym,per,i+1);
      
      buy_price=iLow(sym,per,i-1);
      buy_tp=buy_price+200*Point;
      buy_sl=buy_price-100*Point;
      buy_sl=sl;
      buy_tp=iHigh(sym,per,i);
      //buy_tp=iClose(sym,per,i-1);
      buy_find=true;
      if ( nosl == true ) buy_sl=0;
     
buy_high_price=High[i-1];
buy_high_name="MALH"+Time[i];


     
     
//if ( buy_total == 0 ) {int ticket=OrderSend(Symbol(),OP_BUY,Lot,Ask,0,sl,tp,"BUY",magic,0,clrNONE);
//buy_time=Time[1];
//Alert("BUY ORDER");
//}

     
     
     }
     
     
     
if ( Bid > buy_high_price && buy_high_time!=Time[1] //&& buy_find == true && 
&& buy_smart == true
//&& buy_high_name=="MALH"+Time[i] 
 ) {

     ObjectDelete(ChartID(),buy_high_name);
     ObjectCreate(ChartID(),buy_high_name,OBJ_TREND,0,Time[i-1],High[i-1],Time[i-1]+20*PeriodSeconds(),High[i-1]);
     ObjectSetInteger(ChartID(),buy_high_name,OBJPROP_RAY,False);
     //ObjectSetInteger(ChartID(),"MAL"+Time[i],OBJPROP_COLOR,clrDarkGreen);
     ObjectSetInteger(ChartID(),buy_high_name,OBJPROP_COLOR,clrLimeGreen);
     ObjectSetInteger(ChartID(),buy_high_name,OBJPROP_WIDTH,3);
     ObjectSetInteger(ChartID(),buy_high_name,OBJPROP_BACK,false);
     ObjectSetInteger(ChartID(),buy_high_name,OBJPROP_SELECTABLE,false);
     //ObjectSetString(ChartID(),"MAL"+Time[i],OBJPROP_TOOLTIP,TFtoStr(per));     

buy_high_price=High[1];
buy_high_time=Time[1];

buy_tp=buy_high_price;

//if ( buy_ticket != -1 ) OrderModify(buy_ticket,buy_open_price,buy_sl,buy_tp,0,clrNONE);



}
     
     

if ( //buy_total == 0 && 
Bid > buy_tp && buy_find == true && buy_ticket != -1 ) {//int ticket=OrderSend(Symbol(),OP_BUY,Lot,Ask,0,buy_sl,buy_tp,"BUY",magic,0,clrNONE);
//buy_time=Time[1];
//Alert("BUY ORDER");
///buy_find=false;
}
     
  
  
  

  
       

if ( //buy_total == 0 && 

Bid < buy_price && buy_find == true && buy_smart == false //&& buy_ticket == -1
 ) {
buy_tp=buy_high_price;
buy_tp=0;
buy_ticket=OrderSend(Symbol(),OP_BUY,Lot,Ask,0,buy_sl-(Bid-buy_sl),buy_tp,"BUYSMART",magic,0,clrNONE);
//buy_time=Time[1];
//Alert("BUY ORDER");
buy_find=false;

if ( sell_smart == false ) sell_find=false;
 

}
     
    /* 
if (buy_tp == 0 && buy_ticket != -1 && Bid >= buy_high_price ) {
OrderClose(buy_ticket,Lot,Bid,0,clrNONE);
//buy_find=false;
buy_ticket=-1;
}*/
     
     

if ( //buy_smart == true && 
Open[1] >= ma50 && Close[1] < ma50 && buy_smart_profit > 0 && (Bid-buy_smart_op)/Point >= 250 //&& Bid > buy_high_price
) {
CloseAllBuyOrders();
buy_smart=false;
Print("SellPoint:",(Bid-buy_smart_op)/Point);
}



     if ( iOpen(sym,per,i)-iClose(sym,per,i) > Ortalama*5 && Time[i] != sell_times
     
     && iClose(sym,per,i-1) < iOpen(sym,per,i-1) 
     
     //&& iLow(sym,per,i) < iLow(sym,per,i-1)
     && ((safe==true && iLow(sym,per,i) < iLow(sym,per,i-1)) || safe==false)
     
     && iClose(sym,per,i-1) < iLow(sym,per,i+1)
     
     && sell_smart == false
     
     && Bid < ma50
     
     ) {
     
     double ort=DivZero(iOpen(sym,per,i)-iClose(sym,per,i),Ortalama);

     ObjectDelete(ChartID(),"MAL"+Time[i]);
     ObjectCreate(ChartID(),"MAL"+Time[i],OBJ_TREND,0,Time[i],Open[i],Time[i],Close[i]);
     ObjectSetInteger(ChartID(),"MAL"+Time[i],OBJPROP_RAY,False);
     //ObjectSetInteger(ChartID(),"MAL"+Time[i],OBJPROP_COLOR,clrCrimson);
     ObjectSetInteger(ChartID(),"MAL"+Time[i],OBJPROP_COLOR,clrYellow);
     ObjectSetInteger(ChartID(),"MAL"+Time[i],OBJPROP_WIDTH,3);
     ObjectSetInteger(ChartID(),"MAL"+Time[i],OBJPROP_BACK,false);
     ObjectSetInteger(ChartID(),"MAL"+Time[i],OBJPROP_SELECTABLE,false);
     //ObjectSetString(ChartID(),"MAL"+Time[i],OBJPROP_TOOLTIP,TFtoStr(per));
     
     ObjectDelete(ChartID(),"MALL"+Time[i]);
     ObjectCreate(ChartID(),"MALL"+Time[i],OBJ_TREND,0,Time[i-1],High[i-1],Time[i-1]+20*PeriodSeconds(),High[i-1]);
     ObjectSetInteger(ChartID(),"MALL"+Time[i],OBJPROP_RAY,False);
     //ObjectSetInteger(ChartID(),"MAL"+Time[i],OBJPROP_COLOR,clrDarkGreen);
     ObjectSetInteger(ChartID(),"MALL"+Time[i],OBJPROP_COLOR,clrYellow);
     ObjectSetInteger(ChartID(),"MALL"+Time[i],OBJPROP_WIDTH,3);
     ObjectSetInteger(ChartID(),"MALL"+Time[i],OBJPROP_BACK,false);
     ObjectSetInteger(ChartID(),"MALL"+Time[i],OBJPROP_SELECTABLE,false);
     //ObjectSetString(ChartID(),"MAL"+Time[i],OBJPROP_TOOLTIP,TFtoStr(per));
          

     ObjectDelete(ChartID(),"MALH"+Time[i]);
     ObjectCreate(ChartID(),"MALH"+Time[i],OBJ_TREND,0,Time[i-1],Low[i-1],Time[i-1]+20*PeriodSeconds(),Low[i-1]);
     ObjectSetInteger(ChartID(),"MALH"+Time[i],OBJPROP_RAY,False);
     //ObjectSetInteger(ChartID(),"MAL"+Time[i],OBJPROP_COLOR,clrDarkGreen);
     ObjectSetInteger(ChartID(),"MALH"+Time[i],OBJPROP_COLOR,clrYellow);
     ObjectSetInteger(ChartID(),"MALH"+Time[i],OBJPROP_WIDTH,3);
     ObjectSetInteger(ChartID(),"MALH"+Time[i],OBJPROP_BACK,false);
     ObjectSetInteger(ChartID(),"MALH"+Time[i],OBJPROP_SELECTABLE,false);
     //ObjectSetString(ChartID(),"MAL"+Time[i],OBJPROP_TOOLTIP,TFtoStr(per));   
     
     
     sell_times=Time[i];
     
     double sl=Bid+100*Point;
     double tp=Bid-200*Point;
     sl=iHigh(sym,per,i+1);

      sell_price=iHigh(sym,per,i-1);
      sell_tp=sell_price-200*Point;
      sell_sl=sell_price+100*Point;
      sell_tp=iLow(sym,per,i);
      //sell_tp=iClose(sym,per,i-1);
      sell_sl=sl;
      if ( nosl == true ) sell_sl=0;
      sell_find=true;
      

sell_low_price=Low[i-1];
sell_low_name="MALH"+Time[i];
      
           
    
/*
if ( sell_total == 0 ) {int ticket=OrderSend(Symbol(),OP_SELL,Lot,Bid,0,sl,tp,"SELL",magic,0,clrNONE);
//sell_time=Time[1];
//Alert("SELL ORDER");
}
*/

     
     }    
     

if ( Ask < sell_low_price && sell_low_time!=Time[1] //&& sell_find == true 
&& sell_smart == true //&& sell_low_name=="MALH"+Time[i]
 ) {

     ObjectDelete(ChartID(),sell_low_name);
     ObjectCreate(ChartID(),sell_low_name,OBJ_TREND,0,Time[i-1],High[i-1],Time[i-1]+20*PeriodSeconds(),High[i-1]);
     ObjectSetInteger(ChartID(),sell_low_name,OBJPROP_RAY,False);
     //ObjectSetInteger(ChartID(),"MAL"+Time[i],OBJPROP_COLOR,clrDarkGreen);
     ObjectSetInteger(ChartID(),sell_low_name,OBJPROP_COLOR,clrYellow);
     ObjectSetInteger(ChartID(),sell_low_name,OBJPROP_WIDTH,3);
     ObjectSetInteger(ChartID(),sell_low_name,OBJPROP_BACK,false);
     ObjectSetInteger(ChartID(),sell_low_name,OBJPROP_SELECTABLE,false);
     //ObjectSetString(ChartID(),"MAL"+Time[i],OBJPROP_TOOLTIP,TFtoStr(per));     

sell_low_price=Low[1];
sell_low_time=Time[1];

sell_tp=sell_low_price;

//if ( sell_ticket != -1 ) OrderModify(sell_ticket,sell_open_price,sell_sl,sell_tp,0,clrNONE);


}


     
     

if ( //sell_total == 0 &&
 Ask > sell_tp && sell_find==true) {//int ticket=OrderSend(Symbol(),OP_SELL,Lot,Bid,0,sell_sl,sell_tp,"SELL",magic,0,clrNONE);
//sell_time=Time[1];
//Alert("SELL ORDER");
///sell_find=false;
}


     
          
if ( //sell_total == 0 &&
 Ask > sell_price && sell_find==true && sell_ticket == -1 && sell_smart == false ) {
 sell_tp=sell_low_price;
 sell_tp=0;
 sell_ticket=OrderSend(Symbol(),OP_SELL,Lot,Bid,0,sell_sl+(sell_sl-Bid),sell_tp,"SELLSMART",magic,0,clrNONE);
 //sell_time=Time[1];
//Alert("SELL ORDER");
sell_find=false;

if ( buy_smart == false ) buy_find=false;

}
/*
if (sell_tp == 0 && sell_ticket != -1 && Ask <= sell_low_price ) {
OrderClose(sell_ticket,Lot,Ask,0,clrNONE);
//sell_find=false;
sell_ticket=-1;
}
 */    



if ( //sell_smart == true && 
Open[1] <= ma50 && Close[1] > ma50 && sell_smart_profit > 0 && (sell_smart_op-Bid)/Point >= 250  //&& Bid < sell_low_price
 ) {
CloseAllSellOrders();
sell_smart=false;
Print("SellPoint:",(sell_smart_op-Bid)/Point);
}
     
     
     
     
     
     return;
     


     if ( iClose(sym,per,i)-iOpen(sym,per,i) > Ortalama*5 && Time[i] != buy_time 
     
     && iOpen(sym,per,i-1) > iClose(sym,per,i-1)
     
     && ((safe==true &&  iHigh(sym,per,i) > iHigh(sym,per,i-1)) || safe==false)
     
     && iClose(sym,per,i-1) > iHigh(sym,per,i+1)
     
     ) {
     
     double ort=DivZero(iClose(sym,per,i)-iOpen(sym,per,i),Ortalama);

     ObjectDelete(ChartID(),"MAL"+Time[i]);
     ObjectCreate(ChartID(),"MAL"+Time[i],OBJ_TREND,0,Time[i],Open[i],Time[i],Close[i]);
     ObjectSetInteger(ChartID(),"MAL"+Time[i],OBJPROP_RAY,False);
     //ObjectSetInteger(ChartID(),"MAL"+Time[i],OBJPROP_COLOR,clrDarkGreen);
     ObjectSetInteger(ChartID(),"MAL"+Time[i],OBJPROP_COLOR,clrLimeGreen);
     ObjectSetInteger(ChartID(),"MAL"+Time[i],OBJPROP_WIDTH,3);
     ObjectSetInteger(ChartID(),"MAL"+Time[i],OBJPROP_BACK,false);
     ObjectSetInteger(ChartID(),"MAL"+Time[i],OBJPROP_SELECTABLE,false);
     //ObjectSetString(ChartID(),"MAL"+Time[i],OBJPROP_TOOLTIP,TFtoStr(per));
     
     buy_time=Time[i];
     double sl=Ask-100*Point;
     double tp=Ask+200*Point;
     tp=iHigh(sym,per,i);
     //tp=iHigh(sym,per,i-1);
      sl=iLow(sym,per,i+1);
      if ( nosl == true ) sl=0;
     
     int ticket=OrderSend(Symbol(),OP_BUY,Lot,Ask,0,sl,tp,"BUY",magic,0,clrNONE);
     
if ( buy_total == 0 ) {
//int ticket=OrderSend(Symbol(),OP_BUY,Lot,Ask,0,sl,tp,"BUY",magic,0,clrNONE);
//buy_time=Time[1];
//Alert("BUY ORDER");
}

     
     
     }
     
     
     
     

     if ( iOpen(sym,per,i)-iClose(sym,per,i) > Ortalama*5 && Time[i] != sell_time
     
     && iClose(sym,per,i-1) > iOpen(sym,per,i-1) 
     
     && ((safe==true && iLow(sym,per,i) < iLow(sym,per,i-1)) || safe==false)
     
     && iClose(sym,per,i-1) < iLow(sym,per,i+1)
     
     
     
     ) {
     
     double ort=DivZero(iOpen(sym,per,i)-iClose(sym,per,i),Ortalama);

     ObjectDelete(ChartID(),"MAL"+Time[i]);
     ObjectCreate(ChartID(),"MAL"+Time[i],OBJ_TREND,0,Time[i],Open[i],Time[i],Close[i]);
     ObjectSetInteger(ChartID(),"MAL"+Time[i],OBJPROP_RAY,False);
     //ObjectSetInteger(ChartID(),"MAL"+Time[i],OBJPROP_COLOR,clrCrimson);
     ObjectSetInteger(ChartID(),"MAL"+Time[i],OBJPROP_COLOR,clrYellow);
     ObjectSetInteger(ChartID(),"MAL"+Time[i],OBJPROP_WIDTH,3);
     ObjectSetInteger(ChartID(),"MAL"+Time[i],OBJPROP_BACK,false);
     ObjectSetInteger(ChartID(),"MAL"+Time[i],OBJPROP_SELECTABLE,false);
     //ObjectSetString(ChartID(),"MAL"+Time[i],OBJPROP_TOOLTIP,TFtoStr(per));
     
     sell_time=Time[i];
     
     double sl=Bid+100*Point;
     double tp=Bid-200*Point;
     tp=iLow(sym,per,i);
     //tp=iLow(sym,per,i-1);     
     sl=iHigh(sym,per,i+1);
     if ( nosl == true ) sl=0;
     
     int ticket=OrderSend(Symbol(),OP_SELL,Lot,Bid,0,sl,tp,"SELL",magic,0,clrNONE);

if ( sell_total == 0 ) {//int ticket=OrderSend(Symbol(),OP_SELL,Lot,Bid,0,sl,tp,"SELL",magic,0,clrNONE);
//sell_time=Time[1];
//Alert("SELL ORDER");
}

     
     
     
     }    
     
          

return;

     if ( iClose(sym,per,i)-iOpen(sym,per,i) > Ortalama*5 && Time[i] != buy_time ) {
     
     double ort=DivZero(iClose(sym,per,i)-iOpen(sym,per,i),Ortalama);

     ObjectDelete(ChartID(),"MAL"+Time[i]);
     ObjectCreate(ChartID(),"MAL"+Time[i],OBJ_TREND,0,Time[i],Open[i],Time[i],Close[i]);
     ObjectSetInteger(ChartID(),"MAL"+Time[i],OBJPROP_RAY,False);
     //ObjectSetInteger(ChartID(),"MAL"+Time[i],OBJPROP_COLOR,clrDarkGreen);
     ObjectSetInteger(ChartID(),"MAL"+Time[i],OBJPROP_COLOR,clrLimeGreen);
     ObjectSetInteger(ChartID(),"MAL"+Time[i],OBJPROP_WIDTH,3);
     ObjectSetInteger(ChartID(),"MAL"+Time[i],OBJPROP_BACK,false);
     ObjectSetInteger(ChartID(),"MAL"+Time[i],OBJPROP_SELECTABLE,false);
     //ObjectSetString(ChartID(),"MAL"+Time[i],OBJPROP_TOOLTIP,TFtoStr(per));
     
     buy_time=Time[i];
     
     
     }
     
     

     if ( iOpen(sym,per,i)-iClose(sym,per,i) > Ortalama*5 && Time[i] != sell_time) {
     
     double ort=DivZero(iOpen(sym,per,i)-iClose(sym,per,i),Ortalama);

     ObjectDelete(ChartID(),"MAL"+Time[i]);
     ObjectCreate(ChartID(),"MAL"+Time[i],OBJ_TREND,0,Time[i],Open[i],Time[i],Close[i]);
     ObjectSetInteger(ChartID(),"MAL"+Time[i],OBJPROP_RAY,False);
     //ObjectSetInteger(ChartID(),"MAL"+Time[i],OBJPROP_COLOR,clrCrimson);
     ObjectSetInteger(ChartID(),"MAL"+Time[i],OBJPROP_COLOR,clrYellow);
     ObjectSetInteger(ChartID(),"MAL"+Time[i],OBJPROP_WIDTH,3);
     ObjectSetInteger(ChartID(),"MAL"+Time[i],OBJPROP_BACK,false);
     ObjectSetInteger(ChartID(),"MAL"+Time[i],OBJPROP_SELECTABLE,false);
     //ObjectSetString(ChartID(),"MAL"+Time[i],OBJPROP_TOOLTIP,TFtoStr(per));
     
     sell_time=Time[i];
     
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


   int ortalama_last_bar= -1;

 
double BarOrtalama(int StartVisibleBar,int FinishVisibleBarLenght,string Sym,int Per) { 

///FinishVisibleBarLenght=PERIOD_W1/Period();
//Print("FinishVisibleBarLenght",FinishVisibleBarLenght);
///if ( FinishVisibleBarLenght > Bars ) FinishVisibleBarLenght=Bars;



if ( ortalama_last_bar == WindowFirstVisibleBar() && StartVisibleBar == -1 ) return Ortalama;


if ( ortalama_last_bar != WindowFirstVisibleBar() ) {
ortalama_last_bar = WindowFirstVisibleBar();
}

//Print("FinishVisibleBarLenght2",FinishVisibleBarLenght);


int mumanaliz_shift;
int mumanaliz_shiftb;

   if ( WindowFirstVisibleBar()-WindowBarsPerChart() > 0 ) {
   mumanaliz_shift=WindowFirstVisibleBar()-WindowBarsPerChart();
   } else {
   mumanaliz_shift=0;
   }
   mumanaliz_shiftb=WindowFirstVisibleBar();
   
   
   
   if ( StartVisibleBar != -1 ) mumanaliz_shift=StartVisibleBar;
   
   if ( FinishVisibleBarLenght != -1 ) mumanaliz_shiftb=mumanaliz_shift+FinishVisibleBarLenght;
   
   
   int bar_toplam = mumanaliz_shiftb-mumanaliz_shift;
   double bar_pip = 0;
   double bar_ortalama=0;
   
   for (int t=mumanaliz_shift;t<=mumanaliz_shiftb;t++) {
   
   //bar_pip = bar_pip + MathAbs(Close(select_sym,select_per,t)-Open(select_sym,select_per,t));
   ///bar_pip = bar_pip + MathAbs(Close(select_sym,select_per,t)-Open(select_sym,select_per,t));
   bar_pip = bar_pip + MathAbs(iClose(Sym,Per,t)-iOpen(Sym,Per,t));
   
   }
  
   
   bar_ortalama = bar_pip / bar_toplam;
   
   return bar_ortalama;

}




void CloseAllOrdersMix()
{
   for (int m=OrdersTotal(); m>=0; m--)
   {
      if ( OrderSelect(m, SELECT_BY_POS))
      {
         if(OrderSymbol() == Symbol() && OrderMagicNumber() == magic )
         {
            RefreshRates();
            bool success = OrderClose(OrderTicket(), OrderLots(), OrderClosePrice(), 0, Blue);
         }
      }
    }
}


void CloseAllBuyOrders()
{
   for (int m=OrdersTotal(); m>=0; m--)
   {
      if ( OrderSelect(m, SELECT_BY_POS))
      {
         if(OrderType() == OP_BUY && OrderSymbol() == Symbol() && OrderMagicNumber() == magic )
         {
            RefreshRates();
            bool success = OrderClose(OrderTicket(), OrderLots(), Bid, 0, Blue);
         }
      }
    }
}

void CloseAllSellOrders()
{
   for (int h=OrdersTotal();h>=0;h--)
   {
      if ( OrderSelect(h,SELECT_BY_POS) )
      {
         if(OrderType() == OP_SELL && OrderSymbol() == Symbol() && OrderMagicNumber() == magic )
         {
            RefreshRates();
            bool success =OrderClose(OrderTicket(), OrderLots(), Ask, 0, Red);
         }
      }
   }
}

void CloseAllOrders()
{
   CloseAllBuyOrders();
   CloseAllSellOrders();
}
