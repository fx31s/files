//+------------------------------------------------------------------+
//|                                                        Skyper5.0 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

bool skyper=false;
bool mode=false;
bool eqsys=true;

string last_select_object="";

double high_price;
double low_price;
int shift_1;
int shift_2;
double price_1;
double price_2;
bool lock=false;

bool fibo_tp_level=false;
color tp_level=clrBlack;



     long sinyal_charid=ChartID();
     long currChart=ChartID();
     
   string sym=Symbol();
   ENUM_TIMEFRAMES per=Period();
   
   

bool oto_system=false;

double mode_number=0;

   
   
   
/////////////////////////////////////////////////////////
int ma_shift = 0; // Zaman
int shiftma  = 0;
int shift=0;

extern ENUM_MA_METHOD MaMethod=MODE_SMA;  // Method
extern ENUM_APPLIED_PRICE MaPrice=PRICE_CLOSE;// Ma Price


extern ENUM_TIMEFRAMES system_time_period = PERIOD_CURRENT;

extern ENUM_MA_METHOD MaMethods=MODE_SMA;  // Method
extern ENUM_APPLIED_PRICE MaPrices=PRICE_CLOSE;// Ma Price

extern ENUM_TIMEFRAMES MaTimeA = PERIOD_CURRENT;
extern ENUM_TIMEFRAMES MaTimeB = PERIOD_CURRENT;

//extern int MA_W=21;
//extern int MB_W=55;

extern int MA_W=50;
extern int MB_W=10;
extern int MC_W=20;
/////////////////////////////////////////////////////////
double ma_high=-1;
double ma_low=1000000;


double ma_level[1001];


int swing_power=34;


double Ortalama;

datetime mnt;

double gericekilme=21;
double gericekilme1=21;
double gericekilme2=13;

bool auto_mode=false;


int mode_off_shift=-1;
int mode_hl_shift=-1;







int buy_total=0;
int sell_total=0;
double buy_profit=0;
double sell_profit=0;
double buy_lot=0;
double sell_lot=0;
double buy_pen_lot=0;
double sell_pen_lot=0;

bool eq_order=false;
int eq_live_order=0;
int eq_pen_order=0;
bool eq_system=false; // Eq Sistem
int eq_lot_carpan=1;

bool lock_order_buy_total=0;
bool lock_order_sell_total=0;

double price=0;

double sell_total_profit_loss=0;
double buy_total_profit_loss=0;

double sell_total_profit=0;
double buy_total_profit=0;

double sell_pen_total_profit_loss=0;
double buy_pen_total_profit_loss=0;

double sell_pen_total_profit=0;
double buy_pen_total_profit=0;


double last_buy_lot;
double last_sell_lot;

double buy_orders[50,4];
double sell_orders[50,4];


int magic=0;


bool wick=false;


int objtotal;

bool buy_line=false;
bool sell_line=false;


bool profit_alarm=false;
bool profit_close=false;

bool left_fibo=false;

bool background_work=false;
bool foreground_check=false;


bool profit_sound=true;
//string profit_sound_name="alert2";
string profit_sound_name="kasasesi";

bool full_mode=false;
bool high_low_mode=false;
int hl_count=0;

double sk_prc1=-1;
double sk_prc2=-1;
bool sk_guard=false;
bool sk_guard_sl=false;
double sk_last_buy_total;
double sk_last_sell_total;

int maxDuration = 2 * 60; 
bool order_time_close=false;


bool ifvg=false;
bool ifibo=false;


extern int ObjeOran=100; // Object Screen Size Percent %


//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
  
  
  


  int pos=(ChartGetInteger(0,CHART_WIDTH_IN_PIXELS,0)/2)+100;
  
  
/*
  string filename = "\\Files\\kuralsm.bmp";
  
    ObjectDelete(ChartID(), "WIN_ICON"+ChartID());
    ObjectCreate( ChartID(), "WIN_ICON"+ChartID(), OBJ_BITMAP_LABEL, 0, TimeCurrent(), Ask );
    ObjectSetString( ChartID(), "WIN_ICON"+ChartID(), OBJPROP_BMPFILE, filename );
    ObjectSetInteger(ChartID(),"WIN_ICON"+ChartID(),OBJPROP_BACK,False);
    ObjectSetInteger(ChartID(),"WIN_ICON"+ChartID(),OBJPROP_CORNER,CORNER_RIGHT_LOWER);
    //ObjectSetInteger(ChartID(),"WIN_ICON"+ChartID(),OBJPROP_YSIZE,500);
    //ObjectSetInteger(ChartID(),"WIN_ICON"+ChartID(),OBJPROP_YSIZE,500);
    ObjectSetInteger(ChartID(),"WIN_ICON"+ChartID(),OBJPROP_XDISTANCE,pos);
    ObjectSetInteger(ChartID(),"WIN_ICON"+ChartID(),OBJPROP_YDISTANCE,200);    
    ObjectSetInteger(ChartID(),"WIN_ICON"+ChartID(),OBJPROP_HIDDEN,false);*/
      
  
   ChartSetInteger(ChartID(),CHART_COLOR_ASK,clrNONE);
   ChartSetInteger(ChartID(),CHART_COLOR_BID,clrNONE);  
   ChartSetInteger(ChartID(),CHART_COLOR_GRID,clrNONE);
   ChartSetInteger(ChartID(),CHART_AUTOSCROLL,False);
  
  //Alert(IsTradeAllowed());
  
  
  //ObjectsDeleteAll();
  
  if ( ChartGetInteger(ChartID(),CHART_BRING_TO_TOP) == True ) {
  foreground_check=true;  
  background_work=true;
  
  //if ( profit_sound==true) PlaySound(profit_sound_name);
  
  }
  
  
 //Alert(TerminalInfoInteger(TERMINAL_TRADE_ALLOWED));
 
 //Alert(IsTradeAllowed(),"/",TerminalInfoInteger(TERMINAL_TRADE_ALLOWED));
  
 

  
  
//--- create timer
   //EventSetTimer(60);
   
   /*
double yuzde=DivZero(AccountBalance(),100);
   double oran=yuzde*2.5;
   
   
   
   if ( ChartGetInteger(ChartID(),CHART_BRING_TO_TOP) == True ) {
   
   
   double pip=PipPrice(Symbol(),oran,0,2.5);
   
   Comment("Oran:",oran,"\n Pip:",pip);
   
   //OrderModify(81812788,64280.36,64280.36+pip,0,-1,clrNONE);
   
   }
   */
      
   
   
   
   
    Print("Account #",AccountNumber(), " leverage is ", AccountLeverage(),"/ OneLot",MarketInfo(Symbol(),MODE_MARGINREQUIRED));
    

objtotal=ObjectsTotal();

   ChartSetInteger(ChartID(),CHART_SHOW_ASK_LINE,True);
   ChartSetInteger(ChartID(),CHART_SHOW_BID_LINE,True);   
   
        /////////////////////////////////
  mnt=Time[0]+1000*PeriodSeconds();
  
  if ( Period() == PERIOD_MN1 ) {
  
  mnt=Time[0];
  
  }
  ////////////////////////////
   CreateSinyalButton();
   
   Sinyal();
   
   if ( ObjeOran != 100 ) Resize(ObjeOran);
   
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

int OrdersTotals=-1;

void OnTick()
  {
//---

Sinyal();
AvarageSystem(0);


if ( OrdersTotal() != OrdersTotals ) {
ObjectsDeleteAlls(ChartID(),"BuyLine",-1,OBJ_HLINE);
ObjectsDeleteAlls(ChartID(),"SellLine",-1,OBJ_HLINE);
OrdersTotals=OrdersTotal();
}


//ObjectsDeleteAlls(ChartID(),"Avarage",-1,OBJ_HLINE);


if ( buy_line == true || sell_line == true ) {

   for (int m=OrdersTotal(); m>=0; m--)
   {
      if ( OrderSelect(m, SELECT_BY_POS))
      {
       
      datetime order_open_time = OrderOpenTime();
       int duration = (int)TimeCurrent() - (int)order_open_time;       
       
  if( buy_line == true && ( OrderType() == OP_BUY || OrderType() == OP_BUYLIMIT || OrderType() == OP_BUYSTOP ) && OrderSymbol() == Symbol() && OrderMagicNumber() == magic )
         {


string name="BuyLine"+OrderTicket();
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_HLINE,0,Time[0],OrderOpenPrice());
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlue);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DASH);
ObjectSetInteger(ChartID(),name,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),name,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),name,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
//ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,int(DivZero(duration,60))+" / "+OrderProfit()+"$");
ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,DoubleToString(DivZero(duration,60),1)+" / "+OrderProfit()+"$");
ObjectSetString(ChartID(),name,OBJPROP_TEXT,OrderTicket());
if ( duration >= maxDuration ) ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);
if ( auto_close_profit == true ) {
if ( auto_close_profit_usd != 0 && OrderProfit() >= auto_close_profit_usd ) {
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLimeGreen);
}
} else {
if ( OrderProfit() > 0 ) {
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrChartreuse);
}
}



if ( OrderType() == OP_BUYLIMIT || OrderType() == OP_BUYSTOP ) ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);
if ( OrderType() == OP_BUYLIMIT || OrderType() == OP_BUYSTOP ) ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlue);



         }
         

         if( sell_line==true  && ( OrderType() == OP_SELL || OrderType() == OP_SELLLIMIT || OrderType() == OP_SELLSTOP ) && OrderSymbol() == Symbol() && OrderMagicNumber() == magic )
         {

string name="SellLine"+OrderTicket();
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_HLINE,0,Time[0],OrderOpenPrice());
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrOrangeRed);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DASH);
ObjectSetInteger(ChartID(),name,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),name,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),name,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
//ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,int(DivZero(duration,60))+" / "+OrderProfit()+"$");
ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,DoubleToString(DivZero(duration,60),1)+" / "+OrderProfit()+"$");
ObjectSetString(ChartID(),name,OBJPROP_TEXT,OrderTicket());
if ( duration >= maxDuration ) ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);
if ( auto_close_profit == true ) {
if ( auto_close_profit_usd != 0 && OrderProfit() >= auto_close_profit_usd ) {
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLimeGreen);
}
}else {
if ( OrderProfit() > 0 ) {
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrChartreuse);
}
}

if ( OrderType() == OP_SELLLIMIT || OrderType() == OP_SELLSTOP ) ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);
if ( OrderType() == OP_SELLLIMIT || OrderType() == OP_SELLSTOP ) ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrOrangeRed);

         }         
                  
         
         
      }
    }
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


void BuyCheck(int control_type)
{

string order_list="";
string order_lots="";
string order_buystop_list="";
string order_buystop_cmt_list="";
string order_sellstop_list="";
string order_sellstop_cmt_list="";



   for (int m=OrdersTotal(); m>=0; m--)
   {
      if ( OrderSelect(m, SELECT_BY_POS))
      {
      
         if(OrderType() == OP_BUYSTOP && OrderSymbol() == Symbol() && OrderMagicNumber() != magic )
         {
         
         if ( order_buystop_list != "" ) order_buystop_list=order_buystop_list+","+OrderTicket();
         if ( order_buystop_list == "" ) order_buystop_list=OrderTicket();               
         
         if ( order_buystop_cmt_list != "" ) order_buystop_cmt_list=order_buystop_cmt_list+","+OrderComment();
         if ( order_buystop_cmt_list == "" ) order_buystop_cmt_list=OrderComment();           
         
         }

         if(OrderType() == OP_SELLSTOP && OrderSymbol() == Symbol() && OrderMagicNumber() != magic )
         {
         
         if ( order_sellstop_list != "" ) order_sellstop_list=order_sellstop_list+","+OrderTicket();
         if ( order_sellstop_list == "" ) order_sellstop_list=OrderTicket();               

         if ( order_sellstop_cmt_list != "" ) order_sellstop_cmt_list=order_sellstop_cmt_list+","+OrderComment();
         if ( order_sellstop_cmt_list == "" ) order_sellstop_cmt_list=OrderComment();     
         
         }
         
                  
         
      
         if(OrderType() == OP_BUY && OrderSymbol() == Symbol() && OrderMagicNumber() == magic )
         {
         
         if ( order_list != "" ) order_list=order_list+","+OrderTicket();
         if ( order_lots != "" ) order_lots=order_lots+","+OrderLots();   
               
         if ( order_list == "" ) order_list=OrderTicket();
         if ( order_lots == "" ) order_lots=OrderLots();
                           


         if ( sk_guard_sl == true && OrderStopLoss() == 0 ) {
         double SL=0;
         if ( sk_prc1 > sk_prc2 ) SL=sk_prc2;
         if ( sk_prc2 > sk_prc1 ) SL=sk_prc1;                           
         OrderModify(OrderTicket(),OrderOpenPrice(),SL,OrderTakeProfit(),-1,clrNONE);         
         }
         

         }
      }
    }
    
    //Print(order_lots);
    



string to_split=order_list;//"life_is_good";   // A string to split into substrings
string to_splitl=order_lots;//"life_is_good";   // A string to split into substrings
string to_splitb=order_buystop_list;//"life_is_good";   // A string to split into substrings
string to_splits=order_sellstop_list;//"life_is_good";   // A string to split into substrings
string to_splitsc=order_sellstop_cmt_list;//"life_is_good";   // A string to split into substrings
   string sep=",";                // A separator as a character
   ushort u_sep;                  // The code of the separator character
   string results[];               // An array to get strings
   string resultsl[];               // An array to get strings
   string resultsb[];               // An array to get strings
   string resultss[];               // An array to get strings
   string resultsc[];               // An array to get strings
   //--- Get the separator code
   u_sep=StringGetCharacter(sep,0);
   //--- Split the string to substrings
   int k=StringSplit(to_split,u_sep,results);
   int kl=StringSplit(to_splitl,u_sep,resultsl);
   int kb=StringSplit(to_splitb,u_sep,resultsb);
   int ks=StringSplit(to_splits,u_sep,resultss);
   int kc=StringSplit(to_splitsc,u_sep,resultsc);
   //--- Show a comment 
   //PrintFormat("Strings obtained: %d. Used separator '%s' with the code %d",k,sep,u_sep);
   //--- Now output all obtained strings
   
   if ( control_type == 0 ) {  
   
   Print("SellStopList:",to_splits);  
   if(ks>0)
     {
      for(int i=0;i<ks;i++)
        {
        string OrderTickets=resultss[i];
        string OrderTickets_Comment=resultsc[i];
        long buy_ticket=BuyTicketCheck(OrderTickets_Comment);
        
        if ( buy_ticket == -1 ) {
        OrderDelete(OrderTickets,clrNONE);  
        }      
        }
        
        }
        
        }
        
        
           
   
   if(k>0)
     {
      for(int i=0;i<k;i++)
        {
        
        string OrderTickets=results[i];
        double OrderLot=StringToDouble(resultsl[i]);
        
        Print("Tickets:",OrderTickets,"/ Lot:",OrderLot);

         long ssc_ticket=SellStopCheck(OrderTickets);
            
        /* if ( control_type == 0 ) {         
         if ( ssc_ticket != -1 ) {         
         OrderDelete(ssc_ticket,clrNONE);         
         }        
         }*/
       

         if ( control_type == 1 ) {         
         if ( ssc_ticket == -1 ) {   
         
         double SL=0;
         if ( sk_prc1 > sk_prc2 ) SL=sk_prc1;
         if ( sk_prc2 > sk_prc1 ) SL=sk_prc2;  

         double OP=0;
         if ( sk_prc1 > sk_prc2 ) OP=sk_prc2;
         if ( sk_prc2 > sk_prc1 ) OP=sk_prc1; 
         
         double TP=0;
                  
         if ( sk_guard_sl == false ) SL=0;    
                                      
         if ( sk_guard == true ) OrderSend(OrderSymbol(),OP_SELLSTOP,OrderLot,OP,0,SL,TP,OrderTickets,2,-1,clrNONE);                 
         }        
         }
        
        
        
         //if (!SALE_MODE) PrintFormat("result[%d]=%s",i,results[i]);
        }
     };
     
     
         
    
    





    
}




void SellCheck(int control_type)
{

string order_list="";
string order_lots="";
string order_buystop_list="";
string order_buystop_cmt_list="";
string order_sellstop_list="";
string order_sellstop_cmt_list="";

   for (int h=OrdersTotal();h>=0;h--)
   {
      if ( OrderSelect(h,SELECT_BY_POS) )
      {
      
      
         if(OrderType() == OP_BUYSTOP && OrderSymbol() == Symbol() && OrderMagicNumber() != magic )
         {
         
         if ( order_buystop_list != "" ) order_buystop_list=order_buystop_list+","+OrderTicket();
         if ( order_buystop_list == "" ) order_buystop_list=OrderTicket();               
         
         if ( order_buystop_cmt_list != "" ) order_buystop_cmt_list=order_buystop_cmt_list+","+OrderComment();
         if ( order_buystop_cmt_list == "" ) order_buystop_cmt_list=OrderComment();           
         
         }
         
         


      
         if(OrderType() == OP_SELL && OrderSymbol() == Symbol() && OrderMagicNumber() == magic )
         {
         
         if ( order_list != "" ) order_list=order_list+","+OrderTicket();
         if ( order_lots != "" ) order_lots=order_lots+","+OrderLots();   
               
         if ( order_list == "" ) order_list=OrderTicket();
         if ( order_lots == "" ) order_lots=OrderLots();
                  


         if ( sk_guard_sl == true && OrderStopLoss() == 0 ) {
         double SL=0;
         if ( sk_prc1 < sk_prc2 ) SL=sk_prc2;
         if ( sk_prc2 < sk_prc1 ) SL=sk_prc1;                           
         if ( sk_guard == true ) OrderModify(OrderTicket(),OrderOpenPrice(),SL,OrderTakeProfit(),-1,clrNONE);         
         }
         
         
         /*
         long bsc_ticket=BuyStopCheck(OrderTicket());
         
         if ( control_type == 0 ) {         
         if ( bsc_ticket != -1 ) {         
         OrderDelete(bsc_ticket,clrNONE);         
         }        
         }
                  

         if ( control_type == 1 ) {         
         if ( bsc_ticket == -1 ) {   
         
         double SL=0;
         if ( sk_prc1 < sk_prc2 ) SL=sk_prc1;
         if ( sk_prc2 < sk_prc1 ) SL=sk_prc2;  

         double OP=0;
         if ( sk_prc1 < sk_prc2 ) OP=sk_prc2;
         if ( sk_prc2 < sk_prc1 ) OP=sk_prc1; 
         
         double TP=0;
                  
         if ( sk_guard_sl == false ) SL=0;                                          
         OrderSend(OrderSymbol(),OP_BUYSTOP,OrderLots(),OP,0,SL,TP,OrderTicket(),2,-1,clrNONE);                 
         }        
         }*/
         
         
         
                  
         

         }
         
         
         
         
         
string to_split=order_list;//"life_is_good";   // A string to split into substrings
string to_splitl=order_lots;//"life_is_good";   // A string to split into substrings
string to_splitb=order_buystop_list;//"life_is_good";   // A string to split into substrings
string to_splitbc=order_buystop_cmt_list;//"life_is_good";   // A string to split into substrings
string to_splits=order_sellstop_list;//"life_is_good";   // A string to split into substrings
string to_splitsc=order_sellstop_cmt_list;//"life_is_good";   // A string to split into substrings
   string sep=",";                // A separator as a character
   ushort u_sep;                  // The code of the separator character
   string results[];               // An array to get strings
   string resultsl[];               // An array to get strings
   string resultsb[];               // An array to get strings
   string resultss[];               // An array to get strings
   string resultsc[];               // An array to get strings
   string resultbc[];               // An array to get strings
   //--- Get the separator code
   u_sep=StringGetCharacter(sep,0);
   //--- Split the string to substrings
   int k=StringSplit(to_split,u_sep,results);
   int kl=StringSplit(to_splitl,u_sep,resultsl);
   int kb=StringSplit(to_splitb,u_sep,resultsb);
   //int kb=StringSplit(to_splitb,u_sep,resultsb);
   //int ks=StringSplit(to_splits,u_sep,resultss);
   int kc=StringSplit(to_splitbc,u_sep,resultbc);
   //--- Show a comment 
   //PrintFormat("Strings obtained: %d. Used separator '%s' with the code %d",k,sep,u_sep);
   //--- Now output all obtained strings
   
   if ( control_type == 0 ) {  
   
   Print("BuyStopList:",to_splitb);  
   Print("BuyStopCommentList:",to_splitbc);  
   if(kb>0)
     {
      for(int i=0;i<kb;i++)
        {
        
        
        
        string OrderTickets=resultsb[i];
        string OrderTickets_Comment=resultbc[i];
        long sell_ticket=SellTicketCheck(OrderTickets_Comment);
        
        Print("Bt:",sell_ticket,"/Ot:",OrderTickets,"/Otcmt:",OrderTickets_Comment);
        
        if ( sell_ticket == -1 ) {
        OrderDelete(OrderTickets,clrNONE);  
        }   
        
            
        }
        
        }
        
        }
        
     
   
   if(k>0)
     {
      for(int i=0;i<k;i++)
        {
        
        string OrderTickets=results[i];
        double OrderLot=StringToDouble(resultsl[i]);
        
        Print("Tickets:",OrderTickets,"/ Lot:",OrderLot);

         long ssc_ticket=BuyStopCheck(OrderTickets);
            
        /* if ( control_type == 0 ) {         
         if ( ssc_ticket != -1 ) {         
         OrderDelete(ssc_ticket,clrNONE);         
         }        
         }*/
       

         if ( control_type == 1 ) {         
         if ( ssc_ticket == -1 ) {   
         
         double SL=0;
         if ( sk_prc1 > sk_prc2 ) SL=sk_prc2;
         if ( sk_prc2 > sk_prc1 ) SL=sk_prc1;  

         double OP=0;
         if ( sk_prc1 > sk_prc2 ) OP=sk_prc1;
         if ( sk_prc2 > sk_prc1 ) OP=sk_prc2; 
         
         double TP=0;
                  
         if ( sk_guard_sl == false ) SL=0;    
                                      
         OrderSend(OrderSymbol(),OP_BUYSTOP,OrderLot,OP,0,SL,TP,OrderTickets,2,-1,clrNONE);                 
         }        
         }
        
        
        
         //if (!SALE_MODE) PrintFormat("result[%d]=%s",i,results[i]);
        }
     };
     
     
         
         
      }
   }
}


long BuyStopCheck(string tickets)
{

long sonuc=-1;

   for (int mm=OrdersTotal(); mm>=0; mm--)
   {
      if ( OrderSelect(mm, SELECT_BY_POS))
      {
         if(OrderType() == OP_BUYSTOP && OrderSymbol() == Symbol() && OrderMagicNumber() != magic && OrderComment() == tickets )
         {
         sonuc=OrderTicket();
         }
      }
    }
    
    return sonuc;
    
}


long BuyTicketCheck(string tickets)
{

long sonuc=-1;

   for (int mm=OrdersTotal(); mm>=0; mm--)
   {
      if ( OrderSelect(mm, SELECT_BY_POS))
      {
         if(OrderType() == OP_BUY && OrderSymbol() == Symbol() && OrderMagicNumber() == magic && OrderTicket() == StringToInteger(tickets) )
         {
         sonuc=OrderTicket();
         }
      }
    }
    
    return sonuc;
    
}

long SellTicketCheck(string tickets)
{

long sonuc=-1;

   for (int mm=OrdersTotal(); mm>=0; mm--)
   {
      if ( OrderSelect(mm, SELECT_BY_POS))
      {
         if(OrderType() == OP_SELL && OrderSymbol() == Symbol() && OrderMagicNumber() == magic && OrderTicket() == StringToInteger(tickets) )
         {
         sonuc=OrderTicket();
         }
      }
    }
    
    return sonuc;
    
}



long SellStopCheck(string tickets)
{

long sonuc=-1;

   for (int mm=OrdersTotal(); mm>=0; mm--)
   {
      if ( OrderSelect(mm, SELECT_BY_POS))
      {
         if(OrderType() == OP_SELLSTOP && OrderSymbol() == Symbol() && OrderMagicNumber() != magic && OrderComment() == tickets )
         {
         sonuc=OrderTicket();
         }
      }
    }
    
    return sonuc;
    
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





void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
  
  

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_TRIANGLE
//&& StringFind(sparam,"MP",0) == -1 && StringFind(sparam,"HP",0) == -1 && StringFind(sparam,"LP",0) == -1 && StringFind(sparam,"CP",0) == -1 &&  StringFind(sparam,"Exp131",0) != -1 && StringFind(sparam,"MAL",0) == -1 && lock == false && skyper == false && eqsys == true 

) {


RefreshRates();
ChartRedraw();
WindowRedraw();

//Alert("Selam");

//if ( mode_off_shift != 0 && sparam != last_select_object ) mode=true;



//return;

last_select_object=sparam;



          int obj_typ = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TYPE);
          datetime obj_time1 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,0);
          datetime obj_time2 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,1);
          datetime obj_time3 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,2);
          double obj_prc1 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,0);
          double obj_prc2 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,1);
          double obj_prc3 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,2);
          bool obj_fiil = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_FILL);
          double obj_scale = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_SCALE);
          double obj_angle = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_ANGLE);
          bool obj_ray = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_RAY);
          color obj_color = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_COLOR);
          color obj_bgcolor = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_BGCOLOR);
          int obj_width = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_WIDTH);
          int obj_back = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_BACK);
          
          
          int shift1=iBarShift(Symbol(),Period(),obj_time1);
          int shift2=iBarShift(Symbol(),Period(),obj_time2);
          int shift3=iBarShift(Symbol(),Period(),obj_time3);
          
          
 if ( obj_prc1 > obj_prc2 && obj_prc1 > obj_prc3 ) {
 
 ObjectMove(ChartID(),last_select_object,0,Time[shift1],High[shift1]);
 ObjectMove(ChartID(),last_select_object,1,Time[shift2],Low[shift2]);
 ObjectMove(ChartID(),last_select_object,2,Time[shift3],Low[shift3]);
 
// double yuzdem=DivZero(max_high_price-Low[shift1],100);
double yuzdem=0;

 
double levels=131;
string level=DoubleToString(levels,2);

levels=0;
levels=0.001;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],High[shift1]+levels*yuzdem,mnt,High[shift1]+levels*yuzdem);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_SOLID);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);


levels=0;
levels=0.01;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],Low[shift1]+levels*yuzdem,mnt,Low[shift1]+levels*yuzdem);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);


levels=0;
levels=0.02;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],Low[shift2]+levels*yuzdem,mnt,Low[shift2]+levels*yuzdem);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);

levels=0;
levels=0.03;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift3],Low[shift3]+levels*yuzdem,mnt,Low[shift3]+levels*yuzdem);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);


 
 
 }  
 
 
 if ( obj_prc1 < obj_prc2 && obj_prc1 < obj_prc3 ) {
 
 ObjectMove(ChartID(),last_select_object,0,Time[shift1],Low[shift1]);
 ObjectMove(ChartID(),last_select_object,1,Time[shift2],High[shift2]);
 ObjectMove(ChartID(),last_select_object,2,Time[shift3],High[shift3]);
 
// double yuzdem=DivZero(max_high_price-Low[shift1],100);
double yuzdem=0;

 
double levels=131;
string level=DoubleToString(levels,2);



levels=0;
levels=0.001;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],Low[shift1]+levels*yuzdem,mnt,Low[shift1]+levels*yuzdem);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_SOLID);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);


levels=0;
levels=0.01;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],High[shift1]+levels*yuzdem,mnt,High[shift1]+levels*yuzdem);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);


levels=0;
levels=0.02;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],High[shift2]+levels*yuzdem,mnt,High[shift2]+levels*yuzdem);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);

levels=0;
levels=0.03;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift3],High[shift3]+levels*yuzdem,mnt,High[shift3]+levels*yuzdem);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);


 
 
 }  
       
       
       
          
          
          }
            
  
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_HLINE ) {
  
  string text=ObjectGetString(ChartID(),sparam,OBJPROP_TEXT);
  
  if ( text != "" ) {
  
  int ordtic=StringToInteger(text);
  
  if ( ordtic > 0 ) {

   for (int h=OrdersTotal();h>=0;h--)
   {
      if ( OrderSelect(h,SELECT_BY_POS) )
      {
         if( OrderSymbol() == Symbol() && OrderMagicNumber() == magic && OrderTicket() == ordtic )
         {
              int cevap=MessageBox("OrderCLose","Cls Order",4); //  / Spread:"+Spread_Yuzde+"%"
           
           
           datetime order_open_time = OrderOpenTime();
       int duration = (int)TimeCurrent() - (int)order_open_time;                 
     
     if ( cevap == 6 && duration >= maxDuration ) { 
     

            RefreshRates();
            bool success =OrderClose(OrderTicket(), OrderLots(), OrderClosePrice(), 0, Red);
            
            
            
            }
         }
      }
   }
  
  
  
  }
  
  }
  
  
  }
  //////////////////////////////////////////////////////////////////////////////////
  
  
  if ( sparam == "ButtonSinyal"+17 ) {
  
  
  //Alert("Selam");
  
  //OnTick();
  Sinyal();
  
  }
  
  //Print(sparam);
  
  if ( sparam == 35 ) { // HighLow H
  
  if ( high_low_mode == true ) { high_low_mode = false; } else { high_low_mode =true;}
  
  Comment("HighLowMode:",high_low_mode);  
  CreateSinyalButtonRight();
  
  
  }
  
  
  
  if ( sparam == 33 ) { // Full Mode P
  
  if ( full_mode == true ) { full_mode = false; } else { full_mode =true;}
  
  Comment("Full Mode:",full_mode);  
  CreateSinyalButtonRight();
  
  
  }
  
  
    
  

 //if ( TerminalInfoInteger(TERMINAL_TRADE_ALLOWED) == 1 ) {
 
 //if ( IsTradeAllowed() == true ) {
 
 if ( ChartGetInteger(ChartID(),CHART_BRING_TO_TOP) == True ) {
 
 background_work=true;
 string buttonID="ButtonSinyalRight"+10;
ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrLightGreen);
 }
 
 //}
 
 //}
 
 
   

 //if ( buy_total+sell_total > 0 ) {
 
 if ( TerminalInfoInteger(TERMINAL_TRADE_ALLOWED) == 1 ) {
 
 if ( IsTradeAllowed() == true ) {
 
 if ( ChartGetInteger(ChartID(),CHART_BRING_TO_TOP) == False ) {
 
 background_work=true;
 string buttonID="ButtonSinyalRight"+10;
ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrLightGreen);
 }
 
 }
 
 }
 

 if ( TerminalInfoInteger(TERMINAL_TRADE_ALLOWED) == 0 || IsTradeAllowed() == false) {
 
 //if ( IsTradeAllowed() == false ) {
 
 if ( ChartGetInteger(ChartID(),CHART_BRING_TO_TOP) == False ) {
 
 background_work=false;
 string buttonID="ButtonSinyalRight"+10;
ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrWhite);
 }
 
 //}
 
 }
  
 
 //} 
  
  
//---

//Print(sparam);
/*
if ( ChartGetInteger(ChartID(),CHART_BRING_TO_TOP) == True ) {
foreground_check=true;
}

if ( background_work == true && stop_question == false && ( foreground_check == true || OrdersTotal() > 0 ) ) {


if ( ChartGetInteger(ChartID(),CHART_BRING_TO_TOP) == False ) {

int chart_num=-1;

        long currChart,prevChart=ChartFirst();
   int i=0,limit=100;

   while(i<limit)// We have certainly not more than 100 open charts
     {
      if ( i > 0 ) currChart=ChartNext(prevChart); // Get the new chart ID by using the previous chart ID

      if (ChartID() == currChart ) {
      chart_num=i;
      }

      if(currChart<0) break; 

      prevChart=currChart;// let's save the current chart ID for the ChartNext()
      i++;// Do not forget to increase the counter
      

      
      }
      
      

     int cevap=MessageBox(Symbol()+" "+TFtoStr(Period())+" Stop ? #"+chart_num,"Background Work Stop",4); //  / Spread:"+Spread_Yuzde+"%"
     if ( cevap == 6 ) {
     background_work=false;
string buttonID="ButtonSinyalRight"+10;
ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrWhite);
     
     }
     
     stop_question=true;
     

}

}
*/




if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_RECTANGLE) {

string last_select_objectr=sparam;

//Alert(last_select_objectr);


          int obj_typ = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_TYPE);
          datetime obj_time1 = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_TIME,0);
          datetime obj_time2 = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_TIME,1);
          datetime obj_time3 = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_TIME,2);
          double obj_prc1 = ObjectGetDouble(ChartID(),last_select_objectr,OBJPROP_PRICE,0);
          double obj_prc2 = ObjectGetDouble(ChartID(),last_select_objectr,OBJPROP_PRICE,1);
          double obj_prc3 = ObjectGetDouble(ChartID(),last_select_objectr,OBJPROP_PRICE,2);
          bool obj_fiil = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_FILL);
          double obj_scale = ObjectGetDouble(ChartID(),last_select_objectr,OBJPROP_SCALE);
          double obj_angle = ObjectGetDouble(ChartID(),last_select_objectr,OBJPROP_ANGLE);
          bool obj_ray = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_RAY);
          color obj_color = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_COLOR);
          color obj_bgcolor = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_BGCOLOR);
          int obj_width = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_WIDTH);
          int obj_back = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_BACK);
          
          
          int shift1=iBarShift(Symbol(),Period(),obj_time1);
          int shift2=iBarShift(Symbol(),Period(),obj_time2);
          
          
          if ( obj_prc1 > obj_prc2 ) {
          
          //Alert(last_select_objectr);
          
          double fark=obj_prc1-obj_prc2;
          
          for(int i=1;i<4;i++) {
          
          ObjectDelete(ChartID(),last_select_objectr+"LEVEL"+i);
          ObjectCreate(ChartID(),last_select_objectr+"LEVEL"+i,OBJ_TREND,0,Time[shift1],obj_prc1+(fark*i),Time[shift2],obj_prc1+(fark*i));
          if ( i == 2 ) ObjectSetInteger(ChartID(),last_select_objectr+"LEVEL"+i,OBJPROP_WIDTH,2);
          ObjectDelete(ChartID(),last_select_objectr+"LEVELD"+i);
          ObjectCreate(ChartID(),last_select_objectr+"LEVELD"+i,OBJ_TREND,0,Time[shift1],obj_prc2-(fark*i),Time[shift2],obj_prc2-(fark*i));
          if ( i == 2 ) ObjectSetInteger(ChartID(),last_select_objectr+"LEVELD"+i,OBJPROP_WIDTH,2);   
          
          
          }
          
          
          
          }
          

          if ( obj_prc2 > obj_prc1 ) {
          
          //Alert(last_select_objectr);
          
          double fark=obj_prc2-obj_prc1;
          
          for(int i=1;i<4;i++) {
          
          ObjectDelete(ChartID(),last_select_objectr+"LEVEL"+i);
          ObjectCreate(ChartID(),last_select_objectr+"LEVEL"+i,OBJ_TREND,0,Time[shift1],obj_prc2+(fark*i),Time[shift2],obj_prc2+(fark*i));
          if ( i == 2 ) ObjectSetInteger(ChartID(),last_select_objectr+"LEVEL"+i,OBJPROP_WIDTH,2);
          ObjectDelete(ChartID(),last_select_objectr+"LEVELD"+i);
          ObjectCreate(ChartID(),last_select_objectr+"LEVELD"+i,OBJ_TREND,0,Time[shift1],obj_prc1-(fark*i),Time[shift2],obj_prc1-(fark*i));
          if ( i == 2 ) ObjectSetInteger(ChartID(),last_select_objectr+"LEVELD"+i,OBJPROP_WIDTH,2);    
          
          
          }
          
          
          
          }
          
          
          
          
          
          
          }




if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_RECTANGLE_LABEL) {

Alert("Selam");

string last_select_objectr=sparam;


          int obj_typ = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_TYPE);
          datetime obj_time1 = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_TIME,0);
          datetime obj_time2 = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_TIME,1);
          datetime obj_time3 = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_TIME,2);
          double obj_prc1 = ObjectGetDouble(ChartID(),last_select_objectr,OBJPROP_PRICE,0);
          double obj_prc2 = ObjectGetDouble(ChartID(),last_select_objectr,OBJPROP_PRICE,1);
          double obj_prc3 = ObjectGetDouble(ChartID(),last_select_objectr,OBJPROP_PRICE,2);
          bool obj_fiil = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_FILL);
          double obj_scale = ObjectGetDouble(ChartID(),last_select_objectr,OBJPROP_SCALE);
          double obj_angle = ObjectGetDouble(ChartID(),last_select_objectr,OBJPROP_ANGLE);
          bool obj_ray = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_RAY);
          color obj_color = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_COLOR);
          color obj_bgcolor = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_BGCOLOR);
          int obj_width = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_WIDTH);
          int obj_back = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_BACK);
          
          
          int shift1=iBarShift(Symbol(),Period(),obj_time1);
          int shift2=iBarShift(Symbol(),Period(),obj_time2);
          
          
          
          if ( obj_prc1 > obj_prc2 ) {
          
          
          double yuzde=DivZero(obj_prc1-obj_prc2,100);
          
double high_price=obj_prc1;
double low_price=obj_prc2;

double levels=27.95;
string level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_objectr+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_objectr+"Exp"+level,OBJ_TREND,0,Time[shift1],high_price-levels*yuzde,mnt,high_price-levels*yuzde);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_STYLE,STYLE_DASHDOTDOT);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_WIDTH,1);


levels=38.2;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_objectr+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_objectr+"Exp"+level,OBJ_TREND,0,Time[shift1],high_price-levels*yuzde,mnt,high_price-levels*yuzde);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_STYLE,STYLE_DASHDOTDOT);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_WIDTH,1);

     
levels=55.9;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_objectr+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_objectr+"Exp"+level,OBJ_TREND,0,Time[shift1],high_price-levels*yuzde,mnt,high_price-levels*yuzde);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_STYLE,STYLE_DASHDOTDOT);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_WIDTH,1);

     
        
        
levels=79;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_objectr+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_objectr+"Exp"+level,OBJ_TREND,0,Time[shift1],high_price-levels*yuzde,mnt,high_price-levels*yuzde);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_STYLE,STYLE_DASHDOTDOT);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_WIDTH,1);

     
        
        
                               
          
        
ObjectDelete(ChartID(),last_select_objectr+"ExpC");
ObjectCreate(ChartID(),last_select_objectr+"ExpC",OBJ_TREND,0,Time[shift1],obj_prc1-((obj_prc1-obj_prc2)/2),Time[shift2],obj_prc1-((obj_prc1-obj_prc2)/2));
ObjectSetInteger(ChartID(),last_select_objectr+"ExpC",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),last_select_objectr+"ExpC",OBJPROP_COLOR,clrBlue);
ObjectSetInteger(ChartID(),last_select_objectr+"ExpC",OBJPROP_RAY,True);
ObjectSetInteger(ChartID(),last_select_objectr+"ExpC",OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_objectr+"ExpC",OBJPROP_SELECTED,False);           
          }
          

          if ( obj_prc2 > obj_prc1 ) {
          

          double yuzde=DivZero(obj_prc2-obj_prc1,100);
          
double high_price=obj_prc2;
double low_price=obj_prc1;

double levels=27.95;
string level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_objectr+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_objectr+"Exp"+level,OBJ_TREND,0,Time[shift1],low_price+levels*yuzde,mnt,low_price+levels*yuzde);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_STYLE,STYLE_DASHDOTDOT);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_WIDTH,1);


levels=38.2;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_objectr+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_objectr+"Exp"+level,OBJ_TREND,0,Time[shift1],low_price+levels*yuzde,mnt,low_price+levels*yuzde);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_STYLE,STYLE_DASHDOTDOT);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_WIDTH,1);


levels=55.9;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_objectr+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_objectr+"Exp"+level,OBJ_TREND,0,Time[shift1],low_price+levels*yuzde,mnt,low_price+levels*yuzde);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_STYLE,STYLE_DASHDOTDOT);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_WIDTH,1);


levels=79;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_objectr+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_objectr+"Exp"+level,OBJ_TREND,0,Time[shift1],low_price+levels*yuzde,mnt,low_price+levels*yuzde);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_STYLE,STYLE_DASHDOTDOT);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_WIDTH,1);
        
              

ObjectDelete(ChartID(),last_select_objectr+"ExpC");
ObjectCreate(ChartID(),last_select_objectr+"ExpC",OBJ_TREND,0,Time[shift1],obj_prc2-((obj_prc2-obj_prc1)/2),Time[shift2],obj_prc2-((obj_prc2-obj_prc1)/2));
ObjectSetInteger(ChartID(),last_select_objectr+"ExpC",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),last_select_objectr+"ExpC",OBJPROP_COLOR,clrRed);
ObjectSetInteger(ChartID(),last_select_objectr+"ExpC",OBJPROP_RAY,True);
ObjectSetInteger(ChartID(),last_select_objectr+"ExpC",OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_objectr+"ExpC",OBJPROP_SELECTED,False);
    

          
          }
              
              
              
              
                    
          
          
          
          }
          


double total_sl=0;
double total_full_sl=0;


if ( StringFind(ObjectGetString(ChartID(),sparam,OBJPROP_TEXT),"SL",0) != -1 || ObjectType(sparam) == OBJ_HLINE ) {


double obj_prc=ObjectGetDouble(ChartID(),sparam,OBJPROP_PRICE);
color obj_color=ObjectGetInteger(ChartID(),sparam,OBJPROP_COLOR);
int obj_width=ObjectGetInteger(ChartID(),sparam,OBJPROP_WIDTH);


if ( obj_color == clrRed ) {

//Alert("Selam",obj_prc);


   for (int m=OrdersTotal(); m>=0; m--)
   {
      if ( OrderSelect(m, SELECT_BY_POS))
      {
         if(OrderType() == OP_BUY && OrderSymbol() == Symbol() && OrderMagicNumber() == magic )
         {

         if ( obj_prc < OrderOpenPrice() ) {
         
         double sl=(OrderOpenPrice()-obj_prc)/Point;
         
         double sl_usd=PipPrice(Symbol(),0,sl,OrderLots());
                  
         total_sl=total_sl+sl_usd;
         total_full_sl=total_full_sl+(sl_usd+OrderSwap()+MathAbs(OrderCommission()));
  
  if ( obj_width == 3 ) OrderModify(OrderTicket(),OrderOpenPrice(),obj_prc,OrderTakeProfit(),-1,clrNONE);
  
         
         }



         }
      }
    }


}


if ( obj_color == clrBlue ) {

//Alert("Selam",obj_prc);


   for (int m=OrdersTotal(); m>=0; m--)
   {
      if ( OrderSelect(m, SELECT_BY_POS))
      {
         if(OrderType() == OP_SELL && OrderSymbol() == Symbol() && OrderMagicNumber() == magic )
         {

         if ( obj_prc > OrderOpenPrice() ) {
         
         double sl=(obj_prc-OrderOpenPrice())/Point;
         
         double sl_usd=PipPrice(Symbol(),0,sl,OrderLots());
                  
         total_sl=total_sl+sl_usd;
         total_full_sl=total_full_sl+(sl_usd+OrderSwap()+MathAbs(OrderCommission()));
  
  if ( obj_width == 3 ) OrderModify(OrderTicket(),OrderOpenPrice(),obj_prc,OrderTakeProfit(),-1,clrNONE);
         
         }



         }
      }
    }


}


double yuzde=DivZero(AccountBalance(),100);
double oran=DivZero(total_sl,yuzde);


Comment("TotalSL"+total_sl+"\n Full:"+total_full_sl,"\nOran:"+oran);



}








if ( sparam == 38 ) {

if ( left_fibo == true ) {left_fibo=false;} else {left_fibo=true;}

Comment("Left Fibo:",left_fibo);

}


if  ( sparam == "ButtonSinyal"+5 ) {

//Alert("BuyClose");
int cevap=MessageBox("Close Buy","All Buy Order Close",4); //  / Spread:"+Spread_Yuzde+"%"
if ( cevap == 6 ) {
CloseAllBuyOrders();
ObjectSetString(ChartID(),"ButtonSinyal"+5,OBJPROP_TEXT,"Buy");
}


}


if  ( sparam == "ButtonSinyal"+6 ) {

//Alert("SellClose");
int cevap=MessageBox("Close Sell","All Sell Order Close",4); //  / Spread:"+Spread_Yuzde+"%"
if ( cevap == 6 ) {
CloseAllSellOrders();
ObjectSetString(ChartID(),"ButtonSinyal"+6,OBJPROP_TEXT,"Sell");
}

}





if ( objtotal != ObjectsTotal() && left_fibo == false ) {


    if ( ObjectFind(ChartID(),last_select_object) == -1  ) {
  
     ///////////////////////////////////////////
     // OBJE SILICI
     ///////////////////////////////////////////
       int obj_total=ObjectsTotal(ChartID());
  string namet;
  for(int i=0;i<obj_total;i++)
    {
     namet = ObjectName(ChartID(),i); 
     
     int indexof = StringFind(namet,last_select_object, 0);
     
     if ( indexof != -1  ) ObjectDelete(ChartID(),namet);
     
      i++;// Do not forget to increase the counter
      
      }
      ///////////////////////////
      
      

}

}


if ( ObjectType(sparam) == OBJ_EDIT ) {

string text=ObjectGetString(ChartID(),sparam,OBJPROP_TEXT);

//Alert(text);
Sleep(100);
Comment(text);

if ( StringFind(sparam,"ButtonSinyalRight"+3,0) != -1 ) {

string text=ObjectGetString(ChartID(),sparam,OBJPROP_TEXT);

auto_close_profit_usd = StringToDouble(text);

//Alert(text);
Sleep(100);
Comment(text);



}

if ( StringFind(sparam,"ButtonSinyalRight"+0,0) != -1 ) {

string text=ObjectGetString(ChartID(),sparam,OBJPROP_TEXT);

risk_lot = StringToDouble(text);

//Alert(text);
Sleep(100);
Comment("Risk Lot:",risk_lot);



}

if ( StringFind(sparam,"ButtonSinyalRight"+1,0) != -1 && StringFind(sparam,"ButtonSinyalRight"+14,0) == -1 ) {

string text=ObjectGetString(ChartID(),sparam,OBJPROP_TEXT);

risk_oran = StringToDouble(text);

//Alert(text);
Sleep(100);
Comment("Risk Oran:",risk_oran);



}


if ( StringFind(sparam,"ButtonSinyalRight"+14,0) != -1 ) {

string text=ObjectGetString(ChartID(),sparam,OBJPROP_TEXT);

sk_order_distance = StringToDouble(text);

//Alert(text);
Sleep(100);
Comment("Distance:",sk_order_distance);



}

if ( StringFind(sparam,"ButtonSinyalRight"+15,0) != -1 ) {

string text=ObjectGetString(ChartID(),sparam,OBJPROP_TEXT);

sk_order_limit = StringToInteger(text);

//Alert(text);
Sleep(100);
Comment("Limit:",sk_order_limit);



}


if ( StringFind(sparam,"ButtonSinyalRight"+17,0) != -1 ) {

string text=ObjectGetString(ChartID(),sparam,OBJPROP_TEXT);

sk_buy_robot_price = StringToDouble(text);

if ( sk_buy_robot_price == 0.0 ) sk_buy_robot_price = 1000000;

//Alert(text);
Sleep(100);
Comment("sk_buy_robot_price:",sk_buy_robot_price);



}


if ( StringFind(sparam,"ButtonSinyalRight"+18,0) != -1 ) {

string text=ObjectGetString(ChartID(),sparam,OBJPROP_TEXT);

sk_sell_robot_price = StringToDouble(text);

if ( sk_sell_robot_price == 0.0 ) sk_sell_robot_price = -1;

//Alert(text);
Sleep(100);
Comment("sk_sell_robot_price:",sk_sell_robot_price);



}






}


if ( ObjectType(sparam) == OBJ_BUTTON ) {
string text=ObjectGetString(ChartID(),sparam,OBJPROP_TEXT);

//Alert(text);
Sleep(100);
Comment(text);
ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,False);


if ( text=="Stop" ) {

if ( sk_auto_stop == true ) { sk_auto_stop=false; 

sk_buy_robot_price=1000000;
sk_sell_robot_price=-1;


string buttonID="ButtonSinyalRight"+17;

   string text ="Up Stop";
ObjectSetString(0,buttonID,OBJPROP_TEXT,text);   
   buttonID="ButtonSinyalRight"+18;
   text ="Down Stop";
ObjectSetString(0,buttonID,OBJPROP_TEXT,text);   




} else {

if ( sk_buy_robot_price != 1000000 && sk_sell_robot_price != -1 ) {

sk_auto_stop=true;

}

}

Comment("sk_auto_stop:",sk_auto_stop);

   //Comment("AutoMode:",auto_mode,"\nOtomatik:",oto_system,"\nMode:",mode,"\n",wick);
   //ObjectsDeleteAlls(ChartID(),"Wick",-1,-1);
   CreateSinyalButtonRight();
}


if ( text=="Sound" ) {

if ( profit_sound == true ) { profit_sound=false; } else {profit_sound=true;}

Comment("profit_sound:",profit_sound);

   //Comment("AutoMode:",auto_mode,"\nOtomatik:",oto_system,"\nMode:",mode,"\n",wick);
   //ObjectsDeleteAlls(ChartID(),"Wick",-1,-1);
   CreateSinyalButtonRight();
}


if ( text=="Bid Ask" ) {

if ( bidask_show == true ) { bidask_show=false; 

   ChartSetInteger(ChartID(),CHART_COLOR_ASK,clrNONE);
   ChartSetInteger(ChartID(),CHART_COLOR_BID,clrNONE);  
   ChartSetInteger(ChartID(),CHART_COLOR_GRID,clrNONE);

} else {bidask_show=true;

   ChartSetInteger(ChartID(),CHART_COLOR_ASK,clrRed);
   ChartSetInteger(ChartID(),CHART_COLOR_BID,clrLightGray);  
   ChartSetInteger(ChartID(),CHART_COLOR_GRID,clrLightGray);

}

Comment("bidask:",bidask_show);

   //Comment("AutoMode:",auto_mode,"\nOtomatik:",oto_system,"\nMode:",mode,"\n",wick);
   //ObjectsDeleteAlls(ChartID(),"Wick",-1,-1);
   CreateSinyalButtonRight();
}



 
if ( text=="Full Mode" ) {

if ( full_mode == true ) { full_mode=false; } else {full_mode=true;}

Comment("Full Mode:",full_mode);

   //Comment("AutoMode:",auto_mode,"\nOtomatik:",oto_system,"\nMode:",mode,"\n",wick);
   //ObjectsDeleteAlls(ChartID(),"Wick",-1,-1);
   CreateSinyalButtonRight();
}


if ( text=="High Low" ) {

if ( high_low_mode == true ) { high_low_mode=false; } else {high_low_mode=true;}

Comment("High Low Mode:",high_low_mode);

   //Comment("AutoMode:",auto_mode,"\nOtomatik:",oto_system,"\nMode:",mode,"\n",wick);
   //ObjectsDeleteAlls(ChartID(),"Wick",-1,-1);
   CreateSinyalButtonRight();
}




if ( text=="NonStop" ) {

if ( sk_nonstop_order == true ) { sk_nonstop_order=false; } else {sk_nonstop_order=true;}

Comment("sk_nonstop_order:",sk_nonstop_order);

   //Comment("AutoMode:",auto_mode,"\nOtomatik:",oto_system,"\nMode:",mode,"\n",wick);
   //ObjectsDeleteAlls(ChartID(),"Wick",-1,-1);
   CreateSinyalButtonRight();
}





if ( text=="Robot" ) {

if ( sk_robot == true ) { sk_robot=false; } else {sk_robot=true;}

Comment("sk_robot:",sk_robot);

   //Comment("AutoMode:",auto_mode,"\nOtomatik:",oto_system,"\nMode:",mode,"\n",wick);
   //ObjectsDeleteAlls(ChartID(),"Wick",-1,-1);
   CreateSinyalButtonRight();
}





if ( text=="Auto" ) {

if ( sk_auto_bot == true ) { sk_auto_bot=false; } else {sk_auto_bot=true;}

Comment("sk_auto_bot:",sk_auto_bot);

   //Comment("AutoMode:",auto_mode,"\nOtomatik:",oto_system,"\nMode:",mode,"\n",wick);
   //ObjectsDeleteAlls(ChartID(),"Wick",-1,-1);
   CreateSinyalButtonRight();
}


if ( text=="Time Close" ) {

if ( order_time_close == true ) { order_time_close=false; } else {order_time_close=true;}

Comment("Time Close:",order_time_close);

   //Comment("AutoMode:",auto_mode,"\nOtomatik:",oto_system,"\nMode:",mode,"\n",wick);
   //ObjectsDeleteAlls(ChartID(),"Wick",-1,-1);
   CreateSinyalButtonRight();
}




if ( text=="Lock Lot" ) {

if ( lock_lot == true ) { lock_lot=false; } else {lock_lot=true;}

Comment("lock_lot:",lock_lot);

   //Comment("AutoMode:",auto_mode,"\nOtomatik:",oto_system,"\nMode:",mode,"\n",wick);
   //ObjectsDeleteAlls(ChartID(),"Wick",-1,-1);
   CreateSinyalButtonRight();
}






if ( text=="Bg Work" ) {

if ( background_work == true ) { background_work=false; } else {background_work=true;}

Comment("background_work:",background_work);

   //Comment("AutoMode:",auto_mode,"\nOtomatik:",oto_system,"\nMode:",mode,"\n",wick);
   //ObjectsDeleteAlls(ChartID(),"Wick",-1,-1);
   CreateSinyalButtonRight();
}





if ( text=="Ord PC" ) {

if ( auto_close_profit == true ) { auto_close_profit=false; } else {auto_close_profit=true;}

Comment("Auto Close Profit:",auto_close_profit);

   //Comment("AutoMode:",auto_mode,"\nOtomatik:",oto_system,"\nMode:",mode,"\n",wick);
   //ObjectsDeleteAlls(ChartID(),"Wick",-1,-1);
   CreateSinyalButtonRight();
}


if ( text=="Risk Clear" ) {


         ObjectDelete(ChartID(),"OP");
         ObjectDelete(ChartID(),"TP");
         ObjectDelete(ChartID(),"SL");



}


if ( text=="Risk Buy" ) {



Comment("Risk:",risk_lot,"/",risk_oran);


double yuzde=DivZero(AccountBalance(),100);
   double oran=yuzde*risk_oran;
   


   //if ( ChartGetInteger(ChartID(),CHART_BRING_TO_TOP) == True ) {
   
   
   double pip=PipPrice(Symbol(),oran,0,risk_lot);
   
         //double order_sl=Ask-(pip*(risk_oran))*Point;
         //double order_tp=Ask+(pip*(risk_oran*2))*Point;

         double order_sl=Ask-pip*Point;
         double order_tp=Ask+(pip*2)*Point;         
         
         ObjectDelete(ChartID(),"OP");
         ObjectCreate(ChartID(),"OP",OBJ_HLINE,0,Time[0],Ask);
         ObjectSetInteger(ChartID(),"OP",OBJPROP_COLOR,clrBlack);
         ObjectSetInteger(ChartID(),"OP",OBJPROP_STYLE,STYLE_DASH);
   
         ObjectDelete(ChartID(),"TP");
         ObjectCreate(ChartID(),"TP",OBJ_HLINE,0,Time[0],order_tp);
         ObjectSetInteger(ChartID(),"TP",OBJPROP_COLOR,clrGreenYellow);
         ObjectSetInteger(ChartID(),"TP",OBJPROP_STYLE,STYLE_DASH);
         ObjectSetString(ChartID(),"TP",OBJPROP_TOOLTIP,(pip*2)+" / "+ oran*2);

         ObjectDelete(ChartID(),"SL");
         ObjectCreate(ChartID(),"SL",OBJ_HLINE,0,Time[0],order_sl);
         ObjectSetInteger(ChartID(),"SL",OBJPROP_COLOR,clrOrangeRed);
         ObjectSetInteger(ChartID(),"SL",OBJPROP_STYLE,STYLE_DASH);
         ObjectSetString(ChartID(),"SL",OBJPROP_TOOLTIP,pip+" / "+ oran);
                  
   
   Comment("Oran:",oran,"\n Pip:",pip);
   
   
   }

if ( text=="Risk Sell" ) {



Comment("Risk:",risk_lot,"/",risk_oran);


double yuzde=DivZero(AccountBalance(),100);
   double oran=yuzde*risk_oran;
   
   
   
   //if ( ChartGetInteger(ChartID(),CHART_BRING_TO_TOP) == True ) {
   
   
   double pip=PipPrice(Symbol(),oran,0,risk_lot);
   
   Comment("Oran:",oran,"\n Pip:",pip);
   
        /* double order_sl=Bid+(pip*(risk_oran))*Point;
         double order_tp=Bid-(pip*(risk_oran*2))*Point;*/
         
         double order_sl=Bid+pip*Point;
         double order_tp=Bid-(pip*2)*Point;
            
         ObjectDelete(ChartID(),"OP");
         ObjectCreate(ChartID(),"OP",OBJ_HLINE,0,Time[0],Ask);
         ObjectSetInteger(ChartID(),"OP",OBJPROP_COLOR,clrBlack);
         ObjectSetInteger(ChartID(),"OP",OBJPROP_STYLE,STYLE_DASH);
         
   
         ObjectDelete(ChartID(),"TP");
         ObjectCreate(ChartID(),"TP",OBJ_HLINE,0,Time[0],order_tp);
         ObjectSetInteger(ChartID(),"TP",OBJPROP_COLOR,clrGreenYellow);
         ObjectSetInteger(ChartID(),"TP",OBJPROP_STYLE,STYLE_DASH);
         ObjectSetString(ChartID(),"TP",OBJPROP_TOOLTIP,(pip*2)+" / "+ oran*2);

         ObjectDelete(ChartID(),"SL");
         ObjectCreate(ChartID(),"SL",OBJ_HLINE,0,Time[0],order_sl);
         ObjectSetInteger(ChartID(),"SL",OBJPROP_COLOR,clrOrangeRed);
         ObjectSetInteger(ChartID(),"SL",OBJPROP_STYLE,STYLE_DASH);
         ObjectSetString(ChartID(),"SL",OBJPROP_TOOLTIP,pip+" / "+ oran);
   
   
   }







if ( text=="Risk" ) {



Comment("Risk:",risk_lot,"/",risk_oran);


double yuzde=DivZero(AccountBalance(),100);
   double oran=yuzde*risk_oran;
   
   
   
   //if ( ChartGetInteger(ChartID(),CHART_BRING_TO_TOP) == True ) {
   
   
   double pip=PipPrice(Symbol(),oran,0,risk_lot);
   
   Comment("Oran:",oran,"\n Pip:",pip);
   
   //OrderModify(81812788,64280.36,64280.36+pip,0,-1,clrNONE);
   
   //}
   
      

   for (int h=OrdersTotal();h>=0;h--)
   {
      if ( OrderSelect(h,SELECT_BY_POS) )
      {
         if( (OrderType() == OP_SELL || OrderType() == OP_BUY ) && OrderSymbol() == Symbol() && OrderMagicNumber() == magic )
         {

         if ( OrderLots() == risk_lot && OrderStopLoss() == 0 ) {
         
         double order_sl;
         double order_tp=OrderTakeProfit();
         
        /* if ( OrderTakeProfit() == 0 ) {
         
         if ( OrderType() == OP_BUY && Ask < OrderOpenPrice()+(pip*(risk_oran*2))*Point ) {
         order_tp=OrderOpenPrice()+(pip*(risk_oran*2.0))*Point;
         }

         if ( OrderType() == OP_SELL && Bid > OrderOpenPrice()-(pip*(risk_oran*2))*Point ) {
         order_tp=OrderOpenPrice()-(pip*(risk_oran*2.0))*Point;
         }         
         
         }*/


         if ( OrderTakeProfit() == 0 ) {
         
         if ( OrderType() == OP_BUY && Ask < OrderOpenPrice()+(pip*2)*Point ) {
         order_tp=OrderOpenPrice()+(pip*2)*Point;
         }

         if ( OrderType() == OP_SELL && Bid > OrderOpenPrice()-(pip*2)*Point ) {
         order_tp=OrderOpenPrice()-(pip*2)*Point;
         }         
         
         }         
         
         
         
         if ( OrderType() == OP_BUY ) order_sl=OrderOpenPrice()-pip*Point;
         if ( OrderType() == OP_SELL ) order_sl=OrderOpenPrice()+pip*Point;
         
         OrderModify(OrderTicket(),OrderOpenPrice(),order_sl,order_tp,-1,clrNONE);
         
         
         
         
         
         }
         
         
         


            
         }
      }
   }
   
         
      



   CreateSinyalButtonRight();
}




if ( text=="Risk Free" ) {


   for (int h=OrdersTotal();h>=0;h--)
   {
      if ( OrderSelect(h,SELECT_BY_POS) )
      {
         if( (OrderType() == OP_SELL || OrderType() == OP_BUY ) && OrderSymbol() == Symbol() && OrderMagicNumber() == magic )
         {

         if ( OrderStopLoss() != 0 ) {
         
         //OrderModify(OrderTicket(),OrderOpenPrice(),0,OrderTakeProfit(),-1,clrNONE);
         OrderModify(OrderTicket(),OrderOpenPrice(),0,0,-1,clrNONE);
         
         }
         
         }
         
         }
         

}


}

if ( text=="Risk All" ) {





double yuzde=DivZero(AccountBalance(),100);
   double oran=yuzde*risk_oran;
   
Comment("Risk All:",risk_lot,"/",risk_oran,"/",oran);
   
   
   //if ( ChartGetInteger(ChartID(),CHART_BRING_TO_TOP) == True ) {
   
   
   
   
   //Comment("Oran:",oran,"\n Pip:",pip);
   
   //OrderModify(81812788,64280.36,64280.36+pip,0,-1,clrNONE);
   
   //}
   
      

   for (int h=OrdersTotal();h>=0;h--)
   {
      if ( OrderSelect(h,SELECT_BY_POS) )
      {
         if( (OrderType() == OP_SELL || OrderType() == OP_BUY ) && OrderSymbol() == Symbol() && OrderMagicNumber() == magic )
         {

         if ( OrderStopLoss() == 0 ) {
         
         double pip=PipPrice(Symbol(),oran,0,OrderLots());
         
         double order_sl;
         double order_tp=OrderTakeProfit();
         
         if ( OrderTakeProfit() == 0 ) {
         
         /*if ( OrderType() == OP_BUY && Ask < OrderOpenPrice()+(pip*(risk_oran*2))*Point ) {
         order_tp=OrderOpenPrice()+(pip*(risk_oran*2.0))*Point;
         }

         if ( OrderType() == OP_SELL && Bid > OrderOpenPrice()-(pip*(risk_oran*2))*Point ) {
         order_tp=OrderOpenPrice()-(pip*(risk_oran*2.0))*Point;
         }     */    
         
         if ( OrderType() == OP_BUY && Ask < OrderOpenPrice()+(pip*2)*Point ) {
         order_tp=OrderOpenPrice()+(pip*2)*Point;
         }

         if ( OrderType() == OP_SELL && Bid > OrderOpenPrice()-(pip*2)*Point ) {
         order_tp=OrderOpenPrice()-(pip*2)*Point;
         }  
         
         
         
         }
         
         
         if ( OrderType() == OP_BUY ) order_sl=OrderOpenPrice()-pip*Point;
         if ( OrderType() == OP_SELL ) order_sl=OrderOpenPrice()+pip*Point;
         
         OrderModify(OrderTicket(),OrderOpenPrice(),order_sl,order_tp,-1,clrNONE);
         
         
         
         
         
         }
         
         
         


            
         }
      }
   }
   
         
      



   CreateSinyalButtonRight();
}

if ( text=="iFvg" ) {

if ( ifvg == true ) { ifvg=false; } else {ifvg=true;}

Comment("iFvg:",ifvg);

   //Comment("AutoMode:",auto_mode,"\nOtomatik:",oto_system,"\nMode:",mode,"\n",wick);
   //ObjectsDeleteAlls(ChartID(),"Wick",-1,-1);
   CreateSinyalButton();
}


if ( text=="iFibo" ) {

if ( ifibo == true ) { ifibo=false; } else {ifibo=true;}

Comment("iFibo:",ifibo);

   //Comment("AutoMode:",auto_mode,"\nOtomatik:",oto_system,"\nMode:",mode,"\n",wick);
   //ObjectsDeleteAlls(ChartID(),"Wick",-1,-1);
   CreateSinyalButton();
}


///////////////////////////////////////
if ( text=="Eq" || text == "Skyper" || text == "FiveZero"
 ) {

if ( eqsys == false ) {
skyper=false;
eqsys=true;
wick=false;
} else {
wick == false;
skyper=true;
eqsys=false;
}

Comment("EqSystem:",eqsys);


CreateSinyalButton();

}

if ( text=="Sinyal" ) {

if ( sinyal_sys == true ) { sinyal_sys=false; } else {sinyal_sys=true;}

Comment("Sinyal System:",sinyal_sys);

   //Comment("AutoMode:",auto_mode,"\nOtomatik:",oto_system,"\nMode:",mode,"\n",wick);
   //ObjectsDeleteAlls(ChartID(),"Wick",-1,-1);
   CreateSinyalButton();
}



if ( text=="Profit Alarm" ) {

if ( profit_alarm == true ) { profit_alarm=false; } else {profit_alarm=true;}

Comment("Profit Alarm:",profit_alarm);

   //Comment("AutoMode:",auto_mode,"\nOtomatik:",oto_system,"\nMode:",mode,"\n",wick);
   //ObjectsDeleteAlls(ChartID(),"Wick",-1,-1);
   CreateSinyalButton();
}

if ( text=="Profit Close" ) {

if ( profit_close == true ) { profit_close=false; } else {profit_close=true;}

Comment("Profit Close:",profit_close);

   //Comment("AutoMode:",auto_mode,"\nOtomatik:",oto_system,"\nMode:",mode,"\n",wick);
   //ObjectsDeleteAlls(ChartID(),"Wick",-1,-1);
   CreateSinyalButton();
}





if ( text=="Buy Line" ) {

ObjectsDeleteAlls(ChartID(),"BuyLine",-1,OBJ_HLINE);
ObjectsDeleteAlls(ChartID(),"SellLine",-1,OBJ_HLINE);

if ( buy_line == true ) { buy_line=false; } else {buy_line=true;sell_line=false;}
Comment("BuyLine:",buy_line);
   CreateSinyalButton();
   
   if ( buy_line == true ) ChartSetInteger(ChartID(),CHART_SHOW_TRADE_LEVELS,0,False);   
   
   OrdersTotals=-1;
   
}

if ( text=="Sell Line" ) {


ObjectsDeleteAlls(ChartID(),"BuyLine",-1,OBJ_HLINE);
ObjectsDeleteAlls(ChartID(),"SellLine",-1,OBJ_HLINE);

if ( sell_line == true ) { sell_line=false; } else {sell_line=true;buy_line=false;}
Comment("SellLine:",sell_line);
   CreateSinyalButton();
   


if ( sell_line == true ) ChartSetInteger(ChartID(),CHART_SHOW_TRADE_LEVELS,0,False);   
   
   OrdersTotals=-1;
   
}


if ( text=="Guard" ) {

if ( sk_guard == true ) { sk_guard=false; } else {sk_guard=true;}

Comment("Guard:",sk_guard);

   //Comment("AutoMode:",auto_mode,"\nOtomatik:",oto_system,"\nMode:",mode,"\n",wick);
   //ObjectsDeleteAlls(ChartID(),"Wick",-1,-1);
   CreateSinyalButton();
}

if ( text=="SL" ) {

if ( sk_guard_sl == true ) { sk_guard_sl=false; } else {sk_guard_sl=true;}

Comment("Guard SL:",sk_guard_sl);

   //Comment("AutoMode:",auto_mode,"\nOtomatik:",oto_system,"\nMode:",mode,"\n",wick);
   //ObjectsDeleteAlls(ChartID(),"Wick",-1,-1);
   CreateSinyalButton();
}






if ( text=="Wick" ) {

if ( wick == true ) { wick=false; } else {wick=true; skyper=false; eqsys=false;}

Comment("Wick:",wick);

   //Comment("AutoMode:",auto_mode,"\nOtomatik:",oto_system,"\nMode:",mode,"\n",wick);
   //ObjectsDeleteAlls(ChartID(),"Wick",-1,-1);
   CreateSinyalButton();
}


if ( text=="Reset") {
ObjectsDeleteAll();
/*mode_off_shift=-1;
last_select_object="";
mode=false;
oto_system=false;*/
CreateSinyalButton();
//FiyatSeviyeleri(); 

}
///////////////////////



}


if ( sparam == 18 //|| sparam == 33 
//|| StringFind(sparam,"38.",0) == -1
 ) {

if ( eqsys == false ) {
skyper=false;
eqsys=true;
} else {
if ( wick == false ) skyper=true;
eqsys=false;
}

Comment("EqSystem:",eqsys);

CreateSinyalButton();


}



if ( sparam == 16 ) { // Q

ObjectsDeleteAlls(ChartID(),"Wick",-1,-1);
wick=false;

}



//Print(sparam);




if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_TREND && StringFind(sparam,"MP",0) == -1 && StringFind(sparam,"HP",0) == -1 && StringFind(sparam,"LP",0) == -1 && StringFind(sparam,"CP",0) == -1 &&  StringFind(sparam,"Exp131",0) != -1 && StringFind(sparam,"MAL",0) == -1 && lock == false && skyper == false && eqsys == true ) {


RefreshRates();
ChartRedraw();
WindowRedraw();

//Alert("Selam");

//if ( mode_off_shift != 0 && sparam != last_select_object ) mode=true;



//return;

last_select_object=sparam;



          int obj_typ = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TYPE);
          datetime obj_time1 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,0);
          datetime obj_time2 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,1);
          datetime obj_time3 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,2);
          double obj_prc1 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,0);
          double obj_prc2 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,1);
          double obj_prc3 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,2);
          bool obj_fiil = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_FILL);
          double obj_scale = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_SCALE);
          double obj_angle = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_ANGLE);
          bool obj_ray = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_RAY);
          color obj_color = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_COLOR);
          color obj_bgcolor = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_BGCOLOR);
          int obj_width = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_WIDTH);
          int obj_back = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_BACK);
          
          
          int shift1=iBarShift(Symbol(),Period(),obj_time1);
          int shift2=iBarShift(Symbol(),Period(),obj_time2);
          
          shift_1=shift1;
          shift_2=shift2;
          
          price_1=obj_prc1;
          price_2=obj_prc2;
          
          
          int rplc=StringReplace(last_select_object,"Exp131.00","");
          
          //Alert(last_select_object);
          
          

if ( price_2 > price_1 ) {


//Alert("Selam");

//return;


//////////////////////////////////////////////////////////////////////
double max_price=price_2;
double max_high_price=max_price;
int max_shift=shift2;

//if ( left_fibo == true ) {

double levels=131;
string level=DoubleToString(levels,2);


ObjectMove(ChartID(),last_select_object+"Exp"+level,0,Time[shift1],Low[shift1]);
//ObjectMove(ChartID(),last_select_object+"Exp"+level,1,Time[max_shift],max_high_price);

ObjectMove(ChartID(),last_select_object+"Exp"+level,1,Time[shift2],High[shift2]);

max_high_price=High[shift2];


//ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],Low[shift1],Time[max_shift],max_high_price);
/*
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);
*/

double yuzdem=DivZero(max_high_price-Low[shift1],100);


levels=25;
levels=27.95;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[max_shift],Low[shift1]+levels*yuzdem,mnt,Low[shift1]+levels*yuzdem);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);




levels=38.22;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[max_shift],Low[shift1]+levels*yuzdem,mnt,Low[shift1]+levels*yuzdem);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);




levels=55.9;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[max_shift],Low[shift1]+levels*yuzdem,mnt,Low[shift1]+levels*yuzdem);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);


levels=78.6;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[max_shift],Low[shift1]+levels*yuzdem,mnt,Low[shift1]+levels*yuzdem);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);

//}



} else {



//////////////////////////////////////////////////////////////////////
double max_price=Low[shift2];
double max_low_price=max_price;
int max_shift=shift2;
int max_say=0;






//if ( left_fibo == true ) {

double levels=131;
string level=DoubleToString(levels,2);


ObjectMove(ChartID(),last_select_object+"Exp"+level,0,Time[shift1],High[shift1]);
//ObjectMove(ChartID(),last_select_object+"Exp"+level,1,Time[max_shift],max_high_price);

ObjectMove(ChartID(),last_select_object+"Exp"+level,1,Time[shift2],Low[shift2]);

max_low_price=Low[shift2];



/*
//ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],High[shift1],Time[max_shift],max_low_price);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);
//ObjectSetString(ChartID(),last_select_object+"Exp"+level,OBJPROP_TOOLTIP,max_say);

*/
double yuzdem=DivZero(High[shift1]-max_low_price,100);

levels=25;
levels=27.95;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[max_shift],High[shift1]-levels*yuzdem,mnt,High[shift1]-levels*yuzdem);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);




levels=38.22;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[max_shift],High[shift1]-levels*yuzdem,mnt,High[shift1]-levels*yuzdem);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);




levels=55.9;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[max_shift],High[shift1]-levels*yuzdem,mnt,High[shift1]-levels*yuzdem);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);


levels=78.6;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[max_shift],High[shift1]-levels*yuzdem,mnt,High[shift1]-levels*yuzdem);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);


//}





























}
          
          
          
          
          
          
          }
          
          
          


if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_TREND && StringFind(sparam,"#",0) == -1  && StringFind(sparam,"MP",0) == -1 && StringFind(sparam,"HP",0) == -1 && StringFind(sparam,"LP",0) == -1 && StringFind(sparam,"CP",0) == -1 &&  StringFind(sparam,"Exp",0) == -1 && StringFind(sparam,"MAL",0) == -1 && lock == false && skyper == false && eqsys == true && ifibo == false ) {

RefreshRates();
ChartRedraw();
WindowRedraw();

//Alert("Selam");

//if ( mode_off_shift != 0 && sparam != last_select_object ) mode=true;


last_select_object=sparam;


          int obj_typ = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TYPE);
          datetime obj_time1 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,0);
          datetime obj_time2 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,1);
          datetime obj_time3 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,2);
          double obj_prc1 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,0);
          double obj_prc2 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,1);
          double obj_prc3 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,2);
          bool obj_fiil = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_FILL);
          double obj_scale = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_SCALE);
          double obj_angle = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_ANGLE);
          bool obj_ray = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_RAY);
          color obj_color = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_COLOR);
          color obj_bgcolor = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_BGCOLOR);
          int obj_width = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_WIDTH);
          int obj_back = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_BACK);
          
          
          int shift1=iBarShift(Symbol(),Period(),obj_time1);
          int shift2=iBarShift(Symbol(),Period(),obj_time2);
          
          shift_1=shift1;
          shift_2=shift2;
          
          price_1=obj_prc1;
          price_2=obj_prc2;
          
          
sk_prc1=obj_prc1;
sk_prc2=obj_prc2;

          


if ( price_2 > price_1 ) {


//Alert(obj_width);


ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrCrimson);
ObjectSetInteger(ChartID(),sparam,OBJPROP_SELECTED,True);


high_price=Low[shift2];
low_price=Low[shift1];

//1234


hl_count=hl_count+1;



if ( hl_count < 2  ) {
high_price=Low[shift2];
low_price=Low[shift1];
ObjectSetInteger(ChartID(),sparam,OBJPROP_WIDTH,2);
ObjectMove(ChartID(),last_select_object,1,Time[shift2],Low[shift2]);
} 
if ( hl_count > 2 ) {
high_price=High[shift2];
low_price=Low[shift1];
ObjectMove(ChartID(),last_select_object,1,Time[shift2],High[shift2]);
ObjectSetInteger(ChartID(),sparam,OBJPROP_WIDTH,1);
}

if ( hl_count > 4 ) {
hl_count=0;
}




/*
if ( full_mode == false ) {
if ( obj_width == 1 ) {
high_price=Low[shift2];
low_price=Low[shift1];
ObjectSetInteger(ChartID(),sparam,OBJPROP_WIDTH,2);
ObjectMove(ChartID(),last_select_object,1,Time[shift2],Low[shift2]);
} else {
high_price=High[shift2];
low_price=Low[shift1];
ObjectMove(ChartID(),last_select_object,1,Time[shift2],High[shift2]);
ObjectSetInteger(ChartID(),sparam,OBJPROP_WIDTH,1);
}
}



if ( full_mode == true ) {
if ( high_low_mode == true ) {
high_price=Low[shift2];
low_price=Low[shift1];
ObjectSetInteger(ChartID(),sparam,OBJPROP_WIDTH,2);
ObjectMove(ChartID(),last_select_object,1,Time[shift2],Low[shift2]);
} else {
high_price=High[shift2];
low_price=Low[shift1];
ObjectMove(ChartID(),last_select_object,1,Time[shift2],High[shift2]);
ObjectSetInteger(ChartID(),sparam,OBJPROP_WIDTH,1);
}
}
*/




for (int i=shift1;i>shift2;i--) {
//for (int i=shift2;i<shift1;i++) {

//if ( High[i] > high_price ) {high_price=High[i];shift2=i;}
if ( Low[i] < low_price ) {low_price=Low[i];shift1=i;}

}


/*
//for (int i=shift1;i>shift2;i--) {
for (int i=shift2;i<shift1;i++) {

if ( High[i] > high_price ) {high_price=High[i];shift2=i;}
//if ( Low[i] < low_price ) {low_price=Low[i];shift2=i;}

}
*/


if ( full_mode == true ) {
double highprc=high_price-(DivZero((high_price-low_price),2));
high_price=highprc;
}




  

double yuzde=DivZero(high_price-low_price,100);


//Alert("Selam2",high_price);


ObjectMove(ChartID(),last_select_object,0,Time[shift1],Low[shift1]);
//ObjectMove(ChartID(),last_select_object,1,Time[shift2],Low[shift2]);

/*
sk_sell_robot_price=Low[shift1];
ObjectSetString(ChartID(),"ButtonSinyalRight"+18,OBJPROP_TEXT,sk_sell_robot_price);
*/


//Alert("Selam");

double levels=100;
string level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],high_price+levels*yuzde,mnt,high_price+levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DASHDOTDOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);

levels=100.3;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],high_price+levels*yuzde,mnt,high_price+levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DASHDOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);

sk_prc1=Low[shift1];
sk_prc2=high_price+levels*yuzde;


//////////////////////////////////////////////////////////////////////
//double max_price=high_price+levels*yuzde;
double max_price=High[shift1];//high_price+levels*yuzde;
double max_high_price=max_price;
int max_shift=0;

bool findm=false;

for (int m=shift1+1;m<shift_1+100;m++) {

if ( Bars < m ) continue;

//for (int m=shift1+1;m<Bars;m++) {

if ( findm==true) continue;

if ( High[m] > max_price && High[m] > max_high_price ) {
max_high_price=High[m];
max_shift=m;
int max_say=0;
/*
for (int s=max_shift+1;s<max_shift+50;s++) {


if ( max_high_price > High[s] ) {
max_say=max_say+1;
if ( max_say > 30 ) findm=true;
}

}*/

}
}
////////////////////////////////////////////////////////////////

if ( left_fibo == true ) {

levels=131;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],Low[shift1],Time[max_shift],max_high_price);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);


double yuzdem=DivZero(max_high_price-Low[shift1],100);

levels=25;
levels=27.95;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[max_shift],Low[shift1]+levels*yuzdem,mnt,Low[shift1]+levels*yuzdem);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);



levels=38.22;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[max_shift],Low[shift1]+levels*yuzdem,mnt,Low[shift1]+levels*yuzdem);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);




levels=55.9;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[max_shift],Low[shift1]+levels*yuzdem,mnt,Low[shift1]+levels*yuzdem);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);


levels=78.6;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[max_shift],Low[shift1]+levels*yuzdem,mnt,Low[shift1]+levels*yuzdem);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);

}










levels=100.11;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],low_price+levels*yuzde,mnt,low_price+levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrGreenYellow);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,10);



levels=100.1;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],low_price+levels*yuzde,mnt,low_price+levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);


levels=38.2;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],high_price-levels*yuzde,mnt,high_price-levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrOrangeRed);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);

/*
sk_sell_robot_price=high_price-levels*yuzde;//Low[shift1];
ObjectSetString(ChartID(),"ButtonSinyalRight"+18,OBJPROP_TEXT,sk_sell_robot_price);
*/


levels=21;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],high_price-levels*yuzde,mnt,high_price-levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrOrangeRed);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);

levels=13;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],high_price-levels*yuzde,mnt,high_price-levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrOrangeRed);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);



levels=38.3;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],high_price+levels*yuzde,mnt,high_price+levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrOrangeRed);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);

levels=21.01;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],high_price+levels*yuzde,mnt,high_price+levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrOrangeRed);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);

levels=13.01;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],high_price+levels*yuzde,mnt,high_price+levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrOrangeRed);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);





levels=79;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],high_price+levels*yuzde,mnt,high_price+levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);


levels=55.9;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],high_price+levels*yuzde,mnt,high_price+levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkRed);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DASH);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);

levels=70.7;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],high_price+levels*yuzde,mnt,high_price+levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,3);

sk_buy_robot_price=high_price+levels*yuzde;
ObjectSetString(ChartID(),"ButtonSinyalRight"+17,OBJPROP_TEXT,sk_buy_robot_price);



levels=29.3;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],low_price+levels*yuzde,mnt,low_price+levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);

sk_sell_robot_price=low_price+levels*yuzde;//Low[shift1];
ObjectSetString(ChartID(),"ButtonSinyalRight"+18,OBJPROP_TEXT,sk_sell_robot_price);



levels=87;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],high_price+levels*yuzde,mnt,high_price+levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);




levels=79.87;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_RECTANGLE,0,Time[shift1],high_price+79*yuzde,mnt,high_price+87*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrGreenYellow);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);



levels=122.4;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
if ( full_mode == false ) ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],obj_prc2+(DivZero((obj_prc2-obj_prc1),100)*levels),mnt,obj_prc2+(DivZero((obj_prc2-obj_prc1),100)*levels));
if ( full_mode == true ) ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],obj_prc1+(DivZero((obj_prc2-obj_prc1),100)*levels),mnt,obj_prc1+(DivZero((obj_prc2-obj_prc1),100)*levels));

ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrYellowGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);





}   else {






ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrLimeGreen);
ObjectSetInteger(ChartID(),sparam,OBJPROP_SELECTED,True);


//Alert("Selam2");



//

hl_count=hl_count+1;



if ( hl_count < 2  ) {
high_price=High[shift1];
low_price=High[shift2];
ObjectSetInteger(ChartID(),sparam,OBJPROP_WIDTH,2);
ObjectMove(ChartID(),last_select_object,1,Time[shift2],High[shift2]);
} 

if ( hl_count > 2 ) {
high_price=High[shift1];
low_price=Low[shift2];
ObjectMove(ChartID(),last_select_object,1,Time[shift2],Low[shift2]);
ObjectSetInteger(ChartID(),sparam,OBJPROP_WIDTH,1);
}

if ( hl_count > 4 ) {
hl_count=0;
}



/*
if ( full_mode == false ) {
if ( obj_width == 1  ) {
high_price=High[shift1];
low_price=High[shift2];
ObjectSetInteger(ChartID(),sparam,OBJPROP_WIDTH,2);
ObjectMove(ChartID(),last_select_object,1,Time[shift2],High[shift2]);
} else {
high_price=High[shift1];
low_price=Low[shift2];
ObjectMove(ChartID(),last_select_object,1,Time[shift2],Low[shift2]);
ObjectSetInteger(ChartID(),sparam,OBJPROP_WIDTH,1);
}
}


if ( full_mode == true ) {
if ( high_low_mode == true  ) {
high_price=High[shift1];
low_price=High[shift2];
ObjectSetInteger(ChartID(),sparam,OBJPROP_WIDTH,2);
ObjectMove(ChartID(),last_select_object,1,Time[shift2],High[shift2]);
} else {
high_price=High[shift1];
low_price=Low[shift2];
ObjectMove(ChartID(),last_select_object,1,Time[shift2],Low[shift2]);
ObjectSetInteger(ChartID(),sparam,OBJPROP_WIDTH,1);
}
}
*/




for (int i=shift1;i>shift2;i--) {
//for (int i=shift2;i<shift1;i++) {

if ( High[i] > high_price ) {high_price=High[i];shift1=i;}
//if ( Low[i] < low_price ) {low_price=Low[i];shift2=i;}

}
/*
//for (int i=shift1;i>shift2;i--) {
for (int i=shift2;i<shift1;i++) {

//if ( High[i] > high_price ) {high_price=High[i];shift1=i;}
if ( Low[i] < low_price ) {low_price=Low[i];shift2=i;}

}
*/




ObjectMove(ChartID(),last_select_object,0,Time[shift1],High[shift1]);
//ObjectMove(ChartID(),last_select_object,1,Time[shift2],High[shift2]);






/*
sk_buy_robot_price=High[shift1];
ObjectSetString(ChartID(),"ButtonSinyalRight"+17,OBJPROP_TEXT,sk_buy_robot_price);
*/


if ( full_mode == true ) {
double lowprc=low_price+(DivZero((high_price-low_price),2));
low_price=lowprc;
}



double yuzde=DivZero(high_price-low_price,100);       




double levels=100;
string level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],high_price-levels*yuzde,mnt,high_price-levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);



//Alert("Selam");

//////////////////////////////////////////////////////////////////////
//double max_price=low_price-levels*yuzde;
double max_price=Low[shift1];
double max_low_price=max_price;
int max_shift=shift1;
int max_say=0;

bool findm=false;
/*
//for (int m=shift1+1;m<shift_1+200;m++) {
for (int m=shift1+1;m<Bars;m++) {
if ( findm == true ) continue;

if ( Low[m+2] > Low[m] &&  Low[m+1] > Low[m] && Low[m] < max_price && Low[m] < max_low_price
 ) {
max_low_price=Low[m];
max_shift=m;
int max_say=0;

for (int s=max_shift+1;s<max_shift+50;s++) {

if ( max_low_price < Low[s] ) {
max_say=max_say+1;
if ( max_say > 30 ) {findm=true;}
} else {
max_say=0;
}

}



}
}
////////////////////////////////////////////////////////////////
*/


for (int m=shift1;m<shift1+100;m++) {

if ( Bars < m ) continue;



if ( Low[m] < max_price ) {

if ( Low[m] < max_low_price ) {
max_low_price=Low[m];
max_shift=m;
max_say=0;

/*
if ( findm == true ) continue;
for ( int s=m+1;s<m+50;s++) {
if ( Low[m] < Low[s] ) {
max_say=max_say+1;
if ( max_say > 10 ) findm=true;
} else {
//max_say=0;
}
}
*/

}



}



}

if ( left_fibo == true ) {

levels=131;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],High[shift1],Time[max_shift],max_low_price);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);
//ObjectSetString(ChartID(),last_select_object+"Exp"+level,OBJPROP_TOOLTIP,max_say);


double yuzdem=DivZero(High[shift1]-max_low_price,100);



levels=25;
levels=27.95;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[max_shift],High[shift1]-levels*yuzdem,mnt,High[shift1]-levels*yuzdem);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);



levels=38.22;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[max_shift],High[shift1]-levels*yuzdem,mnt,High[shift1]-levels*yuzdem);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);




levels=55.9;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[max_shift],High[shift1]-levels*yuzdem,mnt,High[shift1]-levels*yuzdem);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);


levels=78.6;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[max_shift],High[shift1]-levels*yuzdem,mnt,High[shift1]-levels*yuzdem);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);


}







levels=100.11;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],high_price-levels*yuzde,mnt,high_price-levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrGreenYellow);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,10);



levels=100.1;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],low_price-levels*yuzde,mnt,low_price-levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DASHDOTDOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);


levels=100.31;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],low_price-levels*yuzde,mnt,low_price-levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DASHDOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);

sk_prc1=High[shift1];
sk_prc2=low_price-levels*yuzde;






levels=38.2;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],low_price+levels*yuzde,mnt,low_price+levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrOrangeRed);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);

/*
sk_buy_robot_price=low_price+levels*yuzde;//High[shift1];
ObjectSetString(ChartID(),"ButtonSinyalRight"+17,OBJPROP_TEXT,sk_buy_robot_price);
*/


levels=21;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],low_price+levels*yuzde,mnt,low_price+levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrOrangeRed);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);

levels=13;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],low_price+levels*yuzde,mnt,low_price+levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrOrangeRed);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);


levels=38.21;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],low_price-levels*yuzde,mnt,low_price-levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrOrangeRed);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);


levels=21.01;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],low_price-levels*yuzde,mnt,low_price-levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrOrangeRed);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);

levels=13.01;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],low_price-levels*yuzde,mnt,low_price-levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrOrangeRed);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);





levels=79;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],low_price-levels*yuzde,mnt,low_price-levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);

levels=55.9;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],low_price-levels*yuzde,mnt,low_price-levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkRed);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DASH);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);


levels=70.7;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],low_price-levels*yuzde,mnt,low_price-levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);

sk_sell_robot_price=low_price-levels*yuzde;
ObjectSetString(ChartID(),"ButtonSinyalRight"+18,OBJPROP_TEXT,sk_sell_robot_price);




levels=29.3;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],high_price-levels*yuzde,mnt,high_price-levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);

sk_buy_robot_price=high_price-levels*yuzde;//low_price+levels*yuzde;//High[shift1];
ObjectSetString(ChartID(),"ButtonSinyalRight"+17,OBJPROP_TEXT,sk_buy_robot_price);



levels=87;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],low_price-levels*yuzde,mnt,low_price-levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);

levels=79.87;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_RECTANGLE,0,Time[shift1],low_price-79*yuzde,mnt,low_price-87*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrGreenYellow);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);

/*
levels=61.8;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],obj_prc2-(DivZero((obj_prc1-obj_prc2),100)*levels),mnt,obj_prc2-(DivZero((obj_prc1-obj_prc2),100)*levels));
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrYellowGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);
*/
levels=122.4;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
if ( full_mode == false ) ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],obj_prc2-(DivZero((obj_prc1-obj_prc2),100)*levels),mnt,obj_prc2-(DivZero((obj_prc1-obj_prc2),100)*levels));
if ( full_mode == true ) ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],obj_prc1-(DivZero((obj_prc1-obj_prc2),100)*levels),mnt,obj_prc1-(DivZero((obj_prc1-obj_prc2),100)*levels));
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrYellowGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);





}
          
          
}
          




if ( sparam == 19 ) {

if ( ChartGetInteger(ChartID(),CHART_SHOW_TRADE_LEVELS,0) == True ) {ChartSetInteger(ChartID(),CHART_SHOW_TRADE_LEVELS,0,False); } else {ChartSetInteger(ChartID(),CHART_SHOW_TRADE_LEVELS,0,True);}

}

/*
if ( sparam == 40 ) {
  
  
  if ( ifvg == true ) { ifvg=false; } else { ifvg=true;}
  
  Comment("ifvg:",ifvg);
  
  CreateSinyalButton();
  
  }
*/



if ( sparam == 40 ) {
  
  
if ( sparam == 40 ) {
  
  
 // if ( ifvg == true ) { ifvg=false; } else { ifvg=true;}
  if ( ifibo == true ) { ifibo=false; } else {ifibo=true;}

  Comment("ifvg:",ifvg);
  Comment("ifibo:",ifibo);
  
  CreateSinyalButton();
  
  }
;
  
  CreateSinyalButton();
  
  }


if(id==CHARTEVENT_CLICK && ifvg==true)
     {
     
     string last_select_object=sparam;
     
      //--- Prepare variables
      int      x     =(int)lparam;
      int      y     =(int)dparam;
      datetime dt    =0;
      double   price =0;
      int      window=0;
      //--- Convert the X and Y coordinates in terms of date/time
      if(ChartXYToTimePrice(0,x,y,window,dt,price))
        {

          datetime obj_time1 = dt;//ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME);
          
         int shift1=iBarShift(Symbol(),Period(),obj_time1);
         
         if ( Open[shift1] >= Close[shift1] && price >= Low[shift1] && price && price <= High[shift1] ) {
         
datetime levels=dt;
string level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"ExpWick"+level);
ObjectCreate(ChartID(),last_select_object+"ExpWick"+level,OBJ_TREND,0,Time[shift1+1],Low[shift1+1],mnt,Low[shift1+1]);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_WIDTH,1);

levels=dt+1;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"ExpWick"+level);
ObjectCreate(ChartID(),last_select_object+"ExpWick"+level,OBJ_TREND,0,Time[shift1-1],High[shift1-1],mnt,High[shift1-1]);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_WIDTH,1);
  
         
         }
         

if ( Close[shift1] > Open[shift1] && price >= Low[shift1] && price && price <= High[shift1] ) {


datetime levels=dt;
string level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"ExpWick"+level);
ObjectCreate(ChartID(),last_select_object+"ExpWick"+level,OBJ_TREND,0,Time[shift1+1],High[shift1+1],mnt,High[shift1+1]);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_WIDTH,1);

levels=dt+1;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"ExpWick"+level);
ObjectCreate(ChartID(),last_select_object+"ExpWick"+level,OBJ_TREND,0,Time[shift1-1],Low[shift1-1],mnt,Low[shift1-1]);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_WIDTH,1);
  



}         
         
        
        
        
        
        }
        
        
        }
        
        

 if(id==CHARTEVENT_CLICK && wick==true)
     {
      //--- Prepare variables
      int      x     =(int)lparam;
      int      y     =(int)dparam;
      datetime dt    =0;
      double   price =0;
      int      window=0;
      //--- Convert the X and Y coordinates in terms of date/time
      if(ChartXYToTimePrice(0,x,y,window,dt,price))
        {
        
        
        

RefreshRates();
ChartRedraw();
WindowRedraw();


//if ( mode_off_shift != 0 && sparam != last_select_object ) mode=true;


last_select_object=sparam;



          datetime obj_time1 = dt;//ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME);
          
         int shift1=iBarShift(Symbol(),Period(),obj_time1);
         
         if ( shift1 > WindowFirstVisibleBar()-30) return;
         
         //Alert(WindowFirstVisibleBar(),"/",shift1);
         
         

          
          
          if ( Open[shift1] >= Close[shift1] && price >= Low[shift1] && price && price <= High[shift1] ) {
          
          double eqh=DivZero(High[shift1]-Open[shift1],2);
          double eql=DivZero(Close[shift1]-Low[shift1],2);
          double eqc=DivZero(High[shift1]-Low[shift1],2);
          double eqb=DivZero(Open[shift1]-Close[shift1],2);
          

datetime levels=dt;
string level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"ExpWick"+level);
ObjectCreate(ChartID(),last_select_object+"ExpWick"+level,OBJ_TREND,0,Time[shift1],Low[shift1]+eql,mnt,Low[shift1]+eql);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_WIDTH,1);

levels=dt;
level=DoubleToString(levels,2)+"s";
ObjectDelete(ChartID(),last_select_object+"ExpWick"+level);
ObjectCreate(ChartID(),last_select_object+"ExpWick"+level,OBJ_TREND,0,Time[shift1],High[shift1]-eqh,mnt,High[shift1]-eqh);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_WIDTH,1);

levels=dt;
level=DoubleToString(levels,2)+"c";
ObjectDelete(ChartID(),last_select_object+"ExpWick"+level);
ObjectCreate(ChartID(),last_select_object+"ExpWick"+level,OBJ_TREND,0,Time[shift1],High[shift1]-eqc,mnt,High[shift1]-eqc);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_COLOR,clrGreenYellow);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_WIDTH,1);

levels=dt;
level=DoubleToString(levels,2)+"b";
ObjectDelete(ChartID(),last_select_object+"ExpWick"+level);
ObjectCreate(ChartID(),last_select_object+"ExpWick"+level,OBJ_TREND,0,Time[shift1],Open[shift1]-eqb,mnt,Open[shift1]-eqb);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_COLOR,clrOrangeRed);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_WIDTH,1);


          
          
         
          }
          

          if ( Close[shift1] > Open[shift1] && price >= Low[shift1] && price && price <= High[shift1] ) {
          
          double eqh=DivZero(High[shift1]-Close[shift1],2);
          double eql=DivZero(Open[shift1]-Low[shift1],2);
          double eqc=DivZero(High[shift1]-Low[shift1],2);
          double eqb=DivZero(Close[shift1]-Open[shift1],2);

datetime levels=dt;//0;
string level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"ExpWick"+level);
ObjectCreate(ChartID(),last_select_object+"ExpWick"+level,OBJ_TREND,0,Time[shift1],Low[shift1]+eql,mnt,Low[shift1]+eql);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_WIDTH,1);

levels=dt;//1;
level=DoubleToString(levels,2)+"s";
ObjectDelete(ChartID(),last_select_object+"ExpWick"+level);
ObjectCreate(ChartID(),last_select_object+"ExpWick"+level,OBJ_TREND,0,Time[shift1],High[shift1]-eqh,mnt,High[shift1]-eqh);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_WIDTH,1);          

levels=dt;
level=DoubleToString(levels,2)+"c";
ObjectDelete(ChartID(),last_select_object+"ExpWick"+level);
ObjectCreate(ChartID(),last_select_object+"ExpWick"+level,OBJ_TREND,0,Time[shift1],High[shift1]-eqc,mnt,High[shift1]-eqc);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_COLOR,clrGreenYellow);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_WIDTH,1);

levels=dt;
level=DoubleToString(levels,2)+"b";
ObjectDelete(ChartID(),last_select_object+"ExpWick"+level);
ObjectCreate(ChartID(),last_select_object+"ExpWick"+level,OBJ_TREND,0,Time[shift1],Close[shift1]-eqb,mnt,Close[shift1]-eqb);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_COLOR,clrOrangeRed);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_WIDTH,1);



         
          }

         
         
         
         
         
         
        }
        
        }
        
        
        
if ( sparam == 16 ) { // Q

ObjectsDeleteAlls(ChartID(),"Wick",-1,-1);
wick=false;

}

if ( sparam == 17 ) {

if ( wick == true ) {wick=false;}else{wick=true;}

Comment("Wick:",wick);




}


        
        

if ( sparam == 45 ) {ObjectsDeleteAll();
eqsys=true;
skyper=false;
wick=false;
CreateSinyalButton();
left_fibo=false;
}



if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_TREND && StringFind(sparam,"MP",0) == -1 && StringFind(sparam,"HP",0) == -1 && StringFind(sparam,"LP",0) == -1 && StringFind(sparam,"CP",0) == -1 &&  StringFind(sparam,"Exp",0) == -1 && StringFind(sparam,"MAL",0) == -1 && lock == false && ifibo == true) {

RefreshRates();
ChartRedraw();
WindowRedraw();


string last_select_objectr=sparam;
last_select_object=sparam;

//Alert(last_select_objectr);


          int obj_typ = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_TYPE);
          datetime obj_time1 = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_TIME,0);
          datetime obj_time2 = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_TIME,1);
          datetime obj_time3 = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_TIME,2);
          double obj_prc1 = ObjectGetDouble(ChartID(),last_select_objectr,OBJPROP_PRICE,0);
          double obj_prc2 = ObjectGetDouble(ChartID(),last_select_objectr,OBJPROP_PRICE,1);
          double obj_prc3 = ObjectGetDouble(ChartID(),last_select_objectr,OBJPROP_PRICE,2);
          bool obj_fiil = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_FILL);
          double obj_scale = ObjectGetDouble(ChartID(),last_select_objectr,OBJPROP_SCALE);
          double obj_angle = ObjectGetDouble(ChartID(),last_select_objectr,OBJPROP_ANGLE);
          bool obj_ray = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_RAY);
          color obj_color = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_COLOR);
          color obj_bgcolor = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_BGCOLOR);
          int obj_width = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_WIDTH);
          int obj_back = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_BACK);
          
          
          int shift1=iBarShift(Symbol(),Period(),obj_time1);
          int shift2=iBarShift(Symbol(),Period(),obj_time2);
          
          
          
          if ( obj_prc2 > obj_prc1 ) {
          
          
          ObjectMove(ChartID(),last_select_objectr,1,obj_time2,High[shift2]);
          ObjectMove(ChartID(),last_select_objectr,0,obj_time1,Low[shift1]);
          
          double fark=High[shift2]-Low[shift1];
          
          int i=shift1;
          int shift=shift2;


/*
   ObjectCreate(ChartID(),"TLINE"+(Time[i]),OBJ_TREND,0,Time[shift],High[shift],Time[i],Low[i]);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]),OBJPROP_STYLE,STYLE_SOLID);
   //if ( work == false )ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]),OBJPROP_COLOR,clrCrimson);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]),OBJPROP_WIDTH,1);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]),OBJPROP_RAY,False);
   //ObjectSetString(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_TOOLTIP,candle_level+"/"+shift);
   */
   ObjectDelete(ChartID(),"TTLINE"+last_select_objectr);
   ObjectCreate(ChartID(),"TTLINE"+last_select_objectr,OBJ_TREND,0,Time[shift],Low[i]+(fark/2),mnt,Low[i]+(fark/2));
   ObjectSetInteger(ChartID(),"TTLINE"+last_select_objectr,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"TTLINE"+last_select_objectr,OBJPROP_STYLE,STYLE_SOLID);
   //if ( work == false )ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"TTLINE"+last_select_objectr,OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(ChartID(),"TTLINE"+last_select_objectr,OBJPROP_WIDTH,1);
   ObjectSetInteger(ChartID(),"TTLINE"+last_select_objectr,OBJPROP_RAY,False);
   //ObjectSetString(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_TOOLTIP,candle_level+"/"+shift);

   
   ObjectDelete(ChartID(),"TTTLINE"+last_select_objectr);
   ObjectCreate(ChartID(),"TTTLINE"+last_select_objectr,OBJ_TREND,0,Time[shift],Low[i]+(fark/4),mnt,Low[i]+(fark/4));
   ObjectSetInteger(ChartID(),"TTTLINE"+last_select_objectr,OBJPROP_BACK,True);
   //ObjectSetInteger(ChartID(),"TTTLINE"+last_select_objectr,OBJPROP_STYLE,STYLE_SOLID);
   ObjectSetInteger(ChartID(),"TTTLINE"+last_select_objectr,OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"TTTLINE"+last_select_objectr,OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(ChartID(),"TTTLINE"+last_select_objectr,OBJPROP_WIDTH,1);
   ObjectSetInteger(ChartID(),"TTTLINE"+last_select_objectr,OBJPROP_RAY,False);
   //ObjectSetString(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_TOOLTIP,candle_level+"/"+shift);

   ObjectDelete(ChartID(),"TTTTLINE"+last_select_objectr);
   ObjectCreate(ChartID(),"TTTTLINE"+last_select_objectr,OBJ_TREND,0,Time[shift],High[shift]-(fark/4),mnt,High[shift]-(fark/4));
   ObjectSetInteger(ChartID(),"TTTTLINE"+last_select_objectr,OBJPROP_BACK,True);
   //ObjectSetInteger(ChartID(),"TTTLINE"+last_select_objectr,OBJPROP_STYLE,STYLE_SOLID);
   ObjectSetInteger(ChartID(),"TTTTLINE"+last_select_objectr,OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"TTTTLINE"+last_select_objectr,OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(ChartID(),"TTTTLINE"+last_select_objectr,OBJPROP_WIDTH,1);
   ObjectSetInteger(ChartID(),"TTTTLINE"+last_select_objectr,OBJPROP_RAY,False);
   //ObjectSetString(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_TOOLTIP,candle_level+"/"+shift);
             
          
          
          
          }



       if ( obj_prc1 > obj_prc2 ) {
          
          
          ObjectMove(ChartID(),last_select_objectr,1,obj_time2,Low[shift2]);
          ObjectMove(ChartID(),last_select_objectr,0,obj_time1,High[shift1]);
          
          double fark=High[shift1]-Low[shift2];
          
          int i=shift2;
          int shift=shift1;


/*
   ObjectCreate(ChartID(),"TLINE"+(Time[i]),OBJ_TREND,0,Time[shift],High[shift],Time[i],Low[i]);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]),OBJPROP_STYLE,STYLE_SOLID);
   //if ( work == false )ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]),OBJPROP_COLOR,clrCrimson);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]),OBJPROP_WIDTH,1);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]),OBJPROP_RAY,False);
   //ObjectSetString(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_TOOLTIP,candle_level+"/"+shift);
   */
   ObjectDelete(ChartID(),"TTLINE"+last_select_objectr);
   ObjectCreate(ChartID(),"TTLINE"+last_select_objectr,OBJ_TREND,0,Time[shift],Low[i]+(fark/2),mnt,Low[i]+(fark/2));
   ObjectSetInteger(ChartID(),"TTLINE"+last_select_objectr,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"TTLINE"+last_select_objectr,OBJPROP_STYLE,STYLE_SOLID);
   //if ( work == false )ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"TTLINE"+last_select_objectr,OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(ChartID(),"TTLINE"+last_select_objectr,OBJPROP_WIDTH,1);
   ObjectSetInteger(ChartID(),"TTLINE"+last_select_objectr,OBJPROP_RAY,False);
   //ObjectSetString(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_TOOLTIP,candle_level+"/"+shift);

   
   ObjectDelete(ChartID(),"TTTLINE"+last_select_objectr);
   ObjectCreate(ChartID(),"TTTLINE"+last_select_objectr,OBJ_TREND,0,Time[shift],Low[i]+(fark/4),mnt,Low[i]+(fark/4));
   ObjectSetInteger(ChartID(),"TTTLINE"+last_select_objectr,OBJPROP_BACK,True);
   //ObjectSetInteger(ChartID(),"TTTLINE"+last_select_objectr,OBJPROP_STYLE,STYLE_SOLID);
   ObjectSetInteger(ChartID(),"TTTLINE"+last_select_objectr,OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"TTTLINE"+last_select_objectr,OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(ChartID(),"TTTLINE"+last_select_objectr,OBJPROP_WIDTH,1);
   ObjectSetInteger(ChartID(),"TTTLINE"+last_select_objectr,OBJPROP_RAY,False);
   //ObjectSetString(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_TOOLTIP,candle_level+"/"+shift);

   ObjectDelete(ChartID(),"TTTTLINE"+last_select_objectr);
   ObjectCreate(ChartID(),"TTTTLINE"+last_select_objectr,OBJ_TREND,0,Time[shift],High[shift]-(fark/4),mnt,High[shift]-(fark/4));
   ObjectSetInteger(ChartID(),"TTTTLINE"+last_select_objectr,OBJPROP_BACK,True);
   //ObjectSetInteger(ChartID(),"TTTLINE"+last_select_objectr,OBJPROP_STYLE,STYLE_SOLID);
   ObjectSetInteger(ChartID(),"TTTTLINE"+last_select_objectr,OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"TTTTLINE"+last_select_objectr,OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(ChartID(),"TTTTLINE"+last_select_objectr,OBJPROP_WIDTH,1);
   ObjectSetInteger(ChartID(),"TTTTLINE"+last_select_objectr,OBJPROP_RAY,False);
   //ObjectSetString(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_TOOLTIP,candle_level+"/"+shift);
             
          
          
          
          }
          
          
                    


}


if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_TREND && StringFind(sparam,"MP",0) == -1 && StringFind(sparam,"HP",0) == -1 && StringFind(sparam,"LP",0) == -1 && StringFind(sparam,"CP",0) == -1 &&  StringFind(sparam,"Exp",0) == -1 && StringFind(sparam,"MAL",0) == -1 && lock == false && skyper == true) {

RefreshRates();
ChartRedraw();
WindowRedraw();





//if ( mode_off_shift != 0 && sparam != last_select_object ) mode=true;


last_select_object=sparam;


          int obj_typ = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TYPE);
          datetime obj_time1 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,0);
          datetime obj_time2 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,1);
          datetime obj_time3 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,2);
          double obj_prc1 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,0);
          double obj_prc2 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,1);
          double obj_prc3 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,2);
          bool obj_fiil = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_FILL);
          double obj_scale = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_SCALE);
          double obj_angle = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_ANGLE);
          bool obj_ray = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_RAY);
          color obj_color = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_COLOR);
          color obj_bgcolor = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_BGCOLOR);
          int obj_width = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_WIDTH);
          int obj_back = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_BACK);
          
          
          int shift1=iBarShift(Symbol(),Period(),obj_time1);
          int shift2=iBarShift(Symbol(),Period(),obj_time2);
          
          shift_1=shift1;
          shift_2=shift2;
          
          price_1=obj_prc1;
          price_2=obj_prc2;
          


if ( obj_prc2 > obj_prc1 ) {

//Alert("Selam");



ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrCrimson);

high_price=High[shift2];
low_price=Low[shift1];




/*
for (int i=shift2;i>=shift1;i--) {
//for (int i=shift2;i<shift1;i++) {

//if ( High[i] > high_price ) {high_price=High[i];shift2=i;}
if ( Low[i] < low_price ) {low_price=Low[i];shift1=i;}

}
*/



/*
//for (int i=shift1;i>shift2;i--) {
for (int i=shift2;i<shift1;i++) {

if ( High[i] > high_price ) {high_price=High[i];shift2=i;}
//if ( Low[i] < low_price ) {low_price=Low[i];shift2=i;}

}

*/
double yuzde=DivZero(high_price-low_price,100);



ObjectMove(ChartID(),last_select_object,1,Time[shift2],High[shift2]);
ObjectMove(ChartID(),last_select_object,0,Time[shift1],Low[shift1]);

double levels=61.8;
string level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],high_price+levels*yuzde,mnt,high_price+levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);

levels=38.2;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],high_price-levels*yuzde,mnt,high_price-levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrOrangeRed);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);




levels=122.4;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],high_price+levels*yuzde,mnt,high_price+levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);


levels=13;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],low_price-levels*yuzde,mnt,low_price-levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);


levels=0;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],low_price-levels*yuzde,mnt,low_price-levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);

levels=-100;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],low_price-levels*yuzde,mnt,low_price-levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);






        //if ( price2 > price1 ) {
        if ( obj_prc2 > obj_prc1 ) {
        
       double tepe_fiyats=High[shift2];
        double dip_fiyats=Low[shift1];
        
        



                 

//Alert("Selam");


  double high_price=tepe_fiyats;
   double low_price=dip_fiyats;
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
   
   double level0=0;
   double level100=0; 
  string namet=last_select_object;
  datetime time1=obj_time1;
  double level=level168;
  string levels="d168";       
  string names=namet +" Flag ";
  
  /*
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,low_price-level,Time[0],low_price-level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrYellow);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);   


  level=eq;
  levels="deq";    
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,eq,Time[0],eq);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrDarkGray);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);
     
  level=level130;
  levels="d130";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,low_price-level,Time[0],low_price-level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrRoyalBlue);

  level=level272;
  levels="d272";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,low_price-level,Time[0],low_price-level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrMediumBlue);

  level=level414;
  levels="d414";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,low_price-level,Time[0],low_price-level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrTurquoise);

  level=level618;
  levels="d618";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,low_price-level,Time[0],low_price-level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrMaroon);

  level=level886;
  levels="d886";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,low_price-level,Time[0],low_price-level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrBrown);
  

  level=level886;
  levels="d886sl";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,low_price-(level*2),Time[0],low_price-(level*2));
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrCrimson);*/

         string name=namet + " FE SL 200";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,dip_fiyats-200*Point,Time[0],dip_fiyats-200*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrRed); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,1);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0);
         ObjectSetInteger(0,name,OBJPROP_BACK,1);
         ObjectDelete(0,name);

        double Fark=(((tepe_fiyats-dip_fiyats)*12)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*4.5)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark);  
        //double prc110=dip_fiyats+Fark*Point;
        
        //double SL11=dip_fiyats+Fark*Point;       
         
         name=namet + " FE 11";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,dip_fiyats+Fark*Point,Time[0],dip_fiyats+Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrBlue); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_SOLID);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);
         ObjectDelete(0,name);

        Fark=(((tepe_fiyats-dip_fiyats)*9)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*4.5)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark);  
        //prc80=dip_fiyats+Fark*Point;
        
        //SL8=dip_fiyats+Fark*Point;       
         
         name=namet + " FE 8";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,dip_fiyats+Fark*Point,Time[0],dip_fiyats+Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrRed); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_SOLID);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);
         ObjectDelete(0,name);


        Fark=(((tepe_fiyats-dip_fiyats)*6)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*4.5)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark); 
        //prc50=dip_fiyats+Fark*Point;
        
        //SL5=dip_fiyats+Fark*Point;        
         
         name=namet + " FE 5";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,dip_fiyats+Fark*Point,Time[0],dip_fiyats+Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrBlack); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_SOLID);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);   
         ObjectDelete(0,name);


        Fark=(((tepe_fiyats-dip_fiyats)*4)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*4)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark);
        //TP4=tepe_fiyats-Fark;
        //prc30=dip_fiyats+Fark*Point;
        
        //ENTRY3=dip_fiyats+Fark*Point;
        
         name=namet + " FE 3.0";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,dip_fiyats+Fark*Point,Time[0],dip_fiyats+Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrRed); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,1);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);         
         ObjectDelete(0,name);
  
  }
  

}



if ( obj_prc1 > obj_prc2 ) {

//Alert("Selam");



ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrCrimson);

high_price=High[shift1];
low_price=Low[shift2];




/*
for (int i=shift2;i>=shift1;i--) {
//for (int i=shift2;i<shift1;i++) {

//if ( High[i] > high_price ) {high_price=High[i];shift2=i;}
if ( Low[i] < low_price ) {low_price=Low[i];shift1=i;}

}
*/



/*
//for (int i=shift1;i>shift2;i--) {
for (int i=shift2;i<shift1;i++) {

if ( High[i] > high_price ) {high_price=High[i];shift2=i;}
//if ( Low[i] < low_price ) {low_price=Low[i];shift2=i;}

}

*/
double yuzde=DivZero(high_price-low_price,100);



ObjectMove(ChartID(),last_select_object,0,Time[shift1],High[shift1]);
ObjectMove(ChartID(),last_select_object,1,Time[shift2],Low[shift2]);

double levels=61.8;
string level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],low_price-levels*yuzde,mnt,low_price-levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);


levels=38.2;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],low_price+levels*yuzde,mnt,low_price+levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrOrangeRed);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);




levels=122.4;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],low_price-levels*yuzde,mnt,low_price-levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);


levels=13;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],high_price+levels*yuzde,mnt,high_price+levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);


levels=0;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],high_price+levels*yuzde,mnt,high_price+levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);


levels=-100;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],high_price+levels*yuzde,mnt,high_price+levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);




        if ( obj_prc1 > obj_prc2 ) {
        
        
        
        double tepe_fiyats=High[shift1];
        double dip_fiyats=Low[shift2];
        
        

        
        //Alert("Selam");

   double high_price=tepe_fiyats;
   double low_price=dip_fiyats;
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
   
   double level0=0;
   double level100=0; 
  string namet=last_select_object;
  datetime time1=obj_time1;
  double level=level168;
  string levels="u168";       
  string names=namet +" Flag ";
  
/*
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,high_price+level,Time[0],high_price+level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrYellow);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);  
    
  
  level=eq;
  levels="ueq";    
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,eq,Time[0],eq);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrDarkGray);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);   
     
  level=level130;
  levels="u130";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,high_price+level,Time[0],high_price+level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrRoyalBlue);

  level=level272;
  levels="u272";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,high_price+level,Time[0],high_price+level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrMediumBlue);

  level=level414;
  levels="u414";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,high_price+level,Time[0],high_price+level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrTurquoise);

  level=level618;
  levels="u618";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,high_price+level,Time[0],high_price+level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrMaroon);

  level=level886;
  levels="u886";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,high_price+level,Time[0],high_price+level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrBrown);


  level=level886;
  levels="u886sl";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,high_price+(level*2),Time[0],high_price+(level*2));
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrCrimson);*/
  
  

         string name=namet + " FE SL 200";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,tepe_fiyats+200*Point,Time[0],tepe_fiyats+200*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrRed); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,1);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectDelete(0,name);

        double Fark=(((tepe_fiyats-dip_fiyats)*12)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*4.5)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark);         
         double prc110 = tepe_fiyats-Fark*Point;
         double SL11 = tepe_fiyats-Fark*Point;
         
         name=namet + " FE 11";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,tepe_fiyats-Fark*Point,Time[0],tepe_fiyats-Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrBlue); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_SOLID);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectDelete(0,name);

        Fark=(((tepe_fiyats-dip_fiyats)*9)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*4.5)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark);         
         //prc80 = tepe_fiyats-Fark*Point;
         //SL8 = tepe_fiyats-Fark*Point;
         
         name=namet + " FE 8";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,tepe_fiyats-Fark*Point,Time[0],tepe_fiyats-Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrRed); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_SOLID);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectDelete(0,name);
                             
        Fark=(((tepe_fiyats-dip_fiyats)*6)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*4.5)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark); 
        //prc50 = tepe_fiyats-Fark*Point;
        
         //SL5 = tepe_fiyats-Fark*Point;       
         
         name=namet + " FE 5";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,tepe_fiyats-Fark*Point,Time[0],tepe_fiyats-Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrBlack); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_SOLID);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectDelete(0,name);


        Fark=(((tepe_fiyats-dip_fiyats)*4)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*4)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark);
        //TP4=tepe_fiyats-Fark;
        //prc30 = tepe_fiyats-Fark*Point;
        
        //Alert("Selam");
        //ENTRY3=tepe_fiyats-Fark*Point;        
        
        
        
         name=namet + " FE 3.0";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,tepe_fiyats-Fark*Point,Time[0],tepe_fiyats-Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrRed); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,1);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0);          
         ObjectDelete(0,name);  
  
  }



}
     
          
          
          
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
// Thank You For Life 26.01.2024



void ObjectsDeleteAlls(long oda_charid,string oda_wilcard,int oda_window,int oda_type) {


//return;

             int obj_total=ObjectsTotal(oda_charid,oda_window,oda_type)-1;
    for(int i=ObjectsTotal(oda_charid,oda_window,oda_type);i>=0;i--)
        {
        string name = ObjectName(oda_charid,i,oda_window,oda_type);
        
  int index = StringFind(name,oda_wilcard, 0); 


  if ( index != -1 ) {
  Sleep(100);
  ObjectDelete(ChartID(),name);
   }  
   
  }


}




void CreateSinyalButtonRight() {


//Lot=0;


  int max_sinyal_number = 25;
  //int max_sinyal_number = 15;
  
  string buttonID="";
  
  //if ( ChartID() == 0 ) {
  /////////////////////////////////////////////////////////////////////////////////////////////////////
     for (int bs=0;bs<=max_sinyal_number;bs++){
   
   buttonID="ButtonSinyalRight"+bs; // Support LeveL Show
   
   string text="";
   color renk=clrWhite;
   
   if ( bs ==  0 ) text =risk_lot;//"Eq";
   if ( bs ==  1 ) text =risk_oran;//"Eq";
   if ( bs ==  2 ) text ="Risk";
   if ( bs ==  3 ) text =auto_close_profit_usd;
   if ( bs ==  4 ) text ="Ord PC";
   if ( bs ==  5 ) text ="Risk Buy";
   if ( bs ==  6 ) text ="Risk Sell";
   if ( bs ==  7 ) text ="Risk Free";
   if ( bs ==  8 ) text ="Risk All";
   if ( bs ==  9 ) text ="Risk Clear";
   if ( bs ==  10 ) text ="Bg Work";
   if ( bs ==  11 ) text ="Lock Lot";
   if ( bs ==  12 ) text ="Robot";
   if ( bs ==  13 ) text ="Auto";
   if ( bs ==  14 ) text =sk_order_distance;
   if ( bs ==  15 ) text =sk_order_limit;
   if ( bs ==  16 ) text ="Stop";
   if ( bs ==  17 && sk_auto_stop == true ) text =sk_buy_robot_price;//"Up Stop";
   if ( bs ==  18 && sk_auto_stop == true ) text =sk_sell_robot_price;//"Down Stop";
   if ( bs ==  17 && sk_auto_stop == false && sk_buy_robot_price == 1000000 ) text ="Up Stop";
   if ( bs ==  18 && sk_auto_stop == false && sk_sell_robot_price == -1 ) text ="Down Stop";   
   if ( bs ==  19 ) text ="Sound";   
   if ( bs ==  20 ) text ="Bid Ask"; 
   if ( bs ==  21 ) text ="NonStop"; 
   if ( bs ==  22 ) text ="Full Mode"; 
   if ( bs ==  23 ) text ="High Low"; 
   if ( bs ==  24 ) text ="Time Close"; 
   
  

   //if ( text=="Wick" && wick == true ) renk=clrRed;
   if ( text=="Risk" ) renk=clrGreenYellow;
   if ( text=="Ord PC" && auto_close_profit == true ) renk=clrOrangeRed;   
   if ( bs == 0 ) renk=clrLightGray;
   if ( bs == 1 ) renk=clrBisque;
   if ( bs == 10 ) renk=clrWhite;//clrLightSteelBlue;
   if ( bs == 10 && background_work == true ) renk=clrLightGreen;   
   if ( bs == 11 && lock_lot == true ) renk=clrLightGray;  
   if ( bs == 12 && sk_robot == true ) renk=clrLightGray;  
   if ( bs == 13 && sk_auto_bot == true ) renk=clrLightGray;  
   if ( bs == 16 && sk_auto_stop == true ) renk=clrLightGray;  
   
   if ( bs == 17 ) renk=clrLightGreen;  
   if ( bs == 18 ) renk=clrLightPink;  

   if ( bs == 19 && profit_sound == true ) renk=clrLightGray;  
   if ( bs == 20 && bidask_show == true ) renk=clrBisque;  
   if ( bs == 21 && sk_nonstop_order == true ) renk=clrBisque;  
   if ( bs == 22 && full_mode == true ) renk=clrBisque;  
   if ( bs == 23 && high_low_mode == true ) renk=clrLightBlue;  
   if ( bs == 24 && order_time_close == true ) renk=clrLightGreen;  
   
   ObjectDelete(0,buttonID); 
   if ( bs < 2 )ObjectCreate(0,buttonID,OBJ_EDIT,0,100,100);
   if ( bs == 2 )ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   if ( bs == 3 )ObjectCreate(0,buttonID,OBJ_EDIT,0,100,100);
   if ( bs == 4 )ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   if ( bs == 5 )ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   if ( bs == 6 )ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   if ( bs == 7 )ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   if ( bs == 8 )ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   if ( bs == 9 )ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   if ( bs == 10 )ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   if ( bs == 11 )ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   if ( bs == 12 )ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   if ( bs == 13 )ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   if ( bs == 14 )ObjectCreate(0,buttonID,OBJ_EDIT,0,100,100);
   if ( bs == 15 )ObjectCreate(0,buttonID,OBJ_EDIT,0,100,100);
   if ( bs == 16 )ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   if ( bs == 17 )ObjectCreate(0,buttonID,OBJ_EDIT,0,100,100);
   if ( bs == 18 )ObjectCreate(0,buttonID,OBJ_EDIT,0,100,100);   
   if ( bs == 19 )ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);   
   if ( bs == 20 )ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);   
   if ( bs == 21 )ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);   
   if ( bs == 22 )ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);   
   if ( bs == 23 )ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);   
   if ( bs == 24 )ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);   
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,renk);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,renk);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,70);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,50+(22*bs));
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,50);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,20);  
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER);

   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,text);
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,7);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);

   if ( bs == 0 ) ObjectSetString(0,buttonID,OBJPROP_TOOLTIP,"Risk Lot");
   if ( bs == 1 ) ObjectSetString(0,buttonID,OBJPROP_TOOLTIP,"Risk Oran");
   if ( bs == 3 ) ObjectSetString(0,buttonID,OBJPROP_TOOLTIP,"Auto Close Profit");
   if ( bs == 14 ) ObjectSetString(0,buttonID,OBJPROP_TOOLTIP,"Distance");
   if ( bs == 15 ) ObjectSetString(0,buttonID,OBJPROP_TOOLTIP,"Order Limit");
   if ( bs == 16 ) ObjectSetString(0,buttonID,OBJPROP_TOOLTIP,"Buy Robot Stop Price");
   if ( bs == 17 ) ObjectSetString(0,buttonID,OBJPROP_TOOLTIP,"Sell Robot Stop Price");   
      
   
   }


}

void CreateSinyalButton() {

CreateSinyalButtonRight();

//Lot=0;


  //int max_sinyal_number = 17;
  int max_sinyal_number = 20;
  
  string buttonID="";
  
  //if ( ChartID() == 0 ) {
  /////////////////////////////////////////////////////////////////////////////////////////////////////
     for (int bs=0;bs<=max_sinyal_number;bs++){
   
   buttonID="ButtonSinyal"+bs; // Support LeveL Show
   
   string text="";
   color renk=clrGreen;
   

   if ( bs ==  2 ) text ="Wick";
   if ( bs ==  0 ) text ="Eq";
   if ( bs ==  3 ) text ="Reset";
   if ( bs ==  1 ) text ="FiveZero";
   if ( bs ==  4 ) text ="Sinyal";
   if ( bs ==  5 ) text ="Buy";
   if ( bs ==  6 ) text ="Sell";
   if ( bs ==  7 ) text ="Time";
   if ( bs ==  8 ) text ="Spread";
   if ( bs ==  9 ) text ="Buy Lot";
   if ( bs ==  10 ) text ="Sell Lot";
   if ( bs ==  11 ) text ="Buy Line";
   if ( bs ==  12 ) text ="Sell Line";
   if ( bs ==  13 ) text ="Profit Alarm";
   if ( bs ==  14 ) text ="Profit Close";
   if ( bs ==  15 ) text ="Guard";
   if ( bs ==  16 ) text ="SL";
   if ( bs ==  17 ) text ="SL USD";
   if ( bs ==  18 ) text ="Today";
   if ( bs ==  19 ) text ="iFvg";
   if ( bs ==  20 ) text ="iFibo";
   
      
   /*
   if ( bs ==  2 ) text ="Auto";
   if ( bs ==  1 ) text ="Otomatik";
   if ( bs ==  0 ) text ="Mode";
   if ( bs ==  4 ) text ="Reset";
   if ( bs ==  5 ) text ="Wick";
   if ( bs ==  3 ) text ="Price";
   if ( bs ==  6 ) text ="Order";
   if ( bs ==  7 ) text ="Up";
   if ( bs ==  8 ) text ="Down";
   if ( bs ==  9 ) text ="Lot "+MarketInfo(Symbol(),MODE_MINLOT);
   if ( bs ==  10 ) text ="Lot "+MarketInfo(Symbol(),MODE_MINLOT)*2;
   if ( bs ==  11 ) text ="Lot "+MarketInfo(Symbol(),MODE_MINLOT)*3;
   if ( bs ==  12 ) text ="Lot "+MarketInfo(Symbol(),MODE_MINLOT)*4;
   if ( bs ==  13 ) text ="Lot "+MarketInfo(Symbol(),MODE_MINLOT)*5;
   if ( bs ==  14 ) text ="Lot "+DoubleToString(MarketInfo(Symbol(),MODE_MINLOT)*10,2);
   if ( bs ==  15  ) text ="Aggressive";
   if ( bs ==  16  ) text ="Standart";
   if ( bs ==  17  ) text ="Defensive";
   if ( bs ==  15  ) text ="Trend";
   if ( bs ==  16  ) text ="Reserval";
   if ( bs ==  17  ) text ="Turbo";
   */
   
   //if ( bs == 10  ) renk=clrLightBlue;   
   //if ( bs == 11  ) renk=clrPink;    
   //if ( text=="Auto" && auto_mode == true ) renk=clrRed;
   //if ( text=="Otomatik" && oto_system == true ) renk=clrRed;
   //if ( text=="Mode" && mode == true ) renk=clrRed;
   if ( text=="Wick" && wick == true ) renk=clrRed;
   if ( text=="Eq" && eqsys == true ) renk=clrRed;
   if ( text=="FiveZero" && skyper == true ) renk=clrRed;
   if ( text=="Sinyal" && sinyal_sys == true ) renk=clrRed;
   if ( text=="Buy Line" && buy_line == true ) renk=clrNavy;
   if ( text=="Sell Line" && sell_line == true ) renk=clrDarkRed;
   if ( text=="Profit Close" && profit_close == true  ) renk=clrRed;
   if ( text=="Guard" && sk_guard == true ) renk=clrNavy;
   if ( text=="SL" && sk_guard_sl == true  ) renk=clrDarkRed;   
   if ( text=="iFvg" && ifvg == true  ) renk=clrDarkRed;   
   if ( text=="iFibo" && ifibo == true  ) renk=clrLightGray;   
   if ( bs == 5  ) renk=clrNavy;
   if ( bs == 6  ) renk=clrDarkRed;
   if ( bs == 6  ) renk=clrDarkRed;
   if ( bs == 7  ) renk=clrYellowGreen;
   if ( bs == 8  ) renk=clrLightGray;
   if ( bs == 9  ) renk=clrDarkBlue;
   if ( bs == 13  ) renk=clrLimeGreen;
   if ( bs == 17  ) renk=clrCrimson;
   if ( bs == 18  ) renk=clrBlack;
   if ( bs == 19 && ifvg == false  ) renk=clrDarkMagenta;
   if ( bs == 20 && ifibo == false  ) renk=clrDarkBlue;

   //if ( bs == 12  ) renk=clrDarkRed; 
   //if ( text=="Price" && price_level == true ) renk=clrDarkGreen;
   //if ( text=="Order" && order_mode == true ) renk=clrLightGray;
   //if ( text=="Down" && order_mode_buy == true ) renk=clrBlue;
   //if ( text=="Up" && order_mode_sell == true ) renk=clrOrangeRed;
/*
   if ( text=="Lot "+MarketInfo(Symbol(),MODE_MINLOT) && order_mode_one == true ) {renk=clrTurquoise;Lot=Lot+MarketInfo(Symbol(),MODE_MINLOT);}
   if ( text=="Lot "+MarketInfo(Symbol(),MODE_MINLOT)*2 && order_mode_two == true ) {renk=clrTurquoise;Lot=Lot+MarketInfo(Symbol(),MODE_MINLOT)*2;}
   if ( text=="Lot "+MarketInfo(Symbol(),MODE_MINLOT)*3 && order_mode_three == true ) {renk=clrTurquoise;Lot=Lot+MarketInfo(Symbol(),MODE_MINLOT)*3;}
   if ( text=="Lot "+MarketInfo(Symbol(),MODE_MINLOT)*4 && order_mode_four == true )  {renk=clrTurquoise;Lot=Lot+MarketInfo(Symbol(),MODE_MINLOT)*4;}
   if ( text=="Lot "+MarketInfo(Symbol(),MODE_MINLOT)*5 && order_mode_five == true )  {renk=clrTurquoise;Lot=Lot+MarketInfo(Symbol(),MODE_MINLOT)*5;}
   if ( text=="Lot "+DoubleToString(MarketInfo(Symbol(),MODE_MINLOT)*10,2) && order_mode_six == true )  {renk=clrTurquoise;Lot=Lot+MarketInfo(Symbol(),MODE_MINLOT)*10;}
   */
   /*
   if ( text=="Aggressive" && order_mode_aggressive == true ) {renk=clrRed;}
   
   if ( text=="Standart" && order_mode_standart == true ) {renk=clrRed;}
      
   if ( text=="Defensive" && order_mode_defensive == true ) {renk=clrRed;}      
   */
/*
   if ( text=="Trend" && order_mode_trend == true ) renk=clrNavy;
   if ( text=="Reserval" && order_mode_reserval == true ) renk=clrMaroon;
   if ( text=="Turbo" && order_mode_turbo == true ) renk=clrLimeGreen;
   
      */
      
                                    
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrWhite);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,renk);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,10);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,50+(20*bs));
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,50);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,20);  
    
   if ( bs >= 5 ) {
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,5);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,70+(20*bs));
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,60);
   }
   
   
   if ( bs >= 7 ) {
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,5);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,80+(20*bs));
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,60);
   }
      


   if ( bs >= 9 ) {
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,5);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,100+(20*bs));
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,60);
   }
   


   if ( bs >= 11 ) {
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,5);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,120+(20*bs));
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,60);
   }
      

   if ( bs >= 13 ) {
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,5);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,140+(20*bs));
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,60);
   }  

   if ( bs >= 15 ) {
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,5);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,160+(20*bs));
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,60);
   }       

   if ( bs >= 17 ) {
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,5);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,180+(20*bs));
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,60);
   }         
   
   if ( bs >= 19 ) {
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,5);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,200+(20*bs));
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,60);
   }         
   
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,text);
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,7);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_LEFT_UPPER); 
   /*
   buttonID="ButtonSinyalTime"+bs;
   
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrWhite);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,130+(120*bs));
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,30);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,110);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,20);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"TIME");
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,8);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_LEFT_LOWER); 
   //ObjectSetInteger(0,buttonID,OBJPROP_HIDDEN,true);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,true);*/
   
   }

}         


string sinyal="";
bool sinyal_sys=false;
int alarm_count=5;
bool fx_bomb=false;

bool auto_close_profit=false;
//double auto_close_profit_usd=0.15;
double auto_close_profit_usd=1.0;
int sk_order_limit=20;
//double sk_order_distance=100;
double sk_order_distance=2000;
//double sk_buy_price[50];
//double sk_sell_price[50];
double sk_last_buy_price=-1;
double sk_last_sell_price=-1;
bool sk_auto_bot=false;
bool sk_robot=false;
double sk_buy_robot_price=1000000;
double sk_sell_robot_price=-1;
bool sk_auto_stop=false;

//double risk_lot=0.10;//MarketInfo(Symbol(),MODE_MINLOT);
double risk_lot=0.01;//MarketInfo(Symbol(),MODE_MINLOT);
double risk_oran=1.5;

bool stop_question=false;

bool lock_lot=false;

bool bidask_show=false;

bool sk_nonstop_order = false;

double sk_buy_prices=1000000;
double sk_sell_prices=-1;

double sk_total_sl_usd=0;
double sk_buy_sl_usd=0;
double sk_sell_sl_usd=0;

double today_buy_profit=0;
double today_sell_profit=0;
double today_buy_lot=0;
double today_sell_lot=0;
int today_buy_total=0;
int today_sell_total=0;
int historytotal;

void Sinyal() {





if ( historytotal!=OrdersHistoryTotal() ) {

today_buy_lot=0;
today_sell_lot=0;
today_buy_profit=0;
today_sell_profit=0;
today_buy_total=0;
today_sell_total=0;
sym=Symbol();

for(int cntf=OrdersHistoryTotal();cntf>=0;cntf--){

if(!OrderSelect(cntf, SELECT_BY_POS, MODE_HISTORY))continue;

if ( OrderSymbol() == sym && OrderType() == OP_BUY && OrderMagicNumber() == magic && int(TimeDay(TimeCurrent())) == int(TimeDay(OrderCloseTime()))
 ) {
today_buy_total=today_buy_total+1;
today_buy_profit=today_buy_profit+OrderProfit()+OrderCommission()+OrderSwap();
today_buy_lot=today_buy_lot+OrderLots();
}

if ( OrderSymbol() == sym && OrderType() == OP_SELL && OrderMagicNumber() == magic && int(TimeDay(TimeCurrent())) == int(TimeDay(OrderCloseTime()))
 ) {
today_sell_total=today_sell_total+1;
today_sell_profit=today_sell_profit+OrderProfit()+OrderCommission()+OrderSwap();
today_sell_lot=today_sell_lot+OrderLots();
}




}

historytotal=OrdersHistoryTotal();

}


ObjectSetString(ChartID(),"ButtonSinyal"+18,OBJPROP_TEXT,DoubleToString(today_sell_profit+today_buy_profit,2)+"$");





//if ( sk_buy_robot_price == 1000000 ) Print("Evet",sk_buy_robot_price);
//if ( sk_sell_robot_price == -1 ) Print("Evet",sk_sell_robot_price);


if ( background_work == false ) {return;
string buttonID="ButtonSinyalRight"+10;
ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrWhite);
}


if ( background_work == true ) {
string buttonID="ButtonSinyalRight"+10;

//Sleep(50);
//if ( ObjectGetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR) == clrLightSteelBlue ) {ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrLightSlateGray);} else {ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrLightSteelBlue);}


}


if ( profit_alarm == true ) {



string buttonID="ButtonSinyal"+13;

//Sleep(50);
if ( ObjectGetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR) == clrLimeGreen ) {ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrChartreuse);} else {ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrLimeGreen);}

if ( AccountProfit() > 0 ) {
if (alarm_count == 5 ) {
Alert(alarm_count+"#Profit Alarm:"+AccountProfit()+"$");
alarm_count=0;
}
alarm_count=alarm_count+1;

}


}

///////////////////////////////////
// Profit Close Otomatik Kapama
///////////////////////////////////

if ( profit_close == true ) {

string buttonID="ButtonSinyal"+14;

//Sleep(50);
if ( ObjectGetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR) == clrDarkRed ) {ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrOrangeRed);} else {ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrDarkRed);}


if ( AccountProfit() >= 1 ) {
CloseAllBuyOrders();
CloseAllSellOrders();
}
}





	int min, sec;
	
   min = iTime(Symbol(),Period(),0) + Period()*60 - CurTime();
   sec = min%60;
   min =(min - min%60) / 60;
   //Comment("Balanced Time to next bar close: " + min + " min " + sec + " sec");
   
     
     ObjectSetString(ChartID(),"ButtonSinyal"+7,OBJPROP_TEXT,min+":"+sec);

     ObjectSetString(ChartID(),"ButtonSinyal"+8,OBJPROP_TEXT,DoubleToString(((Ask-Bid)/Point),0));


int buy_total=0;
double buy_profit=0;
double buy_lot=0;

int sell_total=0;
double sell_profit=0;
double sell_lot=0;

ObjectSetString(ChartID(),"ButtonSinyal"+5,OBJPROP_TEXT,"BUY");
ObjectSetString(ChartID(),"ButtonSinyal"+6,OBJPROP_TEXT,"SELL");


ObjectSetString(ChartID(),"ButtonSinyal"+9,OBJPROP_TEXT,"Buy Lot");
ObjectSetString(ChartID(),"ButtonSinyal"+10,OBJPROP_TEXT,"Sell Lot");




/*
if ( sk_robot == true ) {
for ( int p=0;p<50;p++){
sk_buy_price[p]=10000000;
sk_sell_price[p]=-1;
//Print(p);
}
}
*/
/////////////////////////////////////////////////////////////////////////
// Otomatik Sistem Durdurma
////////////////////////////////////////////////////////////////////////
if ( sk_auto_stop == true && sk_robot == true ) {

if ( Ask >= sk_buy_robot_price && sk_buy_robot_price != 1000000 ) {
sk_robot=false;
sk_auto_bot=false;
}

//////////// Ters yönde ilerlemesine engel oluyoruz.
if ( Ask <= sk_sell_robot_price && sk_sell_robot_price != -1 && buy_total > 0 ) {
sk_robot=false;
sk_auto_bot=false;
}



if ( Bid <= sk_sell_robot_price && sk_sell_robot_price != -1 ) {
sk_robot=false;
sk_auto_bot=false;
}

//////////// Ters yönde ilerlemesine engel oluyoruz.
if ( Bid >= sk_buy_robot_price && sk_buy_robot_price != 1000000 && sell_total > 0  ) {
sk_robot=false;
sk_auto_bot=false;
}

}
/////////////////////////////////////////////////////////////////////////

sk_buy_sl_usd=0;
sk_sell_sl_usd=0;
sk_total_sl_usd=0;

for(int cnts=OrdersTotal()-1;cnts>=0;cnts--){

if(!OrderSelect(cnts, SELECT_BY_POS, MODE_TRADES))continue;

datetime order_open_time = OrderOpenTime();
       int duration = (int)TimeCurrent() - (int)order_open_time;
       

if ( OrderSymbol() == sym && OrderType() == OP_BUY && OrderMagicNumber() == magic ) {


if ( OrderStopLoss() != 0 ) {
int sym_sl_pip=(OrderOpenPrice()-OrderStopLoss())/Point;
double usd=PipPrice(OrderSymbol(),0,sym_sl_pip,OrderLots());
sk_buy_sl_usd=sk_buy_sl_usd+usd;
}


//Print("pip",pip);


//sk_buy_price[buy_total]=OrderOpenPrice();

if (  buy_total == 0 ) sk_buy_prices=OrderOpenPrice();

if ( OrderOpenPrice() <  sk_buy_prices ) sk_buy_prices=OrderOpenPrice();

buy_total=buy_total+1;
//buy_profit=buy_profit+OrderProfit()+OrderCommission()+OrderSwap();
buy_lot=buy_lot+OrderLots();

double oprofit=OrderProfit();


//if ( OrderProfit() > 0 ) {
oprofit=oprofit-MathAbs(OrderCommission());
if ( OrderSwap() > 0 ) {
oprofit=oprofit+MathAbs(OrderSwap());
} else {
oprofit=oprofit-MathAbs(OrderSwap());
}

buy_profit=buy_profit+oprofit;

//} else {
/*
oprofit=MathAbs(oprofit)-MathAbs(OrderCommission());
if ( OrderSwap() > 0 ) {
oprofit=MathAbs(oprofit)+MathAbs(OrderSwap());
} else {
oprofit=MathAbs(oprofit)-MathAbs(OrderSwap());
}

oprofit=oprofit*-1;*/

//}


//Print(OrderProfit()," ",OrderTicket()," $",oprofit);

if ( auto_close_profit == true && IsTradeAllowed() && (( duration >= maxDuration && order_time_close == true ) || order_time_close == false ) ) {
if ( auto_close_profit_usd == 0 && oprofit > (OrderLots()*100)+(DivZero(OrderLots()*100,100)*10) ) {
OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),0,clrNONE);
if ( profit_sound==true) PlaySound(profit_sound_name);
}

/*
if ( auto_close_profit_usd != 0 && oprofit >= auto_close_profit_usd ) {
OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),0,clrNONE);
}*/



if ( auto_close_profit_usd != 0 && oprofit >= auto_close_profit_usd ) {
if ( lock_lot == true ) {
if ( OrderLots() == risk_lot ) {
OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),0,clrNONE);
if ( profit_sound==true) PlaySound(profit_sound_name);
} 
} else {
OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),0,clrNONE);
if ( profit_sound==true) PlaySound(profit_sound_name);
} 

}
}

}

if ( OrderSymbol() == sym && OrderType() == OP_SELL && OrderMagicNumber() == magic ) {

if ( OrderStopLoss() != 0 ) {
int sym_sl_pip=(OrderStopLoss()-OrderOpenPrice())/Point;
double usd=PipPrice(OrderSymbol(),0,sym_sl_pip,OrderLots());
sk_sell_sl_usd=sk_sell_sl_usd+usd;
}



//sk_sell_price[sell_total]=OrderOpenPrice();

if (  sell_total == 0 ) sk_sell_prices=OrderOpenPrice();

if ( OrderOpenPrice() > sk_sell_prices ) sk_sell_prices=OrderOpenPrice();

sell_total=sell_total+1;

//sell_profit=sell_profit+OrderProfit()+OrderCommission()+OrderSwap();
sell_lot=sell_lot+OrderLots();

double oprofit=OrderProfit();


//if ( OrderProfit() > 0 ) {
oprofit=oprofit-MathAbs(OrderCommission());
if ( OrderSwap() > 0 ) {
oprofit=oprofit+MathAbs(OrderSwap());
} else {
oprofit=oprofit-MathAbs(OrderSwap());
}

sell_profit=sell_profit+oprofit;


//Print(OrderProfit()," ",OrderTicket()," $",oprofit);


if ( auto_close_profit == true && IsTradeAllowed() && (( duration >= maxDuration && order_time_close == true ) || order_time_close == false ) ) {

if ( auto_close_profit_usd == 0 && oprofit > (OrderLots()*100)+(DivZero(OrderLots()*100,100)*10) ) {
OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),0,clrNONE);
if ( profit_sound==true) PlaySound(profit_sound_name);
}


if ( auto_close_profit_usd != 0 && oprofit >= auto_close_profit_usd ) {
if ( lock_lot == true ) {
if ( OrderLots() == risk_lot ) {
OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),0,clrNONE);
if ( profit_sound==true) PlaySound(profit_sound_name);
} 
} else {
OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),0,clrNONE);
if ( profit_sound==true) PlaySound(profit_sound_name);
} 
}
}



}




}

sk_total_sl_usd=DoubleToString(NormalizeDouble(MathAbs(sk_buy_sl_usd)+MathAbs(sk_sell_sl_usd),2),2);

//Comment(sk_total_sl_usd);
//12345

   string buttonIDs="ButtonSinyal"+17;
   ObjectSetString(0,buttonIDs,OBJPROP_FONT,"Arial");
   if ( sk_total_sl_usd > 0 ) ObjectSetString(0,buttonIDs,OBJPROP_TEXT,int(sk_total_sl_usd)+"$");
   if ( sk_total_sl_usd == 0 ) ObjectSetString(0,buttonIDs,OBJPROP_TEXT,"");


///////////////////////////////////////////////////////
if ( ( sk_guard == true || sk_guard_sl == true ) && sk_prc1 != -1 && sk_prc2 != -1 ) {

//Alert("Selam");

if ( sk_last_buy_total != buy_total ) {

if ( buy_total > sk_last_buy_total ) BuyCheck(1);
if ( buy_total < sk_last_buy_total ) BuyCheck(0);
sk_last_buy_total=buy_total;
}


if ( sk_last_sell_total != sell_total ) {

if ( sell_total > sk_last_sell_total ) SellCheck(1);
if ( sell_total < sk_last_sell_total ) SellCheck(0);
sk_last_sell_total=sell_total;
}





}
/////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////////////////////

if ( sk_robot == true ) {

if ( buy_total > 0 && buy_total < sk_order_limit ) {

//ArraySort(sk_buy_price,WHOLE_ARRAY,0,MODE_ASCEND);

//double sk_buy_prices=sk_buy_price[0];

if ( (sk_buy_prices-Ask)/Point >= sk_order_distance ) {
OrderSend(Symbol(),OP_BUY,risk_lot,Ask,0,0,0,"",magic,0,clrNONE);
sk_last_buy_price=Ask;
}

}


if ( sell_total > 0 && sell_total < sk_order_limit ) {

//ArraySort(sk_sell_price,WHOLE_ARRAY,0,MODE_DESCEND);

//double sk_sell_prices=sk_sell_price[0];
//Comment(sk_sell_prices);

if ( (Bid-sk_sell_prices)/Point >= sk_order_distance ) {
OrderSend(Symbol(),OP_SELL,risk_lot,Bid,0,0,0,"",magic,0,clrNONE);
sk_last_sell_price=Bid;
}


}

///////////////////////////////////////////////////////////////////////////////
// İşlemler Sıfırlandıktan Sonra ( İşlem açmaya başlaması lazım Robotun, En son nerde kaldıysa onun altına inecek )
///////////////////////////////////////////////////////////////////////////////
if ( sk_auto_bot == true ) {
//////////////////////////////////////////////////////////////////////////
if ( buy_total == 0 && buy_total < sk_order_limit && sk_last_buy_price != -1 ) {

double sk_buy_prices=sk_last_buy_price;

Comment("Last Buy:",sk_buy_prices);

if ( (sk_buy_prices-Ask)/Point >= sk_order_distance ) {
OrderSend(Symbol(),OP_BUY,risk_lot,Ask,0,0,0,"",magic,0,clrNONE);
sk_last_buy_price=Ask;
}

}
///////////////////////////////////////////////////////////////////////////
// Otomatik İşlem Açıcı Harvester
////////////////////////////////////////////////////////////////////////////
if ( sk_auto_stop == true || sk_nonstop_order == true) {
if ( buy_total == 0 && buy_total < sk_order_limit && sk_last_buy_price != -1 ) {
OrderSend(Symbol(),OP_BUY,risk_lot,Ask,0,0,0,"",magic,0,clrNONE);
sk_last_buy_price=Ask;
}
}
///////////////////////////////////////////////////////////////////////////



if ( sell_total == 0 && sell_total < sk_order_limit && sk_last_sell_price != -1 ) {

double sk_sell_prices=sk_last_sell_price;

Comment("Last Sell:",sk_sell_prices);

if ( (Bid-sk_sell_prices)/Point >= sk_order_distance ) {
OrderSend(Symbol(),OP_SELL,risk_lot,Bid,0,0,0,"",magic,0,clrNONE);
sk_last_sell_price=Bid;
}


}
///////////////////////////////////////////////////////////////////////////
// Otomatik İşlem Açıcı Harvester
//////////////////////////////////////////////////////////////////////////
if ( sk_auto_stop == true || sk_nonstop_order == true ) {
if ( sell_total == 0 && sell_total < sk_order_limit && sk_last_sell_price != -1 ) {
double sk_sell_prices=sk_last_sell_price;
Comment("Last Sell:",sk_sell_prices);
OrderSend(Symbol(),OP_SELL,risk_lot,Bid,0,0,0,"",magic,0,clrNONE);
sk_last_sell_price=Bid;
}
}
////////////////////////////////////////////////////////////////////




/////////////////////////////////////////////////////////////////
}
}







//////////////////////////////////////////////////////////////////////////////////////////////////



if ( buy_lot > 0 ) ObjectSetString(ChartID(),"ButtonSinyal"+5,OBJPROP_TEXT,DoubleToString(buy_profit,2));
if ( sell_lot > 0 ) ObjectSetString(ChartID(),"ButtonSinyal"+6,OBJPROP_TEXT,DoubleToString(sell_profit,2));

/////////////////////////////
// Fon Modülü
//////////////////////////////////////////////////////////////
/*
bool fon_mode=false;
if ( fon_mode == true ) {
if ( buy_lot > 0 && sell_lot == 0 ) ObjectSetString(ChartID(),"ButtonSinyal"+6,OBJPROP_TEXT,DoubleToString(AccountEquity()-9336,2));
if ( buy_lot == 0 && sell_lot > 0 ) ObjectSetString(ChartID(),"ButtonSinyal"+5,OBJPROP_TEXT,DoubleToString(AccountEquity()-9336,2));

if ( OrdersTotal() > 0 && AccountEquity()-9336 < 100 && fx_bomb == false ) {Alert("Fx Bomb");
fx_bomb=true;
}
}*/
//////////////////////////////////////////////////////////////

if ( buy_lot > 0 ) ObjectSetString(ChartID(),"ButtonSinyal"+9,OBJPROP_TEXT,DoubleToString(buy_lot,2));
if ( sell_lot > 0 ) ObjectSetString(ChartID(),"ButtonSinyal"+10,OBJPROP_TEXT,DoubleToString(sell_lot,2));



if ( buy_lot == 0 && sell_lot > 0 ) ObjectSetString(ChartID(),"ButtonSinyal"+9,OBJPROP_TEXT,sell_total);
if ( sell_lot == 0 && buy_lot > 0 ) ObjectSetString(ChartID(),"ButtonSinyal"+10,OBJPROP_TEXT,buy_total);


if ( buy_lot == 0 && sell_lot > 0 ) ObjectSetString(ChartID(),"ButtonSinyal"+5,OBJPROP_TEXT,DoubleToString(AccountEquity(),2));
if ( sell_lot == 0 && buy_lot > 0 ) ObjectSetString(ChartID(),"ButtonSinyal"+6,OBJPROP_TEXT,DoubleToString(AccountEquity(),2));


string chart_comment=ChartGetString(ChartID(),CHART_COMMENT);

if ( sell_lot > 0 && buy_lot > 0 ) chart_comment="Account Balance:\n"+AccountEquity()+"$ /"+AccountProfit()+"$";


Comment(chart_comment);



if ( sinyal_sys == false ) return;


string buttonID="ButtonSinyal"+4;

//Sleep(50);
if ( ObjectGetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR) == clrRed ) {ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrDarkRed);} else {ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrRed);}

//Print("Sinyal Sistemi:",Symbol()+" "+TFtoStr(Period()));


if ( Open[4] > Close[4] && Open[3] > Close[3] && Open[2] > Close[2] && Close[1] > Open[1] ) {

if ( StringFind(sinyal,"Buy"+int(Time[1]),0) == -1 ) {
sinyal=sinyal+","+"Buy"+int(Time[1]);
Alert(Symbol()+" "+TFtoStr(Period())+" Buy");


string name="Buy"+int(Time[1]);
ObjectDelete(ChartID(),name);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[4],Close[1],Time[1]+10*PeriodSeconds(),Close[1]);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLimeGreen);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),name,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),name,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),name,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);



}


}

if ( Open[4] < Close[4] && Open[3] < Close[3] && Open[2] < Close[2] && Close[1] < Open[1] ) {
if ( StringFind(sinyal,"Sell"+int(Time[1]),0) == -1 ) {
sinyal=sinyal+","+"Sell"+int(Time[1]);
Alert(Symbol()+" "+TFtoStr(Period())+" Sell");

string name="Sell"+int(Time[1]);
ObjectDelete(ChartID(),name);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[4],Close[1],Time[1]+10*PeriodSeconds(),Close[1]);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrOrangeRed);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),name,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),name,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),name,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);


}
}


}


string TFtoStr(int period) {
 switch(period) {
  case 1     : return("M1");  break;
  case 5     : return("M5");  break;
  case 15    : return("M15"); break;
  case 30    : return("M30"); break;
  case 60    : return("H1");  break;
  case 240   : return("H4");  break;
  case 1440  : return("D1");  break;
  case 10080 : return("W1");  break;
  case 43200 : return("MN1"); break;
  default    : return(DoubleToStr(period,0));
 }
 return("UNKNOWN");
}//string TFtoStr(int period) {
//end stuff by fxdaytrader
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Sinyal Sistemi
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int active_magic_buy=0;
int active_magic_sell=0;


double last_avarage_buy=0; 
double last_avarage_sell=0; 

double last_avarage_buy_profit_price=0;
double last_avarage_sell_profit_price=0;

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
        
        //Comment("avarage_buy:",avarage_buy,"\n avarage_sell:",avarage_sell);
        
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

////////////////////////////////////////////////////////////////////////////
// Pip - Price Fonksiyonu  ? 100 pip kazansa 0.01 bu kur ne kazandırır ?
////////////////////////////////////////////////////////////////////////////

double PipPrice(string sym,double fiyat,int pips,double lots) {


string OrderSymbols = sym;
double sonuc = 0;

//Print("Spread:",MarketInfo(OrderSymbols,MODE_SPREAD));


//if ( MarketInfo(OrderSymbols,MODE_SPREAD) == 0 ) return sonuc;

          int BS_spread = MarketInfo(OrderSymbols,MODE_SPREAD);
              BS_spread = 1;//DivZero((SymbolInfoDouble(Symbol(),SYMBOL_ASK)-SymbolInfoDouble(Symbol(),SYMBOL_BID)),Point);
    double BS_tickvalue = MarketInfo(OrderSymbols,MODE_TICKVALUE);
     double BS_ticksize = MarketInfo(OrderSymbols,MODE_TICKSIZE);
 double BS_spread_price = MarketInfo(OrderSymbols,MODE_MARGINREQUIRED)*BS_spread;
        BS_spread_price = (1/MarketInfo(OrderSymbols,MODE_POINT))*(BS_spread*(MarketInfo(OrderSymbols,MODE_TICKVALUE)*MarketInfo(OrderSymbols,MODE_TICKSIZE)));
        
   double BS_spread_one = DivZero(BS_spread_price,BS_spread)*lots;     
    double Order_Profit = pips*BS_spread_one;   
    
    //if ( BS_spread_one == 0 ) {Alert("BS_spread_one Hatası:",OrderSymbols);return sonuc;}
         
         //Print("OrderSymbols",OrderSymbols,"Fiyat",fiyat,"BS_spread_one",BS_spread_one,"BS_spread_price",BS_spread_price);
         
         int Order_Pips = DivZero(fiyat,BS_spread_one);   


if ( fiyat != 0 ) {
//Alert(fiyat," $ kaç piptir ?",BS_spread_one,"/",IntegerToString(Order_Pips,0)," pip");
sonuc =  Order_Pips;
}

////////////////////////

if ( pips != 0 ) {
//Alert(pips," pip kaç $ kazandırır ?",DoubleToString(Order_Profit,2),"$");
sonuc =  DoubleToString(Order_Profit,2);
}

return sonuc;


}



void Resize(int oranx) {



   long cid=ChartID();
   
   
   //return 0;
   
   
   
   /*
int heightScreen=ChartGetInteger(0,CHART_HEIGHT_IN_PIXELS,0);
int widthScreen=ChartGetInteger(0,CHART_WIDTH_IN_PIXELS,0);

Comment("Height:",heightScreen,"Width:",widthScreen);*/

string obje_listesi="Bilgisi";

       int obj_total=ObjectsTotal(cid);
  string name;
  for(int i=0;i<obj_total;i++)
    {
     name = ObjectName(cid,i);
     
    // Print(oranx,"/",name);
     
int indexof = StringFind(name,obje_listesi, 0);
//if ( indexof != -1 ) continue;


//if(ObjectType(name)!=OBJ_BUTTON || name == "ButtonSHOWHIDE") continue;
//if(ObjectGetInteger(cid,name,OBJPROP_TYPE) != OBJ_LABEL && //ObjectGetInteger(cid,name,OBJPROP_TYPE) != OBJ_BUTTON && 
//ObjectGetInteger(cid,name,OBJPROP_TYPE) != OBJ_RECTANGLE_LABEL && ObjectGetInteger(cid,name,OBJPROP_TYPE) != OBJ_EDIT) continue;
//if(ObjectGetInteger(cid,name,OBJPROP_TYPE) == OBJ_FIBO ) continue;

int ObjWidth = ObjectGetInteger(cid,name,OBJPROP_XSIZE,0);
int ObjHeight = ObjectGetInteger(cid,name,OBJPROP_YSIZE,0);
int ObjX = ObjectGetInteger(cid,name,OBJPROP_XDISTANCE,0);
int ObjY = ObjectGetInteger(cid,name,OBJPROP_YDISTANCE,0);
int ObjFont = ObjectGetInteger(cid,name,OBJPROP_FONTSIZE,0);
//Print(i," object - ",name,"Size:",ButtonWidth,"/",ButtonHeight,"Sinyal:",obje_listesi,"indexof",indexof);

//int oranx=150;

int ObjWidthOran = DivZero(ObjWidth,100)*oranx;
int ObjHeightOran = DivZero(ObjHeight,100)*oranx;
int ObjFontOran = DivZero(ObjFont,100)*oranx;
int ObjXOran = DivZero(ObjX,100)*oranx;
int ObjYOran = DivZero(ObjY,100)*oranx;


int ChartWidths=ObjWidthOran;
int ChartHeights=ObjHeightOran;
int ChartFonts=ObjFontOran;
int ChartXs=ObjXOran;
int ChartYs=ObjYOran;

Print(oranx,"/",name,"/",ObjWidth,"-",ChartWidths);

//ObjectDelete(ChartID(),name);
//ObjectCreate(ChartID(),name,OBJ_BUTTON,0,0,0);

 ObjectSetInteger(cid,name,OBJPROP_XSIZE,ChartWidths);
 ObjectSetInteger(cid,name,OBJPROP_YSIZE,ChartHeights);
 ObjectSetInteger(cid,name,OBJPROP_FONTSIZE,ChartFonts);
 ObjectSetInteger(cid,name,OBJPROP_XDISTANCE,ChartXs);
 ObjectSetInteger(cid,name,OBJPROP_YDISTANCE,ChartYs);
 //ObjectSetInteger(cid,name,OBJPROP_CORNER,CORNER_LEFT_UPPER);
 
ChartRedraw();

}  


}
