//+------------------------------------------------------------------+
//|                                                 HedgePremium.mq4 |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict


extern double Lot=1.5;
extern double Lotc=0.1;
extern double distance=1000;
double dst=10;
extern int magic=9;

double buy_close_price=-1;
double sell_close_price=-1;

double buy_start_price=-1;
double sell_start_price=-1;

double buy_profit=0;
double sell_profit=0;

double buy_close_total=0;
double sell_close_total=0;

extern double target_profit=5000;


bool hedge_start=false;
bool hedge_stop=false;

double acc=0;

extern int min_order_target=4;

extern bool mix_system=false;
extern int mix_total=6;

bool buy_breakeven=false;
bool sell_breakeven=false;

 bool old_system=false;


int long_total=0;
int short_total=0;
double long_lot_total=0;
double short_lot_total=0;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---




//hedge_stop=true;

   double acc=AccountBalance();
   
   

   for (int h=OrdersTotal();h>=0;h--)
   {
      if ( OrderSelect(h,SELECT_BY_POS) )
      {
      
         if(OrderType() == OP_SELL && OrderSymbol() == Symbol() && OrderMagicNumber() != magic  )
         {
         short_total=short_total+1;
         short_lot_total=short_lot_total+OrderLots();
         }
               
         if(OrderType() == OP_BUY && OrderSymbol() == Symbol() && OrderMagicNumber() != magic  )
         {
         long_total=long_total+1;
         long_lot_total=long_lot_total+OrderLots();
         }
             
                            
               
      
         if(OrderType() == OP_SELL && OrderSymbol() == Symbol() && OrderMagicNumber() == magic  )
         {


         sell_start_price=OrderOpenPrice();
         if ( OrderLots() != Lot ) {sell_close_price=OrderOpenPrice()-((DivZero(Lot-OrderLots(),Lotc))*distance);
         sell_close_total=(DivZero(Lot-OrderLots(),Lotc));
         }
 
         }

         if(OrderType() == OP_BUY && OrderSymbol() == Symbol() && OrderMagicNumber() == magic  )
         {
         
         buy_start_price=OrderOpenPrice();
         
         if ( OrderLots() != Lot ) {buy_close_price=OrderOpenPrice()+(((DivZero(Lot-OrderLots(),Lotc)))*distance);
         buy_close_total=(DivZero(Lot-OrderLots(),Lotc));
         }         
         
         
      }
      
      
   }
      
      }
      
      
      if ( sell_start_price != -1 || buy_start_price != -1 ) {
      
      hedge_start=true;
      
      } 
   
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

if ( hedge_stop == false ) HedgePremium();
   
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

        CloseAllSellOrders();
         CloseAllBuyOrders();         
         hedge_stop=true;

}
   
  }
//+------------------------------------------------------------------+
void HedgePremium() {

if ( hedge_start == false ) {
/*
if ( long_total == 0 && short_total == 0 ) {
OrderSend(Symbol(),OP_BUY,Lot,Ask,0,0,0,"",magic,0,clrNONE);
OrderSend(Symbol(),OP_SELL,Lot,Bid,0,0,0,"",magic,0,clrNONE);
}

if ( long_total > 0 && short_total == 0 ) {
OrderSend(Symbol(),OP_SELL,Lot,Bid,0,0,0,"",magic,0,clrNONE);
OrderSend(Symbol(),OP_BUY,Lot,Ask,0,0,0,"",magic,0,clrNONE);
}

if ( short_total > 0 && long_total == 0 ) {
OrderSend(Symbol(),OP_BUY,Lot,Ask,0,0,0,"",magic,0,clrNONE);
OrderSend(Symbol(),OP_SELL,Lot,Bid,0,0,0,"",magic,0,clrNONE);
}*/

if ( long_lot_total == 0 && short_lot_total == 0 ) {
OrderSend(Symbol(),OP_BUY,Lot,Ask,0,0,0,"",magic,0,clrNONE);
OrderSend(Symbol(),OP_SELL,Lot,Bid,0,0,0,"",magic,0,clrNONE);
}

if ( long_lot_total > short_lot_total  ) {
OrderSend(Symbol(),OP_SELL,Lot,Bid,0,0,0,"",magic,0,clrNONE);
OrderSend(Symbol(),OP_BUY,Lot,Ask,0,0,0,"",magic,0,clrNONE);
}

if ( short_lot_total > long_lot_total ) {
OrderSend(Symbol(),OP_BUY,Lot,Ask,0,0,0,"",magic,0,clrNONE);
OrderSend(Symbol(),OP_SELL,Lot,Bid,0,0,0,"",magic,0,clrNONE);
}





hedge_start=true;

buy_start_price=Ask;
sell_start_price=Bid;

}

string CMT="";

if ( hedge_start == true ) {

   for (int m=OrdersTotal(); m>=0; m--)
   {
      if ( OrderSelect(m, SELECT_BY_POS))
      {
         if(OrderType() == OP_BUY && OrderSymbol() == Symbol() && OrderMagicNumber() == magic )
         {
           
           if ( buy_close_price == -1 && (Bid-OrderOpenPrice())/Point >= distance ) {
            RefreshRates();
            bool success = OrderClose(OrderTicket(), Lotc, OrderClosePrice(), 0, Blue);
            buy_close_price=Bid;
            buy_profit=buy_profit+((OrderProfit()/(OrderLots()*100))*(Lotc*100));
            buy_close_total=1;
            }
            

           if ( buy_close_price != -1 && (Bid-buy_close_price)/Point >= distance ) {
            RefreshRates();
            
            if ( OrderLots() < Lotc ) bool success = OrderClose(OrderTicket(), OrderLots(), OrderClosePrice(), 0, Blue);
            
            bool success = OrderClose(OrderTicket(), Lotc, OrderClosePrice(), 0, Blue);
            buy_close_price=Bid;
            buy_profit=buy_profit+((OrderProfit()/(OrderLots()*100))*(Lotc*100));
            buy_close_total=buy_close_total+1;
            }            
            
         }
         
         if(OrderType() == OP_SELL && OrderSymbol() == Symbol() && OrderMagicNumber() == magic  )
         {
           
           if ( sell_close_price == -1 && (OrderOpenPrice()-Ask)/Point >= distance ) {
            RefreshRates();
            bool success = OrderClose(OrderTicket(), Lotc, OrderClosePrice(), 0, Blue);
            sell_close_price=Ask;
            sell_profit=sell_profit+((OrderProfit()/(OrderLots()*100))*(Lotc*100));
            sell_close_total=1;
            }
            

           if ( sell_close_price != -1 && (sell_close_price-Ask)/Point >= distance ) {
            RefreshRates();
            
            if ( OrderLots() < Lotc ) bool success = OrderClose(OrderTicket(), OrderLots(), OrderClosePrice(), 0, Blue);
            
            bool success = OrderClose(OrderTicket(), Lotc, OrderClosePrice(), 0, Blue);
            sell_close_price=Ask;
            sell_profit=sell_profit+((OrderProfit()/(OrderLots()*100))*(Lotc*100));
            sell_close_total=sell_close_total+1;
            }            
            
         }






if (  ((mix_system == true && (sell_close_total+buy_close_total) >= mix_total) || buy_close_total >= min_order_target ) && buy_breakeven == false && sell_breakeven == false ) {

   for (int h=OrdersTotal();h>=0;h--)
   {
      if ( OrderSelect(h,SELECT_BY_POS) )
      {
      
      
         if(OrderType() == OP_SELL && OrderSymbol() == Symbol() && OrderMagicNumber() == magic && OrderStopLoss() == 0.0  )
         {

         double ask=SymbolInfoDouble(Symbol(),SYMBOL_ASK);
         double bid=SymbolInfoDouble(Symbol(),SYMBOL_BID);
         double spread=ask-bid;

           OrderModify(OrderTicket(),OrderOpenPrice(),OrderStopLoss(),OrderOpenPrice()-spread,0,clrNONE);
           //OrderModify(OrderTicket(),OrderOpenPrice(),OrderStopLoss(),OrderOpenPrice(),0,clrNONE); // Daha güvenilir

         }

         if(OrderType() == OP_BUY && OrderSymbol() == Symbol() && OrderMagicNumber() == magic && OrderStopLoss() == 0.0  )
         {
         
         double ask=SymbolInfoDouble(Symbol(),SYMBOL_ASK);
         double bid=SymbolInfoDouble(Symbol(),SYMBOL_BID);
         double spread=ask-bid;

           //OrderModify(OrderTicket(),OrderOpenPrice(),OrderStopLoss(),OrderOpenPrice()+spread,0,clrNONE);  
           OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice()+spread,OrderTakeProfit(),0,clrNONE);  
         
      }
      
      
   }
      
      }

buy_breakeven=true;
}



if ( ( (mix_system == true && (sell_close_total+buy_close_total) >= mix_total) || sell_close_total >= min_order_target ) && sell_breakeven == false && buy_breakeven == false ) {

   for (int h=OrdersTotal();h>=0;h--)
   {
      if ( OrderSelect(h,SELECT_BY_POS) )
      {
      
      
         if(OrderType() == OP_SELL && OrderSymbol() == Symbol() && OrderMagicNumber() == magic  && OrderStopLoss() == 0.0 )
         {

         double ask=SymbolInfoDouble(Symbol(),SYMBOL_ASK);
         double bid=SymbolInfoDouble(Symbol(),SYMBOL_BID);
         double spread=ask-bid;

           //OrderModify(OrderTicket(),OrderOpenPrice(),OrderStopLoss(),OrderOpenPrice()-spread,0,clrNONE);
           OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice()-spread,OrderTakeProfit(),0,clrNONE);
           

         }

         if(OrderType() == OP_BUY && OrderSymbol() == Symbol() && OrderMagicNumber() == magic && OrderStopLoss() == 0.0  )
         {
         
         double ask=SymbolInfoDouble(Symbol(),SYMBOL_ASK);
         double bid=SymbolInfoDouble(Symbol(),SYMBOL_BID);
         double spread=ask-bid;

           OrderModify(OrderTicket(),OrderOpenPrice(),OrderStopLoss(),OrderOpenPrice()+spread,0,clrNONE);  
           //OrderModify(OrderTicket(),OrderOpenPrice(),OrderStopLoss(),OrderOpenPrice(),0,clrNONE); // Daha güvenilir
      }
      
      
   }
      
      }

sell_breakeven=true;
}


//////////////////////////////////////////////////////////////////////////////////////////////////////////////
if ( old_system == true ) {
         
         /*
         if ( buy_close_total >= min_order_target && (Bid-buy_start_price)/Point < DivZero(distance,dst) ) {
         
         
   for (int h=OrdersTotal();h>=0;h--)
   {
      if ( OrderSelect(h,SELECT_BY_POS) )
      {
      
      
         if(OrderType() == OP_SELL && OrderSymbol() == Symbol() && OrderMagicNumber() == magic  && OrderTakeProfit() == 0 )
         {

         double ask=SymbolInfoDouble(Symbol(),SYMBOL_ASK);
         double bid=SymbolInfoDouble(Symbol(),SYMBOL_BID);
         double spread=ask-bid;

           OrderModify(OrderTicket(),OrderOpenPrice(),OrderStopLoss(),OrderOpenPrice()-spread,0,clrNONE);

         }

         if(OrderType() == OP_BUY && OrderSymbol() == Symbol() && OrderMagicNumber() == magic  )
         {
         
            RefreshRates();
            bool success = OrderClose(OrderTicket(), OrderLots(), OrderClosePrice(), 0, Blue);
         
      }
      
      
   }
      
      }
         
        // CloseAllSellOrders();
         //CloseAllBuyOrders();
         hedge_stop=true;
         
            //RefreshRates();
            //bool success = OrderClose(OrderTicket(), OrderLots(), OrderClosePrice(), 0, Blue);
         
         hedge_start = false;
         
buy_close_price=-1;
sell_close_price=-1;

buy_start_price=-1;
sell_start_price=1;

buy_profit=0;
sell_profit=0;

buy_close_total=0;
sell_close_total=0;
         
         
         }
         


         if ( sell_close_total >= min_order_target && (sell_start_price-Ask)/Point < DivZero(distance,dst) ) {
         
         
         
   for (int h=OrdersTotal();h>=0;h--)
   {
      if ( OrderSelect(h,SELECT_BY_POS) )
      {
      
      
         if(OrderType() == OP_SELL && OrderSymbol() == Symbol() && OrderMagicNumber() == magic  )
         {

            RefreshRates();
            bool success = OrderClose(OrderTicket(), OrderLots(), OrderClosePrice(), 0, Blue);

         }

         if(OrderType() == OP_BUY && OrderSymbol() == Symbol() && OrderMagicNumber() == magic  && OrderTakeProfit() == 0  )
         {
         
         double ask=SymbolInfoDouble(Symbol(),SYMBOL_ASK);
         double bid=SymbolInfoDouble(Symbol(),SYMBOL_BID);
         double spread=ask-bid;

           OrderModify(OrderTicket(),OrderOpenPrice(),OrderStopLoss(),OrderOpenPrice()+spread,0,clrNONE);         
      }
      
      
   }
      
      }
      
               
         
         //CloseAllSellOrders();
         //CloseAllBuyOrders();         
         hedge_stop=true;
            //RefreshRates();
            //bool success = OrderClose(OrderTicket(), OrderLots(), OrderClosePrice(), 0, Blue);
         
         hedge_start = false;
         
buy_close_price=-1;
sell_close_price=-1;

buy_start_price=-1;
sell_start_price=1;

buy_profit=0;
sell_profit=0;

buy_close_total=0;
sell_close_total=0;
         
         
         }
         */

}         
/////////////////////////////////////////////////////////////////////////////////////////////////////////
      /*   
if ( mix_system == true ) {
         if ( (sell_close_total+buy_close_total) >= mix_total && (((sell_start_price-Ask)/Point < DivZero(distance,dst)) || ((Bid-buy_start_price)/Point < DivZero(distance,dst) )) ) {
         
         CloseAllSellOrders();
         CloseAllBuyOrders();         
         hedge_stop=true;
            //RefreshRates();
            //bool success = OrderClose(OrderTicket(), OrderLots(), OrderClosePrice(), 0, Blue);
         
         hedge_start = false;
         
buy_close_price=-1;
sell_close_price=-1;

buy_start_price=-1;
sell_start_price=1;

buy_profit=0;
sell_profit=0;

buy_close_total=0;
sell_close_total=0;
         
         
         }
         }
         */
  
         

    
         
      }
    }
    
    
    
double buy_order_profit=0;
double sell_order_profit=0;   
double total_order_profit=0; 
    
   for (int h=OrdersTotal();h>=0;h--)
   {
      if ( OrderSelect(h,SELECT_BY_POS) )
      {
      
      
         if(OrderType() == OP_SELL && OrderSymbol() == Symbol() && OrderMagicNumber() == magic  )
         {

         buy_order_profit=OrderProfit();
         }

         if(OrderType() == OP_BUY && OrderSymbol() == Symbol() && OrderMagicNumber() == magic  )
         {
         
         sell_order_profit=OrderProfit();
         
      }
      
      
   }
      
      }
      
      
      total_order_profit=buy_order_profit+sell_order_profit;
      double total_orders_profit=total_order_profit+(sell_profit+buy_profit);
    
    
///////////////////////////////////////////////////////////////////////////////////         
    if ( total_orders_profit >= target_profit ) {
    

         CloseAllSellOrders();
         CloseAllBuyOrders();         
         hedge_stop=true;
         
         hedge_start = false;
         
buy_close_price=-1;
sell_close_price=-1;

buy_start_price=-1;
sell_start_price=1;

buy_profit=0;
sell_profit=0;

buy_close_total=0;
sell_close_total=0;
 
    
    }  
/////////////////////////////////////////////////////////////////////////////////////    
    
   
Comment("Buy Close Total:",buy_close_total,"\nBuy Profit:",buy_profit,"\nSell Close Total:",sell_close_total,"\nSell Profit:",sell_profit,"\n total_order_profit:",total_order_profit,"\n general_profit:",total_orders_profit,"\n BuySell_profit:",(sell_profit+buy_profit));
}

}



void CloseAllSellOrders()
{
   for (int h=OrdersTotal();h>=0;h--)
   {
      if ( OrderSelect(h,SELECT_BY_POS) )
      {
         if(OrderType() == OP_SELL && OrderSymbol() == Symbol() && OrderMagicNumber() == magic  )
         {
            RefreshRates();
            bool success =OrderClose(OrderTicket(), OrderLots(), Ask, 0, Red);
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
/////////////////////////////////////////////////////////////////////////////////////////
// Divide Zero Hatası için formül.
/////////////////////////////////////////////////////////////////////////////////////////
double DivZero(double n, double d)
{
if (d==0) return(0);  else return(n/d);
} 
//////////////////////////////////////////////////////////////////////} 
