//+------------------------------------------------------------------+
//|                                                       Avaraj.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict


int active_magic_buy=0;
int active_magic_sell=-1;


double last_avarage_buy=0; 
double last_avarage_sell=0; 

double last_avarage_buy_profit_price=0;
double last_avarage_sell_profit_price=0;


// toplam 2 buy veya 2 sell olması lazım live da


//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---

//ObjectsDeleteAll();


EventSetTimer(1);

   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
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

//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//---
   
   AvarageSystem(0);
   //Print("Selam");
   
   
   
  }
  

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Sinyal Sistemi
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


void AvarageSystem(int mgc) {

if ( ChartGetInteger(ChartID(),CHART_BRING_TO_TOP) == 1 ) {


///////////////////////////////////////////////////////////////////////////////////////////////
// Lot Gösterici
///////////////////////////////////////////////////////////////////////////////////////////////
if ( OrdersTotal() > 0 ) {

double margin_buylot=0;
double margin_selllot=0;
double margin_buyprofit=0;
double margin_sellprofit=0;
double avarage = 0;
double avarage_total = 0;
double islem_sayisi = 0;
double islem_sayisi_buy = 0;
double islem_sayisi_sell = 0;


double avarage_total_buy = 0;
double avarage_total_sell = 0;

double avarage_buy = 0;
double avarage_sell = 0;


       for(int i=0; i<OrdersTotal(); i++) {
        if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) {
           if (OrderSymbol()==Symbol() && OrderMagicNumber() == mgc ) {
           
           //Alert("OrderTicket:",OrderTicket());
           
           //Print(OrderTicket(),"/",OrderMagicNumber());
           
           
           
           
        //if ( OrderType() == OP_BUY || OrderType() == OP_BUYSTOP ) {
        if ( OrderType() == OP_BUY  ) {
        
           margin_buylot = margin_buylot + OrderLots();
           
           islem_sayisi=islem_sayisi+(OrderLots()*100);
           avarage_total=avarage_total+(OrderOpenPrice()*(OrderLots()*100));           
           
           islem_sayisi_buy=islem_sayisi_buy+(OrderLots()*100);
           avarage_total_buy=avarage_total_buy+(OrderOpenPrice()*(OrderLots()*100));           
        }
        
        //if ( OrderType() == OP_SELL || OrderType() == OP_SELLSTOP ) {
        if ( OrderType() == OP_SELL  ) {
        
           margin_selllot = margin_selllot + OrderLots();
           
           islem_sayisi=islem_sayisi+(OrderLots()*100);
           avarage_total=avarage_total+(OrderOpenPrice()*(OrderLots()*100));
           
           islem_sayisi_sell=islem_sayisi_sell+(OrderLots()*100);
           avarage_total_sell=avarage_total_sell+(OrderOpenPrice()*(OrderLots()*100));           
        }
        
        
       if ( OrderType() == OP_BUY && OrderProfit() < 0 ) {
        
        margin_buyprofit = margin_buyprofit +  OrderProfit(); 
        
        } 
        
       if ( OrderType() == OP_SELL && OrderProfit() < 0 ) {
        
        margin_sellprofit = margin_sellprofit +  OrderProfit(); 
        
        } 
        
        



}
}
}

if ( avarage_total == 0 ) return;


//////////////////////////////////////////////////////////////////////////////////////////////
// AVARAGE SİSTEMİ
//////////////////////////////////////////////////////////////////////////////////////////////        
        avarage=DivZero(avarage_total,islem_sayisi);
        
        avarage_buy=DivZero(avarage_total_buy,islem_sayisi_buy);
        avarage_sell=DivZero(avarage_total_sell,islem_sayisi_sell);
        
        Comment("avarage_buy:",avarage_buy,"\n avarage_sell:",avarage_sell);
        
        double avarage_fark=avarage_buy-avarage_sell;
        

double avarage_buy_profit_price=avarage_buy+avarage_fark;
double avarage_sell_profit_price=avarage_sell-avarage_fark;

        
if ( last_avarage_buy_profit_price != avarage_buy_profit_price ) {        
if ( ObjectFind(ChartID(),"AvarageBuyp") == -1 ) {        
ObjectCreate(ChartID(),"AvarageBuyp",OBJ_HLINE,0,0,avarage_buy_profit_price);
ObjectSetInteger(ChartID(),"AvarageBuyp",OBJPROP_COLOR,clrLimeGreen);        
ObjectSetInteger(ChartID(),"AvarageBuyp",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),"AvarageBuyp",OBJPROP_SELECTABLE,true);
ObjectSetInteger(ChartID(),"AvarageBuyp",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),"AvarageBuyp",OBJPROP_STYLE,STYLE_DOT);
} else {
ObjectSetDouble(ChartID(),"AvarageBuyp",OBJPROP_PRICE,avarage_buy_profit_price);
last_avarage_buy_profit_price=avarage_buy_profit_price;
}  
}

if ( last_avarage_sell_profit_price != avarage_sell_profit_price ) {        
if ( ObjectFind(ChartID(),"AvarageSellp") == -1 ) {        
ObjectCreate(ChartID(),"AvarageSellp",OBJ_HLINE,0,0,avarage_sell_profit_price);
ObjectSetInteger(ChartID(),"AvarageSellp",OBJPROP_COLOR,clrLimeGreen);        
ObjectSetInteger(ChartID(),"AvarageSellp",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),"AvarageSellp",OBJPROP_SELECTABLE,true);
ObjectSetInteger(ChartID(),"AvarageSellp",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),"AvarageSellp",OBJPROP_STYLE,STYLE_DOT);
} else {
ObjectSetDouble(ChartID(),"AvarageSellp",OBJPROP_PRICE,avarage_sell_profit_price);
last_avarage_sell_profit_price=avarage_sell_profit_price;
}  
}



        
        
        
        ///Print("avarage",avarage,"/",islem_sayisi,"/",avarage_total);

if ( mgc == active_magic_buy ) {

if ( last_avarage_buy != avarage_buy ) {        
if ( ObjectFind(ChartID(),"AvarageBuy") == -1 ) {        
ObjectCreate(ChartID(),"AvarageBuy",OBJ_HLINE,0,0,avarage_buy);
ObjectSetInteger(ChartID(),"AvarageBuy",OBJPROP_COLOR,clrSandyBrown);        
ObjectSetInteger(ChartID(),"AvarageBuy",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),"AvarageBuy",OBJPROP_SELECTABLE,true);
ObjectSetInteger(ChartID(),"AvarageBuy",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),"AvarageBuy",OBJPROP_STYLE,STYLE_DASHDOT);
} else {
ObjectSetDouble(ChartID(),"AvarageBuy",OBJPROP_PRICE,avarage_buy);
last_avarage_buy=avarage_buy;
}   

if ( ObjectFind(ChartID(),"AvarageBuy") != -1 && islem_sayisi_buy == 0 ) ObjectDelete(ChartID(),"AvarageBuy");

}


if ( last_avarage_sell != avarage_sell ) {        
if ( ObjectFind(ChartID(),"AvarageSell") == -1 ) {        
ObjectCreate(ChartID(),"AvarageSell",OBJ_HLINE,0,0,avarage_sell);
ObjectSetInteger(ChartID(),"AvarageSell",OBJPROP_COLOR,clrCrimson);        
ObjectSetInteger(ChartID(),"AvarageSell",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),"AvarageSell",OBJPROP_SELECTABLE,true);
ObjectSetInteger(ChartID(),"AvarageSell",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),"AvarageSell",OBJPROP_STYLE,STYLE_DASHDOT);
} else {
ObjectSetDouble(ChartID(),"AvarageSell",OBJPROP_PRICE,avarage_sell);
last_avarage_sell=avarage_sell;
}   

if ( ObjectFind(ChartID(),"AvarageSell") != -1 && islem_sayisi_sell == 0 ) ObjectDelete(ChartID(),"AvarageSell");

}








}

///////////////////////////////////////////////////////////////////////////////////////////////////////     
if ( mgc == active_magic_sell ) {

if ( last_avarage_sell != avarage ) {        
if ( ObjectFind(ChartID(),"AvarageSell") == -1 ) {        
ObjectCreate(ChartID(),"AvarageSell",OBJ_HLINE,0,0,avarage_sell);
ObjectSetInteger(ChartID(),"AvarageSell",OBJPROP_COLOR,clrCrimson);        
ObjectSetInteger(ChartID(),"AvarageSell",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),"AvarageSell",OBJPROP_SELECTABLE,true);
ObjectSetInteger(ChartID(),"AvarageSell",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),"AvarageSell",OBJPROP_STYLE,STYLE_DASHDOT);
} else {
ObjectSetDouble(ChartID(),"AvarageSell",OBJPROP_PRICE,avarage_sell);
last_avarage_sell=avarage_sell;
}   

if ( ObjectFind(ChartID(),"AvarageSell") != -1 && islem_sayisi_sell == 0 ) ObjectDelete(ChartID(),"AvarageSell");

}


if ( last_avarage_buy != avarage_buy ) {        
if ( ObjectFind(ChartID(),"AvarageBuy") == -1 ) {        
ObjectCreate(ChartID(),"AvarageBuy",OBJ_HLINE,0,0,avarage_buy);
ObjectSetInteger(ChartID(),"AvarageBuy",OBJPROP_COLOR,clrSandyBrown);        
ObjectSetInteger(ChartID(),"AvarageBuy",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),"AvarageBuy",OBJPROP_SELECTABLE,true);
ObjectSetInteger(ChartID(),"AvarageBuy",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),"AvarageBuy",OBJPROP_STYLE,STYLE_DASHDOT);
} else {
ObjectSetDouble(ChartID(),"AvarageBuy",OBJPROP_PRICE,avarage_buy);
last_avarage_buy=avarage_buy;
}   

if ( ObjectFind(ChartID(),"AvarageBuy") != -1 && islem_sayisi_buy == 0 ) ObjectDelete(ChartID(),"AvarageBuy");

}







}

///////////////////////////////////////////////////////////////////////////////////////////////////////     
  
  
    
  
  
  
  
  
  
}
}


}

/////////////////////////////////////////////////////////////////////////////////////////
// Divide Zero Hatası için formül.
/////////////////////////////////////////////////////////////////////////////////////////
double DivZero(double n, double d)
{
if (d==0) return(0);  else return(n/d);
} 
//////////////////////////////////////////////////////////////////////} 
