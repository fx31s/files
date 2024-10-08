//+------------------------------------------------------------------+
//|                                                SessionEaTool.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

double Lot;
int magic=31;

int OrderTotal=OrdersTotal();

int OrderHisTotal=OrdersHistoryTotal();

double london_eq;

bool london_alert=false;

double margin=AccountMargin();

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+

string sym=Symbol();

int OnInit()
  {
  

/*
if ( TimeHour(TimeCurrent()) >= 15 ) {
     int cevap=MessageBox("Session Newyork Tool, Time Late","Time Late",4); 
     if ( cevap == 6 ) {     
     ChartApplyTemplate(ChartID(),"Ny");     
     }
     }*/
     
     


london_start=false;
london_end=false;
tokyo_start=false;
tokyo_end=false;

london_alert=false;
    
  
  ChartSetInteger(ChartID(),CHART_COLOR_BID,clrBlack);
  
  Lot=0.03;
  sym=Symbol();
  symi=Symbol();
  
  AlertOrder();
  
  
  

      string LabelChart="Bilgi";
     ObjectDelete(ChartID(),LabelChart);
     ObjectCreate(ChartID(),LabelChart, OBJ_LABEL,0 , 0, 0);
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,"Bilgi");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_CORNER,CORNER_LEFT_LOWER );
     ObjectSetString(ChartID(),LabelChart, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_COLOR, clrWhite);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 8);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_XDISTANCE, 15);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_YDISTANCE, 60); 
     
     
     LabelChart="Bilgis";
     ObjectDelete(ChartID(),LabelChart);
     ObjectCreate(ChartID(),LabelChart, OBJ_LABEL,0 , 0, 0);
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,"Bilgis");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_CORNER,CORNER_LEFT_LOWER );
     ObjectSetString(ChartID(),LabelChart, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_COLOR, clrWhite);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 8);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_XDISTANCE, 15);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_YDISTANCE, 90);   
     
     
       
   
  
    

  if ( Symbol() == "XAUUSD" || Symbol() == "GOLDm#" || StringFind(Symbol(),"GOLD",0) != -1  ) Lot=0.01;
  
  if ( MarketInfo(Symbol(),MODE_MINLOT) == 0.10 ) Lot=Lot*10;
  
    AvarageSystem(magic);
  
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


if ( OrdersTotal() != OrderTotal ) {
AlertOrder();
OrderTotal=OrdersTotal();
AvarageSystem(magic);
}


if ( AccountMargin() != margin ) {
AlertOrder();
margin=AccountMargin();
}





if ( OrdersHistoryTotal() != OrderHisTotal ) {
AlertHisOrder();
OrderHisTotal=OrdersHistoryTotal();
}


//Comment("OrderTotalProfit(",OrderTotalProfit());

     string  LabelChart="Bilgi";
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,"Profit:"+OrderTotalProfit()+"$");
     


     SessionLondonEq();
     
   int london_fark = 0;
   
   if ( Bid > london_eq ) london_fark=(Bid-london_eq)/Point;
   if ( Bid < london_eq ) london_fark=(london_eq-Bid)/Point;
   
   //Comment("LondonEq:",DoubleToString(london_eq,Digits),"/ Fark:",int(london_fark));     
     
   if ( iOpen(Symbol(),PERIOD_M1,0) < london_eq && iHigh(Symbol(),PERIOD_M1,0) >= london_eq && london_alert == false ) {
   Alert(Symbol()+" LondonEq");
   london_alert=true;
   }
   
   if ( iOpen(Symbol(),PERIOD_M1,0) > london_eq && iLow(Symbol(),PERIOD_M1,0) <= london_eq && london_alert == false ) {
   Alert(Symbol()+" LondonEq");
   london_alert=true;
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

int OrderDeleteLine=0;
int OrderDeleteBuyLine=0;
int OrderDeleteSellLine=0;

void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//---

//Print(sparam);



if ( sparam == 30 ) {

     int cevap=MessageBox("Accounting Symbol","Bulk Calculation",4); 
     if ( cevap == 6 ) {
     Accounting();
     } else {
     BulkCalculation();
     }


}



  if ( sparam == 19 ) { 
  
           
   for(int cnt=0; cnt<OrdersHistoryTotal(); cnt++)
   {
         OrderSelect(cnt,SELECT_BY_POS, MODE_HISTORY);
         
         if ( //TimeDay(OrderCloseTime()) == TimeDay(TimeCurrent()) &&
          OrderSymbol() == Symbol() ) {
         
         ObjectCreate(ChartID(),OrderTicket(),OBJ_TREND,0,OrderOpenTime(),OrderOpenPrice(),OrderCloseTime(),OrderClosePrice());
         ObjectSetInteger(ChartID(),OrderTicket(),OBJPROP_RAY,false);
         ObjectSetInteger(ChartID(),OrderTicket(),OBJPROP_BACK,false);
         ObjectSetInteger(ChartID(),OrderTicket(),OBJPROP_STYLE,STYLE_DOT);
         if ( OrderProfit() > 0 ) ObjectSetInteger(ChartID(),OrderTicket(),OBJPROP_COLOR,clrLimeGreen);
         if ( OrderProfit() < 0 ) ObjectSetInteger(ChartID(),OrderTicket(),OBJPROP_COLOR,clrCrimson);
   
         Print(OrderSymbol());
         
         if ( ChartGetInteger(ChartID(),CHART_SHOW_TRADE_LEVELS) ) {
         ObjectDelete(ChartID(),OrderTicket());
         }
         

         if ( OrderType() == OP_BUY ) ObjectCreate(ChartID(),OrderTicket()+"b",OBJ_ARROW_BUY,0,OrderOpenTime(),OrderOpenPrice(),OrderCloseTime(),OrderClosePrice());
         if ( OrderType() == OP_SELL ) ObjectCreate(ChartID(),OrderTicket()+"s",OBJ_ARROW_SELL,0,OrderOpenTime(),OrderOpenPrice(),OrderCloseTime(),OrderClosePrice());
         //ObjectSetInteger(ChartID(),OrderTicket(),OBJPROP_RAY,false);
         //ObjectSetInteger(ChartID(),OrderTicket(),OBJPROP_BACK,false);
         //ObjectSetInteger(ChartID(),OrderTicket(),OBJPROP_STYLE,STYLE_DOT);
         //if ( OrderProfit() > 0 ) ObjectSetInteger(ChartID(),OrderTicket(),OBJPROP_COLOR,clrLimeGreen);
         //if ( OrderProfit() < 0 ) ObjectSetInteger(ChartID(),OrderTicket(),OBJPROP_COLOR,clrCrimson);
   

         
         if ( ChartGetInteger(ChartID(),CHART_SHOW_TRADE_LEVELS) ) {
         ObjectDelete(ChartID(),OrderTicket()+"b");
         ObjectDelete(ChartID(),OrderTicket()+"s");
         }         
         
         

         if ( OrderType() == OP_BUY ) ObjectCreate(ChartID(),OrderTicket()+"be",OBJ_ARROW_BUY,0,OrderCloseTime(),OrderClosePrice());
         if ( OrderType() == OP_SELL ) ObjectCreate(ChartID(),OrderTicket()+"se",OBJ_ARROW_SELL,0,OrderCloseTime(),OrderClosePrice());
         //ObjectSetInteger(ChartID(),OrderTicket(),OBJPROP_RAY,false);
         //ObjectSetInteger(ChartID(),OrderTicket(),OBJPROP_BACK,false);
         //ObjectSetInteger(ChartID(),OrderTicket(),OBJPROP_STYLE,STYLE_DOT);
         //if ( OrderProfit() > 0 ) ObjectSetInteger(ChartID(),OrderTicket(),OBJPROP_COLOR,clrLimeGreen);
         //if ( OrderProfit() < 0 ) ObjectSetInteger(ChartID(),OrderTicket(),OBJPROP_COLOR,clrCrimson);
   

         
         if ( ChartGetInteger(ChartID(),CHART_SHOW_TRADE_LEVELS) ) {
         ObjectDelete(ChartID(),OrderTicket()+"be");
         ObjectDelete(ChartID(),OrderTicket()+"se");
         }              
         
         
         
         
         
         
         }
                  
         }  
  
  
  // r
  /*if ( ChartGetInteger(ChartID(),CHART_SHOW_TRADE_HISTORY) ) { 
  ChartSetInteger(ChartID(),CHART_SHOW_TRADE_HISTORY,false);
  } else { 
  ChartSetInteger(ChartID(),CHART_SHOW_TRADE_HISTORY,true);
  }*/
  
  if ( ChartGetInteger(ChartID(),CHART_SHOW_TRADE_LEVELS) ) { 
  ChartSetInteger(ChartID(),CHART_SHOW_TRADE_LEVELS,false);
  } else { 
  ChartSetInteger(ChartID(),CHART_SHOW_TRADE_LEVELS,true);
  }
  
    
    
    ChartRedraw(ChartID());
    
    
  }    
  
  
   
   if ( sparam == 34 ) {
   /*
   int ticket_buy=OrderSend(Symbol(),OP_BUY,Lot,Ask,0,0,0,"CasperBuy",magic,0,clrNONE);
   int ticket_sell=OrderSend(Symbol(),OP_SELL,Lot,Bid,0,0,0,"CasperSell",magic,0,clrNONE);*/

   int ticket_buy=OrderSend(Symbol(),OP_BUY,Lot,Ask,0,0,0,"CasperBuy",magic,0,clrNONE);
   string cmt="CasperSell"+ticket_buy;
   int ticket_sell=OrderSend(Symbol(),OP_SELL,Lot,Bid,0,0,0,cmt,magic,0,clrNONE);
      
   
   }
   
   //Print("Sparam",sparam);
   /*
   if ( ObjectGetString(ChartID(),sparam,OBJPROP_TOOLTIP) == "TOKYO EQ" ) {
   OrderDeleteLine=OrderDeleteLine+1;
   Print("OrderDelete Click",OrderDeleteLine);
   if ( OrderDeleteLine == 3 ) {   
   OrderDeleteLine=0;
   Print("OrderDelete Complate");
   }

   }*/


/////////////////////////////////////////////////////////   
int indexof100=StringFind(sparam,"Levelu100",0);
int indexof000=StringFind(sparam,"Leveld000",0);

if ( indexof000 != -1 ) {
OrderDeleteBuyLine=OrderDeleteBuyLine+1;
Comment("Delete Buy Line:",OrderDeleteBuyLine);
if ( OrderDeleteBuyLine == 3 ) {   
   OrderDeleteBuyLine=0;
CloseOrders("",OP_BUY);
}

}


if ( indexof100 != -1 ) {
OrderDeleteSellLine=OrderDeleteSellLine+1;
Comment("Delete Sell Line:",OrderDeleteSellLine);
if ( OrderDeleteSellLine == 3 ) {   
   OrderDeleteSellLine=0;
CloseOrders("",OP_SELL);
}
}
////////////////////////////////////////////////////////


   
   
//////////////////////////////////////////////////////////////////   
int indexof=StringFind(sparam,"OrderClose",0);

if ( indexof != -1 ) {


string obj_tool=ObjectGetString(ChartID(),sparam,OBJPROP_TOOLTIP,0);

if ( StringFind(obj_tool,"CasperSell",0) != -1 ) {
//Alert(obj_tool);
CasperClose(obj_tool);
return;
}


string bilgi=sparam;

int rplc=StringReplace(bilgi,"OrderClose","");

int bilgint=StringToInteger(bilgi);

if(OrderSelect(bilgint, SELECT_BY_TICKET)==true)
    {
    if ( OrderType() > 1 ) {LiveOrderClose(bilgint);
    return;
    }
    }

     int cevap=MessageBox("İşlem Kapatmak",bilgint,4); 
     if ( cevap == 6 ) {
LiveOrderClose(bilgint);
}

//"OrderClose"+OrderTicket(); 

}   
///////////////////////////////////////////////////////////////

   
   
   
   
   if ( sparam == 16 ) {
   
     int cevap=MessageBox("Buy Live","Buy islem Acmak",4); 
     if ( cevap == 6 )int ticket=OrderSend(sym,OP_BUY,Lot,Ask,0,0,0,"MANUEL",magic,0,clrNONE);
   
   
   }
   

   if ( sparam == 17 ) {
   int cevap=MessageBox("Sell Live","Sell islem Acmak",4); 
   if ( cevap == 6 )int ticket=OrderSend(sym,OP_SELL,Lot,Bid,0,0,0,"MANUEL",magic,0,clrNONE);
   
   
   }
   

if ( sparam == 25 ) {

CloseAllPenOrders(sym);

}   
  

if ( sparam == 48  ) {

int cevap=MessageBox("Buy Limit","Buy islem kapatmak",4); 
if ( cevap == 6 ) { 
CloseAllPenOrdersTyp(sym,OP_BUYLIMIT);
CloseAllPenOrdersTyp(sym,OP_SELLSTOP);
}
}   
  
   
if ( sparam == 31 ) {
int cevap=MessageBox("Sell Limit","Sell islem kapatmak",4); 
if ( cevap == 6 ) { 
CloseAllPenOrdersTyp(sym,OP_SELLLIMIT);
CloseAllPenOrdersTyp(sym,OP_BUYSTOP);
}
}   
  
      

if ( sparam == 20 ) { // T
ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_M1);
peri=PERIOD_M1;
per=PERIOD_M1;
SessionOrder("Cdbr");
//int cevap=MessageBox("Cdbr Level","Cdbr Session",4); 
int cevap=MessageBox("Tokyo Level","Tokyo Session",4); 
if ( cevap == 6 ) { 
SessionOrder("Tokyo");
}
}
   
   
   
  }
//+------------------------------------------------------------------+
void CloseAllPenOrders(string sym)
{
   for (int m=OrdersTotal(); m>=0; m--)
   {
      if ( OrderSelect(m, SELECT_BY_POS))
      {
         if(OrderType() > 1 && OrderSymbol() == sym && OrderMagicNumber() == magic )
         {
            RefreshRates();
            bool success = OrderDelete(OrderTicket(),clrNONE);
         }
      }
    }
}


void CloseAllPenOrdersTyp(string sym,int ord_typ)
{
   for (int m=OrdersTotal(); m>=0; m--)
   {
      if ( OrderSelect(m, SELECT_BY_POS))
      {
         if(OrderType() == ord_typ && OrderSymbol() == sym && OrderMagicNumber() == magic )
         {
            RefreshRates();
            bool success = OrderDelete(OrderTicket(),clrNONE);
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

void CloseOrders(string cmt,int ord_type)
{
   for (int m=OrdersTotal(); m>=0; m--)
   {
      if ( OrderSelect(m, SELECT_BY_POS))
      {
         if( (( cmt !="" && StringFind(OrderComment(),cmt,0) != -1 ) || cmt == "" ) &&   OrderType() == ord_type && OrderSymbol() == Symbol() //&& OrderMagicNumber() == magicbuy
         )
         {
            RefreshRates();
            bool success = OrderClose(OrderTicket(), OrderLots(), Bid, 0, Blue);
         }
      }
    }
}


/////////////////////////////////////////////////////////////////////////////////  
void AlertHisOrder() {

//////////////////////////////////////////////////////////////////
   string txt,kurses;
   double OCP;
   int i=OrdersHistoryTotal()-1;
   string cmt = "";
   
   int mgc=-1;
   
   if(OrderSelect(i,SELECT_BY_POS,MODE_HISTORY)==true)
   {      

//if ( OrderComment() == "robot" && OrderProfit() > 0 ) MonitorScreen_Closed = true;

   
                                  
      //OCP=OrderClosePrice();
      //if (OCP==OrderStopLoss()) txt="SL";
      //if (OCP==OrderTakeProfit()) txt="TP";
      //if (OCP!=OrderTakeProfit() && OCP!=OrderStopLoss() ) txt="CLS";&& StringFind(OrderComment(),"[tp]",0) != -1
      
      
      if ( OrderType() < 1 && OrderProfit() > 0 && OrderMagicNumber() == magic  && OrderSymbol() == sym ) {

      //cmt = OrderComment();
      
      mgc=OrderMagicNumber();
      
             //OneLotComment = "OneLot-Guard-"+OneLotComment;
      //ClosePendingTradesCommentSym(OneLotComment,OrderSymbol());
      
      //Comment(cmt);
      
      }
      
      
}      
////////////////////////////////////////////////////////////////////

//( OrderType() == OP_BUYLIMIT || OrderType() == OP_SELLLIMIT )
   for (int m=OrdersTotal(); m>=0; m--)
   {
      if ( OrderSelect(m, SELECT_BY_POS))
      {
         if( OrderType() > 1  && OrderSymbol() == sym && OrderMagicNumber() == mgc   )
         {
            RefreshRates();
            //string cmt=OrderComment();
            //int ticket=StringToInteger(cmt);
            bool success = OrderDelete(OrderTicket(),clrNONE);
            //success = OrderDelete(OrderTicket(),clrNONE);
         }
      }
    }



}

///////////////////////////////////////////////////////////////////////  
// PROFIT  
/////////////////////////////////////////////////////////////////////// 
double OrderTotalProfit(//int typ
)
{

double profits=0;



//if ( Orders < OrdersTotal() ) {

   string txt;
   double OCP;
   //int TYP;
   int ii=OrdersTotal()-1;
          for(int i=0; i<OrdersTotal(); i++) {
        if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) {

//OrderType() == typ && 
    if ( OrderSymbol() == Symbol() //&& OrderMagicNumber() == magic 
    ) {      
    profits=profits+OrderProfit();    
    //if ( OrderProfit() > 0 ) profits=profits+OrderProfit();
    //if ( OrderProfit() < 0 ) profits=profits-OrderProfit();
    
    
    }

  
              
   }
   
}

return profits;

}




void SessionOrder(string sname) {


MidnightOpen();



if ( sname=="Cdbr" ) {


//Alert("Tokyo");


//if ( (int(TimeHour(Timei(1))) == 11  && int(TimeMinute(Timei(1))) == 0 && tokyo_end == false) || (int(TimeHour(Timei(1))) > 11  &&  tokyo_end == false)  ) {

//Alert("Tokyo2");

int buy_total=OrderCommetssType("",sym,OP_BUY);
int sell_total=OrderCommetssType("",sym,OP_SELL);

int buy_limit_total=OrderCommetlive("d886ny",sym,OP_BUYLIMIT,magic);
int sell_limit_total=OrderCommetlive("u886ny",sym,OP_BUYLIMIT,magic);

buy_total=buy_total+buy_limit_total;
sell_total=sell_total+sell_limit_total;



//Alert(int(int(TimeDay(TimeCurrent()))-1));

  

/*
  //string yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 02:00";
  //string yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 09:00";
  string   yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+int(int(TimeDay(TimeCurrent()))-1)+" 21:00"; 
  if ( StringFind(AccountCompany(),"Robo",0) == -1 ) yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+int(int(TimeDay(TimeCurrent()))-1)+" 22:00";
  datetime some_time = StringToTime(yenitarih);
  
  ty_start_time=some_time;


  //yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 11:00";
  //yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 15:25";
  //yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 16:25";  // tr
   yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 03:00";
  if ( StringFind(AccountCompany(),"Robo",0) == -1 ) yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 04:00";
  some_time = StringToTime(yenitarih);*/
  

  //string yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 02:00";
  //string yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 09:00";
  string   yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+int(int(TimeDay(TimeCurrent()))-1)+" 21:00"; 
  if ( StringFind(AccountCompany(),"Robo",0) == -1 ) yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+int(int(TimeDay(TimeCurrent()))-1)+" 21:00";
  datetime some_time = StringToTime(yenitarih);
  
  ty_start_time=some_time;


  //yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 11:00";
  //yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 15:25";
  //yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 16:25";  // tr
   yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 12:00";
  if ( StringFind(AccountCompany(),"Robo",0) == -1 ) yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 12:00";
  some_time = StringToTime(yenitarih);
  
    
  
  
  if ( Time[0] < some_time ) some_time=Time[0];
  

  int ty_end_shift=iBarShift(sym,per,some_time);


   ty_end_time=Timei(ty_end_shift);
   //ty_end_time=Timei(1);

   string name="CDBR-END-"+Timei(ty_end_shift);
   ObjectCreate(ChartID(),name,OBJ_VLINE,0,Timei(ty_end_shift),Highi(ty_end_shift));
   //ObjectCreate(ChartID(),name,OBJ_VLINE,0,Timei(1),Highi(1));
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,true);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
   //ObjectSetString(ChartID(),name,OBJPROP_TEXT,"Fark Oran:"+fark_oran);
   
   
   
  //yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 11:00";
  yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 17:00";
  some_time = StringToTime(yenitarih);
  
  datetime ty_order_time=some_time;
  
  
   name="CDBR-ORDER-"+Timei(ty_end_shift);
   ObjectCreate(ChartID(),name,OBJ_VLINE,0,ty_order_time,Ask);
   //ObjectCreate(ChartID(),name,OBJ_VLINE,0,Timei(1),Highi(1));
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,true);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
   //ObjectSetString(ChartID(),name,OBJPROP_TEXT,"Fark Oran:"+fark_oran);
   
        

   
   tokyo_end=true;


 int shift=iBarShift(sym,per,ty_start_time);
   
   double low_price=1000000;
   double high_price=-1;
   
   int Trend_Screen_High_Shift;
   int Trend_Screen_Low_Shift;
   
   //for(int s=shift;s>0;s--) {
   for(int s=shift;s>=ty_end_shift;s--) {
   
      
   if ( Lowi(s) < low_price ) {
   Trend_Screen_Low_Shift=s;
   low_price=Lowi(s);
   }
   
   if ( Highi(s) > high_price ) {
   Trend_Screen_High_Shift=s;
   high_price=Highi(s);
   }
      
   
   
   }





   yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 06:30";
  if ( StringFind(AccountCompany(),"Robo",0) == -1 ) yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 06:30";
  some_time = StringToTime(yenitarih);
  
  name="CdbrSessionFinish"+Timei(1);
  ObjectCreate(ChartID(),name,OBJ_VLINE,0,some_time,Ask);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrRed);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,"Cdbr Finish");
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);  


   name="CdbrSession"+Timei(1);
   ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,ty_start_time,high_price,ty_end_time,low_price);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,"Cdbr");
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
   ObjectSetInteger(ChartID(),name,OBJPROP_FILL,false);

/*
   
for ( int t=1;t<5;t++) {



   double yuzde = DivZero(high_price-low_price, 100);
      
   double eq=(low_price+((high_price-low_price)*t))+(((high_price-low_price))+yuzde*50); // 50
   

   name="CdbrSessionHigh"+t;
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,ty_start_time,high_price+((high_price-low_price)*t),ty_end_time,low_price+((high_price-low_price)*t));
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,"Cbdr High "+t);
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
   ObjectSetInteger(ChartID(),name,OBJPROP_FILL,false);
   if ( t > 3 ) ObjectDelete(ChartID(),name);

  name="CdbrLevelHigh"+t;
  double level;   
  string levels; 
  ObjectDelete(ChartID(),name+"Eq");
  ObjectCreate(ChartID(),name+"Eq",OBJ_TREND,0,ty_start_time,eq,ty_end_time,eq);
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_COLOR,clrLightGray);   
  ObjectSetString(ChartID(),name+"Eq",OBJPROP_TOOLTIP,"Cbdr EQ "+t);   
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_STYLE,STYLE_DOT);   
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_WIDTH,1); 
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_ZORDER,1);  
  if ( t >= 3 ) ObjectDelete(ChartID(),name+"Eq");

   
      
   eq=(low_price-((high_price-low_price)*t))+(((high_price-low_price))+yuzde*50); // 50
   
     
   
   name="CdbrSessionLow"+t;
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,ty_start_time,high_price-((high_price-low_price)*t),ty_end_time,low_price-((high_price-low_price)*t));
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,"Cbdr Low"+t);
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
   ObjectSetInteger(ChartID(),name,OBJPROP_FILL,false);
   if ( t == 4 ) ObjectDelete(ChartID(),name);

  name="CdbrLevelLow"+t;
  level;   
  levels; 
  ObjectDelete(ChartID(),name+"Eq");
  ObjectCreate(ChartID(),name+"Eq",OBJ_TREND,0,ty_start_time,eq,ty_end_time,eq);
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_COLOR,clrLightGray);   
  ObjectSetString(ChartID(),name+"Eq",OBJPROP_TOOLTIP,"Cbdr EQ "+t);   
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_STYLE,STYLE_DOT);   
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_WIDTH,1); 
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_ZORDER,1);  
  
  
  
}
      
 */     
   
   /*
if ( MarketInfo(sym,MODE_ASK) <= high_price && MarketInfo(sym,MODE_BID) >= low_price ) {
//Alanın İçi 
} else {
//Alanın Dışı
tokyo_end=true;
return;
}*/
   
   
   
   

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


/////////////////////////////////////////////////////////     
   bool sell_order=false;
   bool buy_order=false;
   if ( high_price - Bid < Bid- low_price ) {
   sell_order=true;
   buy_order=false;
   buy_total=1;
   } else {
   buy_order=true;
   sell_order=false;   
   sell_total=1;
   }
////////////////////////////////////////////////////   
   
   buy_total=1;
   sell_total=1;
        
   

  name="CdbrLevel"+Timei(1);
  double level;   
  string levels; 
  ObjectDelete(ChartID(),name+"Eq");
  ObjectCreate(ChartID(),name+"Eq",OBJ_TREND,0,ty_start_time,eq,ty_end_time,eq);
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_COLOR,clrLightGray);   
  ObjectSetString(ChartID(),name+"Eq",OBJPROP_TOOLTIP,"TOKYO EQ");   
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_STYLE,STYLE_DOT);   
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_WIDTH,4); 
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_ZORDER,1);  
  
  
  ObjectDelete(ChartID(),name+"Eqs");
  ObjectCreate(ChartID(),name+"Eqs",OBJ_TREND,0,ty_start_time,eq,ty_end_time,eq);
  ObjectSetInteger(ChartID(),name+"Eqs",OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Eqs",OBJPROP_COLOR,clrDarkBlue); 
  ObjectSetInteger(ChartID(),name+"Eqs",OBJPROP_ZORDER,2);  
  ObjectSetString(ChartID(),name+"Eqs",OBJPROP_TOOLTIP,"TOKYO EQ");   
  ObjectSetInteger(ChartID(),name+"Eqs",OBJPROP_STYLE,STYLE_DOT);   
  ObjectSetInteger(ChartID(),name+"Eqs",OBJPROP_WIDTH,2);
  
   

  level=level45;
  levels="45";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,level,ty_end_time,level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrDarkGray);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);
     
   
  level=level55;
  levels="55";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,level,ty_end_time,level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrDarkGray);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);
  
 level=level79;
  levels="79";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,level,ty_end_time,level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrDarkGray);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);
    
 level=level70;
  levels="70";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,level,ty_end_time,level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrDarkGray);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);

 level=level21;
  levels="21";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,level,ty_end_time,level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrDarkGray);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);

 level=level30;
  levels="30";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,level,ty_end_time,level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrDarkGray);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);         


  int ticket;
  double price;



  level=level0;
  levels="u100cdbr";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_end_time,high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrLightBlue);
  
  price=NormalizeDouble(high_price+level,MarketInfo(sym,MODE_DIGITS));
  if ( sell_total == 0 ) ticket=OrderSend(sym,OP_SELLLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);
  
    

  level=level168;
  levels="u168cdbr";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_end_time,high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrLightBlue);
  
  price=NormalizeDouble(high_price+level,MarketInfo(sym,MODE_DIGITS));
  if ( sell_total == 0 ) ticket=OrderSend(sym,OP_SELLLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);
  
     
  level=level130;
  levels="u130cdbr";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_end_time,high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrLightBlue);
   /*
  price=NormalizeDouble(high_price+level,MarketInfo(sym,MODE_DIGITS));
  //if ( (high_price-MarketInfo(sym,MODE_ASK))/MarketInfo(sym,MODE_POINT) > 5 )
  if ( (high_price-MarketInfo(sym,MODE_ASK)) > MarketInfo(sym,MODE_ASK)-MarketInfo(sym,MODE_BID) )  price=NormalizeDouble(high_price,MarketInfo(sym,MODE_DIGITS));
  if ( sell_total == 0 ) ticket=OrderSend(sym,OP_SELLLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);*/


  level=level272;
  levels="u272cdbr";  
        
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_end_time,high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrLightBlue);

  price=NormalizeDouble(high_price+level,MarketInfo(sym,MODE_DIGITS));
  if ( sell_total == 0 ) ticket=OrderSend(sym,OP_SELLLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);
  
  double price272=price;  
  level=level414;
  levels="u414cdbr";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_end_time,high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrLightBlue);
     
  price=NormalizeDouble(high_price+level,MarketInfo(sym,MODE_DIGITS));
  if ( sell_total == 0 )  ticket=OrderSend(sym,OP_SELLLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);
  double price414=price;



////////////////////////////////////////////////////////////////////////////////////////////////////////////
  level=level618;
  levels="u618";   
        
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_end_time,high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrLightBlue);

  price=NormalizeDouble(high_price+level,MarketInfo(sym,MODE_DIGITS));
  if ( sell_total == 0 ) ticket=OrderSend(sym,OP_SELLLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);
  
  level=level886;
  levels="u886cdbr";
        
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_end_time,high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrLightBlue);

  price=NormalizeDouble(high_price+level,MarketInfo(sym,MODE_DIGITS));
  if ( sell_total == 0 ) ticket=OrderSend(sym,OP_SELLLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);
  
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////  




  double pips=(price414-price272)*2;

   if ( sell_total == 0 ) {
   for(int i=1;i<4;i++) {
   double prices=price+(pips*i);
   if ( i <= 2 ) ticket=OrderSend(sym,OP_SELLLIMIT,Lot,prices,0,0,0,"Mrtcdbr"+i,magic,0,clrNONE);
   ///if ( i >= 3 ) ticket=OrderSend(sym,OP_BUYSTOP,Lot*12,prices,0,0,0,"Mrt"+i,magic,0,clrNONE);
   }
   }



/*
////////////////////////////////////////////////////////////////////////////////////////////////////////
  level=level0;
  levels="d00";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);


  price=NormalizeDouble(low_price-level,MarketInfo(sym,MODE_DIGITS));
  if ( buy_total == 0 ) ticket=OrderSend(sym,OP_BUYLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);
  
  
  level=level100;
  levels="u100";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);


  price=NormalizeDouble(low_price-level,MarketInfo(sym,MODE_DIGITS));
  if ( buy_total == 0 ) ticket=OrderSend(sym,OP_BUYLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////  
*/  
  


  level=level0;
  levels="d000cdbr";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrLightBlue);


  price=NormalizeDouble(low_price-level,MarketInfo(sym,MODE_DIGITS));
  if ( buy_total == 0 ) ticket=OrderSend(sym,OP_BUYLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);
  
  

  level=level168;
  levels="d168cdbr";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrLightBlue);


  price=NormalizeDouble(low_price-level,MarketInfo(sym,MODE_DIGITS));
  if ( buy_total == 0 ) ticket=OrderSend(sym,OP_BUYLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);
     
  level=level130;
  levels="d130cdbr";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrLightBlue);
/*
  price=NormalizeDouble(low_price-level,MarketInfo(sym,MODE_DIGITS));
  //if ( (MarketInfo(sym,MODE_BID)-low_price)/MarketInfo(sym,MODE_POINT) > 5 ) price=NormalizeDouble(low_price,MarketInfo(sym,MODE_DIGITS));
  if ( (MarketInfo(sym,MODE_BID)-low_price) > MarketInfo(sym,MODE_ASK)-MarketInfo(sym,MODE_BID) ) price=NormalizeDouble(low_price,MarketInfo(sym,MODE_DIGITS));
    
  if ( buy_total == 0 ) ticket=OrderSend(sym,OP_BUYLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);*/

  level=level272;
  levels="d272cdbr";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrLightBlue);
  
  price=NormalizeDouble(low_price-level,MarketInfo(sym,MODE_DIGITS));
  if ( buy_total == 0 ) ticket=OrderSend(sym,OP_BUYLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);
  price272=price; 
    
  level=level414;
  levels="d414cdbr";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrLightBlue);     

  price=NormalizeDouble(low_price-level,MarketInfo(sym,MODE_DIGITS));
  if ( buy_total == 0 ) ticket=OrderSend(sym,OP_BUYLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);
  price414=price;



////////////////////////////////////////////////////////////////////////////////////////////////////////////
  level=level618;
  levels="d618ny";  
        
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrLightBlue);
  
  price=NormalizeDouble(low_price-level,MarketInfo(sym,MODE_DIGITS));
  if ( buy_total == 0 ) ticket=OrderSend(sym,OP_BUYLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);
  
  level=level886;
  levels="d886cdbr";    
    
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrLightBlue);
  
  price=NormalizeDouble(low_price-level,MarketInfo(sym,MODE_DIGITS));
  if ( buy_total == 0 ) ticket=OrderSend(sym,OP_BUYLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);
///////////////////////////////////////////////////////////////////////////////////////////////////////////   





  pips=(price272-price414)*2;

if ( buy_total == 0 )  {
   for(int i=1;i<4;i++) {
   double prices=price-(pips*i);
   if ( i <= 2 ) ticket=OrderSend(sym,OP_BUYLIMIT,Lot,prices,0,0,0,"Mrtcdbr"+i,magic,0,clrNONE);
   ///if ( i >= 3 ) ticket=OrderSend(sym,OP_SELLSTOP,Lot*12,prices,0,0,0,"Mrt"+i,magic,0,clrNONE);
   }
}   
   
   
   



   
//}



}



if ( sname=="Tokyo" ) {

//Alert("Tokyo");


//if ( (int(TimeHour(Timei(1))) == 11  && int(TimeMinute(Timei(1))) == 0 && tokyo_end == false) || (int(TimeHour(Timei(1))) > 11  &&  tokyo_end == false)  ) {

//Alert("Tokyo2");

int buy_total=OrderCommetssType("",sym,OP_BUY);
int sell_total=OrderCommetssType("",sym,OP_SELL);

int buy_limit_total=OrderCommetlive("d886",sym,OP_BUYLIMIT,magic);
int sell_limit_total=OrderCommetlive("u886",sym,OP_BUYLIMIT,magic);

buy_total=buy_total+buy_limit_total;
sell_total=sell_total+sell_limit_total;



  //string yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 02:00";
  string yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 03:00";
  if ( StringFind(AccountCompany(),"Robo",0) != -1 ) yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 03:00";
  datetime some_time = StringToTime(yenitarih);
  
  ty_start_time=some_time;


  ///yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 11:00";
  yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 12:00";
  if ( StringFind(AccountCompany(),"Robo",0) != -1 ) yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 12:00";
  some_time = StringToTime(yenitarih);
  
  if ( Time[0] < some_time ) some_time=Time[0];
  

  int ty_end_shift=iBarShift(sym,per,some_time);


   ty_end_time=Timei(ty_end_shift);
   //ty_end_time=Timei(1);

   string name="TOKYO-END-"+Timei(ty_end_shift);
   ObjectCreate(ChartID(),name,OBJ_VLINE,0,Timei(ty_end_shift),Highi(ty_end_shift));
   //ObjectCreate(ChartID(),name,OBJ_VLINE,0,Timei(1),Highi(1));
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,true);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
   //ObjectSetString(ChartID(),name,OBJPROP_TEXT,"Fark Oran:"+fark_oran);

   
   tokyo_end=true;


 int shift=iBarShift(sym,per,ty_start_time);
   
   double low_price=1000000;
   double high_price=-1;
   
   int Trend_Screen_High_Shift;
   int Trend_Screen_Low_Shift;
   
   //for(int s=shift;s>0;s--) {
   for(int s=shift;s>=ty_end_shift;s--) {
   
      
   if ( Lowi(s) < low_price ) {
   Trend_Screen_Low_Shift=s;
   low_price=Lowi(s);
   }
   
   if ( Highi(s) > high_price ) {
   Trend_Screen_High_Shift=s;
   high_price=Highi(s);
   }
      
   
   
   }






   name="TokyoSession"+Timei(1);
   ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,ty_start_time,high_price,ty_end_time,low_price);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,"TOKYO");
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);
   ObjectSetInteger(ChartID(),name,OBJPROP_FILL,false);
   
   
   /*
if ( MarketInfo(sym,MODE_ASK) <= high_price && MarketInfo(sym,MODE_BID) >= low_price ) {
//Alanın İçi 
} else {
//Alanın Dışı
tokyo_end=true;
return;
}*/
   
   
   
   

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
      double level382=yuzde*38.2; // 38.2
   
   double level0=0;
   double level100=0; 
     
/////////////////////////////////////////////////////////     
   bool sell_order=false;
   bool buy_order=false;
   if ( high_price - Bid < Bid- low_price ) {
   sell_order=true;
   buy_order=false;
   } else {
   buy_order=true;
   sell_order=false;   
   }
////////////////////////////////////////////////////   
   
   

  name="TokyoLevel"+Timei(1);
  double level;   
  string levels; 
  ObjectDelete(ChartID(),name+"Eq");
  ObjectCreate(ChartID(),name+"Eq",OBJ_TREND,0,ty_start_time,eq,ty_end_time,eq);
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_COLOR,clrLightGray);   
  ObjectSetString(ChartID(),name+"Eq",OBJPROP_TOOLTIP,"TOKYO EQ");   
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_STYLE,STYLE_DOT);   
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_WIDTH,4); 
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_ZORDER,1);  
  
  
  ObjectDelete(ChartID(),name+"Eqs");
  ObjectCreate(ChartID(),name+"Eqs",OBJ_TREND,0,ty_start_time,eq,ty_end_time,eq);
  ObjectSetInteger(ChartID(),name+"Eqs",OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Eqs",OBJPROP_COLOR,clrDarkBlue); 
  ObjectSetInteger(ChartID(),name+"Eqs",OBJPROP_ZORDER,2);  
  ObjectSetString(ChartID(),name+"Eqs",OBJPROP_TOOLTIP,"TOKYO EQ");   
  ObjectSetInteger(ChartID(),name+"Eqs",OBJPROP_STYLE,STYLE_DOT);   
  ObjectSetInteger(ChartID(),name+"Eqs",OBJPROP_WIDTH,2);
  
   

  level=level45;
  levels="45";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,level,ty_end_time,level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrDarkGray);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);
     
   
  level=level55;
  levels="55";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,level,ty_end_time,level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrDarkGray);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);
  
 level=level79;
  levels="79";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,level,ty_end_time,level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrDarkGray);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);
    
 level=level70;
  levels="70";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,level,ty_end_time,level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrDarkGray);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);

 level=level21;
  levels="21";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,level,ty_end_time,level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrDarkGray);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);

 level=level30;
  levels="30";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,level,ty_end_time,level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrDarkGray);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);         


 level=level382;
  levels="382s";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price+level,Time[0]+1000*PeriodSeconds(),low_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrWhite);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);         

 level=level618;
  levels="618s";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price+level,Time[0]+1000*PeriodSeconds(),low_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrWhite);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);  
  

  int ticket;
  double price;



  level=level100;
  levels="u100";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_end_time,high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);
  
  price=NormalizeDouble(high_price+level,MarketInfo(sym,MODE_DIGITS));
  if ( sell_total == 0 && sell_order == true ) ticket=OrderSend(sym,OP_SELLLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);
  

  level=level168;
  levels="u168";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_end_time,high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);
  
  price=NormalizeDouble(high_price+level,MarketInfo(sym,MODE_DIGITS));
  if ( sell_total == 0 && sell_order == true ) ticket=OrderSend(sym,OP_SELLLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);
  
     
  level=level130;
  levels="u130";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_end_time,high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);
   /*
  price=NormalizeDouble(high_price+level,MarketInfo(sym,MODE_DIGITS));
  //if ( (high_price-MarketInfo(sym,MODE_ASK))/MarketInfo(sym,MODE_POINT) > 5 )
  if ( (high_price-MarketInfo(sym,MODE_ASK)) > MarketInfo(sym,MODE_ASK)-MarketInfo(sym,MODE_BID) )  price=NormalizeDouble(high_price,MarketInfo(sym,MODE_DIGITS));
  if ( sell_total == 0 ) ticket=OrderSend(sym,OP_SELLLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);*/


  level=level272;
  levels="u272";  
        
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_end_time,high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);

  price=NormalizeDouble(high_price+level,MarketInfo(sym,MODE_DIGITS));
  if ( sell_total == 0 && sell_order == true ) ticket=OrderSend(sym,OP_SELLLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);
  
  double price272=price;  
  level=level414;
  levels="u414";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_end_time,high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);
     
  price=NormalizeDouble(high_price+level,MarketInfo(sym,MODE_DIGITS));
  if ( sell_total == 0 && sell_order == true )  ticket=OrderSend(sym,OP_SELLLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);
  double price414=price;



////////////////////////////////////////////////////////////////////////////////////////////////////////////
  level=level618;
  levels="u618";   
        
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_end_time,high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);

  price=NormalizeDouble(high_price+level,MarketInfo(sym,MODE_DIGITS));
  if ( sell_total == 0 && sell_order == true ) ticket=OrderSend(sym,OP_SELLLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);
  
  level=level886;
  levels="u886";
        
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_end_time,high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);

  price=NormalizeDouble(high_price+level,MarketInfo(sym,MODE_DIGITS));
  if ( sell_total == 0 && sell_order == true ) ticket=OrderSend(sym,OP_SELLLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);
  
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////  





  double pips=(price414-price272)*2;
  
  
if ( sell_total == 0 && sell_order == true ) {

   if ( sell_total == 0 ) {
   for(int i=1;i<4;i++) {
   double prices=price+(pips*i);
   if ( i <= 2 ) ticket=OrderSend(sym,OP_SELLLIMIT,Lot,prices,0,0,0,"Mrt"+i,magic,0,clrNONE);
   ///if ( i >= 3 ) ticket=OrderSend(sym,OP_BUYSTOP,Lot*12,prices,0,0,0,"Mrt"+i,magic,0,clrNONE);
   }
   }
   
}   





/*
////////////////////////////////////////////////////////////////////////////////////////////////////////
  level=level0;
  levels="d00";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);


  price=NormalizeDouble(low_price-level,MarketInfo(sym,MODE_DIGITS));
  if ( buy_total == 0 ) ticket=OrderSend(sym,OP_BUYLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);
  
  
  level=level100;
  levels="u100";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);


  price=NormalizeDouble(low_price-level,MarketInfo(sym,MODE_DIGITS));
  if ( buy_total == 0 ) ticket=OrderSend(sym,OP_BUYLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////  
*/  
  


  level=level0;
  levels="d000";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);


  price=NormalizeDouble(low_price-level,MarketInfo(sym,MODE_DIGITS));
  if ( buy_total == 0 && buy_order == true ) ticket=OrderSend(sym,OP_BUYLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);
  
  
  

  level=level168;
  levels="d168";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);


  price=NormalizeDouble(low_price-level,MarketInfo(sym,MODE_DIGITS));
  if ( buy_total == 0 && buy_order == true ) ticket=OrderSend(sym,OP_BUYLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);
     
  level=level130;
  levels="d130";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);
/*
  price=NormalizeDouble(low_price-level,MarketInfo(sym,MODE_DIGITS));
  //if ( (MarketInfo(sym,MODE_BID)-low_price)/MarketInfo(sym,MODE_POINT) > 5 ) price=NormalizeDouble(low_price,MarketInfo(sym,MODE_DIGITS));
  if ( (MarketInfo(sym,MODE_BID)-low_price) > MarketInfo(sym,MODE_ASK)-MarketInfo(sym,MODE_BID) ) price=NormalizeDouble(low_price,MarketInfo(sym,MODE_DIGITS));
    
  if ( buy_total == 0 ) ticket=OrderSend(sym,OP_BUYLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);*/

  level=level272;
  levels="d272";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);
  
  price=NormalizeDouble(low_price-level,MarketInfo(sym,MODE_DIGITS));
  if ( buy_total == 0 && buy_order == true ) ticket=OrderSend(sym,OP_BUYLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);
  price272=price; 
    
  level=level414;
  levels="d414";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);     

  price=NormalizeDouble(low_price-level,MarketInfo(sym,MODE_DIGITS));
  if ( buy_total == 0 && buy_order == true ) ticket=OrderSend(sym,OP_BUYLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);
  price414=price;



////////////////////////////////////////////////////////////////////////////////////////////////////////////
  level=level618;
  levels="d618";  
        
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);
  
  price=NormalizeDouble(low_price-level,MarketInfo(sym,MODE_DIGITS));
  if ( buy_total == 0 && buy_order == true ) ticket=OrderSend(sym,OP_BUYLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);
  
  level=level886;
  levels="d886";    
    
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);
  
  price=NormalizeDouble(low_price-level,MarketInfo(sym,MODE_DIGITS));
  if ( buy_total == 0 && buy_order == true) ticket=OrderSend(sym,OP_BUYLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);
///////////////////////////////////////////////////////////////////////////////////////////////////////////   





  pips=(price272-price414)*2;


if ( buy_total == 0 && buy_order == true )  {
   for(int i=1;i<4;i++) {
   double prices=price-(pips*i);
   if ( i <= 2 ) ticket=OrderSend(sym,OP_BUYLIMIT,Lot,prices,0,0,0,"Mrt"+i,magic,0,clrNONE);
   ///if ( i >= 3 ) ticket=OrderSend(sym,OP_SELLSTOP,Lot*12,prices,0,0,0,"Mrt"+i,magic,0,clrNONE);
   }
}   
   
   
   



   
//}



}


}


double Ortalama;
   //string sym=Symbol();
   ENUM_TIMEFRAMES per=Period();
   
   string symi=Symbol();
   ENUM_TIMEFRAMES peri=Period();   
   

double Openi(int shifti) {
return iOpen(symi,peri,shifti);
}

double Closei(int shifti) {
return iClose(symi,peri,shifti);
}

double Highi(int shifti) {
return iHigh(symi,peri,shifti);
}

double Lowi(int shifti) {
return iLow(symi,peri,shifti);
}

double Timei(int shifti) {
return iTime(symi,peri,shifti);
}


datetime ty_start_time;
datetime ty_end_time;

datetime lnd_start_time;
datetime lnd_end_time;

bool london_start=false;
bool london_end=false;
bool tokyo_start=false;
bool tokyo_end=false;

/////////////////////////////////////////////////////////////////////////////////////////
// Divide Zero Hatası için formül.
/////////////////////////////////////////////////////////////////////////////////////////
double DivZero(double n, double d)
{
if (d==0) return(0);  else return(n/d);
} 
//////////////////////////////////////////////////////////////////////} 

//////////////////////////////////////////////////
// Canli islem Sembol Kontrollu 
//////////////////////////////////////////////////
int OrderCommetssType(string cmt,string sym,int typ){
int com = 0;


//int cnt = 0;
for(int cnts=OrdersTotal()-1;cnts>=0;cnts--){

if(!OrderSelect(cnts, SELECT_BY_POS, MODE_TRADES))continue;
//Sonuna Rakam Ekledik Hangi Tutar Kazaniyor diye onun icin instr veya indexof yapip comment icinde arama yapiyoruz.
int index=StringFind(OrderComment(), cmt, 0);

//Alert(OrderType(),"/",OrderComment(),"/",cmt,"/",index);
//if ( OrderType() == OP_BUY || OrderType() == OP_SELL ) {
if ( OrderSymbol() == sym && OrderType() == typ && OrderMagicNumber() == magic ) {
com++;
}
}

return com;
};





void SessionLondonEq() {

if ( int(TimeHour(TimeCurrent())) < 10 ) return;
if ( StringFind(AccountCompany(),"Robo",0) != -1 && int(TimeHour(TimeCurrent())) < 10 ) return;

  ///string yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 18:00";
  string yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 19:00";
  if ( StringFind(AccountCompany(),"Robo",0) != -1 ) yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 19:00";
  datetime some_time = StringToTime(yenitarih);
    
  lnd_end_time=some_time;

  int lnd_end_shift=iBarShift(sym,per,some_time);
  
  
  ///yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 09:00";
  yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 10:00";
  if ( StringFind(AccountCompany(),"Robo",0) != -1 ) yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 10:00";
  some_time = StringToTime(yenitarih);
  int lnd_start_shift=iBarShift(sym,per,some_time);
  lnd_start_time=some_time;
  



////////////////////////////////////////////////////////////////////////////////////
 int shift=iBarShift(sym,per,lnd_start_time);
 
 int end_shift=0;
 
 if ( int(TimeHour(TimeCurrent())) > 18 ) end_shift=iBarShift(sym,per,lnd_end_time);
 
   
   double low_price=1000000;
   double high_price=-1;
   
   int Trend_Screen_High_Shift;
   int Trend_Screen_Low_Shift;
   
   for(int s=shift;s>=end_shift;s--) {
   
   //if ( int(TimeHour(Timei(s))) < 18 ) {
   
      
   if ( Lowi(s) < low_price ) {
   Trend_Screen_Low_Shift=s;
   low_price=Lowi(s);
   }
   
   if ( Highi(s) > high_price ) {
   Trend_Screen_High_Shift=s;
   high_price=Highi(s);
   }
      
      
  //}
   
   
   }
///////////////////////////////////////////////////////////////////////////////////


double yuzde = DivZero(high_price-low_price, 100);
   
   
   double eq=low_price+yuzde*50; // 50
   double level45=low_price+yuzde*45; // 50
   double level55=low_price+yuzde*55; // 50 
   double level382=low_price+yuzde*38.2; // 50
   double leve618=low_price+yuzde*61.8; // 50       
   

   string name="LondonSession"+lnd_start_time;
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,lnd_start_time,high_price,lnd_end_time,low_price);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGreen);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,"LONDON");
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);
   ObjectSetInteger(ChartID(),name,OBJPROP_FILL,false);
   
      
   
  name="LondonLevel"+lnd_start_time;
  double level;   
  string levels;   
  ObjectDelete(ChartID(),name+"Eq");
  ObjectCreate(ChartID(),name+"Eq",OBJ_TREND,0,lnd_start_time,eq,lnd_end_time,eq);
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_COLOR,clrLightGray);   
  ObjectSetString(ChartID(),name+"Eq",OBJPROP_TOOLTIP,"LONDON EQ");   
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_STYLE,STYLE_DOT);   
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_WIDTH,4); 
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_ZORDER,1);  
  
  ObjectDelete(ChartID(),name+"Eqs");
  ObjectCreate(ChartID(),name+"Eqs",OBJ_TREND,0,lnd_start_time,eq,lnd_end_time,eq);
  ObjectSetInteger(ChartID(),name+"Eqs",OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Eqs",OBJPROP_COLOR,clrDarkBlue); 
  ObjectSetInteger(ChartID(),name+"Eqs",OBJPROP_ZORDER,2);  
  ObjectSetString(ChartID(),name+"Eqs",OBJPROP_TOOLTIP,"LONDON EQ");   
  ObjectSetInteger(ChartID(),name+"Eqs",OBJPROP_STYLE,STYLE_DOT);   
  ObjectSetInteger(ChartID(),name+"Eqs",OBJPROP_WIDTH,2);
       

  level=level382;
  levels="382";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,lnd_start_time,level,lnd_end_time,level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrDarkGreen);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);
     
   
  level=leve618;
  levels="618";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,lnd_start_time,level,lnd_end_time,level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrDarkGreen);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);    

london_eq=eq;


}

bool free_mode=false;

 //////////////////////////////////////////////
// Bekleyen Emirlerden Olusan String Olusturur
///////////////////////////////////////////////
int OrderCommetlive(string cmt,string sym,int typ,int mgc){

int coms = 0;


if ( free_mode == true ) cmt="";



  int total = OrdersTotal();
  for(int i=total-1;i>=0;i--)
  {
    OrderSelect(i, SELECT_BY_POS);
           int type = OrderType();
    string comments = OrderComment();
    
    //Print(OrderTicket());

   //if ( ( StringFind(comments,cmt,0) != -1 ||  comments == cmt || ( free_mode==true && cmt=="") ) && OrderSymbol() == sym && type == typ && (OrderMagicNumber() == mgc || mgc == -1 )  ) {
   if ( ( StringFind(comments,cmt,0) != -1 ||  comments == cmt || ( free_mode==true && cmt=="") ) && OrderSymbol() == sym && type == typ && (OrderMagicNumber() == mgc || mgc == -1 && OrderMagicNumber() != 0 )  ) {
   
   coms = coms +1;

 }
 }
 
 //Print("Live:",coms);
 
return coms;
};


void AlertOrder() {

/////////////////////////////////////////////////////////////
   for (int bbb = ObjectsTotal() - 1; bbb >= 0; --bbb)
   {
      const string objName = ObjectName(0,bbb);
   
      //if (StringFind(objName,"autotrade") > -1)
      if (StringFind(objName,"OrderClose") > -1)
      {
         ObjectDelete(0,objName);
      }
   }
////////////////////////////////////////////////////////////   
   
int t=0;

//int cnt = 0;
for(int cnts=OrdersTotal()-1;cnts>=0;cnts--){

if(!OrderSelect(cnts, SELECT_BY_POS, MODE_TRADES))continue;

if ( OrderSymbol() != Symbol() ) continue;
//Sonuna Rakam Ekledik Hangi Tutar Kazaniyor diye onun icin instr veya indexof yapip comment icinde arama yapiyoruz.
//int index=StringFind(OrderComment(), cmt, 0);

//Alert(OrderType(),"/",OrderComment(),"/",cmt,"/",index);
///if ( OrderType() == OP_BUY || OrderType() == OP_SELL ) {
//if ( OrderSymbol() == sym && OrderType() == typ && OrderMagicNumber() == magic ) {
//com++;

int shift=iBarShift(Symbol(),Period(),OrderOpenTime());

t=t+1;

   string name="OrderClose"+OrderTicket();  
   ObjectDelete(ChartID(),name);      
   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,OrderOpenTime(),OrderOpenPrice(),OrderOpenTime()+10*PeriodSeconds(),OrderOpenPrice());
   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,OrderOpenTime()+t*PeriodSeconds(),High[shift],OrderOpenTime()+(t+1)*PeriodSeconds(),Low[shift]);
   //ObjectCreate(ChartID(),name,OBJ_TREND,0,OrderOpenTime()+t*PeriodSeconds(),OrderOpenPrice(),OrderOpenTime()+((t+1)*PeriodSeconds()),OrderOpenPrice());
   ObjectCreate(ChartID(),name,OBJ_TREND,0,OrderOpenTime(),OrderOpenPrice(),OrderOpenTime()+PeriodSeconds(),OrderOpenPrice());
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,"TOKYO");
   if ( StringFind(OrderComment(),"CasperSell",0) != -1 ) ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,OrderComment());
   if ( StringFind(OrderComment(),"CasperSell",0) != -1 ) ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLimeGreen);
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);
   ObjectSetInteger(ChartID(),name,OBJPROP_FILL,true);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
   

///}
}


}


void LiveOrderClose(int OrdTicket) {


OrderDelete(OrdTicket,clrNONE);
string name="OrderClose"+OrderTicket();  
ObjectDelete(ChartID(),name);

for(int cnts=OrdersTotal()-1;cnts>=0;cnts--){

if(!OrderSelect(cnts, SELECT_BY_POS, MODE_TRADES))continue;

if ( OrderTicket() == OrdTicket ) {
OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),0,clrNONE);

   string name="OrderClose"+OrderTicket();  
   ObjectDelete(ChartID(),name);

}

}
}
/////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////

int active_magic_buy=magic;
int active_magic_sell=magic;


double last_avarage_buy=0; 
double last_avarage_sell=0; 

double last_avarage_buy_profit_price=0;
double last_avarage_sell_profit_price=0;

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
           //if (OrderSymbol()==Symbol() && OrderMagicNumber() == mgc ) {
           if ( OrderSymbol()==Symbol() && ( OrderMagicNumber() == mgc || OrderMagicNumber() == 0) ) {
           
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

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Casper Level Order
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void CasperClose(string cmt) {


//string cmt="CasperSell";
string ordcmt="";

   for (int m=OrdersTotal(); m>=0; m--)
   {
      if ( OrderSelect(m, SELECT_BY_POS))
      {
         if( StringFind(OrderComment(),cmt,0) != -1  &&   OrderType() == OP_SELL && OrderSymbol() == Symbol() && OrderMagicNumber() == magic
         )
         {
         ordcmt=OrderComment();
         int replace=StringReplace(ordcmt,"CasperSell","");
         
         
         
            Print(OrderComment(),"=",ordcmt);
            RefreshRates();
            bool success = OrderClose(OrderTicket(), OrderLots(), OrderClosePrice(), 0, Blue);

            
         }
      }
    }
    

int ordticket=StringToInteger(ordcmt);

//Alert(ordticket);
    
    
   for (int m=OrdersTotal(); m>=0; m--)
   {
      if ( OrderSelect(m, SELECT_BY_POS))
      {
         if( OrderTicket() == ordticket &&  OrderType() == OP_BUY && OrderSymbol() == Symbol() && OrderMagicNumber() == magic
         )
         {
         //string ordcmt=OrderComment();
         //int replace=StringReplace(ordcmt,cmt,"");
         
         
         Print(OrderComment(),"=",ordcmt);
            RefreshRates();
            bool success = OrderClose(OrderTicket(), OrderLots(), OrderClosePrice(), 0, Blue);

            
         }
      }
    }
    


}



void MidnightOpen() {


  //string yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 02:00";
  string yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 07:00";
  if ( StringFind(AccountCompany(),"Robo",0) != -1 ) yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 07:00";
  datetime some_time = StringToTime(yenitarih);  
  
  int shift=iBarShift(Symbol(),PERIOD_M1,some_time);
   
   string name="MNO";
   ObjectDelete(ChartID(),name);
   //ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(Symbol(),PERIOD_M1,i),iOpen(Symbol(),PERIOD_M1,i),iTime(Symbol(),PERIOD_M1,i)+600*PeriodSeconds(PERIOD_M1),iOpen(Symbol(),PERIOD_M1,i));
   ObjectCreate(ChartID(),name,OBJ_TREND,0,some_time,iOpen(Symbol(),PERIOD_M1,shift),Time[0]+100*PeriodSeconds(),iOpen(Symbol(),PERIOD_M1,shift));
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrYellow);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,"Midnight Open");   
   //lnd_start_time=iTime(Symbol(),PERIOD_M1,i);
   //lnd_start_price=iClose(Symbol(),PERIOD_M1,i);


  //string yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 02:00";
  yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 10:00";
  if ( StringFind(AccountCompany(),"Robo",0) != -1 ) yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 10:00";
  some_time = StringToTime(yenitarih); 
  
  shift=iBarShift(Symbol(),PERIOD_M1,some_time); 
   
   name="LNDO";
   ObjectDelete(ChartID(),name);
   //ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(Symbol(),PERIOD_M1,i),iOpen(Symbol(),PERIOD_M1,i),iTime(Symbol(),PERIOD_M1,i)+600*PeriodSeconds(PERIOD_M1),iOpen(Symbol(),PERIOD_M1,i));
   ObjectCreate(ChartID(),name,OBJ_TREND,0,some_time,iOpen(Symbol(),PERIOD_M1,shift),Time[0]+100*PeriodSeconds(),iOpen(Symbol(),PERIOD_M1,shift));
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,"London Open");
   //lnd_start_time=iTime(Symbol(),PERIOD_M1,i);
   //lnd_start_price=iClose(Symbol(),PERIOD_M1,i);
   
   
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////
// Bilinç
//////////////////////////////////////////////////////////////////////////////////////////////////////////



void BulkCalculation() {

string list="";
string liste="";
/*
Accounting_Mode=OP_SELL;
Print("BilicnMulti:",BilincMulti(sym));
return;*/

double account_symbol_lose=0;
double account_order_lose=0;

int count=0;
for(long chartid=ChartFirst(); chartid != -1; chartid=ChartNext(chartid) ) {
Print(ChartSymbol(chartid));
count++;



double u886=-1;
double d886=-1;



sym=ChartSymbol(chartid);
if ( StringFind(list,sym,0) != -1 ) continue;

    int obj_total=ObjectsTotal(chartid);
  string name;
  //for(int i=obj_total-1;i<obj_total;i++)
  for(int i=0;i<obj_total+1;i++)
  //for(int i=0;i<obj_total;i++)
    {
     name = ObjectName(chartid,i);
     
     //Print(name);
     
     
     
     if ( StringFind(name,"Levelu886",0) != -1 ) {
     datetime obj_price = ObjectGetDouble(chartid,name,OBJPROP_PRICE,0);
     
     if ( OrderCommetssTypeMgc("",sym,OP_SELL,-1) > 0 ) {
     u886=obj_price;
     Accounting_Mode=OP_SELL;
     price=u886;
     if ( price < MarketInfo(sym,MODE_BID) ) price=MarketInfo(sym,MODE_BID);
     double blcsym=BilincMulti(sym);
     account_symbol_lose=account_symbol_lose+blcsym;
     if ( Symbol() == sym ) account_order_lose=blcsym;
     list=list+","+sym;
     liste=liste+"\n"+sym+":"+DoubleToString(blcsym,2);
     }
     }
     
     
     if ( StringFind(name,"Leveld886",0) != -1 ) {
     datetime obj_price = ObjectGetDouble(chartid,name,OBJPROP_PRICE,0);
     if ( OrderCommetssTypeMgc("",sym,OP_BUY,-1) > 0 ) {
     d886=obj_price;
     Accounting_Mode=OP_BUY;
     price=d886;
     if ( price > MarketInfo(sym,MODE_BID) ) price=MarketInfo(sym,MODE_BID);
     double blcsym=BilincMulti(sym);
     account_symbol_lose=account_symbol_lose+blcsym;
     if ( Symbol() == sym ) account_order_lose=blcsym;
     list=list+","+sym;
     liste=liste+"\n"+sym+":"+DoubleToString(blcsym,2);
     }
     }
               
     
     }
     
}


Comment("Account Symbol Order Lose:",DoubleToString(account_symbol_lose,2),"\nAccount Order Lose:",DoubleToString(account_order_lose,2),""+liste);

sym=Symbol();


}






double BilincMulti(string sym) {


Print("BilinçMulti:",sym);

double symbol_lose=-1;


//price=obj_prc1;
OrderCommetssTypeMulti(sym);


double mrg=(MarketInfo(sym,MODE_MARGINREQUIRED)/1);




double buy_pen_mrg=buy_pen_lot*mrg;
double sell_pen_mrg=sell_pen_lot*mrg;

double buy_mrg=buy_lot*mrg;
double sell_mrg=sell_lot*mrg;

//double MarginLevel=StringConcatenate("MarginLevel=",DoubleToStr(AccountEquity()/AccountMargin()*100,2),"% ");
//double Buy_MarginLevel=StringConcatenate("MarginLevel=",DoubleToStr((AccountBalance()-buy_total_profit_loss)/buy_mrg*100,2),"% ");

if ( buy_lot > 0 ) {
double Buy_MarginLevel=((AccountBalance()-buy_total_profit_loss)/(buy_mrg*1))*100;
}
if ( buy_pen_lot > 0 ) {
double Buy_PenMarginLevel=((AccountBalance()-(buy_pen_total_profit_loss))/(buy_pen_mrg*1))*100;
}
double Buy_TotalMarginLevel;
if ( buy_lot > 0 || buy_pen_lot > 0 ) {
Buy_TotalMarginLevel=((AccountBalance()-(buy_pen_total_profit_loss+buy_total_profit_loss))/(buy_pen_mrg+buy_mrg*1))*100;
}


if ( sell_lot > 0 ) {
double Sell_MarginLevel=((AccountBalance()-sell_total_profit_loss)/(sell_mrg*1))*100;
}
if ( sell_pen_lot > 0 ) {
double Sell_PenMarginLevel=((AccountBalance()-(sell_pen_total_profit_loss))/(sell_pen_mrg*1))*100;
}

double Sell_TotalMarginLevel;
if ( sell_lot > 0 || sell_pen_lot > 0 ) {
Sell_TotalMarginLevel=((AccountBalance()-(sell_pen_total_profit_loss+sell_total_profit_loss))/(sell_pen_mrg+sell_mrg*1))*100;
}



if ( Accounting_Mode == OP_SELL ) {

symbol_lose=sell_total_profit_loss;
/*
Comment("Object_Name:",last_select_object,"\n Price:",price
,"\n sell_profit_total_lose:",sell_total_profit_loss

//,"\n buy_profit_total_lose:",buy_total_profit_loss
,"\n sell_profit_total:",sell_total_profit

//,"\n buy_profit_total:",buy_total_profit

,"\n\n sell_pen_profit_total_lose:",sell_pen_total_profit_loss

//,"\n buy_pen_profit_total_lose:",buy_pen_total_profit_loss
,"\n sell_pen_profit_total:",sell_pen_total_profit

//,"\n buy_pen_profit_total:",buy_pen_total_profit


,"\n\n Total_sell_lose:",sell_pen_total_profit_loss+sell_total_profit_loss

//,"\n Total_buy_lose:",buy_pen_total_profit_loss+buy_total_profit_loss
,"\n Total_sell_profit:",sell_pen_total_profit+sell_total_profit

//,"\n Total_buy_profit:",buy_pen_total_profit+buy_total_profit

,"\n mrg:",mrg
,"\n buy_mrg:",buy_mrg
,"\n buy_lot:",buy_lot
,"\n buy_margin_level:",Buy_MarginLevel

,"\n buy_mrg:",buy_pen_mrg
,"\n buy_lot:",buy_pen_lot
,"\n buy_margin_level:",Buy_PenMarginLevel

//,"\n buy_mrg:",buy_pen_mrg+buy_mrg
//,"\n buy_lot:",buy_pen_lot+buy_lot
//,"\n buy_margin_level:",Buy_TotalMarginLevel

,"\n sell_mrg:",sell_pen_mrg+sell_mrg
,"\n sell_lot:",sell_pen_lot+sell_lot
,"\n sell_margin_level:",Sell_TotalMarginLevel
);*/

}

if ( Accounting_Mode == OP_BUY ) {

symbol_lose=buy_total_profit_loss;
/*
Comment("Object_Name:",last_select_object,"\n Price:",price
//,"\n sell_profit_total_lose:",sell_total_profit_loss

,"\n buy_profit_total_lose:",buy_total_profit_loss
//,"\n sell_profit_total:",sell_total_profit

,"\n buy_profit_total:",buy_total_profit

//,"\n\n sell_pen_profit_total_lose:",sell_pen_total_profit_loss

,"\n buy_pen_profit_total_lose:",buy_pen_total_profit_loss
//,"\n sell_pen_profit_total:",sell_pen_total_profit

,"\n buy_pen_profit_total:",buy_pen_total_profit


//,"\n\n Total_sell_lose:",sell_pen_total_profit_loss+sell_total_profit_loss

,"\n Total_buy_lose:",buy_pen_total_profit_loss+buy_total_profit_loss
//,"\n Total_sell_profit:",sell_pen_total_profit+sell_total_profit

,"\n Total_buy_profit:",buy_pen_total_profit+buy_total_profit

,"\n mrg:",mrg
,"\n buy_mrg:",buy_mrg
,"\n buy_lot:",buy_lot
,"\n buy_margin_level:",Buy_MarginLevel

,"\n buy_mrg:",buy_pen_mrg
,"\n buy_lot:",buy_pen_lot
,"\n buy_margin_level:",Buy_PenMarginLevel

,"\n buy_mrg:",buy_pen_mrg+buy_mrg
,"\n buy_lot:",buy_pen_lot+buy_lot
,"\n buy_margin_level:",Buy_TotalMarginLevel

//,"\n sell_mrg:",sell_pen_mrg+sell_mrg
//,"\n sell_lot:",sell_pen_lot+sell_lot
//,"\n sell_margin_level:",Sell_TotalMarginLevel
);
*/

}



return symbol_lose;

}
























int Accounting_Mode=-1;

void Accounting(){
/*
BulkCalculation();
return;*/


double u886=-1;
double d886=-1;


    int obj_total=ObjectsTotal();
  string name;
  //for(int i=obj_total-1;i<obj_total;i++)
  for(int i=0;i<obj_total+1;i++)
  //for(int i=0;i<obj_total;i++)
    {
     name = ObjectName(i);
     
     //Print(name);
     
     if ( StringFind(name,"Levelu886",0) != -1 ) {
     datetime obj_price = ObjectGetDouble(ChartID(),name,OBJPROP_PRICE,0);
     
     if ( OrderCommetssTypeMgc("",sym,OP_SELL,-1) > 0 ) {
     u886=obj_price;
     Accounting_Mode=OP_SELL;
     price=u886;
     }
     }
     
     
     if ( StringFind(name,"Leveld886",0) != -1 ) {
     datetime obj_price = ObjectGetDouble(ChartID(),name,OBJPROP_PRICE,0);
     if ( OrderCommetssTypeMgc("",sym,OP_BUY,-1) > 0 ) {
     d886=obj_price;
     Accounting_Mode=OP_BUY;
     price=d886;
     }
     }
               
     
     }
     



   for (int m=OrdersTotal(); m>=0; m--)
   {
      if ( OrderSelect(m, SELECT_BY_POS))
      {
         if( StringFind(OrderComment(),"u886",0) != -1 && (OrderType() == OP_SELL || OrderType() == OP_SELLLIMIT) && OrderSymbol() == Symbol() && OrderMagicNumber() == magic
         )                  
         {
         u886=OrderOpenPrice(); 
         price=u886; 
         Accounting_Mode=OP_SELL;
         }

         if( StringFind(OrderComment(),"d886",0) != -1 && (OrderType() == OP_BUY || OrderType() == OP_BUYLIMIT) && OrderSymbol() == Symbol() && OrderMagicNumber() == magic
         )  
         {                         
         d886=OrderOpenPrice();  
         price=d886; 
         Accounting_Mode=OP_BUY;
         }                  
      }
    }


Print("High886:",u886,"Low886:",d886);

Bilinc();



}


int OrderCommetssTypeMgc(string cmt,string sym,int typ,int mgc){
int com = 0;


//int cnt = 0;
for(int cnts=OrdersTotal()-1;cnts>=0;cnts--){

if(!OrderSelect(cnts, SELECT_BY_POS, MODE_TRADES))continue;
//Sonuna Rakam Ekledik Hangi Tutar Kazaniyor diye onun icin instr veya indexof yapip comment icinde arama yapiyoruz.
int index=StringFind(OrderComment(), cmt, 0);

//Alert(OrderType(),"/",OrderComment(),"/",cmt,"/",index);
//if ( OrderType() == OP_BUY || OrderType() == OP_SELL ) {
if ( OrderSymbol() == sym && OrderType() == typ && ( OrderMagicNumber() == magic || mgc == -1 ) 
 ) {
com++;
}
}

return com;
};




/////////////////////////////////////////////////////////////////////////////////////////////////////////
bool OrderCommetssTypeMulti(string sym){

bool sonuc=false;

buy_total=0;
sell_total=0;
buy_profit=0;
sell_profit=0;
buy_lot=0;
sell_lot=0;

eq_live_order=0;
eq_pen_order=0;


lock_order_buy_total=0;
lock_order_sell_total=0;

sell_total_profit_loss=0;
buy_total_profit_loss=0;

sell_total_profit=0;
buy_total_profit=0;

sell_pen_total_profit_loss=0;
buy_pen_total_profit_loss=0;

sell_pen_total_profit=0;
buy_pen_total_profit=0;

buy_pen_lot=0;
sell_pen_lot=0;



//int cnt = 0;
for(int cnts=OrdersTotal()-1;cnts>=0;cnts--){


if ( OrderSymbol() == sym && OrderMagicNumber() == magic+1 && ( OrderType() == OP_BUYLIMIT || OrderType() == OP_SELLLIMIT ) ) {
eq_pen_order=eq_pen_order+1;
//buy_profit=buy_profit+OrderProfit();
}



if(!OrderSelect(cnts, SELECT_BY_POS, MODE_TRADES))continue;

//Print(OrderTicket());


//Sonuna Rakam Ekledik Hangi Tutar Kazaniyor diye onun icin instr veya indexof yapip comment icinde arama yapiyoruz.
//int index=StringFind(OrderComment(), cmt, 0);

if ( OrderSymbol() == sym && OrderMagicNumber() == magic+1 ) {
eq_live_order=eq_live_order+1;
//buy_profit=buy_profit+OrderProfit();
}
/*
////////////////////////////////////////////////////
if ( OrderSymbol() == sym && OrderType() == OP_BUY && OrderMagicNumber() == magic && OrderComment() == "HEDGE" ) {
//hedge_buy_profit=OrderProfit();
lock_order_buy_total=lock_order_buy_total+1;
}

if ( OrderSymbol() == sym && OrderType() == OP_SELL && OrderMagicNumber() == magic && OrderComment() == "HEDGE" ) {
//hedge_sell_profit=OrderProfit();
lock_order_sell_total=lock_order_sell_total+1;
}
////////////////////////////
*/



//Alert(OrderType(),"/",OrderComment(),"/",cmt,"/",index);
//if ( OrderType() == OP_BUY || OrderType() == OP_SELL ) {
if ( OrderSymbol() == sym && OrderType() == OP_BUY //&& OrderMagicNumber() == magic 
) {
buy_total=buy_total+1;
buy_profit=buy_profit+OrderProfit();
buy_lot=buy_lot+OrderLots();


if ( price < OrderOpenPrice() ) {
   int fiboset_Fark=(OrderOpenPrice()-price)/Point;
   double Pips_Price_valued = PipPrice(sym,0,fiboset_Fark,OrderLots());
   buy_total_profit_loss=buy_total_profit_loss+Pips_Price_valued;
   //Comment(Pips_Price_valued);
}   
  
   
if ( price > OrderOpenPrice() ) {
   int fiboset_Fark=(price-OrderOpenPrice())/Point;
   double Pips_Price_valued = PipPrice(sym,0,fiboset_Fark,OrderLots());
   buy_total_profit=buy_total_profit+Pips_Price_valued;
   //Comment(Pips_Price_valued);
}  



}




if ( OrderSymbol() == sym && ( OrderType() == OP_BUYLIMIT || OrderType() == OP_BUYSTOP )  //&& OrderMagicNumber() == magic 
) {/*
buy_total=buy_total+1;
buy_profit=buy_profit+OrderProfit();
*/
buy_pen_lot=buy_pen_lot+OrderLots();


if ( price < OrderOpenPrice() ) {
   int fiboset_Fark=(OrderOpenPrice()-price)/Point;
   double Pips_Price_valued = PipPrice(sym,0,fiboset_Fark,OrderLots());
   buy_pen_total_profit_loss=buy_pen_total_profit_loss+Pips_Price_valued;
   //Comment(Pips_Price_valued);
}   
  
   
if ( price > OrderOpenPrice() ) {
   int fiboset_Fark=(price-OrderOpenPrice())/Point;
   double Pips_Price_valued = PipPrice(sym,0,fiboset_Fark,OrderLots());
   buy_pen_total_profit=buy_pen_total_profit+Pips_Price_valued;
   //Comment(Pips_Price_valued);
}  



}




if ( OrderSymbol() == sym && OrderType() == OP_SELL //&& OrderMagicNumber() == magic 
 ) {
sell_total=sell_total+1;
sell_profit=sell_profit+OrderProfit();
sell_lot=sell_lot+OrderLots();



if ( price > OrderOpenPrice() ) {

   int fiboset_Fark=(price-OrderOpenPrice())/Point;
   double Pips_Price_valued = PipPrice(sym,0,fiboset_Fark,OrderLots());
   sell_total_profit_loss=sell_total_profit_loss+Pips_Price_valued;
}   
  

if ( price < OrderOpenPrice() ) {

   int fiboset_Fark=(OrderOpenPrice()-price)/Point;
   double Pips_Price_valued = PipPrice(sym,0,fiboset_Fark,OrderLots());
   sell_total_profit=sell_total_profit+Pips_Price_valued;
}   
  

   //Comment(Pips_Price_valued);


}



if ( OrderSymbol() == sym && (OrderType() == OP_SELLLIMIT || OrderType() == OP_SELLSTOP )//&& OrderMagicNumber() == magic 
 ) {
 

//sell_total=sell_total+1;
//sell_profit=sell_profit+OrderProfit();
sell_pen_lot=sell_pen_lot+OrderLots();



if ( price > OrderOpenPrice() ) {

   int fiboset_Fark=(price-OrderOpenPrice())/Point;
   double Pips_Price_valued = PipPrice(sym,0,fiboset_Fark,OrderLots());
   sell_pen_total_profit_loss=sell_pen_total_profit_loss+Pips_Price_valued;
}   
  

if ( price < OrderOpenPrice() ) {

   int fiboset_Fark=(OrderOpenPrice()-price)/Point;
   double Pips_Price_valued = PipPrice(sym,0,fiboset_Fark,OrderLots());
   sell_pen_total_profit=sell_pen_total_profit+Pips_Price_valued;
}   
  

   //Comment(Pips_Price_valued);


}








}

sonuc=true;

/*
if ( lock_order_buy_total == 0 ) lock_order_buy = false;
if ( lock_order_sell_total == 0 ) lock_order_sell = false;
*/
return sonuc;
};

////////////////////////////////////////////////////////////////////////////
// Pip - Price Fonksiyonu  ? 100 pip kazansa 0.01 bu kur ne kazandirir ?
////////////////////////////////////////////////////////////////////////////

double PipPrice(string sym,double fiyat,int pips,double lots) {



string OrderSymbols = sym;
double sonuc = 0;

if ( MarketInfo(OrderSymbols,MODE_SPREAD) == 0 ) return sonuc;

          int BS_spread = MarketInfo(OrderSymbols,MODE_SPREAD);
              BS_spread = 1;
    double BS_tickvalue = MarketInfo(OrderSymbols,MODE_TICKVALUE);
     double BS_ticksize = MarketInfo(OrderSymbols,MODE_TICKSIZE);
 double BS_spread_price = MarketInfo(OrderSymbols,MODE_MARGINREQUIRED)*BS_spread;
        BS_spread_price = (1/MarketInfo(OrderSymbols,MODE_POINT))*(BS_spread*(MarketInfo(OrderSymbols,MODE_TICKVALUE)*MarketInfo(OrderSymbols,MODE_TICKSIZE)));
        
   double BS_spread_one = (BS_spread_price / BS_spread)*lots;     
    double Order_Profit = pips*BS_spread_one;   
    //Alert(Order_Profit);
    
    
    if ( BS_spread_one == 0 ) {//Alert("BS_spread_one Hatasi:",OrderSymbols);
    return sonuc;}
         
         //Print("OrderSymbols",OrderSymbols,"Fiyat",fiyat,"BS_spread_one",BS_spread_one,"BS_spread_price",BS_spread_price);
         
         int Order_Pips = fiyat/BS_spread_one;   


if ( fiyat != 0 ) {
//Alert(fiyat," $ kac piptir ?",BS_spread_one,"/",IntegerToString(Order_Pips,0)," pip");
sonuc =  Order_Pips;
}

////////////////////////

if ( pips != 0 ) {
//Alert(pips," pip kac $ kazandirir ?",DoubleToString(Order_Profit,2),"$");
sonuc =  DoubleToString(Order_Profit,2);
}




return sonuc;


}

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

string last_select_object="";

double price=0;


double sell_total_profit_loss=0;
double buy_total_profit_loss=0;

double sell_total_profit=0;
double buy_total_profit=0;

double sell_pen_total_profit_loss=0;
double buy_pen_total_profit_loss=0;

double sell_pen_total_profit=0;
double buy_pen_total_profit=0;


void Bilinc() {


//price=obj_prc1;
OrderCommetssTypeMulti(sym);


double mrg=(MarketInfo(sym,MODE_MARGINREQUIRED)/1);




double buy_pen_mrg=buy_pen_lot*mrg;
double sell_pen_mrg=sell_pen_lot*mrg;

double buy_mrg=buy_lot*mrg;
double sell_mrg=sell_lot*mrg;

//double MarginLevel=StringConcatenate("MarginLevel=",DoubleToStr(AccountEquity()/AccountMargin()*100,2),"% ");
//double Buy_MarginLevel=StringConcatenate("MarginLevel=",DoubleToStr((AccountBalance()-buy_total_profit_loss)/buy_mrg*100,2),"% ");

if ( buy_lot > 0 ) {
double Buy_MarginLevel=((AccountBalance()-buy_total_profit_loss)/(buy_mrg*1))*100;
}
if ( buy_pen_lot > 0 ) {
double Buy_PenMarginLevel=((AccountBalance()-(buy_pen_total_profit_loss))/(buy_pen_mrg*1))*100;
}
double Buy_TotalMarginLevel;
if ( buy_lot > 0 || buy_pen_lot > 0 ) {
Buy_TotalMarginLevel=((AccountBalance()-(buy_pen_total_profit_loss+buy_total_profit_loss))/(buy_pen_mrg+buy_mrg*1))*100;
}


if ( sell_lot > 0 ) {
double Sell_MarginLevel=((AccountBalance()-sell_total_profit_loss)/(sell_mrg*1))*100;
}
if ( sell_pen_lot > 0 ) {
double Sell_PenMarginLevel=((AccountBalance()-(sell_pen_total_profit_loss))/(sell_pen_mrg*1))*100;
}

double Sell_TotalMarginLevel;
if ( sell_lot > 0 || sell_pen_lot > 0 ) {
Sell_TotalMarginLevel=((AccountBalance()-(sell_pen_total_profit_loss+sell_total_profit_loss))/(sell_pen_mrg+sell_mrg*1))*100;
}



if ( Accounting_Mode == OP_SELL ) {

Comment("Object_Name:",last_select_object,"\n Price:",price
,"\n sell_profit_total_lose:",sell_total_profit_loss

//,"\n buy_profit_total_lose:",buy_total_profit_loss
,"\n sell_profit_total:",sell_total_profit

//,"\n buy_profit_total:",buy_total_profit

,"\n\n sell_pen_profit_total_lose:",sell_pen_total_profit_loss

//,"\n buy_pen_profit_total_lose:",buy_pen_total_profit_loss
,"\n sell_pen_profit_total:",sell_pen_total_profit

//,"\n buy_pen_profit_total:",buy_pen_total_profit


,"\n\n Total_sell_lose:",sell_pen_total_profit_loss+sell_total_profit_loss

//,"\n Total_buy_lose:",buy_pen_total_profit_loss+buy_total_profit_loss
,"\n Total_sell_profit:",sell_pen_total_profit+sell_total_profit

//,"\n Total_buy_profit:",buy_pen_total_profit+buy_total_profit
/*
,"\n mrg:",mrg
,"\n buy_mrg:",buy_mrg
,"\n buy_lot:",buy_lot
,"\n buy_margin_level:",Buy_MarginLevel*/
/*
,"\n buy_mrg:",buy_pen_mrg
,"\n buy_lot:",buy_pen_lot
,"\n buy_margin_level:",Buy_PenMarginLevel*/

//,"\n buy_mrg:",buy_pen_mrg+buy_mrg
//,"\n buy_lot:",buy_pen_lot+buy_lot
//,"\n buy_margin_level:",Buy_TotalMarginLevel

,"\n sell_mrg:",sell_pen_mrg+sell_mrg
,"\n sell_lot:",sell_pen_lot+sell_lot
,"\n sell_margin_level:",Sell_TotalMarginLevel
);

}

if ( Accounting_Mode == OP_BUY ) {
Comment("Object_Name:",last_select_object,"\n Price:",price
//,"\n sell_profit_total_lose:",sell_total_profit_loss

,"\n buy_profit_total_lose:",buy_total_profit_loss
//,"\n sell_profit_total:",sell_total_profit

,"\n buy_profit_total:",buy_total_profit

//,"\n\n sell_pen_profit_total_lose:",sell_pen_total_profit_loss

,"\n buy_pen_profit_total_lose:",buy_pen_total_profit_loss
//,"\n sell_pen_profit_total:",sell_pen_total_profit

,"\n buy_pen_profit_total:",buy_pen_total_profit


//,"\n\n Total_sell_lose:",sell_pen_total_profit_loss+sell_total_profit_loss

,"\n Total_buy_lose:",buy_pen_total_profit_loss+buy_total_profit_loss
//,"\n Total_sell_profit:",sell_pen_total_profit+sell_total_profit

,"\n Total_buy_profit:",buy_pen_total_profit+buy_total_profit
/*
,"\n mrg:",mrg
,"\n buy_mrg:",buy_mrg
,"\n buy_lot:",buy_lot
,"\n buy_margin_level:",Buy_MarginLevel*/
/*
,"\n buy_mrg:",buy_pen_mrg
,"\n buy_lot:",buy_pen_lot
,"\n buy_margin_level:",Buy_PenMarginLevel*/

,"\n buy_mrg:",buy_pen_mrg+buy_mrg
,"\n buy_lot:",buy_pen_lot+buy_lot
,"\n buy_margin_level:",Buy_TotalMarginLevel

//,"\n sell_mrg:",sell_pen_mrg+sell_mrg
//,"\n sell_lot:",sell_pen_lot+sell_lot
//,"\n sell_margin_level:",Sell_TotalMarginLevel
);


}





}


