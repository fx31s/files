//+------------------------------------------------------------------+
//|                                                    TestRobot.mq4 |
//|                                                       Alpc Comp. |
//|                                                  www.alpc.com.tr |
//+------------------------------------------------------------------+
#property copyright "Alpc Comp."
#property link      "www.alpc.com.tr"
#property version   "1.00"
#property strict
//--- introduce the predefined variables from MQL4 for versatility of the code
#ifdef __MQL5__ 
#define Ask    SymbolInfoDouble(_Symbol,SYMBOL_ASK)
#define Bid    SymbolInfoDouble(_Symbol,SYMBOL_BID)
#endif 
//--- redefine the order types from MQL5 to MQL4 for versatility of the code
#ifdef __MQL4__ 
#define ORDER_TYPE_BUY        OP_BUY
#define ORDER_TYPE_SELL       OP_SELL
#define ORDER_TYPE_BUY_LIMIT  OP_BUYLIMIT
#define ORDER_TYPE_SELL_LIMIT OP_SELLLIMIT
#define ORDER_TYPE_BUY_STOP   OP_BUYSTOP
#define ORDER_TYPE_SELL_STOP  OP_SELLSTOP
#endif 

#property strict
//--- SYMBOL_TRADE_STOPS_LEVEL and SYMBOL_TRADE_FREEZE_LEVEL levels
int freeze_level,stops_level;
//--- spread
double spread;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
  //double stops_level=(int)SymbolInfoInteger(_Symbol,SYMBOL_TRADE_STOPS_LEVEL);
  //Print("stops_level",stops_level);
  
//--- create timer
   EventSetTimer(60);
   
//--- order ticket
   int ticket;
//--- the current opening and SL/TP levels
/*
   ... get the ticket 
*/
//--- compare the distance to the current activation price with the SYMBOL_TRADE_FREEZE_LEVEL level
   if(CheckOrderForFREEZE_LEVEL(ticket))
     {
      // check succeeded, modify the order
     }


//--- distance from the activation price, within which it is not allowed to modify orders and positions
   freeze_level=(int)SymbolInfoInteger(_Symbol,SYMBOL_TRADE_FREEZE_LEVEL);
   if(freeze_level!=0)
     {
      PrintFormat("SYMBOL_TRADE_FREEZE_LEVEL=%d: order or position modification is not allowed,"+
                  " if there are %d points to the activation price",freeze_level,freeze_level);
     }

//--- price levels for orders and positions
   double priceopen,stoploss,takeprofit;
//--- ticket of the current order 
   int orderticket;
/*
   ... get the order ticket and new StopLoss/Takeprofit/PriceOpen levels
*/
//--- check the levels before modifying the order   
   if(OrderModifyCheck(orderticket,priceopen,stoploss,takeprofit))
     {
      //--- checking successful
      OrderModify(orderticket,priceopen,stoploss,takeprofit,OrderExpiration());
     }
     


//--- current spread
   spread=Ask-Bid;
//--- randomly get the type of operation
   int oper=(int)(GetTickCount()%2); // remainder of division by two is always either 0 or 1
   switch(oper)
     {
      //--- buy
      case  0:
        {
         //--- get the opening price and knowingly set invalid TP/SL
         double price=Ask;
         double SL=NormalizeDouble(Bid-50*_Point,_Digits);
         double TP=NormalizeDouble(Ask+50*_Point,_Digits);
         //--- perform a check
         PrintFormat("Buy at %.5f   SL=%.5f   TP=%.5f  Bid=%.5f",price,SL,TP,Bid);
         if(!CheckStopLoss_Takeprofit(ORDER_TYPE_BUY,price,SL,TP))
            Print("The StopLoss or TakeProfit level is incorrect!");
         //--- try to buy anyway, in order to see the execution result
         Buy(price,SL,TP);
         Print("  -----------------");
        }
      break;
      //--- sell
      case  1:
        {
         //--- get the opening price and knowingly set invalid TP/SL
         double price=Bid;
         double SL=NormalizeDouble(Ask+50*_Point,_Digits);
         double TP=NormalizeDouble(Bid-50*_Point,_Digits);
         //--- perform a check
         PrintFormat("Sell at %.5f   SL=%.5f   TP=%.5f  Ask=%.5f",price,SL,TP,Ask);
         if(!CheckStopLoss_Takeprofit(ORDER_TYPE_SELL,price,SL,TP))
            Print("The StopLoss or TakeProfit level is incorrect!");
         //--- try to sell anyway, in order to see the execution result
         Sell(price,SL,TP);
         Print("  -----------------");
        }
      break;
      //---
     }
//--- now test placing a pending order
   oper=(int)(GetTickCount()%4); // division by 4 results in remainder from 0 to 3
   switch(oper)
     {
      //--- place the BuyLimit
      case  0:
        {
         //--- get the opening price and knowingly set invalid TP/SL
         double price=NormalizeDouble(Bid-200*_Point,_Digits);
         double SL=NormalizeDouble(price-50*_Point,_Digits);
         double TP=NormalizeDouble(price+50*_Point,_Digits);
         //--- perform a check
         PrintFormat("BuyLimt at %.5f   SL=%.5f   TP=%.5f",price,SL,TP);
         if(!CheckStopLoss_Takeprofit(ORDER_TYPE_BUY_LIMIT,price,SL,TP))
            Print("The StopLoss or TakeProfit level is incorrect!");
         //--- try to buy anyway, in order to see the execution result
         BuyLimit(price,SL,TP);
         Print("  -----------------");
        }
      break;
      //--- place the BuyStop
      case  1:
        {
         //--- get the opening price and knowingly set invalid TP/SL
         double price=NormalizeDouble(Ask+200*_Point,_Digits);
         double SL=NormalizeDouble(price-50*_Point,_Digits);
         double TP=NormalizeDouble(price+50*_Point,_Digits);
         //--- perform a check
         PrintFormat("BuyStop at %.5f   SL=%.5f  TP=%.5f",price,SL,TP);
         if(!CheckStopLoss_Takeprofit(ORDER_TYPE_BUY_STOP,price,SL,TP))
            Print("The StopLoss or TakeProfit level is incorrect!");
         //--- try to place the order anyway, in order to see the execution result
         BuyStop(price,SL,TP);
         Print("  -----------------");
        }
      break;
      //--- place the SellLimit
      case  2:
        {
         //--- get the opening price and knowingly set invalid TP/SL
         double price=NormalizeDouble(Ask+200*_Point,_Digits);
         double SL=NormalizeDouble(price+50*_Point,_Digits);
         double TP=NormalizeDouble(price-50*_Point,_Digits);
         //--- perform a check
         PrintFormat("SellLimit at %.5f   SL=%.5f  TP=%.5f",price,SL,TP);
         if(!CheckStopLoss_Takeprofit(ORDER_TYPE_SELL_LIMIT,price,SL,TP))
            Print("The StopLoss or TakeProfit level is incorrect!");
         //--- try to place the order anyway, in order to see the execution result
         SellLimit(price,SL,TP);
         Print("  -----------------");
        }
      break;
      //--- place the SellStop
      case  3:
        {
         //--- get the opening price and knowingly set invalid TP/SL
         double price=NormalizeDouble(Bid-200*_Point,_Digits);
         double SL=NormalizeDouble(price+50*_Point,_Digits);
         double TP=NormalizeDouble(price-50*_Point,_Digits);
         //--- perform a check
         PrintFormat("SellStop at %.5f  SL=%.5f  TP=%.5f ",price,SL,TP);
         if(!CheckStopLoss_Takeprofit(ORDER_TYPE_SELL_STOP,price,SL,TP))
            Print("The StopLoss or TakeProfit level is incorrect!");
         //--- try to place the order anyway, in order to see the execution result
         SellStop(price,SL,TP);
         Print("  -----------------");
        }
      break;
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
  if(IsTesting()) {
  //Print("I am testing now")
  OnTimer();
  };
  

/*
   int orders=OrdersTotalPending(_Symbol);
//--- order ticket and distance to the activation price
   int distance,ticket;
//--- activation price
   double activation_price;
//--- only if there is a single pending order
   if(orders==1)
     {
      //--- select order for working
      if(OrderPendingSelect(0,_Symbol))
        {
         ticket=OrderTicket();
         //--- activation price
         activation_price=GetActivationPrice(ticket);
         //--- output the distance to the order opening price at the current moment
         distance=(int) MathRound(MathAbs(activation_price-OrderOpenPrice())/_Point);
         //--- get the freeze distance for pending orders and open positions
         freeze_level=(int)SymbolInfoInteger(_Symbol,SYMBOL_TRADE_FREEZE_LEVEL);
         //--- get the nearest allowed price for opening this type of orders 
         stops_level=(int)SymbolInfoInteger(_Symbol,SYMBOL_TRADE_STOPS_LEVEL);
         //--- allowed distance is the greatest of these two values
         int min=MathMax(freeze_level,stops_level);
         double nearest_price=GetNearestPrice(OrderType(),min+1);
         //--- the current order activation price
         double openprice=OrderOpenPrice();
         //--- get the StopLoss and TakeProfit value
         double sl=OrderStopLoss();
         double tp=OrderTakeProfit();
         datetime expiration=(datetime)OrderExpiration();

         //--- if the distance is less than the freeze level
         if(distance<freeze_level)
           {
            PlaySound("stops.wav"); // play a sound alert
            Comment(StringFormat("Distance=%d [SYMBOL_TRADE_FREEZE_LEVEL=%d]  %s  CurrentPrice=%.5f",
                    distance,freeze_level,GetOrderTypeString(OrderType()),activation_price));
            //--- if the new price if different from the one specified in the order, it can be modified
            if(MathAbs(nearest_price-openprice)>_Point)
              {
               //--- first, write a message to the log
               PrintFormat("Try to modify %s #%d at %.5f ==> new price=%.5f:  Bid=%.5f  Ask=%.5f",
                           GetOrderTypeString(OrderType()),ticket,openprice,nearest_price,Bid,Ask);

               //--- try to make a forbidden modification
               if(!OrderModify(ticket,nearest_price,sl,tp,expiration))
                 {
                  PrintFormat("freeze_level=%d",freeze_level);
                  //--- output the result 
                  PrintFormat("OrderModify for %s #%d failed, Error=%d",
                              GetOrderTypeString(OrderType()),ticket,GetLastError());
                 }
               else
                  PrintFormat("Modification of order %s #%d done successfully",
                              GetOrderTypeString(OrderType()),ticket);
               Print(" -------------");
              }
            //--- worked at the distance less than the freeze level - do nothing else on this tick 
            return;
           }
         if(distance>2*min)
           {
            //--- now try to move the order as close as possible to the activation price
            nearest_price=GetNearestPrice(OrderType(),stops_level+1);
            //--- the current distance from the current price to the activation price
            int current_delta=(int)MathAbs((openprice-activation_price)/_Point);
            //--- if the new opening price is different from the previous
            if(MathAbs(nearest_price-openprice)/_Point>=1)
              {
               //--- order can be modified
               PrintFormat("Modify order %s #%d at %.5f => %.5f  OpenPrice-CurrenPrice=%.5f-%.5f=%d points Ask=%.5f Bid=%.5f",
                           GetOrderTypeString(OrderType()),ticket,openprice,nearest_price,openprice,activation_price,current_delta,Ask,Bid);
               //--- modify
               if(OrderModify(ticket,nearest_price,sl,tp,expiration))
                 {
                  PrintFormat("Order %s #%d modified succesfully",GetOrderTypeString(OrderType()),ticket);
                 }
               //--- modification failed
               else
                 {
                  //--- output the result 
                  PrintFormat("OrderModify for %s #%d failed, Error=%d",
                              GetOrderTypeString(OrderType()),ticket,GetLastError());
                 }
              }
            //--- worked at a large distance from the freeze level - do nothing else on this tick 
            return;
           }
         //--- worked with the selected pending order
        }
     }  */
  
   
  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//---
  //Print("Saniye:",TimeSeconds(TimeCurrent()));
  //Print(iClose(NULL,0,0));
  
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
//| Check the distance from opening price to activation price        |
//+------------------------------------------------------------------+
bool CheckOrderForFREEZE_LEVEL(int ticket)
  {
//--- get the SYMBOL_TRADE_FREEZE_LEVEL level
   int freeze_level=(int)SymbolInfoInteger(_Symbol,SYMBOL_TRADE_FREEZE_LEVEL);
   if(freeze_level!=0)
     {
      PrintFormat("SYMBOL_TRADE_FREEZE_LEVEL=%d: Cannot modify order"+
                  "  nearer than %d points from the activation price",freeze_level,freeze_level);
     }
//--- select order for working
   if(!OrderSelect(ticket,SELECT_BY_TICKET,MODE_TRADES))
     {
      //--- failed to select order
      return (false);
     }
//--- get the order data
   double price=OrderOpenPrice();
   double sl=OrderStopLoss();
   double tp=OrderTakeProfit();
   int type=OrderType();
//--- result of checking 
   bool check=false;
//--- check the order type
   switch(type)
     {
      //--- BuyLimit pending order
      case  OP_BUYLIMIT:
        {
         //--- check the distance from the opening price to the activation price
         check=((Ask-price)>freeze_level*_Point);
         if(!check)
            PrintFormat("Order OP_BUYLIMIT #%d cannot be modified: Ask-Open=%d points < SYMBOL_TRADE_FREEZE_LEVEL=%d points",
                        ticket,(int)((Ask-price)/_Point),freeze_level);
         return(check);
        }
      //--- BuyLimit pending order
      case  OP_SELLLIMIT:
        {
         //--- check the distance from the opening price to the activation price
         check=((price-Bid)>freeze_level*_Point);
         if(!check)
            PrintFormat("Order OP_SELLLIMIT #%d cannot be modified: Open-Bid=%d points < SYMBOL_TRADE_FREEZE_LEVEL=%d points",
                        ticket,(int)((price-Bid)/_Point),freeze_level);
         return(check);
        }
      break;
      //--- BuyStop pending order
      case  OP_BUYSTOP:
        {
         //--- check the distance from the opening price to the activation price
         check=((price-Ask)>freeze_level*_Point);
         if(!check)
            PrintFormat("Order OP_BUYSTOP #%d cannot be modified: Ask-Open=%d points < SYMBOL_TRADE_FREEZE_LEVEL=%d points",
                        ticket,(int)((price-Ask)/_Point),freeze_level);
         return(check);
        }
      //--- SellStop pending order
      case  OP_SELLSTOP:
        {
         //--- check the distance from the opening price to the activation price
         check=((Bid-price)>freeze_level*_Point);
         if(!check)
            PrintFormat("Order OP_SELLSTOP #%d cannot be modified: Bid-Open=%d points < SYMBOL_TRADE_FREEZE_LEVEL=%d points",
                        ticket,(int)((Bid-price)/_Point),freeze_level);
         return(check);
        }
      break;
      //--- checking opened Buy order
      case  OP_BUY:
        {
         //--- check TakeProfit distance to the activation price
         bool TP_check=(tp-Bid>freeze_level*_Point);
         if(!TP_check)
            PrintFormat("Order OP_BUY %d cannot be modified: TakeProfit-Bid=%d points < SYMBOL_TRADE_FREEZE_LEVEL=%d points",
                        ticket,(int)((tp-Bid)/_Point),freeze_level);
         //--- check TakeProfit distance to the activation price
         bool SL_check=(Bid-sl>freeze_level*_Point);
         if(!SL_check)
            PrintFormat("Order OP_BUY %d cannot be modified: TakeProfit-Bid=%d points < SYMBOL_TRADE_FREEZE_LEVEL=%d points",
                        ticket,(int)((Bid-sl)/_Point),freeze_level);
         return(SL_check&&TP_check);
        }
      break;
      //--- checking opened Sell order
      case  OP_SELL:
        {
         //--- check TakeProfit distance to the activation price
         bool TP_check=(Ask-tp>freeze_level*_Point);
         if(!TP_check)
            PrintFormat("Order OP_SELL %d cannot be modified: Ask-TakeProfit=%d points < SYMBOL_TRADE_FREEZE_LEVEL=%d points",
                        ticket,(int)((Ask-tp)/_Point),freeze_level);
         //--- check TakeProfit distance to the activation price
         bool SL_check=(sl-Ask>freeze_level*_Point);
         if(!SL_check)
            PrintFormat("Order OP_BUY %d cannot be modified: TakeProfit-Bid=%d points < SYMBOL_TRADE_FREEZE_LEVEL=%d points",
                        ticket,(int)((sl-Ask)/_Point),freeze_level);
         return(SL_check&&TP_check);
        }
      break;
     }
//--- order did not pass the check
   return (false);
  }
  
//+------------------------------------------------------------------+
//| Checking the new values of levels before order modification      |
//+------------------------------------------------------------------+
bool OrderModifyCheck(int ticket,double price,double sl,double tp)
  {
//--- select order by ticket
   if(OrderSelect(ticket,SELECT_BY_TICKET))
     {
      //--- point size and name of the symbol, for which a pending order was placed
      string symbol=OrderSymbol();
      double point=SymbolInfoDouble(symbol,SYMBOL_POINT);
      //--- check if there are changes in the Open price
      bool PriceOpenChanged=true;
      int type=OrderType();
      if(!(type==OP_BUY || type==OP_SELL))
        {
         PriceOpenChanged=(MathAbs(OrderOpenPrice()-price)>point);
        }
      //--- check if there are changes in the StopLoss level
      bool StopLossChanged=(MathAbs(OrderStopLoss()-sl)>point);
      //--- check if there are changes in the Takeprofit level
      bool TakeProfitChanged=(MathAbs(OrderTakeProfit()-sl)>tp);
      //--- if there are any changes in levels
      if(PriceOpenChanged || StopLossChanged || TakeProfitChanged)
         return(true);  // order can be modified      
      //--- there are no changes in the Open, StopLoss and Takeprofit levels
      else
      //--- notify about the error
         PrintFormat("Order #%d already has levels of Open=%.5f SL=.5f TP=%.5f",
                     ticket,OrderOpenPrice(),OrderStopLoss(),OrderTakeProfit());
     }
//--- came to the end, no changes for the order
   return(false);       // no point in modifying 
  }  
  

bool CheckMoneyForTrade(string symb, double lots,int type)
  {
   double free_margin=AccountFreeMarginCheck(symb,type, lots);
   //-- if there is not enough money
   if(free_margin<0)
     {
      string oper=(type==OP_BUY)? "Buy":"Sell";
      Print("Not enough money for ", oper," ",lots, " ", symb, " Error code=",GetLastError());
      return(false);
     }
   //--- checking successful
   return(true);
  }
  
//+------------------------------------------------------------------+
//| Check the correctness of the order volume                        |
//+------------------------------------------------------------------+
/*
bool CheckVolumeValue(double volume,string &description)
  {
//--- minimal allowed volume for trade operations
   double min_volume=SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_MIN);
   if(volume<min_volume)
     {
      description=StringFormat("Volume is less than the minimal allowed SYMBOL_VOLUME_MIN=%.2f",min_volume);
      return(false);
     }

//--- maximal allowed volume of trade operations
   double max_volume=SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_MAX);
   if(volume>max_volume)
     {
      description=StringFormat("Volume is greater than the maximal allowed SYMBOL_VOLUME_MAX=%.2f",max_volume);
      return(false);
     }

//--- get minimal step of volume changing
   double volume_step=SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_STEP);

   int ratio=(int)MathRound(volume/volume_step);
   if(MathAbs(ratio*volume_step-volume)>0.0000001)
     {
      description=StringFormat("Volume is not a multiple of the minimal step SYMBOL_VOLUME_STEP=%.2f, the closest correct volume is %.2f",
                               volume_step,ratio*volume_step);
      return(false);
     }
   description="Correct volume value";
   return(true);
  } */   
  
//+------------------------------------------------------------------+
//| Check if another order can be placed                             |
//+------------------------------------------------------------------+
/*
bool IsNewOrderAllowed()
  {
//--- get the number of pending orders allowed on the account
   int max_allowed_orders=(int)AccountInfoInteger(ACCOUNT_LIMIT_ORDERS);

//--- if there is no limitation, return true; you can send an order
   if(max_allowed_orders==0) return(true);

//--- if we passed to this line, then there is a limitation; find out how many orders are already placed
   int orders=OrdersTotal();

//--- return the result of comparing
   return(orders<max_allowed_orders);
  }
  */
  
  /*
  double max_volume=SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_LIMIT);
if(max_volume==0) volume=SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_MAX);
//+------------------------------------------------------------------+
//| Return the size of position on the specified symbol              |
//+------------------------------------------------------------------+
double PositionVolume(string symbol)
  {
//--- try to select position by a symbol
   bool selected=PositionSelect(symbol);
//--- there is a position
   if(selected)
      //--- return volume of the position
      return(PositionGetDouble(POSITION_VOLUME));
   else
     {
      //--- report a failure to select position
      Print(__FUNCTION__," Failed to perform PositionSelect() for symbol ",
            symbol," Error ",GetLastError());
      return(-1);
     }
  }*/
  
  
//+------------------------------------------------------------------+
//|  returns the volume of current pending order by a symbol         |
//+------------------------------------------------------------------+
/*
double   PendingsVolume(string symbol)
  {
   double volume_on_symbol=0;
   ulong ticket;
//---  get the number of all currently placed orders by all symbols
   int all_orders=OrdersTotal();

//--- get over all orders in the loop
   for(int i=0;i<all_orders;i++)
     {
      //--- get the ticket of an order by its position in the list
      if(ticket=OrderGetTicket(i))
        {
         //--- if our symbol is specified in the order, add the volume of this order
         if(symbol==OrderGetString(ORDER_SYMBOL))
            volume_on_symbol+=OrderGetDouble(ORDER_VOLUME_INITIAL);
        }
     }
//--- return the total volume of currently placed pending orders for a specified symbol
   return(volume_on_symbol);
  }*/
  
//+------------------------------------------------------------------+
//| Return the maximum allowed volume for an order on the symbol     |
//+------------------------------------------------------------------+
/*
double NewOrderAllowedVolume(string symbol)
  {
   double allowed_volume=0;
//--- get the limitation on the maximal volume of an order
   double symbol_max_volume=SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_MAX);
//--- get the limitation on the volume by a symbol
   double max_volume=SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_LIMIT);

//--- get the volume of the open position by a symbol
   double opened_volume=PositionVolume(symbol);
   if(opened_volume>=0)
     {
      //--- if we have exhausted the volume
      if(max_volume-opened_volume<=0)
         return(0);

      //--- volume of the open position doesn't exceed max_volume
      double orders_volume_on_symbol=PendingsVolume(symbol);
      allowed_volume=max_volume-opened_volume-orders_volume_on_symbol;
      if(allowed_volume>symbol_max_volume) allowed_volume=symbol_max_volume;
     }
   return(allowed_volume);
  }       */
  
   
  //+------------------------------------------------------------------+
//| Perform a Buy                                                    |
//+------------------------------------------------------------------+
bool Buy(double price,double sl,double tp)
  {
  
  if ( !CheckMoneyForTrade(Symbol(), 1,OP_BUY) ) return false;
  
  
//--- buy in MQL4
#ifdef __MQL4__
   int ticket=OrderSend(Symbol(),OP_BUY,1,price,10,sl,tp);
   if(ticket<0)
      PrintFormat("OrderSend error %d",GetLastError());
#endif
//--- buy in MQL5         
#ifdef __MQL5__
//--- declare and initialize the trade request and result of trade request
   MqlTradeRequest request={0};
   MqlTradeResult  result={0};
//--- parameters of request
   request.action   =TRADE_ACTION_DEAL;                     // type of trade operation
   request.symbol   =Symbol();                              // symbol
   request.volume   =1;                                     // volume of 1 lot
   request.type     =ORDER_TYPE_BUY;                        // order type
   request.price    =price;                                 // price for opening
   request.sl       =sl;                                    // StopLoss price
   request.tp       =tp;                                    // TakeProfit price
   request.deviation=10;                                    // allowed deviation from the price
   request.magic    =123456;                                // MagicNumber of the order
//--- send the request
   if(!OrderSend(request,result))
      PrintFormat("OrderSend error %d",GetLastError());     // if unable to send the request, output the error code
//--- information about the operation
   PrintFormat("retcode=%u  deal=%I64u  order=%I64u",result.retcode,result.deal,result.order);
#endif  
//---
   return(false);
  }
//+------------------------------------------------------------------+
//| Perform a Sell                                                   |
//+------------------------------------------------------------------+
bool Sell(double price,double sl,double tp)
  {
  
  if ( !CheckMoneyForTrade(Symbol(), 1,OP_SELL) ) return false;
  
//--- sell in MQL4
#ifdef __MQL4__
   int ticket=OrderSend(Symbol(),OP_SELL,1,price,10,sl,tp);
   if(ticket<0)
      PrintFormat("OrderSend error %d",GetLastError());
#endif
//--- sell in MQL5         
#ifdef __MQL5__
//--- declare and initialize the trade request and result of trade request
   MqlTradeRequest request={0};
   MqlTradeResult  result={0};
//--- parameters of request
   request.action   =TRADE_ACTION_DEAL;                     // type of trade operation
   request.symbol   =Symbol();                              // symbol
   request.volume   =1;                                     // volume of 1 lot
   request.type     =ORDER_TYPE_SELL;                       // order type
   request.price    =price;                                 // price for opening
   request.sl       =sl;                                    // StopLoss price
   request.tp       =tp;                                    // TakeProfit price
   request.deviation=10;                                    // allowed deviation from the price
   request.magic    =123456;                                // MagicNumber of the order
//--- send the request
   if(!OrderSend(request,result))
      PrintFormat("OrderSend error %d",GetLastError());     // if unable to send the request, output the error code
//--- information about the operation
   PrintFormat("retcode=%u  deal=%I64u  order=%I64u",result.retcode,result.deal,result.order);
#endif  
//---
   return(false);
  }
//+------------------------------------------------------------------+
//| Place a Sell Stop pending order                                  |
//+------------------------------------------------------------------+
bool BuyLimit(double price,double sl,double tp)
  {
  
  if ( !CheckMoneyForTrade(Symbol(), 1,OP_BUY) ) return false;
  
//--- buy in MQL4
#ifdef __MQL4__
   int ticket=OrderSend(Symbol(),OP_BUYLIMIT,1,price,10,sl,tp);
   if(ticket<0)
      PrintFormat("OrderSend error %d",GetLastError());
#endif
//--- buy in MQL5         
#ifdef __MQL5__
//--- declare and initialize the trade request and result of trade request
   MqlTradeRequest request={0};
   MqlTradeResult  result={0};
//--- parameters of request
   request.action   =TRADE_ACTION_PENDING;                  // type of trade operation
   request.symbol   =Symbol();                              // symbol
   request.volume   =1;                                     // volume of 1 lot
   request.type     =ORDER_TYPE_BUY_LIMIT;                  // order type
   request.price    =price;                                 // price for opening
   request.sl       =sl;                                    // StopLoss price
   request.tp       =tp;                                    // TakeProfit price
   request.deviation=10;                                    // allowed deviation from the price
   request.magic    =123456;                                // MagicNumber of the order
//--- send the request
   if(!OrderSend(request,result))
      PrintFormat("OrderSend error %d",GetLastError());     // if unable to send the request, output the error code
//--- information about the operation
   PrintFormat("retcode=%u  deal=%I64u  order=%I64u",result.retcode,result.deal,result.order);
#endif  
//---
   return(false);
  }
//+------------------------------------------------------------------+
//| Place a Buy Stop pending order                                   |
//+------------------------------------------------------------------+
bool BuyStop(double price,double sl,double tp)
  {
  
  if ( !CheckMoneyForTrade(Symbol(), 1,OP_BUY) ) return false;
  
//--- buy in MQL4
#ifdef __MQL4__
   int ticket=OrderSend(Symbol(),OP_BUYSTOP,1,price,10,sl,tp);
   if(ticket<0)
      PrintFormat("OrderSend error %d",GetLastError());
#endif
//--- buy in MQL5         
#ifdef __MQL5__
//--- declare and initialize the trade request and result of trade request
   MqlTradeRequest request={0};
   MqlTradeResult  result={0};
//--- parameters of request
   request.action   =TRADE_ACTION_PENDING;                  // type of trade operation
   request.symbol   =Symbol();                              // symbol
   request.volume   =1;                                     // volume of 1 lot
   request.type     =ORDER_TYPE_BUY_STOP;                   // order type
   request.price    =price;                                 // price for opening
   request.sl       =sl;                                    // StopLoss price
   request.tp       =tp;                                    // TakeProfit price
   request.deviation=10;                                    // allowed deviation from the price
   request.magic    =123456;                                // MagicNumber of the order
//--- send the request
   if(!OrderSend(request,result))
      PrintFormat("OrderSend error %d",GetLastError());     // if unable to send the request, output the error code
//--- information about the operation
   PrintFormat("retcode=%u  deal=%I64u  order=%I64u",result.retcode,result.deal,result.order);
#endif  
//---
   return(false);
  }
//+------------------------------------------------------------------+
//| Place a Sell Stop pending order                                  |
//+------------------------------------------------------------------+
bool SellLimit(double price,double sl,double tp)
  {
  
  if ( !CheckMoneyForTrade(Symbol(), 1,OP_SELL) ) return false;
  
//--- buy in MQL4
#ifdef __MQL4__
   int ticket=OrderSend(Symbol(),OP_SELLLIMIT,1,price,10,sl,tp);
   if(ticket<0)
      PrintFormat("OrderSend error %d",GetLastError());
#endif
//--- buy in MQL5         
#ifdef __MQL5__
//--- declare and initialize the trade request and result of trade request
   MqlTradeRequest request={0};
   MqlTradeResult  result={0};
//--- parameters of request
   request.action   =TRADE_ACTION_PENDING;                  // type of trade operation
   request.symbol   =Symbol();                              // symbol
   request.volume   =1;                                     // volume of 1 lot
   request.type     =ORDER_TYPE_SELL_LIMIT;                 // order type
   request.price    =price;                                 // price for opening
   request.sl       =sl;                                    // StopLoss price
   request.tp       =tp;                                    // TakeProfit price
   request.deviation=10;                                    // allowed deviation from the price
   request.magic    =123456;                                // MagicNumber of the order
//--- send the request
   if(!OrderSend(request,result))
      PrintFormat("OrderSend error %d",GetLastError());     // if unable to send the request, output the error code
//--- information about the operation
   PrintFormat("retcode=%u  deal=%I64u  order=%I64u",result.retcode,result.deal,result.order);
#endif  
//---
   return(false);
  }
//+------------------------------------------------------------------+
//| Place a Buy Stop pending order                                   |
//+------------------------------------------------------------------+
bool SellStop(double price,double sl,double tp)
  {
  
  if ( !CheckMoneyForTrade(Symbol(), 1,OP_SELL) ) return false;
  
//--- buy in MQL4
#ifdef __MQL4__
   int ticket=OrderSend(Symbol(),OP_SELLSTOP,1,price,10,sl,tp);
   if(ticket<0)
      PrintFormat("OrderSend error %d",GetLastError());
#endif
//--- buy in MQL5         
#ifdef __MQL5__
//--- declare and initialize the trade request and result of trade request
   MqlTradeRequest request={0};
   MqlTradeResult  result={0};
//--- parameters of request
   request.action   =TRADE_ACTION_PENDING;                  // type of trade operation
   request.symbol   =Symbol();                              // symbol
   request.volume   =1;                                     // volume of 1 lot
   request.type     =ORDER_TYPE_SELL_STOP;                  // order type
   request.price    =price;                                 // price for opening
   request.sl       =sl;                                    // StopLoss price
   request.tp       =tp;                                    // TakeProfit price
   request.deviation=10;                                    // allowed deviation from the price
   request.magic    =123456;                                // MagicNumber of the order
//--- send the request
   if(!OrderSend(request,result))
      PrintFormat("OrderSend error %d",GetLastError());     // if unable to send the request, output the error code
//--- information about the operation
   PrintFormat("retcode=%u  deal=%I64u  order=%I64u",result.retcode,result.deal,result.order);
#endif  
//---
   return(false);
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Check the correctness of StopLoss and TakeProfit                 |
//+------------------------------------------------------------------+
bool CheckStopLoss_Takeprofit(ENUM_ORDER_TYPE type,double price,double SL,double TP)
  {
//--- get the SYMBOL_TRADE_STOPS_LEVEL level
   int stops_level=(int)SymbolInfoInteger(_Symbol,SYMBOL_TRADE_STOPS_LEVEL);
   if(stops_level!=0)
     {
      PrintFormat("SYMBOL_TRADE_STOPS_LEVEL=%d: StopLoss and TakeProfit must"+
                  " not be nearer than %d points from the closing price",stops_level,stops_level);
     }
//---
   bool SL_check=false,TP_check=false;
//--- check the order type
   switch(type)
     {
      //--- Buy operation
      case  ORDER_TYPE_BUY:
        {
         //--- check the StopLoss
         SL_check=(Bid-SL>stops_level*_Point);
         if(!SL_check)
            PrintFormat("For order %s   StopLoss=%.5f must be less than %.5f"+
                        " (Bid=%.5f - SYMBOL_TRADE_STOPS_LEVEL=%d points)",
                        EnumToString(type),SL,Bid-stops_level*_Point,Bid,stops_level);
         //--- check the TakeProfit
         TP_check=(TP-Bid>stops_level*_Point);
         if(!TP_check)
            PrintFormat("For order %s   TakeProfit=%.5f must be greater than %.5f"+
                        " (Bid=%.5f + SYMBOL_TRADE_STOPS_LEVEL=%d points)",
                        EnumToString(type),TP,Bid+stops_level*_Point,Bid,stops_level);
         //--- return the result of checking
         return(SL_check&&TP_check);
        }
      //--- Sell operation
      case  ORDER_TYPE_SELL:
        {
         //--- check the StopLoss
         SL_check=(SL-Ask>stops_level*_Point);
         if(!SL_check)
            PrintFormat("For order %s   StopLoss=%.5f must be greater than %.5f"+
                        " (Ask=%.5f + SYMBOL_TRADE_STOPS_LEVEL=%d points)",
                        EnumToString(type),SL,Ask+stops_level*_Point,Ask,stops_level);
         //--- check the TakeProfit
         TP_check=(Ask-TP>stops_level*_Point);
         if(!TP_check)
            PrintFormat("For order %s   TakeProfit=%.5f must be less than %.5f"+
                        " (Ask=%.5f - SYMBOL_TRADE_STOPS_LEVEL=%d points)",
                        EnumToString(type),TP,Ask-stops_level*_Point,Ask,stops_level);
         //--- return the result of checking
         return(TP_check&&SL_check);
        }
      break;
      //--- BuyLimit pending order
      case  ORDER_TYPE_BUY_LIMIT:
        {
         //--- check the StopLoss
         SL_check=((price-SL)>stops_level*_Point);
         if(!SL_check)
            PrintFormat("For order %s   StopLoss=%.5f must be less than %.5f"+
                        " (Open-StopLoss=%d points ==> SYMBOL_TRADE_STOPS_LEVEL=%d points)",
                        EnumToString(type),SL,price-stops_level*_Point,(int)((price-SL)/_Point),stops_level);
         //--- check the TakeProfit
         TP_check=((TP-price)>stops_level*_Point);
         if(!TP_check)
            PrintFormat("For order %s   TakeProfit=%.5f must be greater than %.5f"+
                        " (TakeProfit-Open=%d points ==> SYMBOL_TRADE_STOPS_LEVEL=%d points)",
                        EnumToString(type),TP,price+stops_level*_Point,(int)((TP-price)/_Point),stops_level);
         //--- return the result of checking
         return(SL_check&&TP_check);
        }
      //--- SellLimit pending order
      case  ORDER_TYPE_SELL_LIMIT:
        {
         //--- check the StopLoss
         SL_check=((SL-price)>stops_level*_Point);
         if(!SL_check)
            PrintFormat("For order %s   StopLoss=%.5f must be greater than %.5f"+
                        " (StopLoss-Open=%d points ==> SYMBOL_TRADE_STOPS_LEVEL=%d points)",
                        EnumToString(type),SL,price+stops_level*_Point,(int)((SL-price)/_Point),stops_level);
         //--- check the TakeProfit
         TP_check=((price-TP)>stops_level*_Point);
         if(!TP_check)
            PrintFormat("For order %s   TakeProfit=%.5f must be less than %.5f"+
                        " (Open-TakeProfit=%d points ==> SYMBOL_TRADE_STOPS_LEVEL=%d points)",
                        EnumToString(type),TP,price-stops_level*_Point,(int)((price-TP)/_Point),stops_level);
         //--- return the result of checking
         return(TP_check&&SL_check);
        }
      break;
      //--- BuyStop pending order
      case  ORDER_TYPE_BUY_STOP:
        {
         //--- check the StopLoss
         SL_check=((price-SL)>stops_level*_Point);
         if(!SL_check)
            PrintFormat("For order %s   StopLoss=%.5f must be less than %.5f"+
                        " (Open-StopLoss=%d points ==> SYMBOL_TRADE_STOPS_LEVEL=%d points)",
                        EnumToString(type),SL,price-stops_level*_Point,(int)((price-SL)/_Point),stops_level);
         //--- check the TakeProfit
         TP_check=((TP-price)>stops_level*_Point);
         if(!TP_check)
            PrintFormat("For order %s   TakeProfit=%.5f must be greater than %.5f"+
                        " (TakeProfit-Open=%d points ==> SYMBOL_TRADE_STOPS_LEVEL=%d points)",
                        EnumToString(type),TP,price-stops_level*_Point,(int)((TP-price)/_Point),stops_level);
         //--- return the result of checking
         return(SL_check&&TP_check);
        }
      //--- SellStop pending order
      case  ORDER_TYPE_SELL_STOP:
        {
         //--- check the StopLoss
         SL_check=((SL-price)>stops_level*_Point);
         if(!SL_check)
            PrintFormat("For order %s   StopLoss=%.5f must be greater than %.5f"+
                        " (StopLoss-Open=%d points ==> SYMBOL_TRADE_STOPS_LEVEL=%d points)",
                        EnumToString(type),SL,price+stops_level*_Point,(int)((SL-price)/_Point),stops_level);
         //--- check the TakeProfit
         TP_check=((price-TP)>stops_level*_Point);
         if(!TP_check)
            PrintFormat("For order %s   TakeProfit=%.5f must be less than %.5f"+
                        " (Open-TakeProfit=%d points ==> SYMBOL_TRADE_STOPS_LEVEL=%d points)",
                        EnumToString(type),TP,price-stops_level*_Point,(int)((price-TP)/_Point),stops_level);
         //--- return the result of checking
         return(TP_check&&SL_check);
        }
      break;
     }

//---
   return false;
  }
  
//+------------------------------------------------------------------+
//| Return the total number of pending orders on the symbol          |
//+------------------------------------------------------------------+
int OrdersTotalPending(string sym)
  {
   int orders=0;
   for(int i=0;i<OrdersTotal();i++)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
        {
         if(OrderSymbol()==sym)
           {
            if((OrderType()!=OP_BUY) && (OrderType()!=OP_SELL))
              {
               orders++;
              }
           }
        }
     }
   return(orders);
  }
//+------------------------------------------------------------------+
//| Return the ticket of a pending order by number                   |
//+------------------------------------------------------------------+
int OrderPendingSelect(int ind,string sym)
  {
   int ticket=0,counter=0;
   for(int i=0;i<OrdersTotal();i++)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
        {
         if(OrderSymbol()==sym)
           {
            if((OrderType()!=OP_BUY) && (OrderType()!=OP_SELL))
              {
               if(counter==ind)
                 {
                  ticket=OrderTicket();
                  break;
                 }
               counter++;
              }
           }
        }
     }

   return(ticket);
  }
//+------------------------------------------------------------------+
//| Return the order type as a string                                |
//+------------------------------------------------------------------+
string GetOrderTypeString(int type)
  {
   switch(type)
     {
      case  OP_BUY:
         return("OP_BUY");       break;
      case  OP_SELL:
         return("OP_SELL");      break;
      case  OP_BUYLIMIT:
         return("OP_BUYLIMIT");  break;
      case  OP_SELLLIMIT:
         return("OP_SELLLIMIT"); break;
      case  OP_BUYSTOP:
         return("OP_BUYSTOP");   break;
      case  OP_SELLSTOP:
         return("OP_SELLSTOP");  break;
     }
//--- unknown order type     
   return("Unknown order type");
  }
//+------------------------------------------------------------------+
  
//+------------------------------------------------------------------+
//| Return the current order activation price                        |
//+------------------------------------------------------------------+
double GetActivationPrice(int ticket)
  {
//---
   double activation_price=0;
//---
   if(OrderSelect(ticket,SELECT_BY_TICKET,MODE_TRADES))
     {
      int type=OrderType();
      //--- orders are activated by the Ask price
      if(type==OP_BUYLIMIT || type==OP_BUYSTOP)
        {
         activation_price=Ask;
        }
      else
      //--- orders are activated by the Bid price
      if(type==OP_SELLLIMIT || type==OP_SELLSTOP)
        {
         activation_price=Bid;
        }
     }
//--- price is not determined for the other orders
   return activation_price;
  }
//+------------------------------------------------------------------+
//| Calculate the nearest opening price for the current moment       |
//+------------------------------------------------------------------+
double GetNearestPrice(int type,int distance)
  {
   double price=0;
//--- iterate over the order types
   switch(type)
     {
      case  OP_SELLSTOP:
         price=Bid-distance*_Point;
         break;
      case  OP_BUYLIMIT:
         price=Ask-distance*_Point;
         break;
      case  OP_SELLLIMIT:
         price=Bid+distance*_Point;
         break;
      case  OP_BUYSTOP:
         price=Ask+distance*_Point;
         break;
      default:
         break;
     }
//--- return the received result
   return(NormalizeDouble(price,_Digits));
  }  