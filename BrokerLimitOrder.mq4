//+------------------------------------------------------------------+
//|                                             BrokerLimitOrder.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

int magic=0;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
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
   BrokerLimitOrderOpener("");
  }
//+----


void BrokerLimitOrderOpener(string cmt)
{
   for (int m=OrdersTotal(); m>=0; m--)
   {
      if ( OrderSelect(m, SELECT_BY_POS))
      {
         if(OrderType() >= 2  //&& OrderSymbol() == Symbol() && OrderMagicNumber() == magic && StringFind(OrderComment(),cmt,0) != -1 
         )
         {
         
         string sym=OrderSymbol();
         
         double grid_price=NormalizeDouble(OrderOpenPrice(),MarketInfo(sym,MODE_DIGITS));
         string grid_cmt="";         
         double ord_price=grid_price;
         
         
         
         double Asks=MarketInfo(sym,MODE_ASK);
         double Bids=MarketInfo(sym,MODE_BID);
         
         
         
         if ( OrderType() == OP_SELLLIMIT ) {
         //grid_cmt=level_ticket_order+"SELLL"+DoubleToString(grid_price,Digits);
         grid_cmt="SELL"+DoubleToString(grid_price,MarketInfo(sym,MODE_DIGITS));
         
/*
if ( iClose(sym,PERIOD_M1,0) >=  ord_price  ) { // Kırmızı

OrderDelete(OrderTicket(),clrNONE);
OrderSend(sym,OP_SELL,OrderLots(),Bids,0,0,0,grid_cmt,magic,0,clrNONE);

} else {
*/

if ( iClose(sym,PERIOD_M1,1) >= ord_price || iHigh(sym,PERIOD_M1,1) >= ord_price ) { // İşlem geldiği halde açmadıysa

if ( //iClose(sym,PERIOD_M1,0) >  iOpen(sym,PERIOD_M1,1) 

//|| 

ord_price-MarketInfo(sym,MODE_BID) >= 0 && ord_price-MarketInfo(sym,MODE_BID) <= 20*MarketInfo(sym,MODE_POINT)

) { // Kırmızı

OrderDelete(OrderTicket(),clrNONE);
OrderSend(sym,OP_SELL,OrderLots(),Bids,0,0,0,OrderComment(),magic,0,clrNONE);
Sleep(100);

}


//}

}  
         
         }


         if ( OrderType() == OP_BUYLIMIT ) { 
         // Buy Ask Açar Bid üzerinde dolaşıyor, ask fiyata gelmiyor.
         ////////////////////////////////////////////////////////////////////
         //grid_cmt=level_ticket_order+"BUYL"+DoubleToString(grid_price,Digits);
         grid_cmt="BUY"+DoubleToString(grid_price,Digits);
 /*        
if ( iClose(sym,PERIOD_M1,0) <=  ord_price ) { // Kırmızı

OrderDelete(OrderTicket(),clrNONE);
OrderSend(sym,OP_BUY,OrderLots(),Asks,0,0,0,grid_cmt,magic,0,clrNONE);

} else {*/


if ( iClose(sym,PERIOD_M1,1) <= ord_price || iLow(sym,PERIOD_M1,1) <= ord_price ) {

if ( //iClose(sym,PERIOD_M1,0) <  iOpen(sym,PERIOD_M1,1) 

//|| 
MarketInfo(sym,MODE_BID)-ord_price >= 0 && MarketInfo(sym,MODE_BID)-ord_price <= 20*MarketInfo(sym,MODE_POINT)

) { // Kırmızı

OrderDelete(OrderTicket(),clrNONE);
OrderSend(sym,OP_BUY,OrderLots(),Asks,0,0,0,OrderComment(),magic,0,clrNONE);
Sleep(100);

}


//}

}




         
         }
                  
         
         
         
         
         
            //OrderDelete(OrderTicket(),clrNONE);
         }
      }
    }
}
