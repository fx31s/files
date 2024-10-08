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
  
  double last_acc_profit=0;
  
  
  bool martin=false;
  
  
  
  
  
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer
   //EventSetTimer(60);
   
   robotime=Time[1];
   
   
   if ( Year() != 2023 ) {   
   ExpertRemove();
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
int sell_smart_total=0;
int buy_smart_total=0;

double sell_smart_op;
double buy_smart_op;

double last_buy_price=-1;
double last_sell_price=-1;

void OnTick()
  {
//---

   if ( Year() != 2023 ) {   
   ExpertRemove();
   }
   

if ( AccountProfit() < last_acc_profit ) {
last_acc_profit=AccountProfit();
Print("Last Acc Profit:",last_acc_profit);
}

sell_smart=false;
buy_smart=false;

double ma50=iMA(Symbol(), Period(), 50, 15, MODE_SMA, PRICE_OPEN, 1);



/////////////////////////////////////////////////////////////////////////////////////////////////////
sell_total=0;
buy_total=0;
buy_smart_profit=0;
sell_smart_profit=0;
buy_profit=0;
sell_profit=0;
sell_smart_total=0;
buy_smart_total=0;



   for (int h=OrdersTotal();h>=0;h--)
   {
      if ( OrderSelect(h,SELECT_BY_POS) )
      {
         if(OrderType() == OP_SELL && OrderSymbol() == Symbol() && OrderMagicNumber() == magic )
         {
         sell_total=sell_total+1;
         //sell_profit=sell_profit+OrderProfit();
         
         if ( OrderProfit() > 0 ) {sell_profit=sell_profit+MathAbs(OrderProfit());
         sell_profit=sell_profit-MathAbs(OrderSwap());
         sell_profit=sell_profit-MathAbs(OrderCommission());
         }
         if ( OrderProfit() < 0 ) {sell_profit=sell_profit-MathAbs(OrderProfit());
         sell_profit=sell_profit-MathAbs(OrderSwap());
         sell_profit=sell_profit-MathAbs(OrderCommission());
         }
         
                  
         
         if ( OrderComment() == "SELLSMART" ) {sell_smart=true;
         sell_smart_profit=sell_smart_profit+OrderProfit();
         sell_smart_op=OrderOpenPrice();
         sell_smart_total=sell_smart_total+1;
         }
         
         }
         
         if(OrderType() == OP_BUY && OrderSymbol() == Symbol() && OrderMagicNumber() == magic )
         {
         buy_total=buy_total+1;
         if ( OrderProfit() > 0 ) {buy_profit=buy_profit+MathAbs(OrderProfit());
         buy_profit=buy_profit-MathAbs(OrderSwap());
         buy_profit=buy_profit-MathAbs(OrderCommission());
         }
         if ( OrderProfit() < 0 ) {buy_profit=buy_profit-MathAbs(OrderProfit());
         buy_profit=buy_profit-MathAbs(OrderSwap());
         buy_profit=buy_profit-MathAbs(OrderCommission());
         }
         
         if ( OrderComment() == "BUYSMART" ) {buy_smart=true;
         buy_smart_profit=buy_smart_profit+OrderProfit();
         buy_smart_op=OrderOpenPrice();
         buy_smart_total=buy_smart_total+1;
         }
         
         }
                  
         
      }
   }   
////////////////////////////////////////////////////////////////////////////////////////////////////   
   
   if ( buy_smart == false ) buy_ticket=-1;
   if ( sell_smart == false ) sell_ticket=-1;
   
   
   
   /*
   if ( buy_profit > 1.80 && buy_total >= 1) {
   CloseAllBuyOrders();
   buy_find=false;
   buy_ticket=-1;
   last_buy_price=-1;
   Print("Buy Profit:",buy_profit);
   }

   if ( sell_profit > 1.80 && sell_total >= 1) {
   CloseAllSellOrders();
   sell_find=false;
   sell_ticket=-1;
   last_sell_price=-1;
   }*/
      
   
   
   
   
   if ( avrg_time != Time[1] ) {
   Ortalama=BarOrtalama(1,300,Symbol(),Period());
   Comment("BarOrtalama:",Ortalama);
   avrg_time=Time[1];
   }

Comment("BarOrtalama:",Ortalama,"\nBuy Profit:",buy_profit,"\nSell Profit:",sell_profit,"\nAccProfit:",AccountProfit(),"\n DD:",last_acc_profit);

int i=2;

bool buy_order_sys=true;


if ( buy_order_sys == true ) {

     if ( iClose(sym,per,i)-iOpen(sym,per,i) > Ortalama*5 && Time[i] != buy_times 
     
     && iClose(sym,per,i-1) > iOpen(sym,per,i-1)
     
     //&& iHigh(sym,per,i) > iHigh(sym,per,i-1)
     && ((safe==true &&  iHigh(sym,per,i) > iHigh(sym,per,i-1)) || safe==false)
     
     && iClose(sym,per,i-1) > iHigh(sym,per,i+1)
     
     //&& buy_smart == false
     
     //&& Bid > ma50
     
     && buy_smart_total == 0 
     
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
      buy_price=iOpen(sym,per,i-1);

      buy_tp=buy_price+200*Point;
      buy_sl=buy_price-100*Point;
      buy_sl=sl;
      buy_tp=iHigh(sym,per,i);
      //buy_tp=iClose(sym,per,i-1);
      buy_find=true;
      if ( nosl == true ) buy_sl=0;
     
buy_high_price=High[i-1];
buy_high_name="MALH"+Time[i];




   double low_price=Low[i];
   double high_price=High[i];


  double yuzde = DivZero(high_price-low_price, 100);
   
   
   double eq=low_price+yuzde*50; // 50
   
   double level45=low_price+yuzde*45; // 50
   double level55=low_price+yuzde*55; // 50
   
   double level70=low_price+yuzde*70; // 50
   double level79=low_price+yuzde*79; // 50
   double level21=low_price+yuzde*21; // 50
   double level30=low_price+yuzde*30; // 50
   

   double level168=yuzde*16.18; // 50
   double level130=yuzde*13; // 50
   double level272=yuzde*27.2; // 50
   double level414=yuzde*41.4; // 50
   double level618=yuzde*61.8; // 50 
   double level886=yuzde*88.6; // 50   
   double level342=yuzde*34.2; // 50      
   
   double level0=0;
   double level100=0; 


   double tepe_prc=high_price;
   double dip_prc=low_price;
   double fractal133=(tepe_prc-dip_prc)*1.133;
         //fractal133=dip_prc+fractal133;  

   double level=fractal133*1.3;
   buy_sl=low_price-level;
   
   
   level=level886;
   buy_tp=high_price+level;
     
     
//if ( buy_total == 0 ) {int ticket=OrderSend(Symbol(),OP_BUY,Lot,Ask,0,sl,tp,"BUY",magic,0,clrNONE);
//buy_time=Time[1];
//Alert("BUY ORDER");
//}

     
     
     }
     
     
     
if ( Bid > buy_high_price && buy_high_time!=Time[1] //&& buy_find == true && 
&& buy_smart == true

&& buy_smart_total == 0


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

//buy_tp=buy_high_price;

//if ( buy_ticket != -1 ) OrderModify(buy_ticket,buy_open_price,buy_sl,buy_tp,0,clrNONE);



}
     
     

if ( //buy_total == 0 && 
Bid > buy_tp && buy_find == true && buy_ticket != -1 ) {//int ticket=OrderSend(Symbol(),OP_BUY,Lot,Ask,0,buy_sl,buy_tp,"BUY",magic,0,clrNONE);
//buy_time=Time[1];
//Alert("BUY ORDER");
///buy_find=false;
}
     
  
  
  

  
       

if ( //buy_total == 0 && 

Bid < buy_price && buy_find == true //&& buy_smart == false //&& buy_ticket == -1

//&& ( last_buy_price == -1 || (last_buy_price != -1 && (last_buy_price-Bid)/Point >= 500) )

//&& martin == true

&& buy_smart_total == 0

 ) {
 
 double last_buy_lot=0.01;
 
if ( buy_total == 0 ) last_buy_lot=0.01;
if ( buy_total == 1 ) last_buy_lot=0.02;
if ( buy_total == 2 ) last_buy_lot=0.04;
if ( buy_total == 3 ) last_buy_lot=0.08;
if ( buy_total > 3 ) last_buy_lot=0.16;
Lot=last_buy_lot;

 
//buy_tp=buy_high_price;
//buy_tp=0;
//buy_sl=0;
//buy_ticket=OrderSend(Symbol(),OP_BUY,Lot,Ask,0,buy_sl-(Bid-buy_sl),buy_tp,"BUYSMART",magic,0,clrNONE);
buy_ticket=OrderSend(Symbol(),OP_BUY,Lot,Ask,0,buy_sl,buy_tp,"BUYSMART",magic,0,clrNONE);
//buy_time=Time[1];
//Alert("BUY ORDER");
buy_find=false;
buy_smart=false;
//last_buy_price=Ask;
last_buy_price=-1;
if ( sell_smart == false ) sell_find=false;
 

}
     
    /* 
if (buy_tp == 0 && buy_ticket != -1 && Bid >= buy_high_price ) {
OrderClose(buy_ticket,Lot,Bid,0,clrNONE);
//buy_find=false;
buy_ticket=-1;
}*/
     
     
/*
if ( //buy_smart == true && 
Open[1] >= ma50 && Close[1] < ma50 && buy_smart_profit > 0 && (Bid-buy_smart_op)/Point >= 250 //&& Bid > buy_high_price
) {
CloseAllBuyOrders();
buy_smart=false;
Print("SellPoint:",(Bid-buy_smart_op)/Point);
}
*/


}



//return;



bool sell_order_sys=true;

if ( sell_order_sys == true ) {


     if ( iOpen(sym,per,i)-iClose(sym,per,i) > Ortalama*5 && Time[i] != sell_times
     
     && iClose(sym,per,i-1) < iOpen(sym,per,i-1) 
     
     //&& iLow(sym,per,i) < iLow(sym,per,i-1)
     && ((safe==true && iLow(sym,per,i) < iLow(sym,per,i-1)) || safe==false)
     
     && iClose(sym,per,i-1) < iLow(sym,per,i+1)
     
     //&& sell_smart == false
     
     //&& Bid < ma50
     
     && sell_smart_total == 0
     
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
     


   double low_price=Low[i];
   double high_price=High[i];


  double yuzde = DivZero(high_price-low_price, 100);
   
   
   double eq=low_price+yuzde*50; // 50
   
   double level45=low_price+yuzde*45; // 50
   double level55=low_price+yuzde*55; // 50
   
   double level70=low_price+yuzde*70; // 50
   double level79=low_price+yuzde*79; // 50
   double level21=low_price+yuzde*21; // 50
   double level30=low_price+yuzde*30; // 50
   

   double level168=yuzde*16.18; // 50
   double level130=yuzde*13; // 50
   double level272=yuzde*27.2; // 50
   double level414=yuzde*41.4; // 50
   double level618=yuzde*61.8; // 50 
   double level886=yuzde*88.6; // 50   
   double level342=yuzde*34.2; // 50      
   
   double level0=0;
   double level100=0; 


   double tepe_prc=high_price;
   double dip_prc=low_price;
   double fractal133=(tepe_prc-dip_prc)*1.133;
         //fractal133=dip_prc+fractal133;  

   double level=fractal133*1.3;
   sell_sl=high_price+level;
   
   
   level=level886;
   sell_tp=low_price-level;
   
   
         
     
     
     sell_times=Time[i];
     
     double sl=Bid+100*Point;
     double tp=Bid-200*Point;
     sl=iHigh(sym,per,i+1);

      sell_price=iHigh(sym,per,i-1);
      sell_price=iOpen(sym,per,i-1);
      
      
      //sell_tp=sell_price-200*Point;
      //sell_sl=sell_price+100*Point;
      //sell_tp=iLow(sym,per,i);
      //sell_tp=iClose(sym,per,i-1);
      //sell_sl=sl;
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

&& sell_smart_total == 0

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

//sell_tp=sell_low_price;

//if ( sell_ticket != -1 ) OrderModify(sell_ticket,sell_open_price,sell_sl,sell_tp,0,clrNONE);


}


     
     

if ( //sell_total == 0 &&
 Ask > sell_tp && sell_find==true) {//int ticket=OrderSend(Symbol(),OP_SELL,Lot,Bid,0,sell_sl,sell_tp,"SELL",magic,0,clrNONE);
//sell_time=Time[1];
//Alert("SELL ORDER");
///sell_find=false;
}





          
if ( //sell_total == 0 &&
 Ask > sell_price && sell_find==true 
 
 //&& sell_ticket == -1 && sell_smart == false 

//&& ( last_sell_price == -1 || (last_sell_price != -1 && (Bid-last_sell_price)/Point >= 500))

 //&& martin == true
 
&& sell_smart_total == 0
 
 ) {
 
 double last_sell_lot=0.01;
 
if ( sell_total == 0 ) last_sell_lot=0.01;
if ( sell_total == 1 ) last_sell_lot=0.02;
if ( sell_total == 2 ) last_sell_lot=0.04;
if ( sell_total == 3 ) last_sell_lot=0.08;
if ( sell_total > 3 ) last_sell_lot=0.16;
Lot=last_sell_lot; 
 
 //sell_tp=sell_low_price;
 //sell_tp=0;
 //sell_sl=0;
 sell_ticket=OrderSend(Symbol(),OP_SELL,Lot,Bid,0,sell_sl,sell_tp,"SELLSMART",magic,0,clrNONE);
 //sell_time=Time[1];
//Alert("SELL ORDER");
sell_find=false;
last_sell_price=Bid;
last_sell_price=-1;

if ( buy_smart == false ) buy_find=false;

}
/*
if (sell_tp == 0 && sell_ticket != -1 && Ask <= sell_low_price ) {
OrderClose(sell_ticket,Lot,Ask,0,clrNONE);
//sell_find=false;
sell_ticket=-1;
}
 */    


/*
if ( //sell_smart == true && 
Open[1] <= ma50 && Close[1] > ma50 && sell_smart_profit > 0 && (sell_smart_op-Bid)/Point >= 250  //&& Bid < sell_low_price
 ) {
CloseAllSellOrders();
sell_smart=false;
Print("SellPoint:",(sell_smart_op-Bid)/Point);
}
 */    
    
    
    } 
     
     
     
     //return;
     
     
     
     bool buy_order_system = true;
     
     if ( buy_order_system == true ) {


     if ( iClose(sym,per,i)-iOpen(sym,per,i) > Ortalama*5 && Time[i] != buy_time 
     
     && iOpen(sym,per,i-1) > iClose(sym,per,i-1)
     
     && ((safe==true &&  iHigh(sym,per,i) > iHigh(sym,per,i-1)) || safe==false)
     
     && iClose(sym,per,i-1) > iHigh(sym,per,i+1)
     
     //&& ( last_buy_price == -1 || (last_buy_price != -1 && (last_buy_price-Bid)/Point >= 500) )
     
     //&& martin == true
     
     && buy_total == 0
     
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
      
      
      sl=0;
      tp=0;
      
 double last_buy_lot=0.01;
 
if ( buy_total == 0 ) last_buy_lot=0.01;
if ( buy_total == 1 ) last_buy_lot=0.02;
if ( buy_total == 2 ) last_buy_lot=0.04;
if ( buy_total == 3 ) last_buy_lot=0.08;
if ( buy_total > 3 ) last_buy_lot=0.16;
Lot=last_buy_lot;





   double low_price=Low[i];
   double high_price=High[i];


  double yuzde = DivZero(high_price-low_price, 100);
   
   
   double eq=low_price+yuzde*50; // 50
   
   double level45=low_price+yuzde*45; // 50
   double level55=low_price+yuzde*55; // 50
   
   double level70=low_price+yuzde*70; // 50
   double level79=low_price+yuzde*79; // 50
   double level21=low_price+yuzde*21; // 50
   double level30=low_price+yuzde*30; // 50
   

   double level168=yuzde*16.18; // 50
   double level130=yuzde*13; // 50
   double level272=yuzde*27.2; // 50
   double level414=yuzde*41.4; // 50
   double level618=yuzde*61.8; // 50 
   double level886=yuzde*88.6; // 50   
   double level342=yuzde*34.2; // 50      
   
   double level0=0;
   double level100=0; 


   double tepe_prc=high_price;
   double dip_prc=low_price;
   double fractal133=(tepe_prc-dip_prc)*1.133;
         //fractal133=dip_prc+fractal133;  

   double level=fractal133*1.3;
   sl=low_price-level;
   
   
   level=level886;
   tp=high_price+level;
     
     int ticket=OrderSend(Symbol(),OP_BUY,Lot,Ask,0,sl,tp,"BUY",magic,0,clrNONE);
     last_buy_price=-1;
     //buy_find=false;
     
if ( buy_total == 0 ) {
//int ticket=OrderSend(Symbol(),OP_BUY,Lot,Ask,0,sl,tp,"BUY",magic,0,clrNONE);
//buy_time=Time[1];
//Alert("BUY ORDER");
}

     
     
     }
     
     
     }
     
     //return;
     
     bool sell_order_system = true;
     
     if ( sell_order_system == true ) {

     

     if ( iOpen(sym,per,i)-iClose(sym,per,i) > Ortalama*5 && Time[i] != sell_time
     
     && iClose(sym,per,i-1) > iOpen(sym,per,i-1) 
     
     && ((safe==true && iLow(sym,per,i) < iLow(sym,per,i-1)) || safe==false)
     
     && iClose(sym,per,i-1) < iLow(sym,per,i+1)
     
     //&& ( last_sell_price == -1 || (last_sell_price != -1 && (Bid-last_sell_price)/Point >= 500))
     
     //&& martin == true
     
     && sell_total == 0
     
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
     
     sl=0;
     tp=0;
     
     
 double last_sell_lot=0.01;
 
if ( sell_total == 0 ) last_sell_lot=0.01;
if ( sell_total == 1 ) last_sell_lot=0.02;
if ( sell_total == 2 ) last_sell_lot=0.04;
if ( sell_total == 3 ) last_sell_lot=0.08;
if ( sell_total > 3 ) last_sell_lot=0.16;
Lot=last_sell_lot; 



   double low_price=Low[i];
   double high_price=High[i];


  double yuzde = DivZero(high_price-low_price, 100);
   
   
   double eq=low_price+yuzde*50; // 50
   
   double level45=low_price+yuzde*45; // 50
   double level55=low_price+yuzde*55; // 50
   
   double level70=low_price+yuzde*70; // 50
   double level79=low_price+yuzde*79; // 50
   double level21=low_price+yuzde*21; // 50
   double level30=low_price+yuzde*30; // 50
   

   double level168=yuzde*16.18; // 50
   double level130=yuzde*13; // 50
   double level272=yuzde*27.2; // 50
   double level414=yuzde*41.4; // 50
   double level618=yuzde*61.8; // 50 
   double level886=yuzde*88.6; // 50   
   double level342=yuzde*34.2; // 50      
   
   double level0=0;
   double level100=0; 


   double tepe_prc=high_price;
   double dip_prc=low_price;
   double fractal133=(tepe_prc-dip_prc)*1.133;
         //fractal133=dip_prc+fractal133;  

   double level=fractal133*1.3;
   sl=high_price+level;
   
   
   level=level886;
   tp=low_price-level;


     int ticket=OrderSend(Symbol(),OP_SELL,Lot,Bid,0,sl,tp,"SELL",magic,0,clrNONE);
     last_sell_price=-1;
     //sell_find=false;

if ( sell_total == 0 ) {//int ticket=OrderSend(Symbol(),OP_SELL,Lot,Bid,0,sl,tp,"SELL",magic,0,clrNONE);
//sell_time=Time[1];
//Alert("SELL ORDER");
}

     
     
     
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
