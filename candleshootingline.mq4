//+------------------------------------------------------------------+
//|                                           candleshootingstar.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Mehmet Özhan Hastaoğlu"
#property link      "ozhanhastaoglu@gmail.com"
#property version   "1.00"
#property strict
// Eğitim için shoting star boyun bölgesi ve üst zaman dilimi barlarını çözen bir yazılım geliştirdim.
// Olayın kendisi çözüldü, tuzağı buldum. 
// Line sistemi ekledim üç dokunuş.
// Kazandığın para gerçek, hadi hayırlı olsun.
// Multi Line Sistemini Tamamladım, büyük zaman dilimlerinde kolay işareletme yapılıyor.
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+

bool LINE_SYSTEM=false;
bool BAR_SYSTEM=false;


color colorLawGreen=clrBlack;  
bool TRADE_LEVELS=true;
bool Chart_Forward = false;
 bool Chart_Rewind = false;
    int Chart_Pos = -1;
long currChart=ChartID();


int ToplamObje=ObjectsTotal();

extern color yazirenk_ust = clrBlack;
extern color yazirenk = clrLightGreen;

int scale=ChartGetInteger(ChartID(),CHART_SCALE); 

string mod_type = "";
double mod_price = -1;
double mod_prices = -1;
double last_mod_prices = -1;
bool mod_change=false;   
bool multi_mod=false;

string last_mode_vline="";
datetime last_mode_vline_time;
double last_mode_vline_price=-1;
int last_mode_vline_shift=-1;

double order1,order2,order3,sl,tp,tp1,tp2,tp3,order_type;

bool order_mode=false;

//long chart_active = ChartID();

bool onscreen=true; 

string last_select_object = "";
bool chartonscreen=true;

double SSSL=-1;


int OnInit()
  {
  

//if ( TerminalInfoInteger(TERMINAL_TRADE_ALLOWED) == 0 ) return;

//if (!IsTradeAllowed()) return;


      string OrderLine="ExpertAllow";
      ObjectDelete(OrderLine);
      //OrderTime=Time[WindowFirstVisibleBar()-40];
      ObjectCreate(ChartID(),OrderLine,OBJ_LABEL,0,0,0,0,0);          // Create an arrow
      //ObjectSetInteger(ChartID(),OrderLine,OBJPROP_ARROWCODE,108);    // Set the arrow code
      //ObjectSetInteger(ChartID(),OrderLine,OBJPROP_TIME,OrderTime);        // Set timeOrderTime+40*PeriodSeconds()
      //ObjectSetDouble(ChartID(),OrderLine,OBJPROP_PRICE,OrderOpenPrices);// Set price
      if (!IsTradeAllowed()) ObjectSetText(OrderLine,"L",30,"WingDings",clrBlack);
      if (IsTradeAllowed()) ObjectSetText(OrderLine,"J",30,"WingDings",clrBlack);
      ObjectSetInteger(ChartID(),OrderLine, OBJPROP_XDISTANCE, 80);
      ObjectSetInteger(ChartID(),OrderLine, OBJPROP_YDISTANCE, 30);        
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_ANCHOR,ANCHOR_UPPER);    // Set the arrow code
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_CORNER,CORNER_LEFT_UPPER);    // Set the arrow code
      //ObjectSetInteger(ChartID(),OrderLine,OBJPROP_FONTSIZE,8); 
      //ObjectSetInteger(ChartID(),OrderLine,OBJPROP_COLOR,clrBlack);
         //ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER);
         
         








  
 
 onscreen=true;
 //Alert(onscreen);

if ( chart_symbol != "" ) {
//Alert("Çiz2:",chart_symbol);
//if ( chart_symbol != "" ) 
//CanddleShootingLine("",NULL,NULL,chart_symbol,PERIOD_M15,"SHOW",ChartID());
//ObjectsDeleteAlls(ChartID(),"Trend Manuel",0,-1);
CanddleShootingLine("",wtime1,wtime2,wsym,wper,wislem,ChartID(),wscale);
//chart_show == false && 
//chart_show=true;
chart_symbol="";
}
 

     /*long currChart=ChartID();
     string LabelChartP="ChartSymbol";
     ObjectCreate(currChart,LabelChartP, OBJ_EDIT,0 , 0, 0);
     ObjectSetString(currChart,LabelChartP,OBJPROP_TEXT,Symbol());
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_CORNER, 1);
     ObjectSetString(currChart,LabelChartP, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_COLOR, clrGreen);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_FONTSIZE, 10);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_XDISTANCE, 80);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_YDISTANCE, 50);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_XSIZE, 50); 
     //ObjectSetInteger(currChart,LabelChartP, OBJPROP_TIMEFRAMES, OBJ_PERIOD_MN1);
     ObjectSetString(currChart,LabelChartP,OBJPROP_TOOLTIP,"chart_symbol");
     
     currChart=ChartID();
     LabelChartP="ChartPeriod";
     ObjectCreate(currChart,LabelChartP, OBJ_EDIT,0 , 0, 0);
     ObjectSetString(currChart,LabelChartP,OBJPROP_TEXT,Period());
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_CORNER, 1);
     ObjectSetString(currChart,LabelChartP, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_COLOR, clrGreen);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_FONTSIZE, 10);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_XDISTANCE, 80);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_YDISTANCE, 70);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_XSIZE, 50); 
     //ObjectSetInteger(currChart,LabelChartP, OBJPROP_TIMEFRAMES, OBJ_PERIOD_MN1);
     ObjectSetString(currChart,LabelChartP,OBJPROP_TOOLTIP,"chart_period");   */   
     
 
 
//////////////////////////////////////////////////////////////////////////////////////////////////// 
// OTO SEÇİLEBİLİR SİSTEM
////////////////////////////////////////////////////////////////////////////////////////////////////
 //if ( Symbol() == "USDTRY" ) {
 
 //Print("Yeni Yükleme",ObjectsTotal());

      for(int i=ObjectsTotal();i>=0;i--)
        {
        string name = ObjectName(ChartID(),i);
        
           int indexoft=StringFind(name, "Star-31", 0);
    
           if(indexoft!=-1) continue; 
     
  /*if ( ObjectGetInteger(ChartID(),name,OBJPROP_TYPE) == OBJ_TREND && ObjectGetString(ChartID(),name,OBJPROP_TEXT) != "" ) {      
  Print(ObjectGetString(ChartID(),name,OBJPROP_TEXT));
  Print("name",name);
  }*/
  
  if ( ObjectGetInteger(ChartID(),name,OBJPROP_TYPE) == OBJ_TREND && StringToInteger(ObjectGetString(ChartID(),name,OBJPROP_TEXT)) == Period()  ) {
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTABLE,true);
  //Print(name);
   }

  if ( ObjectGetInteger(ChartID(),name,OBJPROP_TYPE) == OBJ_TREND && StringToInteger(ObjectGetString(ChartID(),name,OBJPROP_TEXT)) > 0    ) {
  if ( StringToInteger(ObjectGetString(ChartID(),name,OBJPROP_TEXT)) != Period()    ) {
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTABLE,false);
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTED,false);
  }
  //Print(name);
   }
      
   

  }
  
  //}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////  
   
 
 
 //ObjectSetInteger(ChartID(),last_object,OBJPROP_SELECTED,false);

        string LabelChart="PeriodBilgisis";
        ObjectDelete(ChartID(),LabelChart);
     
        LabelChart="PeriodBilgisi";
        ObjectDelete(ChartID(),LabelChart);
        
        if ( Period() != -1 ) {
        
        string PeriodBilgisi=TFtoStr(Period());
     if ( ObjectFind(ChartID(),LabelChart) == -1 ) {
     
     ObjectCreate(ChartID(),LabelChart, OBJ_LABEL,0 , 0, 0);
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,PeriodBilgisi);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_CORNER, 1);
     ObjectSetString(ChartID(),LabelChart, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_COLOR, yazirenk_ust);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 40);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_XDISTANCE, 185);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_YDISTANCE, 30);  
     
     LabelChart="PeriodBilgisis";
     ObjectCreate(ChartID(),LabelChart, OBJ_LABEL,0 , 0, 0);
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,PeriodBilgisi);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_CORNER, 1);
     ObjectSetString(ChartID(),LabelChart, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_COLOR, yazirenk);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 40);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_XDISTANCE, 183);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_YDISTANCE, 30); 
     

     LabelChart="PeriodBilgisisym";
     ObjectCreate(ChartID(),LabelChart, OBJ_LABEL,0 , 0, 0);
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,Symbol());
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_CORNER, 1);
     ObjectSetString(ChartID(),LabelChart, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_COLOR, yazirenk_ust);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 20);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_XDISTANCE, 185);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_YDISTANCE, 80);  
     
     LabelChart="PeriodBilgisisyms";
     ObjectCreate(ChartID(),LabelChart, OBJ_LABEL,0 , 0, 0);
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,Symbol());
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_CORNER, 1);
     ObjectSetString(ChartID(),LabelChart, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_COLOR, yazirenk);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 20);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_XDISTANCE, 183);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_YDISTANCE, 80); 


     LabelChart="PeriodBilgibuylotprofit";
     ObjectCreate(ChartID(),LabelChart, OBJ_LABEL,0 , 0, 0);
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,"");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_CORNER, 1);
     ObjectSetString(ChartID(),LabelChart, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_COLOR, yazirenk_ust);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 10);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_XDISTANCE, 183);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_YDISTANCE, 110); 

     LabelChart="PeriodBilgibuylotprofits";
     ObjectCreate(ChartID(),LabelChart, OBJ_LABEL,0 , 0, 0);
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,"");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_CORNER, 1);
     ObjectSetString(ChartID(),LabelChart, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_COLOR, yazirenk);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 10);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_XDISTANCE, 185);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_YDISTANCE, 110);    
     
     LabelChart="PeriodBilgiselllotprofit";
     ObjectCreate(ChartID(),LabelChart, OBJ_LABEL,0 , 0, 0);
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,"");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_CORNER, 1);
     ObjectSetString(ChartID(),LabelChart, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_COLOR, yazirenk_ust);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 10);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_XDISTANCE, 183);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_YDISTANCE, 130); 

     LabelChart="PeriodBilgiselllotprofits";
     ObjectCreate(ChartID(),LabelChart, OBJ_LABEL,0 , 0, 0);
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,"");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_CORNER, 1);
     ObjectSetString(ChartID(),LabelChart, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_COLOR, yazirenk);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 10);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_XDISTANCE, 185);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_YDISTANCE, 130);   
     
                 
     
         
     } else {     
     LabelChart="PeriodBilgisi";
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,PeriodBilgisi);
     } 
     }
     
     

     
          
  
  
  Comment("LineTrader/ShootingStar   Silme Kare Seç : S harfine bas / Trend Line System : T, / Bar Period System : B , / Hide Show : (G) H J K L , Trend Fan: T(true)+F , Z : Sil Önceki, Multi Mode:(O) / Z Önceki Sil, Fibo Line Show Hide: Q / OrderMode: X, Order Open: Y , Order Close: U / BreakEven: i ");
  
  

      /*case CHART_COLOR_BACKGROUND:
      case CHART_COLOR_FOREGROUND:
      case CHART_COLOR_GRID:
      case CHART_COLOR_VOLUME:
      case CHART_COLOR_CHART_UP:
      case CHART_COLOR_CHART_DOWN:
      case CHART_COLOR_CHART_LINE:
      case CHART_COLOR_CANDLE_BULL:
      case CHART_COLOR_CANDLE_BEAR:
      case CHART_COLOR_BID:
      case CHART_COLOR_ASK:
      case CHART_COLOR_LAST:
      case CHART_COLOR_STOP_LEVEL:*/
/*
ChartSetInteger(ChartID(),CHART_COLOR_BACKGROUND,clrWhite);      
ChartSetInteger(ChartID(),CHART_COLOR_FOREGROUND,clrWhite);      
      
ChartSetInteger(ChartID(),CHART_COLOR_CHART_UP,clrWhite);
ChartSetInteger(ChartID(),CHART_COLOR_CANDLE_BULL,clrWhite);        

ChartSetInteger(ChartID(),CHART_COLOR_CHART_DOWN,clrWhite);
ChartSetInteger(ChartID(),CHART_COLOR_CANDLE_BEAR,clrWhite);        
  */
  
//--- create timer



/*
      string OrderLine="FeOrderSave"+Symbol();
      datetime OrderTime;
      if ( WindowFirstVisibleBar()-5 > 0 ) {
      OrderTime=Time[WindowFirstVisibleBar()-5];
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_TIME,OrderTime);
      }

      //Print(WindowFirstVisibleBar()-40);
      if ( WindowFirstVisibleBar()-40 > 0 ) {
      OrderLine="FeOrderDelete"+Symbol();
      OrderTime=Time[WindowFirstVisibleBar()-40];
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_TIME,OrderTime); 
      }

      if ( WindowFirstVisibleBar()-20 > 0 ) {
      OrderLine="FeOrderLoad"+Symbol();
      OrderTime=Time[WindowFirstVisibleBar()-20];
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_TIME,OrderTime);
      }  */
  
//--- create timer
   
   FeAnaliz(); 







   EventSetTimer(1);
   //ObjectsDeleteAll();
   
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
string comm="";
string sinyallist = "";

void OnTimer()
  {
//---

//Print("Selam");

///CanddleSignal();


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Sinyal Sistemi
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
if ( ChartGetInteger(ChartID(),CHART_BRING_TO_TOP) == 1 ) {


///////////////////////////////////////////////////////////////////////////////////////////////
// Lot Gösterici
///////////////////////////////////////////////////////////////////////////////////////////////
if ( OrdersTotal() > 0 ) {

double margin_buylot=0;
double margin_selllot=0;
double margin_buyprofit=0;
double margin_sellprofit=0;

       for(int i=0; i<OrdersTotal(); i++) {
        if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) {
           if (OrderSymbol()==Symbol()) {
           
           //Alert("OrderTicket:",OrderTicket());
           
           
        if ( OrderType() == OP_BUY ) {
        
           margin_buylot = margin_buylot + OrderLots();
        
        }
        
        if ( OrderType() == OP_SELL ) {
        
           margin_selllot = margin_selllot + OrderLots();
        
        }
        


        
        //&& OrderProfit() < 0
               if ( OrderType() == OP_BUY  ) {
        
        margin_buyprofit = margin_buyprofit +  OrderProfit(); 
        margin_buyprofit = margin_buyprofit +  OrderCommission();
        margin_buyprofit = margin_buyprofit +  MathAbs(OrderSwap());


        } 
       // && OrderProfit() < 0
       if ( OrderType() == OP_SELL  ) {
        
        margin_sellprofit = margin_sellprofit +  OrderProfit(); 
        margin_sellprofit = margin_sellprofit +  OrderCommission();
        margin_sellprofit = margin_sellprofit +  OrderSwap();
        
        } 
        
        



}
}
}
        
    double margin_toplam_lot;    

margin_selllot = NormalizeDouble(margin_selllot,2);
 margin_buylot = NormalizeDouble(margin_buylot,2);
 
margin_sellprofit = NormalizeDouble(margin_sellprofit,2);
 margin_buyprofit = NormalizeDouble(margin_buyprofit,2);
  
 
string buy_lot_bilgisi="Buy Lot :"+margin_buylot+"/"+margin_buyprofit+"$";

string sell_lot_bilgisi="Sell Lot :"+margin_selllot+"/"+margin_sellprofit+"$";

if ( margin_buylot == 0 ) buy_lot_bilgisi="";
if ( margin_selllot == 0 ) sell_lot_bilgisi="";


     string LabelChart="PeriodBilgibuylotprofit";
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,buy_lot_bilgisi);

     LabelChart="PeriodBilgibuylotprofits";
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,buy_lot_bilgisi);
     

     LabelChart="PeriodBilgiselllotprofit";
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,sell_lot_bilgisi);

     LabelChart="PeriodBilgiselllotprofits";
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,sell_lot_bilgisi);
     
     
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////


















if ( comm == "" ) {
comm=ChartGetString(ChartID(),CHART_COMMENT);
}

string islemler= comm;//OrdersTotal()+"İşlemler";

   int total = OrdersTotal();
   //Alert(total);
   
   for(int i=total-1;i>=0;i--)
  //for(int i=total;i>=0;i--)
  {
    OrderSelect(i, SELECT_BY_POS);
    int type   = OrderType();

 if ( (OrderType() == OP_BUYLIMIT || OrderType() == OP_SELLLIMIT || OrderType() == OP_BUYSTOP || OrderType() == OP_SELLSTOP ) ){ 
    
    double Symbol_Bid = MarketInfo(OrderSymbol(),MODE_BID);
    double Symbol_Ask = MarketInfo(OrderSymbol(),MODE_ASK);
    double Symbol_Point = MarketInfo(OrderSymbol(),MODE_POINT);
    
    double Symbol_Fark = -1;
    int Symbol_Pip=-1;
///    
    if ( OrderType() == OP_BUYLIMIT ) {    
    Symbol_Fark=Symbol_Bid-OrderOpenPrice(); 
    
    Symbol_Pip = Symbol_Fark/Symbol_Point;
    
    
    if ( Symbol() == OrderSymbol() ) {
    
    for(int t=0;t<=5;t++) {
    
    //ObjectDelete(ChartID(),"FXBRB"+t);
    
    if ( (iLow(OrderSymbol(),PERIOD_M1,t) - OrderOpenPrice())/Symbol_Point < 20 && (iLow(OrderSymbol(),PERIOD_M1,t) - OrderOpenPrice())/Symbol_Point > 0 ) {
    //if ( (OrderOpenPrice()-Low[t])/Symbol_Point > -200 ) {
    
    if ( Symbol() == OrderSymbol() ) {
    ObjectCreate(ChartID(),"FXBRB"+Time[t],OBJ_TREND,0,Time[t],OrderOpenPrice(),Time[t],iLow(OrderSymbol(),PERIOD_M1,t));
    ObjectSetInteger(ChartID(),"FXBRB"+Time[t],OBJPROP_RAY,false);
    ObjectSetString(ChartID(),"FXBRB"+Time[t],OBJPROP_TOOLTIP,int((iLow(OrderSymbol(),PERIOD_M1,t) - OrderOpenPrice())/Symbol_Point));
    }
    
    int indexoft=StringFind(sinyallist, OrderTicket(), 0);
    
    if(indexoft==-1) {
    Alert(t," BUYLIMIT ",OrderSymbol()," ",int((iLow(OrderSymbol(),PERIOD_M1,t) - OrderOpenPrice())/Symbol_Point));
    } 
    
    sinyallist=sinyallist+OrderTicket()+",";

    }

    }
               
    }
    
    }
////
    if ( OrderType() == OP_SELLLIMIT ) {    
    Symbol_Fark=OrderOpenPrice()-Symbol_Ask;        
    
        
    int Symbol_Pip = Symbol_Fark/Symbol_Point;
    

    if ( Symbol() == OrderSymbol() ) {
    
    for(int t=0;t<=5;t++) {
    
    //ObjectDelete(ChartID(),"FXBRS"+t);
    
    if ( (OrderOpenPrice()-iHigh(OrderSymbol(),PERIOD_M1,t))/Symbol_Point < 20 && (OrderOpenPrice()-iHigh(OrderSymbol(),PERIOD_M1,t))/Symbol_Point > 0 ) {
    //if ( (OrderOpenPrice()-Low[t])/Symbol_Point > -200 ) {
    
    if ( Symbol() == OrderSymbol() ) {
    ObjectCreate(ChartID(),"FXBRS"+Time[t],OBJ_TREND,0,Time[t],OrderOpenPrice(),Time[t],iHigh(OrderSymbol(),PERIOD_M1,t));
    ObjectSetInteger(ChartID(),"FXBRS"+Time[t],OBJPROP_RAY,false);
    ObjectSetString(ChartID(),"FXBRS"+Time[t],OBJPROP_TOOLTIP,int((iHigh(OrderSymbol(),PERIOD_M1,t) - OrderOpenPrice())/Symbol_Point));
    }

    int indexoft=StringFind(sinyallist, OrderTicket(), 0);
    
    if(indexoft==-1) {
    Alert(t," SELLLIMIT ",OrderSymbol()," ",int((OrderOpenPrice()-iHigh(OrderSymbol(),PERIOD_M1,t))/Symbol_Point));
    } 
    
    sinyallist=sinyallist+OrderTicket()+",";    
    
    
    }
    
    }
    
    }    
    
    }
    
///
    
    
    if ( Symbol_Pip < 100 ) {
    
    islemler = islemler + "\n" + OrderSymbol() + " " + Symbol_Pip + " / " +OrderTicket();
    
    }
    
    }
    
    
    

}

  Comment("İşlemler:",islemler);


} else {
 
}
//////////////////////////////////////////////////////////////////////////////////////////  

   
       string LabelChart="SpreadBilgisi";
     if ( ObjectFind(ChartID(),LabelChart) == -1 ) {
     
     ObjectCreate(ChartID(),LabelChart, OBJ_LABEL,0 , 0, 0);
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,MarketInfo(Symbol(),MODE_SPREAD));
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_CORNER, 1);
     ObjectSetString(ChartID(),LabelChart, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 30);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_COLOR, clrBlack);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 16);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_XDISTANCE, 35);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_YDISTANCE, 10);      
     } else {     
     LabelChart="SpreadBilgisi";
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,MarketInfo(Symbol(),MODE_SPREAD));
     } 
     

     
  datetime bar_start_time=Time[0];
  datetime bar_end_time=bar_start_time+PeriodSeconds();
  int seconds_remaining=bar_end_time-TimeCurrent();  
       
        LabelChart="ZamanBilgisi";
     if ( ObjectFind(ChartID(),LabelChart) == -1 ) {     
     ObjectCreate(ChartID(),LabelChart, OBJ_LABEL,0 , 0, 0);
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,seconds_remaining);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_CORNER, 1);
     ObjectSetString(ChartID(),LabelChart, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 10);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_COLOR, clrBlack);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 9);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_XDISTANCE, 55);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_YDISTANCE, 30);     
     } else {     
     LabelChart="ZamanBilgisi";
     string ZamanBilgisi=TimeToStr(seconds_remaining,TIME_MINUTES|TIME_SECONDS);
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,ZamanBilgisi);
     }
     
     
   
  }
  
  
string last_object="";  
int objtotal = ObjectsTotal();

void ObjectsDeleteAlls(long oda_charid,string oda_wilcard,int oda_window,int oda_type) {


//return;

             int obj_total=ObjectsTotal(oda_charid,oda_window,oda_type)-1;
    for(int i=ObjectsTotal(oda_charid,oda_window,oda_type);i>=0;i--)
        {
        string name = ObjectName(oda_charid,i,oda_window,oda_type);
        
  int index = StringFind(name,oda_wilcard, 0); 


  if ( index != -1 ) {
  //Sleep(100);
  ObjectDelete(ChartID(),name);
   }  
   
  }


}
  
  
datetime last_time;
  
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
  
  
  if ( sparam == 45 ) {
  
  
  CloseAllOrdersMix();
  
  }
  
if ( sparam == 17 ) { // W
 
 bool filefind=false;
 string filenames="";
 
 for(int t=1;t<=10;t++) {
 
 string filename=Symbol()+"-"+t+".gif";
 
   if(FileIsExist("Analiz\\"+filename))
     {
     filenames=Symbol()+"-"+(t+1)+".gif";
     }

 
 }
 
 if ( filenames == "" ) filenames=Symbol()+"-"+1+".gif";
 
 long height = ChartGetInteger(ChartID(),CHART_HEIGHT_IN_PIXELS,0);
 long width = ChartGetInteger(ChartID(),CHART_WIDTH_IN_PIXELS,0);

 
 if(!WindowScreenShot("Analiz\\"+filenames,width,height)) Print("WindowScreenShot error: "+GetLastError());
 
 
 
 Print("Resim Kaydedildi = "+filenames);
 
 
 }
 
  
  
  
  
  
      string OrderLine="ExpertAllow";
      ObjectDelete(OrderLine);
      //OrderTime=Time[WindowFirstVisibleBar()-40];
      ObjectCreate(ChartID(),OrderLine,OBJ_LABEL,0,0,0,0,0);          // Create an arrow
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_BACK,true);    // Set the arrow code
      //ObjectSetInteger(ChartID(),OrderLine,OBJPROP_TIME,OrderTime);        // Set timeOrderTime+40*PeriodSeconds()
      //ObjectSetDouble(ChartID(),OrderLine,OBJPROP_PRICE,OrderOpenPrices);// Set price
      if (!IsTradeAllowed()) ObjectSetText(OrderLine,"L",30,"WingDings",clrBlack);
      if (IsTradeAllowed()) ObjectSetText(OrderLine,"J",30,"WingDings",clrSlateGray);
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_ANCHOR,ANCHOR_UPPER);    // Set the arrow code
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_CORNER,CORNER_LEFT_UPPER);    // Set the arrow code
      ObjectSetInteger(ChartID(),OrderLine, OBJPROP_XDISTANCE, 80);
      ObjectSetInteger(ChartID(),OrderLine, OBJPROP_YDISTANCE, 30);  
      
      

if ( sparam == "ExpertAllow" ) {

ChartApplyTemplate(ChartID(),"CLS764.tpl");


}
      
  
/////////////////////////////////////////////////////////////////////////  
int indexoftime = StringFind(sparam,"ShootingStar-Time",0);

if ( indexoftime != -1 ) {

string time_text = ObjectGetString(ChartID(),sparam,OBJPROP_TEXT);

int time_per = GetStringPeriyod(time_text);

 ChartSetSymbolPeriod(ChartID(),Symbol(),time_per);

}  
//////////////////////////////////////////////////////////////////////  
  
  
  
  
  
  
  
  
  
  
  
  
  
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  
// CHART OBJECT COPY SYSTEM
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  
if ( (ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_GANNFAN || ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_TRENDBYANGLE || ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_ELLIPSE || ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_FIBO || ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_EXPANSION || ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_HLINE || ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_VLINE || ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_TRIANGLE || ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_TREND || ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_RECTANGLE )  && ObjectGetInteger(ChartID(),sparam,OBJPROP_SELECTED) == true && ObjectGetInteger(ChartID(),sparam,OBJPROP_SELECTABLE) == true ) {
last_select_object=sparam;
Comment("last_select_object",last_select_object);
}


ChartListAll();


if ( ChartGetInteger(ChartID(),CHART_BRING_TO_TOP) == 1 && chartonscreen == false ) {
//string OrderLine="FeOrderSave"+Symbol()+"-1";
//ObjectDelete(OrderLine);
ObjectsDeleteAlls(ChartID(),"Chart",0,-1);
//FeAnaliz();


int counts=0;
int iii=0;



for(long chartid=ChartFirst(); chartid != -1; chartid=ChartNext(chartid) ) {counts++;
      string csym=ChartSymbol(chartid);
      string cper=ChartPeriod(chartid);
//Print(chartid,"/",csym,"/",cper);
      
      if ( csym == Symbol() ) {
      
      iii++;           
      
      string OrderLine="Chart"+chartid;
      ObjectCreate(ChartID(),OrderLine,OBJ_LABEL,0,0,0,0,0);          // Create an arrow
      ObjectSetText(OrderLine,"n",13,"WingDings",clrRed);
      //ObjectSetInteger(ChartID(),OrderLine,OBJPROP_ARROWCODE,108);    // Set the arrow code
      //ObjectSetInteger(ChartID(),OrderLine,OBJPROP_TIME,OrderTime);        // Set time
      //ObjectSetDouble(ChartID(),OrderLine,OBJPROP_PRICE,OrderOpenPrices);// Set price
      ObjectSetInteger(ChartID(),OrderLine, OBJPROP_XDISTANCE, 20*iii);
      ObjectSetInteger(ChartID(),OrderLine, OBJPROP_YDISTANCE, 130);
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_ANCHOR,ANCHOR_UPPER);    // Set the arrow code
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_CORNER,CORNER_LEFT_LOWER);      
      ObjectSetString(ChartID(),OrderLine,OBJPROP_TOOLTIP,csym+"/"+TFtoStr(cper));      
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_COLOR,clrDarkGray);
      if ( ChartID() == chartid ) ObjectSetInteger(ChartID(),OrderLine,OBJPROP_COLOR,clrLimeGreen);

      OrderLine="ChartText"+chartid;
      ObjectCreate(ChartID(),OrderLine,OBJ_LABEL,0,0,0,0,0);          // Create an arrow
      ObjectSetText(OrderLine,TFtoStr(cper),7,"Arial",clrBlack);
      //ObjectSetInteger(ChartID(),OrderLine,OBJPROP_ARROWCODE,108);    // Set the arrow code
      //ObjectSetInteger(ChartID(),OrderLine,OBJPROP_TIME,OrderTime);        // Set time
      //ObjectSetDouble(ChartID(),OrderLine,OBJPROP_PRICE,OrderOpenPrices);// Set price
      ObjectSetInteger(ChartID(),OrderLine, OBJPROP_XDISTANCE, 20*iii);
      ObjectSetInteger(ChartID(),OrderLine, OBJPROP_YDISTANCE, 140);
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_ANCHOR,ANCHOR_UPPER);    // Set the arrow code
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_CORNER,CORNER_LEFT_LOWER);      
      ObjectSetString(ChartID(),OrderLine,OBJPROP_TOOLTIP,csym+"/"+TFtoStr(cper));      
      //ObjectSetInteger(ChartID(),OrderLine,OBJPROP_COLOR,clrRed);
      //if ( ChartID() == chartid ) ObjectSetInteger(ChartID(),OrderLine,OBJPROP_COLOR,clrLimeGreen);
      
}

}

chartonscreen=true;
//Print("sil");
}

if ( ChartGetInteger(ChartID(),CHART_BRING_TO_TOP) == 0 ) {
chartonscreen=false;
}



           int indexofc=StringFind(sparam, "Chart", 0);
    
           if(indexofc!=-1) {
           
           
           
           string objname = sparam;                  
      int replacedz = StringReplace(objname,"Chart","");
          replacedz+= StringReplace(objname,".","");
          
          long chart_number = (long)objname;
          
          
          
          int obj_typ = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TYPE);
          datetime obj_time1 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME1);
          datetime obj_time2 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME2);
          datetime obj_time3 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME3);
          double obj_prc1 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE1);
          double obj_prc2 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE2);
          double obj_prc3 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE3);
          bool obj_fiil = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_FILL);
          double obj_scale = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_SCALE);
          double obj_angle = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_ANGLE);
          bool obj_ray = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_RAY);
          color obj_color = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_COLOR);
          color obj_bgcolor = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_BGCOLOR);
          int obj_width = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_WIDTH);
          int obj_back = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_BACK);
          
          
          //Alert(chart_number,"/",last_select_object,"/",obj_fiil);
          
          ObjectDelete(chart_number,last_select_object);
          ObjectCreate(chart_number,last_select_object,obj_typ,0,obj_time1,obj_prc1,obj_time2,obj_prc2,obj_time3,obj_prc3);
          ObjectSetInteger(chart_number,last_select_object,OBJPROP_COLOR,obj_color);
          ObjectSetInteger(chart_number,last_select_object,OBJPROP_RAY,obj_ray);
          ObjectSetInteger(chart_number,last_select_object,OBJPROP_WIDTH,obj_width);
          ObjectSetInteger(chart_number,last_select_object,OBJPROP_FILL,obj_fiil);
          ObjectSetInteger(chart_number,last_select_object,OBJPROP_BGCOLOR,obj_bgcolor);
          ObjectSetInteger(chart_number,last_select_object,OBJPROP_BACK,obj_back);
          ObjectSetDouble(chart_number,last_select_object,OBJPROP_SCALE,obj_scale);
          ObjectSetDouble(chart_number,last_select_object,OBJPROP_ANGLE,obj_angle);
          ChartRedraw(chart_number);
          
          
          ChartSetInteger(chart_number,CHART_BRING_TO_TOP,0,true);
          /*    
          long chartwindow = -1;
          ChartGetInteger(chart_number,CHART_WINDOW_HANDLE,0,chartwindow);
          ChartSetInteger(chart_number,CHART_BRING_TO_TOP,0,true);
          
          
          //ChartSetInteger(long(objname),CHART_QUICK_NAVIGATION,true);
             */
                     
           
           
           } 
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////           
  
  
  
  

           int indexofsc=StringFind(sparam, "SymbolC", 0);
    
           if(indexofsc!=-1) {
           
           
           
           string objname = sparam;                  
      int replacedz = StringReplace(objname,"SymbolC","");
          replacedz+= StringReplace(objname,".","");
          
          long chart_number = (long)objname;
          
          
          
          int obj_typ = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TYPE);
          datetime obj_time1 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME1);
          datetime obj_time2 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME2);
          datetime obj_time3 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME3);
          double obj_prc1 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE1);
          double obj_prc2 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE2);
          double obj_prc3 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE3);
          bool obj_fiil = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_FILL);
          double obj_scale = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_SCALE);
          double obj_angle = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_ANGLE);
          bool obj_ray = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_RAY);
          color obj_color = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_COLOR);
          color obj_bgcolor = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_BGCOLOR);
          int obj_width = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_WIDTH);
          int obj_back = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_BACK);
          
          
          //Alert(chart_number,"/",last_select_object,"/",obj_fiil);
          
          ObjectDelete(chart_number,last_select_object);
          ObjectCreate(chart_number,last_select_object,obj_typ,0,obj_time1,obj_prc1,obj_time2,obj_prc2,obj_time3,obj_prc3);
          ObjectSetInteger(chart_number,last_select_object,OBJPROP_COLOR,obj_color);
          ObjectSetInteger(chart_number,last_select_object,OBJPROP_RAY,obj_ray);
          ObjectSetInteger(chart_number,last_select_object,OBJPROP_WIDTH,obj_width);
          ObjectSetInteger(chart_number,last_select_object,OBJPROP_FILL,obj_fiil);
          ObjectSetInteger(chart_number,last_select_object,OBJPROP_BGCOLOR,obj_bgcolor);
          ObjectSetInteger(chart_number,last_select_object,OBJPROP_BACK,obj_back);
          ObjectSetDouble(chart_number,last_select_object,OBJPROP_SCALE,obj_scale);
          ObjectSetDouble(chart_number,last_select_object,OBJPROP_ANGLE,obj_angle);
          ChartRedraw(chart_number);
          
          
          ChartSetInteger(chart_number,CHART_BRING_TO_TOP,0,true);
          /*    
          long chartwindow = -1;
          ChartGetInteger(chart_number,CHART_WINDOW_HANDLE,0,chartwindow);
          ChartSetInteger(chart_number,CHART_BRING_TO_TOP,0,true);
          
          
          //ChartSetInteger(long(objname),CHART_QUICK_NAVIGATION,true);
             */
                     
           
           
           } 
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////           
  
    
  
  
  
  
  
  
  
  
  
  
  
  
//Print("sparam",sparam);

if ( sparam == 47 ) { //V
//CanddleFunc();
CanddleSignal();
}  
  


  
if ( ChartGetInteger(ChartID(),CHART_BRING_TO_TOP) == 1 && onscreen == false ) {
//string OrderLine="FeOrderSave"+Symbol()+"-1";
//ObjectDelete(OrderLine);
ObjectsDeleteAlls(ChartID(),"FeOrder",0,-1);
FeAnaliz();
onscreen=true;
Print("sil");
}




if ( ChartGetInteger(ChartID(),CHART_BRING_TO_TOP) == 0 ) {
onscreen=false;
}
  
  
//---
MumAnaliz();

FeAnalizEvent(sparam,id);


int indexvl = StringFind(sparam,"Vertical Line", 0); 

if ( indexvl != -1  ) {

string sid=sparam;

//Alert(sid);

//datetime vline_time = ObjectGetInteger(ChartID(),sparam,OBJPROP_TIME,0);

  datetime time=ObjectGetInteger(ChartID(),sid,OBJPROP_TIME);  
    int shift=iBarShift(Symbol(),Period(),time);

last_time=time;

//Comment(sid,"/",time,"/",shift,"/",last_time,"/",last_object);

if ( ObjectGetInteger(ChartID(),last_object,OBJPROP_TYPE) == OBJ_TREND ) {
ObjectSetInteger(ChartID(),last_object,OBJPROP_TIME1,last_time);
ChartRedraw();
}


}


//Print(sparam);

if ( id == CHARTEVENT_KEYDOWN ) {






int keydown=sparam;



if ( keydown == 40 ) {

//Alert("Selam2",OrdersTotal());

   for(int index=OrdersTotal()-1;index>=0;index--)   
     {
     
     //Print(index);
     
      if(OrderSelect(index,SELECT_BY_POS,MODE_TRADES))
        {

        
        if  ( OrderType() != OP_BUY && OrderType() != OP_SELL ) continue;
        
        if(OrderSymbol()!=Symbol()) continue;
        
        if ( OrderProfit() < 0 ) continue;
        
        string cmt=Symbol()+"-Trendline";

    int indexof=StringFind(OrderComment(), cmt, 0);
    
    /*if(indexof==-1) continue;

    cmt="-"+TFtoStr(Period())+"-";

    int indexoft=StringFind(OrderComment(), cmt, 0);
    
    if(indexoft==-1) continue;   */ 
    
    
    
    
    
    //Print(OrderTicket(),OrderComment());
       
    OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice(),OrderTakeProfit(),-1,clrNONE);
 
    
    
    }
    }




}





if ( keydown == 45 ) {

if ( order_mode == true ) { order_mode=false; } else { order_mode=true; }

Comment("order_mode",order_mode,"/",last_object,"/",order_type);

//ObjectSetInteger(ChartID(),last_object,OBJPROP_SELECTABLE,true);

}



if ( keydown == 22 ) { // u
//order_mode == true && 
if ( ObjectGetInteger(ChartID(),last_object,OBJPROP_TYPE) == OBJ_TREND  ) {



CloseTrades(last_object,"PEN",OP_BUYLIMIT);
CloseTrades(last_object,"PEN",OP_SELLLIMIT);

//Alert(last_object);


}


}




if ( keydown == 21 ) { // y

double orderlot=0.05;
orderlot=(NormalizeDouble((AccountBalance()/20000),2));
//if ( Symbol() == "XAUUSD" ) orderlot = orderlot/5;
if ( Symbol() == "XAUUSD" ) {//orderlot = 0.02;
orderlot=(NormalizeDouble((AccountBalance()/45000),2));
}




//Alert("Selam","/",last_object,"/",order_mode);

if ( order_mode == true && ObjectGetInteger(ChartID(),last_object,OBJPROP_TYPE) == OBJ_TREND && order_type == OP_SELLLIMIT ) {



//order1=NormalizeDouble(SS886,Digits);
//order2=NormalizeDouble(Low[shift1],Digits);
//tp=NormalizeDouble(SS764,Digits);
//tp1=NormalizeDouble(SS764,Digits);
//sl=NormalizeDouble(High[shift1],Digits);

string ordercmt=Symbol()+"-"+last_object+"-"+TFtoStr(Period())+"-1";
int ticket=OrderSend(Symbol(),OP_SELLLIMIT,orderlot,order1,0,sl,tp1,ordercmt,0,0,clrNONE);

//tp=NormalizeDouble(SS786,Digits);
//tp2=NormalizeDouble(SS786,Digits);
ordercmt=Symbol()+"-"+last_object+"-"+TFtoStr(Period())+"-2";
int ticket2=OrderSend(Symbol(),OP_SELLLIMIT,orderlot,order2,0,sl,tp2,ordercmt,0,0,clrNONE);


//order1=NormalizeDouble(SS864,Digits);
ordercmt=Symbol()+"-"+last_object+"-"+TFtoStr(Period())+"-3";
int ticket3=OrderSend(Symbol(),OP_SELLLIMIT,orderlot,order3,0,sl,tp3,ordercmt,0,0,clrNONE);

//order_type=OP_SELLLIMIT;
order_mode=false;

}







if ( order_mode == true && ObjectGetInteger(ChartID(),last_object,OBJPROP_TYPE) == OBJ_TREND && order_type == OP_BUYLIMIT) {

string ordercmt="";


//order1=NormalizeDouble(SS886,Digits);
//order2=NormalizeDouble(High[shift1],Digits);
//tp=NormalizeDouble(SS764,Digits);
//tp1=NormalizeDouble(SS764,Digits);
//sl=NormalizeDouble(Low[shift1],Digits);

ordercmt=Symbol()+"-"+last_object+"-"+TFtoStr(Period())+"-1";
int ticket=OrderSend(Symbol(),OP_BUYLIMIT,orderlot,order1,0,sl,tp,ordercmt,0,0,clrNONE);

//tp=NormalizeDouble(SS786,Digits);
//tp2=NormalizeDouble(SS786,Digits);
ordercmt=Symbol()+"-"+last_object+"-"+TFtoStr(Period())+"-2";
int ticket2=OrderSend(Symbol(),OP_BUYLIMIT,orderlot,order2,0,sl,tp2,ordercmt,0,0,clrNONE);

//order1=NormalizeDouble(SS864,Digits);
//tp=NormalizeDouble(SS786,Digits);
ordercmt=Symbol()+"-"+last_object+"-"+TFtoStr(Period())+"-3";
int ticket3=OrderSend(Symbol(),OP_BUYLIMIT,orderlot,order3,0,sl,tp3,ordercmt,0,0,clrNONE);

//order_type=OP_BUYLIMIT;
order_mode=false;

}








}







if ( keydown == 11 ) {
ChartApplyTemplate(ChartID(),"Default");
}

if ( keydown == 2 ) { // 1
Print("SmartFibo");
ChartApplyTemplate(ChartID(),"#-1-Default-SmartFibo");
}

if ( keydown == 3 ) { // 2
Print("SmartFibo");
ChartApplyTemplate(ChartID(),"#-2-Default-ShootingLine");
}

if ( keydown == 4 ) { // 3
Print("SmartFibo");
ChartApplyTemplate(ChartID(),"#-3-Default-Son");
}

if ( keydown == 5 ) { // 4
Print("SmartFibo");
ChartApplyTemplate(ChartID(),"#-4-Default-Bos");
}

if ( keydown == 6 ) { // 5
Print("SmartFibo");
ChartApplyTemplate(ChartID(),"#-5-Default-Printer");
}

if ( keydown == 7 ) { // 6
Print("SmartFibo");
ChartApplyTemplate(ChartID(),"#-6-Default-Close");
}

if ( keydown == 8 ) { // 7
Print("DayTrade");
ChartApplyTemplate(ChartID(),"Day");
}




}






if ( sparam == 24 ) { // O

if ( multi_mod == true ) { multi_mod=false; } else { multi_mod = true;}

Comment("MultiMode:",multi_mod);

}

//int indexsss = StringFind(sparam,"ShootingStar", 0); 
if ( multi_mod == true && ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_VLINE && ObjectGetInteger(ChartID(),sparam,OBJPROP_SELECTED) == true  ) {

  datetime time=ObjectGetInteger(ChartID(),sparam,OBJPROP_TIME);  
    int shift=iBarShift(Symbol(),Period(),time);
    
    ObjectSetInteger(ChartID(),last_mode_vline,OBJPROP_WIDTH,1);
    ObjectSetInteger(ChartID(),sparam,OBJPROP_WIDTH,3);
    
    ObjectSetInteger(ChartID(),last_mode_vline,OBJPROP_COLOR,clrDarkGray);
    ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrBlue);    
  
    ObjectSetInteger(ChartID(),last_mode_vline,OBJPROP_BACK,true);
    ObjectSetInteger(ChartID(),sparam,OBJPROP_BACK,true);


if ( mod_type == "HIGHDOWN" ) last_mode_vline_price=High[shift];
if ( mod_type != "HIGHDOWN" ) last_mode_vline_price=Low[shift];

    ObjectDelete(ChartID(),last_mode_vline+"HLINE");  
    ObjectCreate(ChartID(),sparam+"HLINE",OBJ_HLINE,0,Time[1],last_mode_vline_price);
    ObjectSetInteger(ChartID(),last_mode_vline+"HLINE",OBJPROP_COLOR,clrDarkGray);
    ObjectSetInteger(ChartID(),last_mode_vline+"HLINE",OBJPROP_STYLE,3);
    ObjectSetInteger(ChartID(),last_mode_vline+"HLINE",OBJPROP_WIDTH,1);

    //ObjectDelete(ChartID(),sparam+"TLINE");  
if ( mod_type == "HIGHDOWN" ) ObjectCreate(ChartID(),sparam+"TLINE"+last_mode_vline_price,OBJ_TRENDBYANGLE,0,Time[shift],last_mode_vline_price,Time[shift],last_mode_vline_price+500*Point);
if ( mod_type != "HIGHDOWN" ) ObjectCreate(ChartID(),sparam+"TLINE"+last_mode_vline_price,OBJ_TRENDBYANGLE,0,Time[shift],last_mode_vline_price,Time[shift],last_mode_vline_price-500*Point);
    ObjectSetInteger(ChartID(),sparam+"TLINE"+last_mode_vline_price,OBJPROP_COLOR,clrDarkGray);
    ObjectSetInteger(ChartID(),sparam+"TLINE"+last_mode_vline_price,OBJPROP_STYLE,3);
    ObjectSetInteger(ChartID(),sparam+"TLINE"+last_mode_vline_price,OBJPROP_WIDTH,1);    
    ObjectSetInteger(ChartID(),sparam+"TLINE"+last_mode_vline_price,OBJPROP_RAY,false);  
    ObjectSetInteger(ChartID(),sparam+"TLINE"+last_mode_vline_price,OBJPROP_BACK,true);  
    
last_mode_vline_time=time;
last_mode_vline_shift=shift;
last_mode_vline=sparam;

Comment("last_mode_vline:",last_mode_vline,"/ Price:",last_mode_vline_price);


    

  


}



















if ( sparam == 44 ) { // ZZ

if ( last_mod_prices != -1 ) {

string namel=last_object+"-ShootingStar-888"+last_mod_prices;
ObjectDelete(ChartID(),namel);

namel=last_object+"-ShootingStar-864-"+last_mod_prices;
ObjectDelete(ChartID(),namel);

namel=last_object+"-ShootingStar-827-"+last_mod_prices;
ObjectDelete(ChartID(),namel);

namel=last_object+"-ShootingStar-886-"+last_mod_prices;
ObjectDelete(ChartID(),namel);

namel=last_object+"-ShootingStar-786-"+last_mod_prices;
ObjectDelete(ChartID(),namel);

namel=last_object+"-ShootingStar-707-"+last_mod_prices;
ObjectDelete(ChartID(),namel);

namel=last_object+"-ShootingStar-764-"+last_mod_prices;
ObjectDelete(ChartID(),namel);

namel=last_object+"-ShootingStar-118-"+last_mod_prices;
ObjectDelete(ChartID(),namel);
}
}


//Print("sparam",sparam);


  if ( scale != ChartGetInteger(0,CHART_SCALE) ) {
  Comment("Scale:",ChartGetInteger(0,CHART_SCALE));
  scale=ChartGetInteger(0,CHART_SCALE);
  }
    

if ( id == 9 && multi_mod == true ) {
ChartSetInteger(currChart,CHART_AUTOSCROLL,false);
}

    if ( id == 9 && multi_mod == false ) {


  datetime left;
  int      right_bound;
  if ( WindowFirstVisibleBar() > -1 ) {
  //left=Time[WindowFirstVisibleBar()];
  right_bound=WindowFirstVisibleBar()-WindowBarsPerChart();}
  else{
  //left=TimeCurrent();
  right_bound=WindowFirstVisibleBar()-WindowBarsPerChart();
  }
  
  
  
/////////////////////////////////////////////////////////////  
if ( Chart_Pos < right_bound ) 
{
Chart_Rewind = true;Chart_Forward=false;
//Print("Geri Gidiyor");
ChartSetInteger(currChart,CHART_AUTOSCROLL,false);
}
else 
{
Chart_Rewind = false;Chart_Forward=true;
//Print("İleri Gidiyor");
if (Chart_Pos < 0 ) ChartSetInteger(currChart,CHART_AUTOSCROLL,true);
}
Chart_Pos = right_bound;
//Print(right_bound);
}

/////////////////////////////////////////////////////////////




//Print("sparam",sparam);


int indexsss = StringFind(sparam,"ShootingStar", 0); 
if ( LINE_SYSTEM == true && ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_TREND && indexsss == -1 ) {
last_object=sparam;
Comment("Trend Last Object:",sparam);

}


if ( id == CHARTEVENT_KEYDOWN ) {

if ( LINE_SYSTEM == true && sparam == 44 ) {


             int obj_total=ObjectsTotal()-1;
    for(int i=ObjectsTotal();i>=0;i--)
        {
        
        string sparam = ObjectName(i);
        string name = ObjectName(i);


  int index = StringFind(name,last_object, 0); 
  int last_object_len=StringLen(last_object);
  
  int index31 = StringFind(name,"-ShootingStar-31-", 0); 
  int index32 = StringFind(name,"-ShootingStar-32-", 0); 
  

  
  
  int object_len=StringLen(name);
//|| index333 != -1 || index222 != -1
  //if ( index != -1 && last_object_len != object_len && ( index1333 != -1 || index1222 != -1   ) ) {
  if ( index != -1 && last_object_len != object_len && (index31 != -1 || index32 != -1) ) {
  //Sleep(100);
  ObjectDelete(ChartID(),name);
  
     /*if ( ObjectGetInteger(0,name, OBJPROP_TIMEFRAMES) == -1 ) {
     ObjectSetInteger(0,name, OBJPROP_TIMEFRAMES, OBJ_PERIOD_M1 | OBJ_PERIOD_M5 | OBJ_PERIOD_M15 | OBJ_PERIOD_M30 | OBJ_PERIOD_H1 | OBJ_PERIOD_H4 | OBJ_PERIOD_D1 | OBJ_PERIOD_W1 | OBJ_PERIOD_MN1);
     } else {
     ObjectSetInteger(0,name, OBJPROP_TIMEFRAMES, -1);
     } */ 
  
   }  
   
}   

}


if ( LINE_SYSTEM == true && sparam == 33 ) {

Comment("TREND FANI");



string sparam=last_object;

  double price1=ObjectGetDouble(ChartID(),sparam,OBJPROP_PRICE1);
  double price2=ObjectGetDouble(ChartID(),sparam,OBJPROP_PRICE2);
  
  double time1=ObjectGetInteger(ChartID(),sparam,OBJPROP_TIME1);
  double time2=ObjectGetInteger(ChartID(),sparam,OBJPROP_TIME2);
  
  int shift1=iBarShift(Symbol(),Period(),time1);
  int shift2=iBarShift(Symbol(),Period(),time2);
  
  //Alert(price1,"/",price2,"/",shift1,"/",shift2);
  
  if ( price1 > price2 ) {
  
  for ( int t=shift2;t<=shift1;t++){
  
  int fark=0;
  int govde=0;
  if ( Open[t] > Close[t] ) {
  fark=(High[t]-Open[t])/Point;
  govde = (Open[t]-Close[t])/Point;}
  
  if ( Close[t] > Open[t] ) {
  fark=(High[t]-Close[t])/Point;
  govde = (Close[t]-Open[t])/Point;}
  
  if ( Close[t] == Open[t] ) {
  fark=(High[t]-Close[t])/Point;
  govde = (Open[t]-Close[t])/Point;}
  
  //int govde = (Open[t]-Close[t])/Point;
  
  ObjectDelete(ChartID(),sparam+"-ShootingStar-31-"+t);
  ObjectDelete(ChartID(),sparam+"-ShootingStar-32-"+t);
  
  
  double yuzde = govde/100;
  
  if ( yuzde == 0.0 ) continue;
  
  double oran=fark/(govde/100);
  
  if ( oran <= 30 ) continue;
  
  
  //Print(t);
  
  //if ( High[t] < price1 ) continue;
  ObjectCreate(ChartID(),sparam+"-ShootingStar-31-"+t,OBJ_TREND,0,time1,Low[shift1],Time[t],High[t]);
  ObjectSetInteger(ChartID(),sparam+"-ShootingStar-31-"+t,OBJPROP_COLOR,clrDarkGray);
  ObjectSetInteger(ChartID(),sparam+"-ShootingStar-31-"+t,OBJPROP_WIDTH,4);
  ObjectSetInteger(ChartID(),sparam+"-ShootingStar-31-"+t,OBJPROP_STYLE,2);
  ObjectSetInteger(ChartID(),sparam+"-ShootingStar-31-"+t,OBJPROP_BACK,true);
  ObjectSetInteger(ChartID(),sparam+"-ShootingStar-31-"+t,OBJPROP_RAY,false);
  ObjectSetInteger(ChartID(),sparam+"-ShootingStar-31-"+t,OBJPROP_SELECTABLE,false);
  ObjectSetInteger(ChartID(),sparam+"-ShootingStar-31-"+t,OBJPROP_SELECTED,false); 
  //ObjectSetString(ChartID(),sparam+"-ShootingStar-31-"+t,OBJPROP_TOOLTIP,TFtoStr(Period()));  

  //if ( High[t] < price1 ) continue;
  ObjectCreate(ChartID(),sparam+"-ShootingStar-32-"+t,OBJ_TREND,0,time1,Low[shift1],Time[t],High[t]);
  ObjectSetInteger(ChartID(),sparam+"-ShootingStar-32-"+t,OBJPROP_COLOR,clrDarkBlue);
  ObjectSetInteger(ChartID(),sparam+"-ShootingStar-32-"+t,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),sparam+"-ShootingStar-32-"+t,OBJPROP_STYLE,2);
  ObjectSetInteger(ChartID(),sparam+"-ShootingStar-32-"+t,OBJPROP_BACK,true);
  ObjectSetInteger(ChartID(),sparam+"-ShootingStar-32-"+t,OBJPROP_RAY,true);
  ObjectSetInteger(ChartID(),sparam+"-ShootingStar-32-"+t,OBJPROP_SELECTABLE,false);
  ObjectSetInteger(ChartID(),sparam+"-ShootingStar-32-"+t,OBJPROP_SELECTED,false); 
  ObjectSetString(ChartID(),sparam+"-ShootingStar-32-"+t,OBJPROP_TOOLTIP,oran); 
  
  
    
  
  }
  
  
  }
  
if ( price2 > price1 ) {

//Alert("P Büyük");
  
  for ( int t=shift2;t<=shift1;t++){
  
  
  
  int fark=0;
  int govde=0;
  double oran=0;
  if ( Open[t] > Close[t] ) {
  fark=(Close[t]-Low[t])/Point;
  govde = (Open[t]-Close[t])/Point;}
  
  if ( Close[t] > Open[t] ) {
  fark=(Open[t]-Low[t])/Point;
  govde = (Close[t]-Open[t])/Point;}
  
  if ( Close[t] == Open[t] ) {
  fark=(Close[t]-Low[t])/Point;
  govde = (Open[t]-Close[t])/Point;}
  
  //int govde = (Open[t]-Close[t])/Point;
  
  ObjectDelete(ChartID(),sparam+"-ShootingStar-31-"+t);
  ObjectDelete(ChartID(),sparam+"-ShootingStar-32-"+t);
  
  
  if ( govde < 1 ) continue;
  
  double yuzde = govde/100;
  
  if ( yuzde == 0.0 ) continue;
  
  //Print(govde,"/",fark,"/",yuzde);
  if ( fark/(govde/100) > 0  ) {
  oran=fark/(govde/100);
  }
  //Print(t);
  if ( oran <= 30 ) continue;
  
  
  
  
  //if ( Low[t] < price1 ) continue;
  ObjectCreate(ChartID(),sparam+"-ShootingStar-31-"+t,OBJ_TREND,0,time1,High[shift1],Time[t],Low[t]);
  ObjectSetInteger(ChartID(),sparam+"-ShootingStar-31-"+t,OBJPROP_COLOR,clrDarkGray);
  ObjectSetInteger(ChartID(),sparam+"-ShootingStar-31-"+t,OBJPROP_WIDTH,4);
  ObjectSetInteger(ChartID(),sparam+"-ShootingStar-31-"+t,OBJPROP_STYLE,2);
  ObjectSetInteger(ChartID(),sparam+"-ShootingStar-31-"+t,OBJPROP_BACK,true);
  ObjectSetInteger(ChartID(),sparam+"-ShootingStar-31-"+t,OBJPROP_RAY,false);
  ObjectSetInteger(ChartID(),sparam+"-ShootingStar-31-"+t,OBJPROP_SELECTABLE,false);
  ObjectSetInteger(ChartID(),sparam+"-ShootingStar-31-"+t,OBJPROP_SELECTED,false); 
  //ObjectSetString(ChartID(),sparam+"-ShootingStar-31-"+t,OBJPROP_TOOLTIP,TFtoStr(Period())); 

  //if ( Low[t] < price1 ) continue;
  ObjectCreate(ChartID(),sparam+"-ShootingStar-32-"+t,OBJ_TREND,0,time1,High[shift1],Time[t],Low[t]);
  ObjectSetInteger(ChartID(),sparam+"-ShootingStar-32-"+t,OBJPROP_COLOR,clrDarkGreen);
  ObjectSetInteger(ChartID(),sparam+"-ShootingStar-32-"+t,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),sparam+"-ShootingStar-32-"+t,OBJPROP_STYLE,2);
  ObjectSetInteger(ChartID(),sparam+"-ShootingStar-32-"+t,OBJPROP_BACK,true);
  ObjectSetInteger(ChartID(),sparam+"-ShootingStar-32-"+t,OBJPROP_RAY,true);
  ObjectSetInteger(ChartID(),sparam+"-ShootingStar-32-"+t,OBJPROP_SELECTABLE,false);
  ObjectSetInteger(ChartID(),sparam+"-ShootingStar-32-"+t,OBJPROP_SELECTED,false); 
  ObjectSetString(ChartID(),sparam+"-ShootingStar-32-"+t,OBJPROP_TOOLTIP,oran); 
  
  
    
  
  
  
  }
  
  
  
  }

}





//Print(sparam);

if ( sparam  == 33 ) {


GizleGoster(sparam);


}



if ( sparam  == 16 ) {


GizleGoster(sparam);


}



if ( sparam  == 34 ) {


GizleGoster(sparam);


}

if ( sparam  == 35 ) {


GizleGoster(sparam);


}

if ( sparam  == 36 ) {


GizleGoster(sparam);


}

if ( sparam  == 37 ) {


GizleGoster(sparam);


}

if ( sparam  == 38 ) {


GizleGoster(sparam);


}



  if ( sparam == 19 ) { // r
  if ( TRADE_LEVELS ) { TRADE_LEVELS=false; 
  ChartSetInteger(0,CHART_SHOW_TRADE_LEVELS,false);
  } else { TRADE_LEVELS=true;
  ChartSetInteger(0,CHART_SHOW_TRADE_LEVELS,true);
  }
  
  Comment("TRADE_LEVELS:",TRADE_LEVELS);
  }    
    

  if ( sparam == 20 ) { // t
  if ( LINE_SYSTEM ) { LINE_SYSTEM=false; 
  
  } else { LINE_SYSTEM=true;
  
  }
  
  Comment("TREND LINE_SYSTEM:",LINE_SYSTEM);
  }    
      

  if ( sparam == 48 ) { // t
  if ( BAR_SYSTEM ) { BAR_SYSTEM=false; 
  
  } else { BAR_SYSTEM=true;
  
  }
  
  Comment("BAR PERIOD_SYSTEM:",BAR_SYSTEM);
  }   
  
  

}




    if ( id == 9 ) {
    
  //  TFBars = Bars(Symbol,Period());
//BarsCounted = TFBars-MathMax(IndS2,IndS1+1);&& Time[WindowFirstVisibleBar()] != NULL


if ( Bars > 1000 ) {
  datetime left;
  int      right_bound;
  if ( WindowFirstVisibleBar() > -1 ) {
  //Print(WindowFirstVisibleBar(),"Bars",Bars);
  //left=Time[WindowFirstVisibleBar()];
  right_bound=WindowFirstVisibleBar()-WindowBarsPerChart();}
  else{
  //left=TimeCurrent();
  right_bound=WindowFirstVisibleBar()-WindowBarsPerChart();
  }
  
  
  
/////////////////////////////////////////////////////////////  
if ( Chart_Pos < right_bound ) 
{
Chart_Rewind = true;
Chart_Forward=false;
//Print("Geri Gidiyor");
///ChartSetInteger(currChart,CHART_AUTOSCROLL,false);
}
else 
{
Chart_Rewind = false;Chart_Forward=true;
//Print("İleri Gidiyor");
///if (Chart_Pos < 0 ) ChartSetInteger(currChart,CHART_AUTOSCROLL,true);
}
Chart_Pos = right_bound;
//Print(right_bound);

}


}

/////////////////////////////////////////////////////////////



  
    
    


if ( ToplamObje!=ObjectsTotal() && ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) != OBJ_RECTANGLE && ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) != OBJ_TREND ) {

//Print("ObjeSilindi",last_object);

if ( ObjectFind(ChartID(),last_object) != -1 ) return;

//if ( ObjectGetInteger(ChartID(),last_object,OBJPROP_TYPE) == OBJ_RECTANGLE || ObjectGetInteger(ChartID(),last_object,OBJPROP_TYPE) == OBJ_TREND ) { // Silinden objeden değer gelmedi için


if ( last_object == "" ) return;

Print("ObjeSilindi2",last_object);

if ( last_object == "" ) {
Print("last_object bos",last_object);
}


//Alert("Sil2",last_object);

//ObjectsDeleteAlls(ChartID(),last_object,-1,OBJ_TREND);


    for(int i=ObjectsTotal();i>=0;i--)
        {
        string name = ObjectName(ChartID(),i);
        
  int index = StringFind(name,last_object, 0); 


  if ( index != -1 ) {
  Sleep(100);
  ObjectDelete(ChartID(),name);
   }  
   
  }
  ChartRedraw();
  
  

//}


//Alert("Silinmiş");
last_object="";
ToplamObje=ObjectsTotal();

}



/*
  if ( sparam == 31 ) { // t
  if ( LINE_SYSTEM ) { LINE_SYSTEM=false; 
  
  } else { LINE_SYSTEM=true;
  
  }
  
  Comment("TREND LINE_SYSTEM:",LINE_SYSTEM);
  }    */
  
  

if ( sparam == 31 ) {

//if ( objtotal != ObjectsTotal() && last_object != "" ) {

//if ( ObjectFind(ChartID(),last_object) == -1 ) {

if ( ObjectGetInteger(ChartID(),last_object,OBJPROP_TYPE) == OBJ_RECTANGLE || ObjectGetInteger(ChartID(),last_object,OBJPROP_TYPE) == OBJ_TREND ) {

//Alert("Sil2",last_object);

//ObjectsDeleteAlls(ChartID(),last_object,-1,OBJ_TREND);


    for(int i=ObjectsTotal();i>=0;i--)
        {
        string name = ObjectName(ChartID(),i);
        
  int index = StringFind(name,last_object, 0); 


  if ( index != -1 ) {
  Sleep(10);
  ObjectDelete(ChartID(),name);
   }  
   
  }
  ChartRedraw();
  
  

}


//Alert("Silinmiş");
last_object="";
//objtotal=ObjectsTotal();

//}



//}

}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// CANDLE SHOOTING LINE
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

int indexss = StringFind(sparam,"ShootingStar", 0); 


if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_TREND && indexss == -1 ) {

//Alert("LightBlue");

//////////////////////////////////////////////////////////////////////////////////////////////////// 
// SEÇİLİ OLANI KALINLAŞTIRMA SİSTEMİ
////////////////////////////////////////////////////////////////////////////////////////////////////
 //if ( Symbol() == "USDTRY" ) {
 
 //Print("Yeni Yükleme",ObjectsTotal());

if ( last_object != sparam ) {
//ObjectSetInteger(ChartID(),last_object,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),last_object+"-ShootingStar-31",OBJPROP_WIDTH,1);

ObjectSetInteger(ChartID(),last_object+"-ShootingStar-618",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),last_object+"-ShootingStar-500",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),last_object+"-ShootingStar-382",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),last_object+"-ShootingStar-886",OBJPROP_WIDTH,1);

//ObjectSetInteger(ChartID(),sparam,OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-31",OBJPROP_WIDTH,2);

ObjectSetInteger(ChartID(),sparam+"-ShootingStar-618",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-500",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-382",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-886",OBJPROP_WIDTH,2);
}

     /* for(int i=ObjectsTotal();i>=0;i--)
        {
        string name = ObjectName(ChartID(),i);
        
           int indexoft=StringFind(name, last_object, 0);
    
           if(indexoft!=-1) continue; 
     
  if ( ObjectGetInteger(ChartID(),name,OBJPROP_TYPE) == OBJ_TREND && ObjectGetInteger(ChartID(),name,OBJPROP_COLOR) == clrLightBlue  ) {
  ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightSteelBlue);
  
  
  
  //Print(name);
   } else {
  if ( ObjectGetInteger(ChartID(),name,OBJPROP_TYPE) == OBJ_TREND && ObjectGetInteger(ChartID(),name,OBJPROP_COLOR) == clrLightSteelBlue  ) {
  ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);
  ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightBlue);      
  }
   }

  }*/
  
  //}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////  
   
   



////////////////////////////////////////////////////////////////////////////////////////
// TREND LINE LOCK
///////////////////////////////////////////////////////////////////////////////////////
if ( ObjectGetString(ChartID(),sparam,OBJPROP_TEXT) == "" && ObjectGetString(ChartID(),sparam,OBJPROP_TOOLTIP) == "" )  {
ObjectSetString(ChartID(),sparam,OBJPROP_TEXT,Period());

ObjectSetInteger(ChartID(),sparam,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam,OBJPROP_STYLE,2);
if ( LINE_SYSTEM == false ) ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrBlack);
if ( LINE_SYSTEM == false ) ObjectSetInteger(ChartID(),sparam,OBJPROP_RAY,false);
if ( LINE_SYSTEM == false ) ObjectSetInteger(ChartID(),sparam,OBJPROP_BACK,false);
if ( LINE_SYSTEM == false ) ObjectSetInteger(ChartID(),sparam,OBJPROP_WIDTH,2);


if ( LINE_SYSTEM ) {
ObjectSetString(ChartID(),sparam,OBJPROP_TOOLTIP,TFtoStr(Period()));

if ( Period() == PERIOD_D1 ) ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrBlue);
if ( Period() == PERIOD_H4 ) ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrRed);
if ( Period() == PERIOD_H1 ) ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrGreen);
if ( Period() == PERIOD_M30 ) ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrYellow);
if ( Period() == PERIOD_M15 ) ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrMagenta);
if ( Period() == PERIOD_M5 ) ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrWhite);
if ( Period() == PERIOD_W1 ) ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrBlack);
if ( Period() == PERIOD_M1 ) ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrBrown);
}

} else {
if ( int(ObjectGetString(ChartID(),sparam,OBJPROP_TEXT)) != Period() ) {
ObjectSetInteger(ChartID(),sparam,OBJPROP_SELECTABLE,false);
ObjectSetInteger(ChartID(),sparam,OBJPROP_SELECTED,false);
return;
} else {
ObjectSetInteger(ChartID(),sparam,OBJPROP_SELECTABLE,true);
ObjectSetInteger(ChartID(),sparam,OBJPROP_SELECTED,true);
}
}
///////////////////////////////////////////////////////////////////////////////////////





last_object=sparam;
Comment("last_object",last_object);

  double price1=ObjectGetDouble(ChartID(),sparam,OBJPROP_PRICE1);
  double price2=ObjectGetDouble(ChartID(),sparam,OBJPROP_PRICE2);
  
  double time1=ObjectGetInteger(ChartID(),sparam,OBJPROP_TIME1);
  double time2=ObjectGetInteger(ChartID(),sparam,OBJPROP_TIME2);
  
  int shift1=iBarShift(Symbol(),Period(),time1);
  int shift2=iBarShift(Symbol(),Period(),time2);
  
//if ( LINE_SYSTEM ) {  
ObjectDelete(ChartID(),sparam+"-ShootingStar-31");
ObjectCreate(ChartID(),sparam+"-ShootingStar-31",OBJ_TREND,0,time1,price1,time2,price2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-31",OBJPROP_COLOR,clrDarkGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-31",OBJPROP_WIDTH,4);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-31",OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-31",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-31",OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-31",OBJPROP_SELECTABLE,false);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-31",OBJPROP_SELECTED,false);  
ObjectSetString(ChartID(),sparam+"-ShootingStar-31",OBJPROP_TEXT,TFtoStr(Period())); 

//}  
  
if ( LINE_SYSTEM || ObjectGetString(ChartID(),sparam,OBJPROP_TOOLTIP) != "" ) return;  
  
  
  
  
  

if ( price1 > price2 ) {



//Alert("Selam");
///////////////////////////////////////////////////////////////////////////////////////////////////////
// Yeni Kontrol Sistemi - Önceki Ölçüm Yeri Tespiti ( Hatalı İşlem Uyarısı ) 
///////////////////////////////////////////////////////////////////////////////////////////////////////
for (int kontrol=WindowFirstVisibleBar();kontrol>0;kontrol--) {
ObjectDelete(ChartID(),sparam+"-ShootingStar-Control-"+kontrol);
ObjectDelete(ChartID(),sparam+"CONTROL"+kontrol);
}


int kontrolend=shift1-10;

if ( kontrolend < shift2 ) kontrolend=shift2+1;

bool kontrol_uyari=false;

if ( kontrolend > 1 ) {

for (int kontrol=kontrolend;kontrol<shift1-1;kontrol++) {
ObjectDelete(ChartID(),sparam+"-ShootingStar-Control-"+kontrol);
if ( Open[kontrol] < Close[kontrol] && Close[kontrol+1] < Open[kontrol+1]  ) {
kontrol_uyari=true;
///ObjectCreate(ChartID(),sparam+"-ShootingStar-Control-"+kontrol,OBJ_VLINE,0,Time[kontrol],Ask);


      ObjectCreate(ChartID(),sparam+"-ShootingStar-Control-"+kontrol,OBJ_ARROW,0,0,0,0,0);          // Create an arrow
      ObjectSetInteger(ChartID(),sparam+"-ShootingStar-Control-"+kontrol,OBJPROP_ARROWCODE,108);    // Set the arrow code
      ObjectSetInteger(ChartID(),sparam+"-ShootingStar-Control-"+kontrol,OBJPROP_TIME,Time[kontrol]);        // Set timeOrderTime+40*PeriodSeconds()
      ObjectSetDouble(ChartID(),sparam+"-ShootingStar-Control-"+kontrol,OBJPROP_PRICE,Low[kontrol]);// Set price
      ObjectSetInteger(ChartID(),sparam+"-ShootingStar-Control-"+kontrol,OBJPROP_ANCHOR,ANCHOR_UPPER);    // Set the arrow code
      ObjectSetInteger(ChartID(),sparam+"-ShootingStar-Control-"+kontrol,OBJPROP_FONTSIZE,8); 
      //ObjectSetInteger(ChartID(),sparam+"-ShootingStar-Control-"+kontrol,OBJPROP_COLOR,clrBlack);
      
      
      
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-Control-"+kontrol,OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-Control-"+kontrol,OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-Control-"+kontrol,OBJPROP_STYLE,STYLE_DASHDOTDOT);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-Control-"+kontrol,OBJPROP_COLOR,clrDarkRed);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-Control-"+kontrol,OBJPROP_SELECTABLE,false);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-Control-"+kontrol,OBJPROP_SELECTED,false);
ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrDarkRed);
}


//if ( kontrol_uyari ) Alert("Dikkat");
//Print(kontrol);

}
}
/////////////////////////////////////////////////////////////////////////////////////////////////////






//Alert("Selam");


      long chartid=ChartID();      
      string OrderLine=sparam+"-ShootingStar-Time";
      ObjectDelete(OrderLine);
      ObjectCreate(ChartID(),OrderLine,OBJ_TEXT,0,Time[shift1],High[shift1],0,0);          // Create an arrow
      ObjectSetText(OrderLine,TFtoStr(Period()),8,"Arial",clrWhite);    
      ObjectSetString(ChartID(),OrderLine,OBJPROP_TOOLTIP,TFtoStr(Period()));      
      //ObjectSetInteger(ChartID(),OrderLine,OBJPROP_COLOR,clrDarkGray);
      //if ( ChartID() == chartid ) ObjectSetInteger(ChartID(),OrderLine,OBJPROP_COLOR,clrLimeGreen);
      


ObjectSetDouble(ChartID(),sparam,OBJPROP_PRICE1,Low[shift1]);
ObjectSetDouble(ChartID(),sparam,OBJPROP_PRICE2,Low[shift2]);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-31",OBJPROP_TIME1,Time[shift1]);
ObjectSetDouble(ChartID(),sparam+"-ShootingStar-31",OBJPROP_PRICE1,Low[shift1]);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-31",OBJPROP_TIME2,Time[shift2]);
ObjectSetDouble(ChartID(),sparam+"-ShootingStar-31",OBJPROP_PRICE2,Low[shift2]);

price1=Low[shift1];
price2=Low[shift2];




if ( multi_mod == true && last_mode_vline_price !=-1 ) {

price1=last_mode_vline_price;
shift1=last_mode_vline_shift;
/*
last_mode_vline="";
last_mode_vline_time=-1;
last_mode_vline_price=-1;
last_mode_vline_shift=-1;*/

ObjectSetInteger(ChartID(),sparam,OBJPROP_TIME1,Time[shift1]);
ObjectSetDouble(ChartID(),sparam,OBJPROP_PRICE1,Low[shift1]);
ObjectSetDouble(ChartID(),sparam,OBJPROP_PRICE2,Low[shift2]);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-31",OBJPROP_TIME1,Time[shift1]);
ObjectSetDouble(ChartID(),sparam+"-ShootingStar-31",OBJPROP_PRICE1,Low[shift1]);

}




///////////////////////////////////////////////////////////////////////////////////////////////////////////////
mod_change=false;


if ( multi_mod ) {

if ( mod_price == -1 && mod_prices == -1 ) {
mod_price = NormalizeDouble(price2,Digits);
mod_prices = price1;
}


if ( NormalizeDouble(mod_price,Digits) == NormalizeDouble(price2,Digits) && mod_prices != price1) {
last_mod_prices=mod_prices;
Comment("last_mod_prices",last_mod_prices);
//Alert("Üst Sabit - Alt Değişti",mod_price,"/",price2,"/",price1,"/",mod_prices);
mod_price = NormalizeDouble(price2,Digits);
mod_prices = price1;
mod_change = true;
//return;
} else {
mod_type = "LOWUP";
mod_price = NormalizeDouble(price2,Digits);
//mod_price = price2;
mod_prices = price1;
}
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////





///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
ObjectDelete(ChartID(),sparam+"-ShootingStar-666");
ObjectCreate(ChartID(),sparam+"-ShootingStar-666",OBJ_TREND,0,time2,price2,time2+(time2-time1),price1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-666",OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-666",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-666",OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-666",OBJPROP_BACK,true);


ObjectDelete(ChartID(),sparam+"-ShootingStar-333");
ObjectCreate(ChartID(),sparam+"-ShootingStar-333",OBJ_TREND,0,time1,price1,time1+(time2-time1),price1+(price1-price2));
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333",OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333",OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333",OBJPROP_BACK,true);

//Alert("Selam2");



//double price=ObjectGetValueByShift("MyTrendLine#123", 11)

int shift=ObjectGetShiftByValue(sparam+"-ShootingStar-666", price1);
//Alert(shift);


double SS888=price1;

string namel=sparam+"-ShootingStar-888";

if ( mod_change ) namel=sparam+"-ShootingStar-888-"+mod_prices;


ObjectDelete(ChartID(),namel);
if ( shift > -1 ) ObjectCreate(ChartID(),namel,OBJ_TREND,0,time1,price1,Time[shift],price1);
if ( shift < 0 ) ObjectCreate(ChartID(),namel,OBJ_TREND,0,time1,price1,Time[0]+MathAbs(shift)*PeriodSeconds(),price1);
/*{ 
 } else {
shift=1; // Hafa verdiği için ekledim.
ObjectCreate(ChartID(),sparam+"-ShootingStar-888",OBJ_TREND,0,time1,price1,Time[shift],price1);
}*/
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),namel,OBJPROP_BACK,true);








double SS1618s=High[shift1]+((High[shift1]-Low[shift2])/100)*61.8;

namel=sparam+"-ShootingStar-16x18";

//if ( mod_change ) namel=sparam+"-ShootingStar-888-"+mod_prices;

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time1,SS1618s,time2+PeriodSeconds()*1100,SS1618s);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,clrLimeGreen);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),namel,OBJPROP_BACK,true);
//ObjectSetString(ChartID(),namel,OBJPROP_TOOLTIP,"Deneme");

double SS1414s=High[shift1]+((High[shift1]-Low[shift2])/100)*41.4;

namel=sparam+"-ShootingStar-14x14";

//if ( mod_change ) namel=sparam+"-ShootingStar-888-"+mod_prices;

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time1,SS1414s,time2+PeriodSeconds()*1100,SS1414s);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,clrDarkGray);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),namel,OBJPROP_BACK,true);
//ObjectSetString(ChartID(),namel,OBJPROP_TOOLTIP,"Deneme");

double SS1272s=High[shift1]+((High[shift1]-Low[shift2])/100)*27.2;

namel=sparam+"-ShootingStar-12x72";

//if ( mod_change ) namel=sparam+"-ShootingStar-888-"+mod_prices;

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time1,SS1272s,time2+PeriodSeconds()*1100,SS1272s);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),namel,OBJPROP_BACK,true);
//ObjectSetString(ChartID(),namel,OBJPROP_TOOLTIP,"Deneme");








/*
//shift=ObjectGetShiftByValue(sparam+"-ShootingStar-666", price1);
ObjectDelete(ChartID(),sparam+"-ShootingStar-999");
if ( shift > -1 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-999",OBJ_TRIANGLE,0,time1,price1,time2,price2,Time[0]+MathAbs(shift)*PeriodSeconds(),price1);
if ( shift < 0 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-999",OBJ_TRIANGLE,0,time1,price1,time2,price2,Time[shift],price1);
*/
/*
ObjectDelete(ChartID(),sparam+"-ShootingStar-999");
if ( shift < 0 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-999",OBJ_TRIANGLE,0,time1,price1,time2,price2,Time[0]+MathAbs(shift)*PeriodSeconds(),price1);
if ( shift > -1 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-999",OBJ_TRIANGLE,0,time1,price1,time2,price2,Time[shift],price1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-999",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-999",OBJPROP_COLOR,clrBisque);*/
/*
shift=ObjectGetShiftByValue(sparam+"-ShootingStar-666", price2+(High[shift1]-Low[shift1]));

ObjectDelete(ChartID(),sparam+"-ShootingStar-222");
if ( shift < -1 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-222",OBJ_TREND,0,time1,High[shift1],Time[0]+MathAbs(shift)*PeriodSeconds(),price2+(High[shift1]-Low[shift1]));
if ( shift >= 0 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-222",OBJ_TREND,0,time1,High[shift1],Time[shift],price2+(High[shift1]-Low[shift1]));
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222",OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222",OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222",OBJPROP_RAY,false);
*/




int x=0;
for (int t=1;t<=150;t++) {
x=t-1;

//if ( price2+((High[shift1]-Low[shift1])*t) > Low[shift2]+(((price1-price2)/100)*88.6) ) continue;



shift=ObjectGetShiftByValue(sparam+"-ShootingStar-666", price2+((High[shift1]-Low[shift1])*t));

ObjectDelete(ChartID(),sparam+"-ShootingStar-222-"+t);
if ( shift < -1 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-222-"+t,OBJ_TREND,0,time1,High[shift1]+((High[shift1]-Low[shift1])*x),Time[0]+MathAbs(shift)*PeriodSeconds(),price2+((High[shift1]-Low[shift1])*t));
if ( shift >= 0 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-222-"+t,OBJ_TREND,0,time1,High[shift1]+((High[shift1]-Low[shift1])*x),Time[shift],price2+((High[shift1]-Low[shift1])*t));
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222-"+t,OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222-"+t,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222-"+t,OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222-"+t,OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222-"+t,OBJPROP_RAY,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222-"+t,OBJPROP_TIMEFRAMES, -1);

ObjectDelete(ChartID(),sparam+"-ShootingStar-1222-"+t);

if ( shift < -1 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-1222-"+t,OBJ_TREND,0,time1,High[shift1]+((High[shift1]-Low[shift1])*t),Time[0]+MathAbs(shift)*PeriodSeconds(),price2+((High[shift1]-Low[shift1])*x));
if ( shift >= 0 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-1222-"+t,OBJ_TREND,0,time1,High[shift1]+((High[shift1]-Low[shift1])*t),Time[shift],price2+((High[shift1]-Low[shift1])*x));
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1222-"+t,OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1222-"+t,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1222-"+t,OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1222-"+t,OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1222-"+t,OBJPROP_RAY,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1222-"+t,OBJPROP_TIMEFRAMES, -1);
}




x=0;
for (int t=1;t<=150;t++) {
x=t-1;

shift=ObjectGetShiftByValue(sparam+"-ShootingStar-31", price1+((High[shift1]-Low[shift1])*t));


ObjectDelete(ChartID(),sparam+"-ShootingStar-333-"+t);
ObjectCreate(ChartID(),sparam+"-ShootingStar-333-"+t,OBJ_TREND,0,time1,Low[shift1]-((High[shift1]-Low[shift1])*t),time1+(time2-time1),(price1-(price2-price1))-((High[shift1]-Low[shift1])*x));
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_TIMEFRAMES, -1);


ObjectDelete(ChartID(),sparam+"-ShootingStar-1333-"+t);
ObjectCreate(ChartID(),sparam+"-ShootingStar-1333-"+t,OBJ_TREND,0,time1,Low[shift1]-((High[shift1]-Low[shift1])*x),time1+(time2-time1),(price1-(price2-price1))-((High[shift1]-Low[shift1])*t));
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1333-"+t,OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1333-"+t,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1333-"+t,OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1333-"+t,OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1333-"+t,OBJPROP_TIMEFRAMES, -1);

/*if ( shift < -1 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-333-"+t,OBJ_TREND,0,time1,Low[shift1]+((High[shift1]-Low[shift1])*x),Time[0]+MathAbs(shift)*PeriodSeconds(),price1+((High[shift1]-Low[shift1])*t));
if ( shift >= 0 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-333-"+t,OBJ_TREND,0,time1,Low[shift1]+((High[shift1]-Low[shift1])*x),Time[shift],price1+((High[shift1]-Low[shift1])*t));
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_RAY,true);*/


}




/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////


double SS618=High[shift1]-(((High[shift1]-price2)/100)*61.8);
ObjectDelete(ChartID(),sparam+"-ShootingStar-618");
ObjectCreate(ChartID(),sparam+"-ShootingStar-618",OBJ_TREND,0,time1,SS618,time2,SS618);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-618",OBJPROP_COLOR,clrLightBlue);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-618",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-618",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-618",OBJPROP_BACK,true);

double SS382=High[shift1]-(((High[shift1]-price2)/100)*38.2);
ObjectDelete(ChartID(),sparam+"-ShootingStar-382");
ObjectCreate(ChartID(),sparam+"-ShootingStar-382",OBJ_TREND,0,time1,SS382,time2,SS382);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-382",OBJPROP_COLOR,clrLightBlue);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-382",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-382",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-382",OBJPROP_BACK,true);



double SS500=High[shift1]-(((High[shift1]-price2)/100)*50);
ObjectDelete(ChartID(),sparam+"-ShootingStar-500");
ObjectCreate(ChartID(),sparam+"-ShootingStar-500",OBJ_TREND,0,time1,SS500,time2,SS500);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-500",OBJPROP_COLOR,clrLightBlue);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-500",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-500",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-500",OBJPROP_BACK,true);


double SS236=High[shift1]-(((High[shift1]-price2)/100)*23.6);
ObjectDelete(ChartID(),sparam+"-ShootingStar-236");
ObjectCreate(ChartID(),sparam+"-ShootingStar-236",OBJ_TREND,0,time1,SS236,time2,SS236);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-236",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-236",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-236",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-236",OBJPROP_BACK,true);

double SS854=High[shift1]-(((High[shift1]-price2)/100)*85.4);
ObjectDelete(ChartID(),sparam+"-ShootingStar-854");
ObjectCreate(ChartID(),sparam+"-ShootingStar-854",OBJ_TREND,0,time1,SS854,time2,SS854);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-854",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-854",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-854",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-854",OBJPROP_BACK,true);

double SS736=High[shift1]-(((High[shift1]-price2)/100)*73.6);
ObjectDelete(ChartID(),sparam+"-ShootingStar-736");
ObjectCreate(ChartID(),sparam+"-ShootingStar-736",OBJ_TREND,0,time1,SS736,time2,SS736);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-736",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-736",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-736",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-736",OBJPROP_BACK,true);

double SS354=High[shift1]-(((High[shift1]-price2)/100)*35.4);
ObjectDelete(ChartID(),sparam+"-ShootingStar-354");
ObjectCreate(ChartID(),sparam+"-ShootingStar-354",OBJ_TREND,0,time1,SS354,time2,SS354); // 236 + 118
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-354",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-354",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-354",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-354",OBJPROP_BACK,true);

double SS309=High[shift1]-(((High[shift1]-price2)/100)*30.9);
ObjectDelete(ChartID(),sparam+"-ShootingStar-309");
ObjectCreate(ChartID(),sparam+"-ShootingStar-309",OBJ_TREND,0,time1,SS309,time2,SS309); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-309",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-309",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-309",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-309",OBJPROP_BACK,true);

double SS441=High[shift1]-(((High[shift1]-price2)/100)*44.1);
ObjectDelete(ChartID(),sparam+"-ShootingStar-441");
ObjectCreate(ChartID(),sparam+"-ShootingStar-441",OBJ_TREND,0,time1,SS441,time2,SS441); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-441",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-441",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-441",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-441",OBJPROP_BACK,true);

double SS559=High[shift1]-(((High[shift1]-price2)/100)*55.9);
ObjectDelete(ChartID(),sparam+"-ShootingStar-559");
ObjectCreate(ChartID(),sparam+"-ShootingStar-559",OBJ_TREND,0,time1,SS559,time2,SS559); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-559",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-559",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-559",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-559",OBJPROP_BACK,true);

double SS677=High[shift1]-(((High[shift1]-price2)/100)*67.7);
ObjectDelete(ChartID(),sparam+"-ShootingStar-677");
ObjectCreate(ChartID(),sparam+"-ShootingStar-677",OBJ_TREND,0,time1,SS677,time2,SS677); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-677",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-677",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-677",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-677",OBJPROP_BACK,true);

double SS795=High[shift1]-(((High[shift1]-price2)/100)*79.5);
ObjectDelete(ChartID(),sparam+"-ShootingStar-795");
ObjectCreate(ChartID(),sparam+"-ShootingStar-795",OBJ_TREND,0,time1,SS795,time2,SS795); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-795",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-795",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-795",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-795",OBJPROP_BACK,true);

double SS913=High[shift1]-(((High[shift1]-price2)/100)*91.3);
ObjectDelete(ChartID(),sparam+"-ShootingStar-913");
ObjectCreate(ChartID(),sparam+"-ShootingStar-913",OBJ_TREND,0,time1,SS913,time2,SS913); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-913",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-913",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-913",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-913",OBJPROP_BACK,true);

//
double SS177=High[shift1]-(((High[shift1]-price2)/100)*17.7);
ObjectDelete(ChartID(),sparam+"-ShootingStar-117");
ObjectCreate(ChartID(),sparam+"-ShootingStar-177",OBJ_TREND,0,time1,SS177,time2,SS177); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-177",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-177",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-177",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-177",OBJPROP_BACK,true);


double SS118f=High[shift1]-(((High[shift1]-price2)/100)*11.8);
ObjectDelete(ChartID(),sparam+"-ShootingStar-118f");
ObjectCreate(ChartID(),sparam+"-ShootingStar-118f",OBJ_TREND,0,time1,SS118f,time2,SS118f); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-118f",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-118f",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-118f",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-118f",OBJPROP_BACK,true);

double SS59=High[shift1]-(((High[shift1]-price2)/100)*5.9);
ObjectDelete(ChartID(),sparam+"-ShootingStar-59");
ObjectCreate(ChartID(),sparam+"-ShootingStar-59",OBJ_TREND,0,time1,SS59,time2,SS59); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-59",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-59",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-59",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-59",OBJPROP_BACK,true);



double SS1272=High[shift1]-(((High[shift1]-price2)/100)*127.2);
ObjectDelete(ChartID(),sparam+"-ShootingStar-1272");
ObjectCreate(ChartID(),sparam+"-ShootingStar-1272",OBJ_TREND,0,time1,SS1272,time2,SS1272); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1272",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1272",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1272",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1272",OBJPROP_BACK,true);

double SS1118=High[shift1]-(((High[shift1]-price2)/100)*111.8);
ObjectDelete(ChartID(),sparam+"-ShootingStar-1118");
//ObjectCreate(ChartID(),sparam+"-ShootingStar-1118",OBJ_TREND,0,time1,SS1118,time2,SS1118); // (382-236)=146/2=73 + 236=
ObjectCreate(ChartID(),sparam+"-ShootingStar-1118",OBJ_TREND,0,time1,SS1118,time2,SS1118); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1118",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1118",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1118",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1118",OBJPROP_BACK,true);

double SS1414=High[shift1]-(((High[shift1]-price2)/100)*141.4);
ObjectDelete(ChartID(),sparam+"-ShootingStar-1414");
ObjectCreate(ChartID(),sparam+"-ShootingStar-1414",OBJ_TREND,0,time1,SS1414,time2,SS1414); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1414",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1414",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1414",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1414",OBJPROP_BACK,true);

double SS1618=High[shift1]-(((High[shift1]-price2)/100)*161.8);
ObjectDelete(ChartID(),sparam+"-ShootingStar-1618");
//ObjectCreate(ChartID(),sparam+"-ShootingStar-1618",OBJ_TREND,0,time1,SS1618,time2,SS1414); // (382-236)=146/2=73 + 236=
ObjectCreate(ChartID(),sparam+"-ShootingStar-1618",OBJ_TREND,0,time1,SS1618,time2,SS1618); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1618",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1618",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1618",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1618",OBJPROP_BACK,true);

double SS2618=High[shift1]-(((High[shift1]-price2)/100)*261.8);
ObjectDelete(ChartID(),sparam+"-ShootingStar-2618");
//ObjectCreate(ChartID(),sparam+"-ShootingStar-1618",OBJ_TREND,0,time1,SS1618,time2,SS1414); // (382-236)=146/2=73 + 236=
ObjectCreate(ChartID(),sparam+"-ShootingStar-2618",OBJ_TREND,0,time1,SS2618,time2,SS2618); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-2618",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-2618",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-2618",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-2618",OBJPROP_BACK,true);


//////////////////////////////////////////////////////////

double SS1272n=High[shift1]+(((High[shift1]-price2)/100)*27.2);
ObjectDelete(ChartID(),sparam+"-ShootingStar-1272n");
ObjectCreate(ChartID(),sparam+"-ShootingStar-1272n",OBJ_TREND,0,time1,SS1272n,time2,SS1272n); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1272n",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1272n",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1272n",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1272n",OBJPROP_BACK,true);

double SS1118n=High[shift1]+(((High[shift1]-price2)/100)*11.8);
ObjectDelete(ChartID(),sparam+"-ShootingStar-1118n");
//ObjectCreate(ChartID(),sparam+"-ShootingStar-1118",OBJ_TREND,0,time1,SS1118,time2,SS1118); // (382-236)=146/2=73 + 236=
ObjectCreate(ChartID(),sparam+"-ShootingStar-1118n",OBJ_TREND,0,time1,SS1118n,time2,SS1118n); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1118n",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1118n",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1118n",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1118n",OBJPROP_BACK,true);

double SS1414n=High[shift1]+(((High[shift1]-price2)/100)*41.4);
ObjectDelete(ChartID(),sparam+"-ShootingStar-1414n");
ObjectCreate(ChartID(),sparam+"-ShootingStar-1414n",OBJ_TREND,0,time1,SS1414n,time2,SS1414n); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1414n",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1414n",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1414n",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1414n",OBJPROP_BACK,true);

double SS1618n=High[shift1]+(((High[shift1]-price2)/100)*61.8);
ObjectDelete(ChartID(),sparam+"-ShootingStar-1618n");
//ObjectCreate(ChartID(),sparam+"-ShootingStar-1618",OBJ_TREND,0,time1,SS1618,time2,SS1414); // (382-236)=146/2=73 + 236=
ObjectCreate(ChartID(),sparam+"-ShootingStar-1618n",OBJ_TREND,0,time1,SS1618n,time2,SS1618n); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1618n",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1618n",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1618n",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1618n",OBJPROP_BACK,true);

//Alert(shift1,"/",price2);
double SS2618n=High[shift1]+(((High[shift1]-price2)/100)*161.8);
ObjectDelete(ChartID(),sparam+"-ShootingStar-2618n");
//ObjectCreate(ChartID(),sparam+"-ShootingStar-1618",OBJ_TREND,0,time1,SS1618,time2,SS1414); // (382-236)=146/2=73 + 236=
ObjectCreate(ChartID(),sparam+"-ShootingStar-2618n",OBJ_TREND,0,time1,SS2618n,time2,SS2618n); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-2618n",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-2618n",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-2618n",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-2618n",OBJPROP_BACK,true);







double SS827=Low[shift2]+(((price1-price2)/100)*87.6);

namel=sparam+"-ShootingStar-827";

if ( mod_change ) namel=sparam+"-ShootingStar-827-"+mod_prices;

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time2,SS827,time2+PeriodSeconds()*11,SS827);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),namel,OBJPROP_BACK,true);
//ObjectSetInteger(ChartID(),sparam+"-ShootingStar-827",OBJPROP_RAY,false);



double SS842=Low[shift2]+(((price1-price2)/100)*84.2);

namel=sparam+"-ShootingStar-842";

if ( mod_change ) namel=sparam+"-ShootingStar-842-"+mod_prices;

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time2,SS842,time2+PeriodSeconds()*11,SS842);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),namel,OBJPROP_BACK,true);
//ObjectSetInteger(ChartID(),sparam+"-ShootingStar-827",OBJPROP_RAY,false);



double SS864=Low[shift2]+(((price1-price2)/100)*86.4);

namel=sparam+"-ShootingStar-864";

if ( mod_change ) namel=sparam+"-ShootingStar-864-"+mod_prices;

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time2,SS864,time2+PeriodSeconds()*11,SS864);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,1);
ObjectSetInteger(ChartID(),namel,OBJPROP_BACK,true);
//ObjectSetInteger(ChartID(),sparam+"-ShootingStar-827",OBJPROP_RAY,false);




double SS886=Low[shift2]+(((price1-price2)/100)*88.6);

namel=sparam+"-ShootingStar-886";

if ( mod_change ) namel=sparam+"-ShootingStar-886-"+mod_prices;

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time1,SS886,time2,SS886);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),namel,OBJPROP_BACK,true);
//ObjectSetString(ChartID(),namel,OBJPROP_TOOLTIP,"Deneme");



SSSL=price1+(price1-SS886);

namel=sparam+"-ShootingStar-SL";
ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time1,SSSL,time2,SSSL);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,clrDarkGray);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),namel,OBJPROP_BACK,true);
//ObjectSetString(ChartID(),namel,OBJPROP_TOOLTIP,"Deneme");


for (int slt=2;slt<=10;slt++){

namel=sparam+"-ShootingStar-SL"+slt;

SSSL=price1+((price1-SS886)*slt);

//if ( mod_change ) namel=sparam+"-ShootingStar-886-"+mod_prices;

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time1,SSSL,time2,SSSL);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,clrRed);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),namel,OBJPROP_BACK,true);
//ObjectSetString(ChartID(),namel,OBJPROP_TOOLTIP,"Deneme");

}

SSSL=price1+((price1-SS886)*2);






double SS786=Low[shift2]+(((price1-price2)/100)*78.6);

namel=sparam+"-ShootingStar-786";

if ( mod_change ) namel=sparam+"-ShootingStar-786-"+mod_prices;

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time1,SS786,time2,SS786);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,clrMaroon);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,4);



double SS707=Low[shift2]+(((price1-price2)/100)*70.7);

namel=sparam+"-ShootingStar-707";

if ( mod_change ) namel=sparam+"-ShootingStar-707-"+mod_prices;

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time1,SS707,time2,SS707);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,clrGoldenrod);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,2);



double SS764=Low[shift2]+(((price1-price2)/100)*76.4);

namel=sparam+"-ShootingStar-764";

if ( mod_change ) namel=sparam+"-ShootingStar-764-"+mod_prices;

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time1,SS764,time2,SS764);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,clrBlue);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,3);


int spread=(MarketInfo(Symbol(),MODE_ASK)-MarketInfo(Symbol(),MODE_BID))/Point;
int fark = int((SS886-SS764)/Point);

//Comment("Pip:",fark,"/",spread,"=",fark/spread,"/",(fark-spread));
Comment("Pip:",fark,"/",spread,"/",(fark-spread));

//Alert("Selam3",SS886,"/",shift1);

//////////////////////////////////////////////////////
// Seviyeyi geçip geçmediğini kontrol eden çubukları ayarlıyor
//////////////////////////////////////////////////////
int shiftc=1;
if ( shift1 > 1000 ) {

int shift886=ObjectGetShiftByValue(sparam+"-ShootingStar-666", SS886);

ObjectDelete(ChartID(),sparam+"CONTROL");
//ObjectCreate(ChartID(),sparam+"CONTROL",OBJ_VLINE,0,Time[shift886],SS886);

if ( shift886 > 0 ) ObjectCreate(ChartID(),sparam+"CONTROL",OBJ_VLINE,0,Time[shift886],SS886);
if ( shift886 < -0 ) {
datetime ctime=Time[0]+MathAbs(shift886)*PeriodSeconds();
ObjectCreate(ChartID(),sparam+"CONTROL",OBJ_VLINE,0,ctime,SS886);
}


shiftc=shift1-((shift1-shift886)*2);
if ( shiftc < 0 ) shiftc=1;
} 
/////////////////////////////////////////////////////



for(int c=shiftc;c<=shift1-10;c++){

ObjectDelete(ChartID(),sparam+"CONTROL"+c);

if ( High[c] >= SS886 && Close[c] < SS886 ) {


      ObjectCreate(ChartID(),sparam+"CONTROL"+c,OBJ_ARROW,0,0,0,0,0);          // Create an arrow
      ObjectSetInteger(ChartID(),sparam+"CONTROL"+c,OBJPROP_ARROWCODE,108);    // Set the arrow code
      ObjectSetInteger(ChartID(),sparam+"CONTROL"+c,OBJPROP_TIME,Time[c]);        // Set timeOrderTime+40*PeriodSeconds()
      ObjectSetDouble(ChartID(),sparam+"CONTROL"+c,OBJPROP_PRICE,High[c]);// Set price
      ObjectSetInteger(ChartID(),sparam+"CONTROL"+c,OBJPROP_ANCHOR,ANCHOR_UPPER);    // Set the arrow code
      ObjectSetInteger(ChartID(),sparam+"CONTROL"+c,OBJPROP_FONTSIZE,8); 
      //ObjectSetInteger(ChartID(),sparam+"CONTROL"+c,OBJPROP_COLOR,clrBlack);



//ObjectCreate(ChartID(),sparam+"CONTROL"+c,OBJ_VLINE,0,Time[c],Close[c]);
ObjectSetInteger(ChartID(),sparam+"CONTROL"+c,OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam+"CONTROL"+c,OBJPROP_WIDTH,3);
ObjectSetInteger(ChartID(),sparam+"CONTROL"+c,OBJPROP_COLOR,clrDarkGray);





}

//Print(c);

}



for(int c=shiftc;c<=shift1-10;c++){

ObjectDelete(ChartID(),sparam+"CONTROLL"+c);

if ( High[c] >= SS764 && Open[c] < SS764 ) {


      ObjectCreate(ChartID(),sparam+"CONTROLL"+c,OBJ_ARROW,0,0,0,0,0);          // Create an arrow
      ObjectSetInteger(ChartID(),sparam+"CONTROLL"+c,OBJPROP_ARROWCODE,108);    // Set the arrow code
      ObjectSetInteger(ChartID(),sparam+"CONTROLL"+c,OBJPROP_TIME,Time[c]);        // Set timeOrderTime+40*PeriodSeconds()
      ObjectSetDouble(ChartID(),sparam+"CONTROLL"+c,OBJPROP_PRICE,Close[c]);// Set price
      ObjectSetInteger(ChartID(),sparam+"CONTROLL"+c,OBJPROP_ANCHOR,ANCHOR_UPPER);    // Set the arrow code
      ObjectSetInteger(ChartID(),sparam+"CONTROLL"+c,OBJPROP_FONTSIZE,8); 
      //ObjectSetInteger(ChartID(),sparam+"CONTROL"+c,OBJPROP_COLOR,clrBlack);



//ObjectCreate(ChartID(),sparam+"CONTROL"+c,OBJ_VLINE,0,Time[c],Close[c]);
ObjectSetInteger(ChartID(),sparam+"CONTROLL"+c,OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam+"CONTROLL"+c,OBJPROP_WIDTH,3);
ObjectSetInteger(ChartID(),sparam+"CONTROLL"+c,OBJPROP_COLOR,clrLawnGreen);





}

//Print(c);

}




if ( order_mode == true ) {

order1=NormalizeDouble(SS886,Digits);
order2=NormalizeDouble(Low[shift1],Digits);
tp=NormalizeDouble(SS764,Digits);
tp1=NormalizeDouble(SS764,Digits);
tp3=NormalizeDouble(SS618,Digits);
sl=NormalizeDouble(High[shift1],Digits);

string ordercmt=Symbol()+"-"+sparam+"-"+TFtoStr(Period())+"-1";
//int ticket=OrderSend(Symbol(),OP_SELLLIMIT,0.01,order1,0,sl,tp,ordercmt,0,0,clrNONE);

tp=NormalizeDouble(SS786,Digits);
tp2=NormalizeDouble(SS786,Digits);
ordercmt=Symbol()+"-"+sparam+"-"+TFtoStr(Period())+"-2";
//int ticket2=OrderSend(Symbol(),OP_SELLLIMIT,0.01,order2,0,sl,tp,ordercmt,0,0,clrNONE);


order3=NormalizeDouble(SS864,Digits);
ordercmt=Symbol()+"-"+sparam+"-"+TFtoStr(Period())+"-3";
//int ticket3=OrderSend(Symbol(),OP_SELLLIMIT,0.01,order1,0,sl,tp,ordercmt,0,0,clrNONE);

order_type=OP_SELLLIMIT;
//order_mode=false;

}






double SS118=Low[shift2]+(((price1-price2)/100)*11.8);

namel=sparam+"-ShootingStar-118";

if ( mod_change ) namel=sparam+"-ShootingStar-118-"+mod_prices;

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time2,SS118,time2+PeriodSeconds()*11,SS118);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,clrBisque);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),namel,OBJPROP_BACK,true);




ObjectSetString(ChartID(),sparam+"-ShootingStar-Time",OBJPROP_TOOLTIP,int((SS842-SS786)/Point)+"="+int((Bid-SS842)/Point)+"/"+int((SS888-SS886)/Point)+"="+int((Bid-SS888)/Point));

if ( (int((SS842-SS786)/Point) > 100 && Bid < SS842) || (int((SS888-SS886)/Point) > 100 && Bid < SS888) ) {
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-Time",OBJPROP_COLOR,clrGold);
} else {
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-Time",OBJPROP_COLOR,clrWhite);
}





}




//if ( price2 > price1 ) {
if ( price1 < price2 ) {

///Alert("Selam2");
///////////////////////////////////////////////////////////////////////////////////////////////////////
// Yeni Kontrol Sistemi - Önceki Ölçüm Yeri Tespiti ( Hatalı İşlem Uyarısı ) 
///////////////////////////////////////////////////////////////////////////////////////////////////////
for (int kontrol=WindowFirstVisibleBar();kontrol>0;kontrol--) {
ObjectDelete(ChartID(),sparam+"-ShootingStar-Control-"+kontrol);
ObjectDelete(ChartID(),sparam+"CONTROL"+kontrol);
}

int kontrolend=shift1-10;

if ( kontrolend < shift2 ) kontrolend=shift2+1;

bool kontrol_uyari=false;

if ( kontrolend > 1 ) {
for (int kontrol=kontrolend;kontrol<shift1-1;kontrol++) {
ObjectDelete(ChartID(),sparam+"-ShootingStar-Control-"+kontrol);
if ( Open[kontrol] > Close[kontrol] && Close[kontrol+1] > Open[kontrol+1]  ) {
kontrol_uyari=true;
//ObjectCreate(ChartID(),sparam+"-ShootingStar-Control-"+kontrol,OBJ_VLINE,0,Time[kontrol],Ask);


      //OrderLine="FeOrderDelete"+Symbol();
      //OrderTime=Time[WindowFirstVisibleBar()-40];
      ObjectCreate(ChartID(),sparam+"-ShootingStar-Control-"+kontrol,OBJ_ARROW,0,0,0,0,0);          // Create an arrow
      ObjectSetInteger(ChartID(),sparam+"-ShootingStar-Control-"+kontrol,OBJPROP_ARROWCODE,108);    // Set the arrow code
      ObjectSetInteger(ChartID(),sparam+"-ShootingStar-Control-"+kontrol,OBJPROP_TIME,Time[kontrol]);        // Set timeOrderTime+40*PeriodSeconds()
      ObjectSetDouble(ChartID(),sparam+"-ShootingStar-Control-"+kontrol,OBJPROP_PRICE,High[kontrol]);// Set price
      ObjectSetInteger(ChartID(),sparam+"-ShootingStar-Control-"+kontrol,OBJPROP_ANCHOR,ANCHOR_UPPER);    // Set the arrow code
      ObjectSetInteger(ChartID(),sparam+"-ShootingStar-Control-"+kontrol,OBJPROP_FONTSIZE,8); 
      //ObjectSetInteger(ChartID(),sparam+"-ShootingStar-Control-"+kontrol,OBJPROP_COLOR,clrBlack);
      

ObjectSetInteger(ChartID(),sparam+"-ShootingStar-Control-"+kontrol,OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-Control-"+kontrol,OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-Control-"+kontrol,OBJPROP_STYLE,STYLE_DASHDOTDOT);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-Control-"+kontrol,OBJPROP_COLOR,clrDarkRed);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-Control-"+kontrol,OBJPROP_SELECTABLE,false);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-Control-"+kontrol,OBJPROP_SELECTED,false);

ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrDarkRed);
}


//if ( kontrol_uyari ) Alert("Dikkat");
//Print(kontrol);
}
}
/////////////////////////////////////////////////////////////////////////////////////////////////////




      long chartid=ChartID();      
      string OrderLine=sparam+"-ShootingStar-Time";
      ObjectDelete(OrderLine);
      ObjectCreate(ChartID(),OrderLine,OBJ_TEXT,0,Time[shift1],Low[shift1],0,0);          // Create an arrow
      ObjectSetText(OrderLine,TFtoStr(Period()),8,"Arial",clrWhite);    
      ObjectSetString(ChartID(),OrderLine,OBJPROP_TOOLTIP,TFtoStr(Period()));      
      //ObjectSetInteger(ChartID(),OrderLine,OBJPROP_COLOR,clrDarkGray);
      //if ( ChartID() == chartid ) ObjectSetInteger(ChartID(),OrderLine,OBJPROP_COLOR,clrLimeGreen);
      
      
     
     
     


ObjectSetDouble(ChartID(),sparam,OBJPROP_PRICE1,High[shift1]);
ObjectSetDouble(ChartID(),sparam,OBJPROP_PRICE2,High[shift2]);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-31",OBJPROP_TIME1,Time[shift1]);
ObjectSetDouble(ChartID(),sparam+"-ShootingStar-31",OBJPROP_PRICE1,High[shift1]);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-31",OBJPROP_TIME2,Time[shift2]);
ObjectSetDouble(ChartID(),sparam+"-ShootingStar-31",OBJPROP_PRICE2,High[shift2]);

price1=High[shift1];
price2=High[shift2];


if ( multi_mod == true && last_mode_vline_price !=-1 ) {

price1=last_mode_vline_price;
shift1=last_mode_vline_shift;
/*
last_mode_vline="";
last_mode_vline_time=-1;
last_mode_vline_price=-1;
last_mode_vline_shift=-1;*/

ObjectSetInteger(ChartID(),sparam,OBJPROP_TIME1,Time[shift1]);
ObjectSetDouble(ChartID(),sparam,OBJPROP_PRICE1,High[shift1]);
ObjectSetDouble(ChartID(),sparam,OBJPROP_PRICE2,High[shift2]);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-31",OBJPROP_TIME1,Time[shift1]);
ObjectSetDouble(ChartID(),sparam+"-ShootingStar-31",OBJPROP_PRICE1,High[shift1]);

}



///////////////////////////////////////////////////////////////////////////////////////////////////////////////
mod_change=false;


if ( multi_mod ) {

if ( mod_price == -1 && mod_prices == -1 ) {
mod_price = NormalizeDouble(price2,Digits);
mod_prices = price1;
}

mod_type = "HIGHDOWN";

if ( NormalizeDouble(mod_price,Digits) == NormalizeDouble(price2,Digits) && mod_prices != price1) {
last_mod_prices=mod_prices;
Comment("last_mod_prices",last_mod_prices);
//Alert("Üst Sabit - Alt Değişti",mod_price,"/",price2,"/",price1,"/",mod_prices);
mod_price = NormalizeDouble(price2,Digits);
mod_prices = price1;
mod_change = true;
//return;
} else {

mod_price = NormalizeDouble(price2,Digits);
//mod_price = price2;
mod_prices = price1;
}
}

//Alert("Mod Type:",mod_type);

//////////////////////////////////////////////////////////////////////////////////////////////////////////////

//Alert("Selam3=",price2,"/",mod_price);
//

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
ObjectDelete(ChartID(),sparam+"-ShootingStar-666");
ObjectCreate(ChartID(),sparam+"-ShootingStar-666",OBJ_TREND,0,time2,price2,time2+(time2-time1),price1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-666",OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-666",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-666",OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-666",OBJPROP_BACK,true);

ObjectDelete(ChartID(),sparam+"-ShootingStar-333");
ObjectCreate(ChartID(),sparam+"-ShootingStar-333",OBJ_TREND,0,time1,price1,time1+(time2-time1),price1-(price2-price1));
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333",OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333",OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333",OBJPROP_BACK,true);





//double price=ObjectGetValueByShift("MyTrendLine#123", 11)

int shift=ObjectGetShiftByValue(sparam+"-ShootingStar-666", price1);
//Alert(shift);


double SS888=price1;

string namel=sparam+"-ShootingStar-888";

if ( mod_change ) namel=sparam+"-ShootingStar-888-"+mod_prices;

ObjectDelete(ChartID(),namel);
if ( shift > -1 ) ObjectCreate(ChartID(),namel,OBJ_TREND,0,time1,price1,Time[shift],price1);
if ( shift < 0 ) ObjectCreate(ChartID(),namel,OBJ_TREND,0,time1,price1,Time[0]+MathAbs(shift)*PeriodSeconds(),price1);
/*{ 
 } else {
shift=1; // Hafa verdiği için ekledim.
ObjectCreate(ChartID(),sparam+"-ShootingStar-888",OBJ_TREND,0,time1,price1,Time[shift],price1);
}*/
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),namel,OBJPROP_BACK,true);



double SS1618s=Low[shift1]-((High[shift2]-Low[shift1])/100)*61.8;

namel=sparam+"-ShootingStar-16x18";

//if ( mod_change ) namel=sparam+"-ShootingStar-888-"+mod_prices;

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time1,SS1618s,time2+PeriodSeconds()*1100,SS1618s);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,clrLimeGreen);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),namel,OBJPROP_BACK,true);
//ObjectSetString(ChartID(),namel,OBJPROP_TOOLTIP,"Deneme");

double SS1414s=Low[shift1]-((High[shift2]-Low[shift1])/100)*41.4;

namel=sparam+"-ShootingStar-14x14";

//if ( mod_change ) namel=sparam+"-ShootingStar-888-"+mod_prices;

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time1,SS1414s,time2+PeriodSeconds()*1100,SS1414s);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,clrDarkGray);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),namel,OBJPROP_BACK,true);
//ObjectSetString(ChartID(),namel,OBJPROP_TOOLTIP,"Deneme");

double SS1272s=Low[shift1]-((High[shift2]-Low[shift1])/100)*27.2;

namel=sparam+"-ShootingStar-12x72";

//if ( mod_change ) namel=sparam+"-ShootingStar-888-"+mod_prices;

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time1,SS1272s,time2+PeriodSeconds()*1100,SS1272s);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),namel,OBJPROP_BACK,true);
//ObjectSetString(ChartID(),namel,OBJPROP_TOOLTIP,"Deneme");


/*
//shift=ObjectGetShiftByValue(sparam+"-ShootingStar-666", price1);
ObjectDelete(ChartID(),sparam+"-ShootingStar-999");
if ( shift > -1 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-999",OBJ_TRIANGLE,0,time1,price1,time2,price2,Time[0]+MathAbs(shift)*PeriodSeconds(),price1);
if ( shift < 0 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-999",OBJ_TRIANGLE,0,time1,price1,time2,price2,Time[shift],price1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-999",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-999",OBJPROP_COLOR,clrBisque);
*/
/*
ObjectDelete(ChartID(),sparam+"-ShootingStar-999");
if ( shift < 0 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-999",OBJ_TRIANGLE,0,time1,price1,time2,price2,Time[0]+MathAbs(shift)*PeriodSeconds(),price1);
if ( shift > -1 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-999",OBJ_TRIANGLE,0,time1,price1,time2,price2,Time[shift],price1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-999",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-999",OBJPROP_COLOR,clrBisque);*/

shift=ObjectGetShiftByValue(sparam+"-ShootingStar-666", price2-(High[shift1]-Low[shift1]));
/*
ObjectDelete(ChartID(),sparam+"-ShootingStar-222");
if ( shift < -1 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-222",OBJ_TREND,0,time1,Low[shift1],Time[0]+MathAbs(shift)*PeriodSeconds(),price2-(High[shift1]-Low[shift1]));
if ( shift >= 0 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-222",OBJ_TREND,0,time1,Low[shift1],Time[shift],price2-(High[shift1]-Low[shift1]));
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222",OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222",OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222",OBJPROP_RAY,false);
*/
int x=0;
for (int t=1;t<=150;t++) {
x=t-1;

shift=ObjectGetShiftByValue(sparam+"-ShootingStar-666", price2-((High[shift1]-Low[shift1])*t));

ObjectDelete(ChartID(),sparam+"-ShootingStar-222-"+t);
if ( shift < -1 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-222-"+t,OBJ_TREND,0,time1,Low[shift1]-((High[shift1]-Low[shift1])*x),Time[0]+MathAbs(shift)*PeriodSeconds(),price2-((High[shift1]-Low[shift1])*t));
if ( shift >= 0 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-222-"+t,OBJ_TREND,0,time1,Low[shift1]-((High[shift1]-Low[shift1])*x),Time[shift],price2-((High[shift1]-Low[shift1])*t));
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222-"+t,OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222-"+t,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222-"+t,OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222-"+t,OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222-"+t,OBJPROP_RAY,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222-"+t,OBJPROP_TIMEFRAMES, -1);

ObjectDelete(ChartID(),sparam+"-ShootingStar-1222-"+t);
if ( shift < -1 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-1222-"+t,OBJ_TREND,0,time1,Low[shift1]-((High[shift1]-Low[shift1])*t),Time[0]+MathAbs(shift)*PeriodSeconds(),price2-((High[shift1]-Low[shift1])*x));
if ( shift >= 0 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-1222-"+t,OBJ_TREND,0,time1,Low[shift1]-((High[shift1]-Low[shift1])*t),Time[shift],price2-((High[shift1]-Low[shift1])*x));
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1222-"+t,OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1222-"+t,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1222-"+t,OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1222-"+t,OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1222-"+t,OBJPROP_RAY,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1222-"+t,OBJPROP_TIMEFRAMES, -1);


}


/*
ObjectDelete(ChartID(),sparam+"-ShootingStar-333-x");
ObjectCreate(ChartID(),sparam+"-ShootingStar-333-x",OBJ_TREND,0,time1,price1+(High[shift1]-Low[shift1]),time1+(time2-time1),(price1-(price2-price1))+(High[shift1]-Low[shift1]));
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-x",OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-x",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-x",OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-x",OBJPROP_BACK,true);
*/




x=0;
for (int t=1;t<=150;t++) {
x=t-1;

shift=ObjectGetShiftByValue(sparam+"-ShootingStar-31", price1+((High[shift1]-Low[shift1])*t));


ObjectDelete(ChartID(),sparam+"-ShootingStar-333-"+t);
ObjectCreate(ChartID(),sparam+"-ShootingStar-333-"+t,OBJ_TREND,0,time1,Low[shift1]+((High[shift1]-Low[shift1])*t),time1+(time2-time1),(price1-(price2-price1))+((High[shift1]-Low[shift1])*x));
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_TIMEFRAMES, -1);

ObjectDelete(ChartID(),sparam+"-ShootingStar-1333-"+t);
ObjectCreate(ChartID(),sparam+"-ShootingStar-1333-"+t,OBJ_TREND,0,time1,Low[shift1]+((High[shift1]-Low[shift1])*x),time1+(time2-time1),(price1-(price2-price1))+((High[shift1]-Low[shift1])*t));
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1333-"+t,OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1333-"+t,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1333-"+t,OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1333-"+t,OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1333-"+t,OBJPROP_TIMEFRAMES, -1);

/*if ( shift < -1 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-333-"+t,OBJ_TREND,0,time1,Low[shift1]+((High[shift1]-Low[shift1])*x),Time[0]+MathAbs(shift)*PeriodSeconds(),price1+((High[shift1]-Low[shift1])*t));
if ( shift >= 0 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-333-"+t,OBJ_TREND,0,time1,Low[shift1]+((High[shift1]-Low[shift1])*x),Time[shift],price1+((High[shift1]-Low[shift1])*t));
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_RAY,true);*/


}






//Alert("Selam",price2);


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

double SS618=Low[shift1]+(((price2-Low[shift1])/100)*61.8);
ObjectDelete(ChartID(),sparam+"-ShootingStar-618");
ObjectCreate(ChartID(),sparam+"-ShootingStar-618",OBJ_TREND,0,time1,SS618,time2,SS618);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-618",OBJPROP_COLOR,clrLightBlue);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-618",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-618",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-618",OBJPROP_BACK,true);

double SS382=Low[shift1]+(((price2-Low[shift1])/100)*38.2);
ObjectDelete(ChartID(),sparam+"-ShootingStar-382");
ObjectCreate(ChartID(),sparam+"-ShootingStar-382",OBJ_TREND,0,time1,SS382,time2,SS382);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-382",OBJPROP_COLOR,clrLightBlue);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-382",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-382",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-382",OBJPROP_BACK,true);

double SS500=Low[shift1]+(((price2-Low[shift1])/100)*50);
ObjectDelete(ChartID(),sparam+"-ShootingStar-500");
ObjectCreate(ChartID(),sparam+"-ShootingStar-500",OBJ_TREND,0,time1,SS500,time2,SS500);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-500",OBJPROP_COLOR,clrLightBlue);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-500",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-500",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-500",OBJPROP_BACK,true);


double SS236=Low[shift1]+(((price2-Low[shift1])/100)*23.6);
ObjectDelete(ChartID(),sparam+"-ShootingStar-236");
ObjectCreate(ChartID(),sparam+"-ShootingStar-236",OBJ_TREND,0,time1,SS236,time2,SS236);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-236",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-236",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-236",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-236",OBJPROP_BACK,true);

double SS854=Low[shift1]+(((price2-Low[shift1])/100)*85.4);
ObjectDelete(ChartID(),sparam+"-ShootingStar-854");
ObjectCreate(ChartID(),sparam+"-ShootingStar-854",OBJ_TREND,0,time1,SS854,time2,SS854);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-854",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-854",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-854",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-854",OBJPROP_BACK,true);

double SS736=Low[shift1]+(((price2-Low[shift1])/100)*73.6);
ObjectDelete(ChartID(),sparam+"-ShootingStar-736");
ObjectCreate(ChartID(),sparam+"-ShootingStar-736",OBJ_TREND,0,time1,SS736,time2,SS736);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-736",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-736",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-736",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-736",OBJPROP_BACK,true);

double SS354=Low[shift1]+(((price2-Low[shift1])/100)*35.4);
ObjectDelete(ChartID(),sparam+"-ShootingStar-354");
ObjectCreate(ChartID(),sparam+"-ShootingStar-354",OBJ_TREND,0,time1,SS354,time2,SS354); // 236 + 118
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-354",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-354",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-354",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-354",OBJPROP_BACK,true);

double SS309=Low[shift1]+(((price2-Low[shift1])/100)*30.9);
ObjectDelete(ChartID(),sparam+"-ShootingStar-309");
ObjectCreate(ChartID(),sparam+"-ShootingStar-309",OBJ_TREND,0,time1,SS309,time2,SS309); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-309",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-309",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-309",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-309",OBJPROP_BACK,true);

double SS441=Low[shift1]+(((price2-Low[shift1])/100)*44.1);
ObjectDelete(ChartID(),sparam+"-ShootingStar-441");
ObjectCreate(ChartID(),sparam+"-ShootingStar-441",OBJ_TREND,0,time1,SS441,time2,SS441); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-441",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-441",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-441",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-441",OBJPROP_BACK,true);

double SS559=Low[shift1]+(((price2-Low[shift1])/100)*55.9);
ObjectDelete(ChartID(),sparam+"-ShootingStar-559");
ObjectCreate(ChartID(),sparam+"-ShootingStar-559",OBJ_TREND,0,time1,SS559,time2,SS559); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-559",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-559",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-559",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-559",OBJPROP_BACK,true);

double SS677=Low[shift1]+(((price2-Low[shift1])/100)*67.7);
ObjectDelete(ChartID(),sparam+"-ShootingStar-677");
ObjectCreate(ChartID(),sparam+"-ShootingStar-677",OBJ_TREND,0,time1,SS677,time2,SS677); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-677",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-677",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-677",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-677",OBJPROP_BACK,true);

double SS795=Low[shift1]+(((price2-Low[shift1])/100)*79.5);
ObjectDelete(ChartID(),sparam+"-ShootingStar-795");
ObjectCreate(ChartID(),sparam+"-ShootingStar-795",OBJ_TREND,0,time1,SS795,time2,SS795); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-795",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-795",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-795",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-795",OBJPROP_BACK,true);

double SS913=Low[shift1]+(((price2-Low[shift1])/100)*91.3);
ObjectDelete(ChartID(),sparam+"-ShootingStar-913");
ObjectCreate(ChartID(),sparam+"-ShootingStar-913",OBJ_TREND,0,time1,SS913,time2,SS913); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-913",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-913",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-913",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-913",OBJPROP_BACK,true);

///
double SS177=Low[shift1]+(((price2-Low[shift1])/100)*17.7);
ObjectDelete(ChartID(),sparam+"-ShootingStar-177");
ObjectCreate(ChartID(),sparam+"-ShootingStar-177",OBJ_TREND,0,time1,SS177,time2,SS177); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-177",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-177",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-177",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-177",OBJPROP_BACK,true);
//ObjectSetString(ChartID(),sparam+"-ShootingStar-177",OBJPROP_TOOLTIP,"Deneme");


double SS118f=Low[shift1]+(((price2-Low[shift1])/100)*11.8);
ObjectDelete(ChartID(),sparam+"-ShootingStar-118f");
ObjectCreate(ChartID(),sparam+"-ShootingStar-118f",OBJ_TREND,0,time1,SS118f,time2,SS118f); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-118f",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-118f",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-118f",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-118f",OBJPROP_BACK,true);

double SS59=Low[shift1]+(((price2-Low[shift1])/100)*5.9);
ObjectDelete(ChartID(),sparam+"-ShootingStar-59");
ObjectCreate(ChartID(),sparam+"-ShootingStar-59",OBJ_TREND,0,time1,SS59,time2,SS59); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-59",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-59",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-59",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-59",OBJPROP_BACK,true);

////////////////////////////////////////////////////////////////////////////////////

double SS1272=Low[shift1]+(((price2-Low[shift1])/100)*127.2);
ObjectDelete(ChartID(),sparam+"-ShootingStar-1272");
ObjectCreate(ChartID(),sparam+"-ShootingStar-1272",OBJ_TREND,0,time1,SS1272,time2,SS1272); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1272",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1272",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1272",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1272",OBJPROP_BACK,true);

double SS1118=Low[shift1]+(((price2-Low[shift1])/100)*111.8);
ObjectDelete(ChartID(),sparam+"-ShootingStar-1118");
//ObjectCreate(ChartID(),sparam+"-ShootingStar-1118",OBJ_TREND,0,time1,SS1118,time2,SS1118); // (382-236)=146/2=73 + 236=
ObjectCreate(ChartID(),sparam+"-ShootingStar-1118",OBJ_TREND,0,time1,SS1118,time2,SS1118); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1118",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1118",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1118",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1118",OBJPROP_BACK,true);

double SS1414=Low[shift1]+(((price2-Low[shift1])/100)*141.4);
ObjectDelete(ChartID(),sparam+"-ShootingStar-1414");
ObjectCreate(ChartID(),sparam+"-ShootingStar-1414",OBJ_TREND,0,time1,SS1414,time2,SS1414); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1414",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1414",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1414",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1414",OBJPROP_BACK,true);

double SS1618=Low[shift1]+(((price2-Low[shift1])/100)*161.8);
ObjectDelete(ChartID(),sparam+"-ShootingStar-1618");
//ObjectCreate(ChartID(),sparam+"-ShootingStar-1618",OBJ_TREND,0,time1,SS1618,time2,SS1414); // (382-236)=146/2=73 + 236=
ObjectCreate(ChartID(),sparam+"-ShootingStar-1618",OBJ_TREND,0,time1,SS1618,time2,SS1618); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1618",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1618",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1618",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1618",OBJPROP_BACK,true);

double SS2618=Low[shift1]+(((price2-Low[shift1])/100)*261.8);
ObjectDelete(ChartID(),sparam+"-ShootingStar-2618");
//ObjectCreate(ChartID(),sparam+"-ShootingStar-1618",OBJ_TREND,0,time1,SS1618,time2,SS1414); // (382-236)=146/2=73 + 236=
ObjectCreate(ChartID(),sparam+"-ShootingStar-2618",OBJ_TREND,0,time1,SS2618,time2,SS2618); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-2618",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-2618",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-2618",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-2618",OBJPROP_BACK,true);

//////////////////////////////////////////////////////////

double SS1272n=Low[shift1]-(((price2-Low[shift1])/100)*27.2);
ObjectDelete(ChartID(),sparam+"-ShootingStar-1272n");
ObjectCreate(ChartID(),sparam+"-ShootingStar-1272n",OBJ_TREND,0,time1,SS1272n,time2,SS1272n); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1272n",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1272n",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1272n",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1272n",OBJPROP_BACK,true);

double SS1118n=Low[shift1]-(((price2-Low[shift1])/100)*11.8);
ObjectDelete(ChartID(),sparam+"-ShootingStar-1118n");
//ObjectCreate(ChartID(),sparam+"-ShootingStar-1118",OBJ_TREND,0,time1,SS1118,time2,SS1118); // (382-236)=146/2=73 + 236=
ObjectCreate(ChartID(),sparam+"-ShootingStar-1118n",OBJ_TREND,0,time1,SS1118n,time2,SS1118n); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1118n",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1118n",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1118n",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1118n",OBJPROP_BACK,true);

double SS1414n=Low[shift1]-(((price2-Low[shift1])/100)*41.4);
ObjectDelete(ChartID(),sparam+"-ShootingStar-1414n");
ObjectCreate(ChartID(),sparam+"-ShootingStar-1414n",OBJ_TREND,0,time1,SS1414n,time2,SS1414n); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1414n",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1414n",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1414n",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1414n",OBJPROP_BACK,true);

double SS1618n=Low[shift1]-(((price2-Low[shift1])/100)*61.8);
ObjectDelete(ChartID(),sparam+"-ShootingStar-1618n");
//ObjectCreate(ChartID(),sparam+"-ShootingStar-1618",OBJ_TREND,0,time1,SS1618,time2,SS1414); // (382-236)=146/2=73 + 236=
ObjectCreate(ChartID(),sparam+"-ShootingStar-1618n",OBJ_TREND,0,time1,SS1618n,time2,SS1618n); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1618n",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1618n",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1618n",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1618n",OBJPROP_BACK,true);

double SS2618n=Low[shift1]-(((price2-Low[shift1])/100)*161.8);
ObjectDelete(ChartID(),sparam+"-ShootingStar-2618n");
//ObjectCreate(ChartID(),sparam+"-ShootingStar-1618",OBJ_TREND,0,time1,SS1618,time2,SS1414); // (382-236)=146/2=73 + 236=
ObjectCreate(ChartID(),sparam+"-ShootingStar-2618n",OBJ_TREND,0,time1,SS2618n,time2,SS2618n); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-2618n",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-2618n",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-2618n",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-2618n",OBJPROP_BACK,true);



//Comment("Evet");

// 1.618 .1414 1.118 1.272

double SS842=High[shift2]-(((price2-price1)/100)*84.2);

namel=sparam+"-ShootingStar-842";

if ( mod_change ) namel=sparam+"-ShootingStar-842-"+mod_prices;

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time2,SS842,time2+PeriodSeconds()*11,SS842);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),namel,OBJPROP_BACK,true);



double SS864=High[shift2]-(((price2-price1)/100)*86.4);

namel=sparam+"-ShootingStar-864";

if ( mod_change ) namel=sparam+"-ShootingStar-864-"+mod_prices;

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time2,SS864,time2+PeriodSeconds()*11,SS864);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,1);
ObjectSetInteger(ChartID(),namel,OBJPROP_BACK,true);
//ObjectSetInteger(ChartID(),sparam+"-ShootingStar-827",OBJPROP_RAY,false);


double SS827=High[shift2]-(((price2-price1)/100)*87.6);

namel=sparam+"-ShootingStar-827";

if ( mod_change ) namel=sparam+"-ShootingStar-827-"+mod_prices;

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time2,SS827,time2+PeriodSeconds()*11,SS827);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),namel,OBJPROP_BACK,true);
//ObjectSetInteger(ChartID(),sparam+"-ShootingStar-827",OBJPROP_RAY,false);


double SS886=High[shift2]-(((price2-price1)/100)*88.6);

namel=sparam+"-ShootingStar-886";



if ( mod_change ) namel=sparam+"-ShootingStar-886-"+mod_prices;

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time1,SS886,time2,SS886);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),namel,OBJPROP_BACK,true);
//ObjectSetString(ChartID(),namel,OBJPROP_TOOLTIP,"Deneme");


SSSL=price1-(SS886-price1);

namel=sparam+"-ShootingStar-SL";

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time1,SSSL,time2,SSSL);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,clrDarkGray);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),namel,OBJPROP_BACK,true);
//ObjectSetString(ChartID(),namel,OBJPROP_TOOLTIP,"Deneme");


for (int slt=2;slt<=10;slt++){

namel=sparam+"-ShootingStar-SL"+slt;

SSSL=price1-((SS886-price1)*slt);

//if ( mod_change ) namel=sparam+"-ShootingStar-886-"+mod_prices;

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time1,SSSL,time2,SSSL);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,clrRed);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),namel,OBJPROP_BACK,true);
//ObjectSetString(ChartID(),namel,OBJPROP_TOOLTIP,"Deneme");
}

SSSL=price1-((SS886-price1)*2);



double SS786=High[shift2]-(((price2-price1)/100)*78.6);

namel=sparam+"-ShootingStar-786";

if ( mod_change ) namel=sparam+"-ShootingStar-786-"+mod_prices;

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time1,SS786,time2,SS786);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,clrMaroon);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,4);



double SS707=High[shift2]-(((price2-price1)/100)*70.7);

namel=sparam+"-ShootingStar-707";

if ( mod_change ) namel=sparam+"-ShootingStar-707-"+mod_prices;

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time1,SS707,time2,SS707);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,clrGoldenrod);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,2);

double SS764=High[shift2]-(((price2-price1)/100)*76.4);

namel=sparam+"-ShootingStar-764";

if ( mod_change ) namel=sparam+"-ShootingStar-764-"+mod_prices;

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time1,SS764,time2,SS764);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,clrBlue);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,3);

int spread=(MarketInfo(Symbol(),MODE_ASK)-MarketInfo(Symbol(),MODE_BID))/Point;
int fark = int((SS764-SS886)/Point);

//Comment("Pip:",fark,"/",spread,"=",fark/spread,"/",(fark-spread));
Comment("Pip:",fark,"/",spread,"/",(fark-spread));




//Alert("Selam2","/",shift886);

int shiftc=1;
if ( shift1 > 1000 ) {

int shift886=ObjectGetShiftByValue(sparam+"-ShootingStar-666", SS886);
//Alert(shift886);
ObjectDelete(ChartID(),sparam+"CONTROL");
if ( shift886 > 0 ) ObjectCreate(ChartID(),sparam+"CONTROL",OBJ_VLINE,0,Time[shift886],SS886);
if ( shift886 < -0 ) {
datetime ctime=Time[0]+MathAbs(shift886)*PeriodSeconds();
ObjectCreate(ChartID(),sparam+"CONTROL",OBJ_VLINE,0,ctime,SS886);
}

shiftc=shift1-((shift1-shift886)*2);
if ( shiftc < 0 ) shiftc=1;
} 


for(int c=shiftc;c<=shift1-10;c++){

ObjectDelete(ChartID(),sparam+"CONTROL"+c);

if ( Low[c] <= SS886 && Open[c] > SS886 ) {


      ObjectCreate(ChartID(),sparam+"CONTROL"+c,OBJ_ARROW,0,0,0,0,0);          // Create an arrow
      ObjectSetInteger(ChartID(),sparam+"CONTROL"+c,OBJPROP_ARROWCODE,108);    // Set the arrow code
      ObjectSetInteger(ChartID(),sparam+"CONTROL"+c,OBJPROP_TIME,Time[c]);        // Set timeOrderTime+40*PeriodSeconds()
      ObjectSetDouble(ChartID(),sparam+"CONTROL"+c,OBJPROP_PRICE,Low[c]);// Set price
      ObjectSetInteger(ChartID(),sparam+"CONTROL"+c,OBJPROP_ANCHOR,ANCHOR_LOWER);    // Set the arrow code
      ObjectSetInteger(ChartID(),sparam+"CONTROL"+c,OBJPROP_FONTSIZE,8); 
      //ObjectSetInteger(ChartID(),sparam+"CONTROL"+c,OBJPROP_COLOR,clrBlack);
      
      
///ObjectCreate(ChartID(),sparam+"CONTROL"+c,OBJ_VLINE,0,Time[c],Close[c]);
ObjectSetInteger(ChartID(),sparam+"CONTROL"+c,OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam+"CONTROL"+c,OBJPROP_WIDTH,3);
ObjectSetInteger(ChartID(),sparam+"CONTROL"+c,OBJPROP_COLOR,clrDarkGray);
}

//Print(c);

}


for(int c=shiftc;c<=shift1-10;c++){

ObjectDelete(ChartID(),sparam+"CONTROLL"+c);

if ( Low[c] <= SS786 && Open[c] > SS786 ) {


      ObjectCreate(ChartID(),sparam+"CONTROLL"+c,OBJ_ARROW,0,0,0,0,0);          // Create an arrow
      ObjectSetInteger(ChartID(),sparam+"CONTROLL"+c,OBJPROP_ARROWCODE,108);    // Set the arrow code
      ObjectSetInteger(ChartID(),sparam+"CONTROLL"+c,OBJPROP_TIME,Time[c]);        // Set timeOrderTime+40*PeriodSeconds()
      ObjectSetDouble(ChartID(),sparam+"CONTROLL"+c,OBJPROP_PRICE,Close[c]);// Set price
      ObjectSetInteger(ChartID(),sparam+"CONTROLL"+c,OBJPROP_ANCHOR,ANCHOR_LOWER);    // Set the arrow code
      ObjectSetInteger(ChartID(),sparam+"CONTROLL"+c,OBJPROP_FONTSIZE,8); 
      //ObjectSetInteger(ChartID(),sparam+"CONTROL"+c,OBJPROP_COLOR,clrBlack);
      
      
///ObjectCreate(ChartID(),sparam+"CONTROL"+c,OBJ_VLINE,0,Time[c],Close[c]);
ObjectSetInteger(ChartID(),sparam+"CONTROLL"+c,OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam+"CONTROLL"+c,OBJPROP_WIDTH,3);
ObjectSetInteger(ChartID(),sparam+"CONTROLL"+c,OBJPROP_COLOR,clrLawnGreen);
}

//Print(c);

}




if ( order_mode == true ) {

string ordercmt="";


order1=NormalizeDouble(SS886,Digits);
order2=NormalizeDouble(High[shift1],Digits);
tp=NormalizeDouble(SS764,Digits);
tp1=NormalizeDouble(SS764,Digits);
tp3=NormalizeDouble(SS618,Digits);
sl=NormalizeDouble(Low[shift1],Digits);

ordercmt=Symbol()+"-"+sparam+"-"+TFtoStr(Period())+"-1";
//int ticket=OrderSend(Symbol(),OP_BUYLIMIT,0.01,order1,0,sl,tp,ordercmt,0,0,clrNONE);

tp=NormalizeDouble(SS786,Digits);
tp2=NormalizeDouble(SS786,Digits);
ordercmt=Symbol()+"-"+sparam+"-"+TFtoStr(Period())+"-2";
//int ticket2=OrderSend(Symbol(),OP_BUYLIMIT,0.01,order2,0,sl,tp,ordercmt,0,0,clrNONE);

order3=NormalizeDouble(SS864,Digits);
//tp=NormalizeDouble(SS786,Digits);
ordercmt=Symbol()+"-"+sparam+"-"+TFtoStr(Period())+"-3";
//int ticket3=OrderSend(Symbol(),OP_BUYLIMIT,0.01,order1,0,sl,tp,ordercmt,0,0,clrNONE);

order_type=OP_BUYLIMIT;
//order_mode=false;

}



double SS118=High[shift2]-(((price2-price1)/100)*11.8);

namel=sparam+"-ShootingStar-118";

if ( mod_change ) namel=sparam+"-ShootingStar-118-"+mod_prices;

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time2,SS118,time2+PeriodSeconds()*11,SS118);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,clrBisque);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),namel,OBJPROP_BACK,true);


ObjectSetString(ChartID(),sparam+"-ShootingStar-Time",OBJPROP_TOOLTIP,int((SS786-SS842)/Point)+"="+int((Bid-SS842)/Point)+"/"+int((SS886-SS888)/Point)+"="+int((Bid-SS888)/Point));
//ObjectSetString(ChartID(),sparam+"-ShootingStar-Time",OBJPROP_TOOLTIP,int((SS786-SS842)/Point)+"="+int((SS842-Bid)/Point)+"/"+int((SS886-SS888)/Point)+"="+int((SS888-Bid)/Point));
//ObjectSetString(ChartID(),sparam+"-ShootingStar-Time",OBJPROP_TOOLTIP,int((SS786-SS842)/Point)+"/"+int((SS886-SS888)/Point));

if ( (int((SS786-SS842)/Point) > 100 && Bid > SS842) || (int((SS886-SS888)/Point) > 100 && Bid > SS888) ) {
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-Time",OBJPROP_COLOR,clrGold);
} else {
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-Time",OBJPROP_COLOR,clrWhite);
}



ChartRedraw();


}



ToplamObje=ObjectsTotal();

//Alert("Selam");
GizleGoster(16);

}




  if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_RECTANGLE && BAR_SYSTEM ) {
  
  
  
  
last_object=sparam;

Comment("last_object:",last_object);


      for(int i=ObjectsTotal();i>=0;i--)
        {
        string name = ObjectName(ChartID(),i);
        
  int index = StringFind(name,last_object, 0); 

  if ( ObjectGetInteger(ChartID(),name,OBJPROP_TYPE) != OBJ_RECTANGLE ) {
  if ( index != -1 ) {
  Sleep(100);
  ObjectDelete(ChartID(),name);
   }  
   }
   
   
  }
  

     //if ( ObjectGetInteger(0,name, OBJPROP_TIMEFRAMES) == -1 ) {
     //ObjectSetInteger(0,name, OBJPROP_TIMEFRAMES, OBJ_PERIOD_M1 | OBJ_PERIOD_M5 | OBJ_PERIOD_M15 | OBJ_PERIOD_M30 | OBJ_PERIOD_H1 | OBJ_PERIOD_H4 | OBJ_PERIOD_D1 | OBJ_PERIOD_W1 | OBJ_PERIOD_MN1);
     //} else {
     //ObjectSetInteger(ChartID(),sparam, OBJPROP_TIMEFRAMES, -1);
     
     //}  
  
  
  
  double price1=ObjectGetDouble(ChartID(),sparam,OBJPROP_PRICE1);
  double price2=ObjectGetDouble(ChartID(),sparam,OBJPROP_PRICE2);
  
  double time1=ObjectGetInteger(ChartID(),sparam,OBJPROP_TIME1);
  double time2=ObjectGetInteger(ChartID(),sparam,OBJPROP_TIME2);
  
  int shift1=iBarShift(Symbol(),Period(),time1);
  int shift2=iBarShift(Symbol(),Period(),time2);
  
  int shiftf;
  if ( shift1 > shift2 ) shiftf=shift1-shift2;
  if ( shift1 < shift2 ) shiftf=shift2-shift1;  
  
  
  //Alert("Selam",shift1,"/",shift2,"/",shiftf);
  
  
  if ( shift1 > shift2 ) {
  
  for(int t=shift2;t<=shift1;t++){

  datetime line_time_end=Time[t-1]-PeriodSeconds(PERIOD_M1);
  datetime line_time_start=Time[t]+PeriodSeconds(PERIOD_M1);
    
    
  color barcolor = clrBlack;  
  if ( Close[t] > Open[t] ) barcolor=clrGreen;  
  if ( Open[t] > Close[t] ) barcolor=clrRed;


  string name=sparam+"-ShootingStar-start-"+t;
  ObjectDelete(ChartID(),name);
  ObjectCreate(ChartID(),name,OBJ_TREND,0,line_time_start,High[t],line_time_start,Low[t]);
  ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);  
  ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,barcolor);  
  ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);  


  name=sparam+"-ShootingStar-end-"+t;
  ObjectDelete(ChartID(),name);
  ObjectCreate(ChartID(),name,OBJ_TREND,0,line_time_end,High[t],line_time_end,Low[t]);
  ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);  
  ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,barcolor);  
  ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);  
  ObjectSetInteger(ChartID(),name,OBJPROP_BACK,true);
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTABLE,false);
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTED,false);  
  
  

  name=sparam+"-ShootingStar-high-"+t;
  ObjectDelete(ChartID(),name);
  ObjectCreate(ChartID(),name,OBJ_TREND,0,line_time_start,High[t],line_time_end,High[t]);
  ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);  
  ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBisque);  
  ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2); 
  ObjectSetInteger(ChartID(),name,OBJPROP_BACK,true);
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTABLE,false);
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTED,false);
  if ( shiftf == 2 && t==shift2+1) ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true);  
  if ( shiftf == 2 && t==shift2+1) ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
  if ( shiftf == 2 && t==shift2+1) ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,2);  
  
  name=sparam+"-ShootingStar-low-"+t;
  ObjectDelete(ChartID(),name);
  ObjectCreate(ChartID(),name,OBJ_TREND,0,line_time_start,Low[t],line_time_end,Low[t]);
  ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);  
  ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrWhite);  
  ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2); 
  ObjectSetInteger(ChartID(),name,OBJPROP_BACK,true);
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTABLE,false);
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTED,false);
  if ( shiftf == 2 && t==shift2+1) ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true);  
  if ( shiftf == 2 && t==shift2+1) ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1); 
  if ( shiftf == 2 && t==shift2+1) ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,2); 
    
  name=sparam+"-ShootingStar-open-"+t;
  ObjectDelete(ChartID(),name);
  ObjectCreate(ChartID(),name,OBJ_TREND,0,line_time_start,Open[t],line_time_end,Open[t]);
  ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);  
  ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrDarkBlue);  
  ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2); 
  ObjectSetInteger(ChartID(),name,OBJPROP_BACK,true);
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTABLE,false);
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTED,false);
  
  name=sparam+"-ShootingStar-close-"+t;
  ObjectDelete(ChartID(),name);
  ObjectCreate(ChartID(),name,OBJ_TREND,0,line_time_start,Close[t],line_time_end,Close[t]);
  ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);  
  ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrCrimson);  
  ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2); 
  ObjectSetInteger(ChartID(),name,OBJPROP_BACK,true);
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTABLE,false);
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTED,false);
  
  
  
  
    
  /*


  
 

  ObjectDelete(ChartID(),sparam+"-right-alt");
  ObjectCreate(ChartID(),sparam+"-right-alt",OBJ_TREND,0,Time[shift2],Low[shift2],right_line_time,Low[shift2]);
  ObjectSetInteger(ChartID(),sparam+"-right-alt",OBJPROP_RAY,false);    
  ObjectSetInteger(ChartID(),sparam+"-right-alt",OBJPROP_COLOR,clrMagenta);  
  ObjectSetInteger(ChartID(),sparam+"-right-alt",OBJPROP_WIDTH,2);    
  

  ObjectDelete(ChartID(),sparam+"-right-open");
  ObjectCreate(ChartID(),sparam+"-right-open",OBJ_TREND,0,Time[shift2],Open[shift2],right_line_time,Open[shift2]);
  ObjectSetInteger(ChartID(),sparam+"-right-open",OBJPROP_RAY,false);    
  ObjectSetInteger(ChartID(),sparam+"-right-open",OBJPROP_COLOR,clrDarkRed);  
  ObjectSetInteger(ChartID(),sparam+"-right-open",OBJPROP_WIDTH,2);    
  
  ObjectDelete(ChartID(),sparam+"-right-close");
  ObjectCreate(ChartID(),sparam+"-right-close",OBJ_TREND,0,Time[shift2],Close[shift2],right_line_time,Close[shift2]);
  ObjectSetInteger(ChartID(),sparam+"-right-close",OBJPROP_RAY,false);    
  ObjectSetInteger(ChartID(),sparam+"-right-close",OBJPROP_COLOR,clrDarkBlue);  
  ObjectSetInteger(ChartID(),sparam+"-right-close",OBJPROP_WIDTH,2);  */ 
  
  
  
  
  
  
  }
  
  
  
  }
  

  if ( Period() == PERIOD_D1 ) ObjectSetInteger(ChartID(),sparam, OBJPROP_TIMEFRAMES, OBJ_PERIOD_D1);
  if ( Period() == PERIOD_H4 ) ObjectSetInteger(ChartID(),sparam, OBJPROP_TIMEFRAMES, OBJ_PERIOD_H4);
  if ( Period() == PERIOD_H1 ) ObjectSetInteger(ChartID(),sparam, OBJPROP_TIMEFRAMES, OBJ_PERIOD_H1);
  if ( Period() == PERIOD_M15 ) ObjectSetInteger(ChartID(),sparam, OBJPROP_TIMEFRAMES, OBJ_PERIOD_M15);
  if ( Period() == PERIOD_M30 ) ObjectSetInteger(ChartID(),sparam, OBJPROP_TIMEFRAMES, OBJ_PERIOD_M30);
  if ( Period() == PERIOD_M5 ) ObjectSetInteger(ChartID(),sparam, OBJPROP_TIMEFRAMES, OBJ_PERIOD_M5);
  if ( Period() == PERIOD_MN1 ) ObjectSetInteger(ChartID(),sparam, OBJPROP_TIMEFRAMES, OBJ_PERIOD_MN1);
  if ( Period() == PERIOD_W1 ) ObjectSetInteger(ChartID(),sparam, OBJPROP_TIMEFRAMES, OBJ_PERIOD_W1);  
  
  ToplamObje=ObjectsTotal();
  
  
  return;
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  

  
  int shift3;
  if ( shiftf == 2 ) {
  
  if ( shift1 > shift2 ) {shift3=shift1-1;
  
  ObjectDelete(ChartID(),sparam+"-orta");
  ObjectCreate(ChartID(),sparam+"-orta",OBJ_TREND,0,Time[shift3],Low[shift3],Time[shift3]*100*PeriodSeconds(),Low[shift3]);
  
  //Alert(Time[shift2]+(PeriodSeconds()-PeriodSeconds(PERIOD_M1)));
  
  datetime right_line_time=Time[shift2-1]-PeriodSeconds(PERIOD_M1);
  datetime right_line_start=Time[shift2]+PeriodSeconds(PERIOD_M1);
  
  datetime left_line_time=Time[shift1]+PeriodSeconds(PERIOD_M1);
  datetime center_line_start=Time[shift3]-PeriodSeconds(PERIOD_M1);
  datetime center_line_time=Time[shift2]-PeriodSeconds(PERIOD_M1);
  datetime left_line_time_end=Time[shift1-1]-PeriodSeconds(PERIOD_M1);
  datetime next_line_time_end=Time[shift2-1]+PeriodSeconds(PERIOD_M1);
  
  //Alert(left_line_time,"/",right_line_time);
  
  

  ObjectDelete(ChartID(),sparam+"-orta-alt");
  ObjectCreate(ChartID(),sparam+"-orta-alt",OBJ_TREND,0,Time[shift3],Low[shift3],Time[shift3]*100*PeriodSeconds(),Low[shift3]);

  
  ObjectDelete(ChartID(),sparam+"-orta-ust");
  ObjectCreate(ChartID(),sparam+"-orta-ust",OBJ_TREND,0,Time[shift3],High[shift3],Time[shift3]*100*PeriodSeconds(),High[shift3]);

  ObjectDelete(ChartID(),sparam+"-next-ust");
  ObjectCreate(ChartID(),sparam+"-next-ust",OBJ_TREND,0,Time[shift2-1],High[shift2-1],Time[0],High[shift2-1]);
      
  
  ObjectDelete(ChartID(),sparam+"-left");
  ObjectCreate(ChartID(),sparam+"-left",OBJ_TREND,0,left_line_time,High[shift1],left_line_time,Low[shift1]);
  ObjectSetInteger(ChartID(),sparam+"-left",OBJPROP_RAY,false);
  

  ObjectDelete(ChartID(),sparam+"-left-alt");
  ObjectCreate(ChartID(),sparam+"-left-alt",OBJ_TREND,0,Time[shift1],Low[shift1],left_line_time_end,Low[shift1]);
  
  ObjectDelete(ChartID(),sparam+"-left-ust");
  ObjectCreate(ChartID(),sparam+"-left-ust",OBJ_TREND,0,Time[shift1],High[shift1],left_line_time_end,High[shift1]);
  
  
  
  
  
  ObjectDelete(ChartID(),sparam+"-right-start");
  ObjectCreate(ChartID(),sparam+"-right-start",OBJ_TREND,0,right_line_start,High[shift2],right_line_start,Low[shift2]);
  ObjectSetInteger(ChartID(),sparam+"-right-start",OBJPROP_RAY,false);  
  ObjectSetInteger(ChartID(),sparam+"-right-start",OBJPROP_COLOR,clrMagenta);  
  ObjectSetInteger(ChartID(),sparam+"-right-start",OBJPROP_WIDTH,2);    
  

  ObjectDelete(ChartID(),sparam+"-right");
  ObjectCreate(ChartID(),sparam+"-right",OBJ_TREND,0,right_line_time,High[shift2],right_line_time,Low[shift2]);
  ObjectSetInteger(ChartID(),sparam+"-right",OBJPROP_RAY,false);  
  ObjectSetInteger(ChartID(),sparam+"-right",OBJPROP_COLOR,clrMagenta);  
  ObjectSetInteger(ChartID(),sparam+"-right",OBJPROP_WIDTH,2);  
  
  ObjectDelete(ChartID(),sparam+"-right-ust");
  ObjectCreate(ChartID(),sparam+"-right-ust",OBJ_TREND,0,Time[shift2],High[shift2],right_line_time,High[shift2]);
  ObjectSetInteger(ChartID(),sparam+"-right-ust",OBJPROP_RAY,false);  
  ObjectSetInteger(ChartID(),sparam+"-right-ust",OBJPROP_COLOR,clrMagenta);  
  ObjectSetInteger(ChartID(),sparam+"-right-ust",OBJPROP_WIDTH,2);  

  ObjectDelete(ChartID(),sparam+"-right-alt");
  ObjectCreate(ChartID(),sparam+"-right-alt",OBJ_TREND,0,Time[shift2],Low[shift2],right_line_time,Low[shift2]);
  ObjectSetInteger(ChartID(),sparam+"-right-alt",OBJPROP_RAY,false);    
  ObjectSetInteger(ChartID(),sparam+"-right-alt",OBJPROP_COLOR,clrMagenta);  
  ObjectSetInteger(ChartID(),sparam+"-right-alt",OBJPROP_WIDTH,2);    
  

  ObjectDelete(ChartID(),sparam+"-right-open");
  ObjectCreate(ChartID(),sparam+"-right-open",OBJ_TREND,0,Time[shift2],Open[shift2],right_line_time,Open[shift2]);
  ObjectSetInteger(ChartID(),sparam+"-right-open",OBJPROP_RAY,false);    
  ObjectSetInteger(ChartID(),sparam+"-right-open",OBJPROP_COLOR,clrDarkRed);  
  ObjectSetInteger(ChartID(),sparam+"-right-open",OBJPROP_WIDTH,2);    
  
  ObjectDelete(ChartID(),sparam+"-right-close");
  ObjectCreate(ChartID(),sparam+"-right-close",OBJ_TREND,0,Time[shift2],Close[shift2],right_line_time,Close[shift2]);
  ObjectSetInteger(ChartID(),sparam+"-right-close",OBJPROP_RAY,false);    
  ObjectSetInteger(ChartID(),sparam+"-right-close",OBJPROP_COLOR,clrDarkBlue);  
  ObjectSetInteger(ChartID(),sparam+"-right-close",OBJPROP_WIDTH,2);   
    
    
  
  
  
  ObjectDelete(ChartID(),sparam+"-center");
  ObjectCreate(ChartID(),sparam+"-center",OBJ_TREND,0,center_line_time,High[shift3],center_line_time,Low[shift3]);
  ObjectSetInteger(ChartID(),sparam+"-center",OBJPROP_RAY,false);  
  

  ObjectDelete(ChartID(),sparam+"-center-start");
  ObjectCreate(ChartID(),sparam+"-center-start",OBJ_TREND,0,center_line_start,High[shift3],center_line_start,Low[shift3]);
  ObjectSetInteger(ChartID(),sparam+"-center-start",OBJPROP_RAY,false);    
  

  ObjectDelete(ChartID(),sparam+"-left-end");
  ObjectCreate(ChartID(),sparam+"-left-end",OBJ_TREND,0,left_line_time_end,High[shift1],left_line_time_end,Low[shift1]);
  ObjectSetInteger(ChartID(),sparam+"-left-end",OBJPROP_RAY,false);  


  /*ObjectDelete(ChartID(),sparam+"-left-end");
  ObjectCreate(ChartID(),sparam+"-left-end",OBJ_TREND,0,left_line_time_end,High[shift1],left_line_time_end,Low[shift1]);
  ObjectSetInteger(ChartID(),sparam+"-left-end",OBJPROP_RAY,false);  */
      
    
    
  
  
  
  }
  if ( shift1 < shift2 ) {shift3=shift2-1;
  
  }
  
  
  
  
  }
  
  
  Comment("Kare Çizildi",time1,"/",time2,"/",shift1,"/",shift2,"/",shift3,"/",shiftf);
  
  
  
  if ( Period() == PERIOD_D1 ) ObjectSetInteger(ChartID(),sparam, OBJPROP_TIMEFRAMES, OBJ_PERIOD_D1);
  if ( Period() == PERIOD_H4 ) ObjectSetInteger(ChartID(),sparam, OBJPROP_TIMEFRAMES, OBJ_PERIOD_H4);
  if ( Period() == PERIOD_H1 ) ObjectSetInteger(ChartID(),sparam, OBJPROP_TIMEFRAMES, OBJ_PERIOD_H1);
  if ( Period() == PERIOD_M15 ) ObjectSetInteger(ChartID(),sparam, OBJPROP_TIMEFRAMES, OBJ_PERIOD_M15);
  if ( Period() == PERIOD_M30 ) ObjectSetInteger(ChartID(),sparam, OBJPROP_TIMEFRAMES, OBJ_PERIOD_M30);
  if ( Period() == PERIOD_M5 ) ObjectSetInteger(ChartID(),sparam, OBJPROP_TIMEFRAMES, OBJ_PERIOD_M5);
  if ( Period() == PERIOD_MN1 ) ObjectSetInteger(ChartID(),sparam, OBJPROP_TIMEFRAMES, OBJ_PERIOD_MN1);
  if ( Period() == PERIOD_W1 ) ObjectSetInteger(ChartID(),sparam, OBJPROP_TIMEFRAMES, OBJ_PERIOD_W1);
  
  
  }






   
  }
//+------------------------------------------------------------------+


//////////////////////////////////////////////////////////////////////
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

 


void GizleGoster(int islem) {



if ( islem == 33 ) {
             int obj_total=ObjectsTotal()-1;
    for(int i=ObjectsTotal();i>=0;i--)
        {
        
        string sparam = ObjectName(i);
        string name = ObjectName(i);


  int index = StringFind(name,last_object, 0); 
  int last_object_len=StringLen(last_object);
  
  int object_len=StringLen(name);

  if ( index != -1 && last_object_len != object_len) {
  //Sleep(100);
  //ObjectDelete(ChartID(),name);
  
     //if ( ObjectGetInteger(0,name, OBJPROP_TIMEFRAMES) == -1 ) {
     //ObjectSetInteger(0,name, OBJPROP_TIMEFRAMES, OBJ_PERIOD_M1 | OBJ_PERIOD_M5 | OBJ_PERIOD_M15 | OBJ_PERIOD_M30 | OBJ_PERIOD_H1 | OBJ_PERIOD_H4 | OBJ_PERIOD_D1 | OBJ_PERIOD_W1 | OBJ_PERIOD_MN1);
     //} else {
     ObjectSetInteger(0,name, OBJPROP_TIMEFRAMES, -1);
     //}  
  
   }  
   
}   
}










if ( islem == 34 ) {
             int obj_total=ObjectsTotal()-1;
    for(int i=ObjectsTotal();i>=0;i--)
        {
        
        string sparam = ObjectName(i);
        string name = ObjectName(i);


  int index = StringFind(name,last_object, 0); 
  int last_object_len=StringLen(last_object);
  
  int object_len=StringLen(name);

  if ( index != -1 && last_object_len != object_len) {
  //Sleep(100);
  //ObjectDelete(ChartID(),name);
  
     if ( ObjectGetInteger(0,name, OBJPROP_TIMEFRAMES) == -1 ) {
     ObjectSetInteger(0,name, OBJPROP_TIMEFRAMES, OBJ_PERIOD_M1 | OBJ_PERIOD_M5 | OBJ_PERIOD_M15 | OBJ_PERIOD_M30 | OBJ_PERIOD_H1 | OBJ_PERIOD_H4 | OBJ_PERIOD_D1 | OBJ_PERIOD_W1 | OBJ_PERIOD_MN1);
     } else {
     ObjectSetInteger(0,name, OBJPROP_TIMEFRAMES, -1);
     }  
  
   }  
   
}   
}



if ( islem == 35 ) {
             int obj_total=ObjectsTotal()-1;
    for(int i=ObjectsTotal();i>=0;i--)
        {
        
        string sparam = ObjectName(i);
        string name = ObjectName(i);


  int index = StringFind(name,last_object, 0); 
  int last_object_len=StringLen(last_object);
  
  int index333 = StringFind(name,"-333-", 0); 
  int index1333 = StringFind(name,"-1333-", 0); 
  
  int index222 = StringFind(name,"-222-", 0); 
  int index1222 = StringFind(name,"-1222-", 0); 
  
  
  int object_len=StringLen(name);

  //if ( index != -1 && last_object_len != object_len && ( index333 != -1 || index222 != -1 ) ) {
  if ( index != -1 && last_object_len != object_len && ( index222 != -1 ) ) {
  //Sleep(100);
  //ObjectDelete(ChartID(),name);
  
     if ( ObjectGetInteger(0,name, OBJPROP_TIMEFRAMES) == -1 ) {
     ObjectSetInteger(0,name, OBJPROP_TIMEFRAMES, OBJ_PERIOD_M1 | OBJ_PERIOD_M5 | OBJ_PERIOD_M15 | OBJ_PERIOD_M30 | OBJ_PERIOD_H1 | OBJ_PERIOD_H4 | OBJ_PERIOD_D1 | OBJ_PERIOD_W1 | OBJ_PERIOD_MN1);
     } else {
     ObjectSetInteger(0,name, OBJPROP_TIMEFRAMES, -1);
     }  
  
   }  
   
}   
}





if ( islem == 36 ) {


             int obj_total=ObjectsTotal()-1;
    for(int i=ObjectsTotal();i>=0;i--)
        {
        
        string sparam = ObjectName(i);
        string name = ObjectName(i);


  int index = StringFind(name,last_object, 0); 
  int last_object_len=StringLen(last_object);
  
  int index333 = StringFind(name,"-333-", 0); 
  int index1333 = StringFind(name,"-1333-", 0); 
  
  int index222 = StringFind(name,"-222-", 0); 
  int index1222 = StringFind(name,"-1222-", 0); 
  
  
  int object_len=StringLen(name);
//|| index333 != -1 || index222 != -1
  //if ( index != -1 && last_object_len != object_len && ( index1333 != -1 || index1222 != -1   ) ) {
  if ( index != -1 && last_object_len != object_len && ( index333 != -1   ) ) {
  //Sleep(100);
  //ObjectDelete(ChartID(),name);
  
     if ( ObjectGetInteger(0,name, OBJPROP_TIMEFRAMES) == -1 ) {
     ObjectSetInteger(0,name, OBJPROP_TIMEFRAMES, OBJ_PERIOD_M1 | OBJ_PERIOD_M5 | OBJ_PERIOD_M15 | OBJ_PERIOD_M30 | OBJ_PERIOD_H1 | OBJ_PERIOD_H4 | OBJ_PERIOD_D1 | OBJ_PERIOD_W1 | OBJ_PERIOD_MN1);
     } else {
     ObjectSetInteger(0,name, OBJPROP_TIMEFRAMES, -1);
     }  
  
   }  
   
}   
}



if ( islem == 37 ) {


             int obj_total=ObjectsTotal()-1;
    for(int i=ObjectsTotal();i>=0;i--)
        {
        
        string sparam = ObjectName(i);
        string name = ObjectName(i);


  int index = StringFind(name,last_object, 0); 
  int last_object_len=StringLen(last_object);
  
  int index333 = StringFind(name,"-333-", 0); 
  int index1333 = StringFind(name,"-1333-", 0); 
  
  int index222 = StringFind(name,"-222-", 0); 
  int index1222 = StringFind(name,"-1222-", 0); 
  
  
  int object_len=StringLen(name);
//|| index333 != -1 || index222 != -1
//if ( index != -1 && last_object_len != object_len && ( index1333 != -1 || index1222 != -1   ) ) {
  if ( index != -1 && last_object_len != object_len && index1222 != -1    ) {
  //Sleep(100);
  //ObjectDelete(ChartID(),name);
  
     if ( ObjectGetInteger(0,name, OBJPROP_TIMEFRAMES) == -1 ) {
     ObjectSetInteger(0,name, OBJPROP_TIMEFRAMES, OBJ_PERIOD_M1 | OBJ_PERIOD_M5 | OBJ_PERIOD_M15 | OBJ_PERIOD_M30 | OBJ_PERIOD_H1 | OBJ_PERIOD_H4 | OBJ_PERIOD_D1 | OBJ_PERIOD_W1 | OBJ_PERIOD_MN1);
     } else {
     ObjectSetInteger(0,name, OBJPROP_TIMEFRAMES, -1);
     }  
  
   }  
   
}   
}





if ( islem == 38 ) { ///ş


             int obj_total=ObjectsTotal()-1;
    for(int i=ObjectsTotal();i>=0;i--)
        {
        
        string sparam = ObjectName(i);
        string name = ObjectName(i);


  int index = StringFind(name,last_object, 0); 
  int last_object_len=StringLen(last_object);
  
  int index333 = StringFind(name,"-333-", 0); 
  int index1333 = StringFind(name,"-1333-", 0); 
  
  int index222 = StringFind(name,"-222-", 0); 
  int index1222 = StringFind(name,"-1222-", 0); 
  
  
  int object_len=StringLen(name);
//|| index333 != -1 || index222 != -1
  //if ( index != -1 && last_object_len != object_len && ( index1333 != -1 || index1222 != -1   ) ) {
  if ( index != -1 && last_object_len != object_len && index1333 != -1  ) {
  //Sleep(100);
  //ObjectDelete(ChartID(),name);
  
     if ( ObjectGetInteger(0,name, OBJPROP_TIMEFRAMES) == -1 ) {
     ObjectSetInteger(0,name, OBJPROP_TIMEFRAMES, OBJ_PERIOD_M1 | OBJ_PERIOD_M5 | OBJ_PERIOD_M15 | OBJ_PERIOD_M30 | OBJ_PERIOD_H1 | OBJ_PERIOD_H4 | OBJ_PERIOD_D1 | OBJ_PERIOD_W1 | OBJ_PERIOD_MN1);
     } else {
     ObjectSetInteger(0,name, OBJPROP_TIMEFRAMES, -1);
     }  
  
   }  
   
}   



}









if ( islem == 16 ) { ///ş

//Alert("Q");

//string to_split="-707,-786,-764,-618,-886,-864,-827,-888";


             int obj_total=ObjectsTotal()-1;
    for(int i=ObjectsTotal();i>=0;i--)
        {
        
        string sparam = ObjectName(i);
        string name = ObjectName(i);


  int index = StringFind(name,last_object, 0); 
  int last_object_len=StringLen(last_object);
  
  
/*
string sep=",";                // A separator as a character
   ushort u_sep;                  // The code of the separator character
   string results[];               // An array to get strings
   //--- Get the separator code
   u_sep=StringGetCharacter(sep,0);
   //--- Split the string to substrings
   int k=StringSplit(to_split,u_sep,results);
   //--- Show a comment 
   //PrintFormat("Strings obtained: %d. Used separator '%s' with the code %d",k,sep,u_sep);
   //--- Now output all obtained strings
   //Print("Destek Direnc Web Load 3:",k);
   
   //int DDsays=-1;
   //int DDtoplam=-1;
   
   bool linebul=false;
   string linename="";
   
   if(k>0)
     {
      for(int i=0;i<k;i++)
        {

   linename=results[i];

   int index_split = StringFind(name,linename, 0);         

   if ( index_split != -1 ) {
   linebul=true;
   }        
        
        Print(results[i]);

   
   }
  }*/
  
  
  
  
  //int index333 = StringFind(name,"-333-", 0); 
  //int index1333 = StringFind(name,"-1333-", 0); 
  
  //int index222 = StringFind(name,"-222-", 0); 
  //int index1222 = StringFind(name,"-1222-", 0); 
  
  
  int object_len=StringLen(name);
//|| index333 != -1 || index222 != -1&& index1333 != -1
  //if ( index != -1 && last_object_len != object_len && ( index1333 != -1 || index1222 != -1   ) ) {
  if ( index != -1 && last_object_len != object_len   ) {
  //Sleep(100);
  //ObjectDelete(ChartID(),name);
     
     if ( ObjectGetInteger(0,name, OBJPROP_TIMEFRAMES) == -1 && (ObjectGetInteger(0,name,OBJPROP_COLOR) == clrLightGray || ObjectGetInteger(0,name,OBJPROP_COLOR) == clrNavy) //&& linebul == true
      ) {
     ObjectSetInteger(0,name, OBJPROP_TIMEFRAMES, OBJ_PERIOD_M1 | OBJ_PERIOD_M5 | OBJ_PERIOD_M15 | OBJ_PERIOD_M30 | OBJ_PERIOD_H1 | OBJ_PERIOD_H4 | OBJ_PERIOD_D1 | OBJ_PERIOD_W1 | OBJ_PERIOD_MN1);
     } else {
     if ( //linebul == false
     //ObjectGetInteger(0,name,OBJPROP_COLOR) == clrLightGray
     (ObjectGetInteger(0,name,OBJPROP_COLOR) == clrLightGray || ObjectGetInteger(0,name,OBJPROP_COLOR) == clrNavy)
      ) {
     ObjectSetInteger(0,name, OBJPROP_TIMEFRAMES, -1);
     }  
     }
  
   }  
   
}   



}





}   
   



void ObjectsDeleteAllss(long oda_charid,string oda_wilcard,int oda_window,int oda_type) {


//return;

             int obj_total=ObjectsTotal(oda_charid,oda_window,oda_type)-1;
    for(int i=ObjectsTotal(oda_charid,oda_window,oda_type);i>=0;i--)
        {
        string name = ObjectName(oda_charid,i,oda_window,oda_type);
        
  int index = StringFind(name,oda_wilcard, 0); 


  if ( index != -1 ) {
  //Sleep(100);
  ObjectDelete(ChartID(),name);
   }  
   
  }
ChartRedraw();

}   

void FeAnalizOld() {


/*
  int totalii = OrdersTotal();
  
  //Alert(OrdersTotal());
  
  for(int iii=0;iii<=OrdersTotal()-1;iii++)
  {
    OrderSelect(iii, SELECT_BY_POS);
           int typei = OrderType();
    string commentsi = OrderComment();
    
    
    if ( Symbol() == OrderSymbol() ) {*/
    
    
    
    
    //Print(OrderTicket(),"/",ObjectFind("Order"+OrderTicket()));
    
    string OrderLine="FeOrderSave"+Symbol();
    if ( ObjectFind("FeOrderSave"+Symbol()) == -1 ) {
    
    //int      right_bound=WindowFirstVisibleBar()-WindowBarsPerChart();
    
  datetime left;
  int      right_bound;
  if ( WindowFirstVisibleBar() > -1 ) {
  //left=Time[WindowFirstVisibleBar()];
  right_bound=WindowFirstVisibleBar()-WindowBarsPerChart();}
  else{
  //left=TimeCurrent();
  right_bound=WindowFirstVisibleBar()-WindowBarsPerChart();
  }

double OrderOpenPrices=Ask;

bool tpl_files_per_find=false;
bool tpl_files_find=false;
string tpl_files=Symbol();
string tpl_files_time = "";

if(FileIsExist(tpl_files +"-"+Period()+"-.tpl",1)) {
    //tpl_files_find=true;
    tpl_files_per_find=true;
    } 
    

//Alert("Delete",tpl_files);
    
    if(FileIsExist(tpl_files +"-1-.tpl",1)) {
    tpl_files_time="M1";
    } 
        
    if(FileIsExist(tpl_files +"-5-.tpl",1)) {
    if ( tpl_files_time != "" ) tpl_files_time=tpl_files_time+" ";
    tpl_files_time=tpl_files_time+"M5";
    }         
    
    if(FileIsExist(tpl_files +"-15-.tpl",1)) {
    if ( tpl_files_time != "" ) tpl_files_time=tpl_files_time+" ";
    tpl_files_time=tpl_files_time+"M15";
    }         

    if(FileIsExist(tpl_files +"-30-.tpl",1)) {
    if ( tpl_files_time != "" ) tpl_files_time=tpl_files_time+" ";
    tpl_files_time=tpl_files_time+"M30";
    }     
        
    if(FileIsExist(tpl_files +"-60-.tpl",1)) {
    if ( tpl_files_time != "" ) tpl_files_time=tpl_files_time+" ";
    tpl_files_time=tpl_files_time+"H1";
    }     
    
    if(FileIsExist(tpl_files +"-240-.tpl",1)) {
    if ( tpl_files_time != "" ) tpl_files_time=tpl_files_time+" ";
    tpl_files_time=tpl_files_time+"H4";
    } 
    
    if(FileIsExist(tpl_files +"-1440-.tpl",1)) {
    if ( tpl_files_time != "" ) tpl_files_time=tpl_files_time+" ";
    tpl_files_time=tpl_files_time+"D1";
    } 

    if(FileIsExist(tpl_files +"-10080-.tpl",1)) {
    if ( tpl_files_time != "" ) tpl_files_time=tpl_files_time+" ";
    tpl_files_time=tpl_files_time+"W1";
    } 

    if(FileIsExist(tpl_files +"-43200-.tpl",1)) {
    if ( tpl_files_time != "" ) tpl_files_time=tpl_files_time+" ";
    tpl_files_time=tpl_files_time+"MN1";
    } 
        
    if ( tpl_files_time != "" ) tpl_files_find=true;
      
    
    //Alert(right_bound,"/",WindowFirstVisibleBar());
    
//datetime right=Time[right_bound]+Period()*60;
//shift=iBarShift(ChartSymbol(ChartID()),ChartPeriod(ChartID()),right);   
//shift = (shift+carpan)*-1;
    //datetime right=Time[right_bound]+Period()*60;
    ObjectDelete(OrderLine);
    //ObjectCreate(ChartID(),OrderLine,OBJ_TREND,0,Time[WindowFirstVisibleBar()],OrderOpenPrice(),Time[WindowFirstVisibleBar()]+5*PeriodSeconds(),OrderOpenPrice());
    //ObjectSetInteger(ChartID(),OrderLine,OBJPROP_RAY_RIGHT,0);
    //ObjectSetInteger(ChartID(),OrderLine,OBJPROP_WIDTH,2);
    //ObjectCreate(ChartID(),OrderLine,OBJ_HLINE,0,Time[0],OrderOpenPrice());
      //datetime OrderTime=Time[WindowFirstVisibleBar()]+5*PeriodSeconds();
      datetime OrderTime=Time[WindowFirstVisibleBar()-5];
      ObjectCreate(ChartID(),OrderLine,OBJ_ARROW,0,0,0,0,0);          // Create an arrow
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_ARROWCODE,108);    // Set the arrow code
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_TIME,OrderTime);        // Set time
      ObjectSetDouble(ChartID(),OrderLine,OBJPROP_PRICE,OrderOpenPrices);// Set price
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_ANCHOR,ANCHOR_UPPER);    // Set the arrow code
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_FONTSIZE,8); 
         //ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER);
      OrderLine="FeOrderLoad"+Symbol();
      OrderTime=Time[WindowFirstVisibleBar()-20];
      ObjectCreate(ChartID(),OrderLine,OBJ_ARROW,0,0,0,0,0);          // Create an arrow
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_ARROWCODE,108);    // Set the arrow code
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_TIME,OrderTime);        // Set timeOrderTime+20*PeriodSeconds()
      ObjectSetDouble(ChartID(),OrderLine,OBJPROP_PRICE,OrderOpenPrices);// Set price
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_ANCHOR,ANCHOR_UPPER);    // Set the arrow code
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_FONTSIZE,8); 
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_COLOR,clrAliceBlue);      
      if ( tpl_files_find ) ObjectSetInteger(ChartID(),OrderLine,OBJPROP_COLOR,clrDarkGreen);
      if ( tpl_files_per_find ) ObjectSetInteger(ChartID(),OrderLine,OBJPROP_COLOR,clrLimeGreen);
      if ( tpl_files_find ) ObjectSetString(ChartID(),OrderLine,OBJPROP_TEXT,tpl_files_time);
      
         //ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER);

      OrderLine="FeOrderDelete"+Symbol();
      OrderTime=Time[WindowFirstVisibleBar()-40];
      ObjectCreate(ChartID(),OrderLine,OBJ_ARROW,0,0,0,0,0);          // Create an arrow
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_ARROWCODE,108);    // Set the arrow code
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_TIME,OrderTime);        // Set timeOrderTime+40*PeriodSeconds()
      ObjectSetDouble(ChartID(),OrderLine,OBJPROP_PRICE,OrderOpenPrices);// Set price
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_ANCHOR,ANCHOR_UPPER);    // Set the arrow code
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_FONTSIZE,8); 
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_COLOR,clrBlack);
         //ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER);
         
                           
         
         
      ChartRedraw(ChartID()); 
      
          
    
    }
    
    //}
    
    
    
  
    
    
    //}

}






int FileInfo(const int handle,const ENUM_FILE_PROPERTY_INTEGER id,
              long l,const string type)
  {
//--- receive the property value
   ResetLastError();
   if((l=FileGetInteger(handle,id))!=-1)
     {
      //--- the value received, display it in the correct format
     /* if(!StringCompare(type,"bool"))
         Print(EnumToString(id)," = ",l ? "true" : "false");
      if(!StringCompare(type,"date"))
         Print(EnumToString(id)," = ",(datetime)l);
      if(!StringCompare(type,"other"))
         Print(EnumToString(id)," = ",l);*/
     }
   else
      Print("Error, Code = ",GetLastError());
  
  return (datetime)l;
  
  }
  
  
string FileTime(string filename) {

    long   l=0;    
    int handle=FileOpen(filename,FILE_READ|FILE_CSV);
    //int handle=FileOpen(tpl_files +"-5-.tpl",FILE_READ|FILE_CSV);
    int modify_date=FileInfo(handle,FILE_CREATE_DATE,l,"date");
    FileClose(handle);
    datetime modify_dates=modify_date;
    int gecen_sure = (TimeLocal()-modify_dates)/60;
    string gecen_time = "dk";
    if ( gecen_sure > 60 ) {
    gecen_time = "s";
    gecen_sure = gecen_sure/60;
    
    if ( gecen_sure > 24 ) {
    gecen_time = "g";
    gecen_sure = gecen_sure/24;    
    }
    
    }  
    
    return gecen_sure+gecen_time;

}  




void FeAnaliz() {

//Alert("Selam");

  //int totalii = OrdersTotal();
  
  //Alert(OrdersTotal());
  
  for(int iii=0;iii<=5;iii++)
  {
    /*OrderSelect(iii, SELECT_BY_POS);
           int typei = OrderType();
    string commentsi = OrderComment();
    
    
    if ( Symbol() == OrderSymbol() ) {*/
    
    
    
    
    //Print(OrderTicket(),"/",ObjectFind("Order"+OrderTicket()));
    
    string OrderLine="FeOrderSave"+Symbol()+"-"+iii;
    if ( ObjectFind("FeOrderSave"+Symbol()+"-"+iii) == -1 ) {
    
    //int      right_bound=WindowFirstVisibleBar()-WindowBarsPerChart();
    
  datetime left;
  int      right_bound;
  if ( WindowFirstVisibleBar() > -1 ) {
  //left=Time[WindowFirstVisibleBar()];
  right_bound=WindowFirstVisibleBar()-WindowBarsPerChart();}
  else{
  //left=TimeCurrent();
  right_bound=WindowFirstVisibleBar()-WindowBarsPerChart();
  }

double OrderOpenPrices=Ask;

bool tpl_files_per_find=false;
bool tpl_files_find=false;
string tpl_files=Symbol()+"-"+iii;
string tpl_files_time = "";

if(FileIsExist(tpl_files +"-"+Period()+"-.tpl",1)) {
    //tpl_files_find=true;
    tpl_files_per_find=true;
    } 
    

//Alert("Delete",tpl_files);
    
    if(FileIsExist(tpl_files +"-1-.tpl",1)) {
    tpl_files_time="M1("+FileTime(tpl_files +"-1-.tpl")+")";
    } 
        
    if(FileIsExist(tpl_files +"-5-.tpl",1)) {
    if ( tpl_files_time != "" ) tpl_files_time=tpl_files_time+" ";
    tpl_files_time=tpl_files_time+"M5("+FileTime(tpl_files +"-5-.tpl")+")";
    }         
    
    if(FileIsExist(tpl_files +"-15-.tpl",1)) {
    if ( tpl_files_time != "" ) tpl_files_time=tpl_files_time+" ";
    tpl_files_time=tpl_files_time+"M15("+FileTime(tpl_files +"-15-.tpl")+")";
    }         

    if(FileIsExist(tpl_files +"-30-.tpl",1)) {
    if ( tpl_files_time != "" ) tpl_files_time=tpl_files_time+" ";
    tpl_files_time=tpl_files_time+"M30("+FileTime(tpl_files +"-30-.tpl")+")";
    }     
        
    if(FileIsExist(tpl_files +"-60-.tpl",1)) {
    if ( tpl_files_time != "" ) tpl_files_time=tpl_files_time+" ";
    tpl_files_time=tpl_files_time+"H1("+FileTime(tpl_files +"-60-.tpl")+")";
    }     
    
    if(FileIsExist(tpl_files +"-240-.tpl",1)) {
    if ( tpl_files_time != "" ) tpl_files_time=tpl_files_time+" ";
    tpl_files_time=tpl_files_time+"H4("+FileTime(tpl_files +"-240-.tpl")+")";
    } 
    
    if(FileIsExist(tpl_files +"-1440-.tpl",1)) {
    if ( tpl_files_time != "" ) tpl_files_time=tpl_files_time+" ";
    tpl_files_time=tpl_files_time+"D1("+FileTime(tpl_files +"-1440-.tpl")+")";
    } 

    if(FileIsExist(tpl_files +"-10080-.tpl",1)) {
    if ( tpl_files_time != "" ) tpl_files_time=tpl_files_time+" ";
    tpl_files_time=tpl_files_time+"W1("+FileTime(tpl_files +"-10080-.tpl")+")";
    } 

    if(FileIsExist(tpl_files +"-43200-.tpl",1)) {
    if ( tpl_files_time != "" ) tpl_files_time=tpl_files_time+" ";
    tpl_files_time=tpl_files_time+"MN1("+FileTime(tpl_files +"-43200-.tpl")+")";
    } 
        
    if ( tpl_files_time != "" ) tpl_files_find=true;
      
    
    //Alert(right_bound,"/",WindowFirstVisibleBar());
    
//datetime right=Time[right_bound]+Period()*60;
//shift=iBarShift(ChartSymbol(ChartID()),ChartPeriod(ChartID()),right);   
//shift = (shift+carpan)*-1;
    //datetime right=Time[right_bound]+Period()*60;
    ObjectDelete(OrderLine);
    //ObjectCreate(ChartID(),OrderLine,OBJ_TREND,0,Time[WindowFirstVisibleBar()],OrderOpenPrice(),Time[WindowFirstVisibleBar()]+5*PeriodSeconds(),OrderOpenPrice());
    //ObjectSetInteger(ChartID(),OrderLine,OBJPROP_RAY_RIGHT,0);
    //ObjectSetInteger(ChartID(),OrderLine,OBJPROP_WIDTH,2);
    //ObjectCreate(ChartID(),OrderLine,OBJ_HLINE,0,Time[0],OrderOpenPrice());
      //datetime OrderTime=Time[WindowFirstVisibleBar()]+5*PeriodSeconds();
      //datetime OrderTime=Time[WindowFirstVisibleBar()-5];
      ObjectCreate(ChartID(),OrderLine,OBJ_LABEL,0,0,0,0,0);          // Create an arrow
      ObjectSetText(OrderLine,"l",13,"WingDings",clrRed);
      //ObjectSetInteger(ChartID(),OrderLine,OBJPROP_ARROWCODE,108);    // Set the arrow code
      //ObjectSetInteger(ChartID(),OrderLine,OBJPROP_TIME,OrderTime);        // Set time
      //ObjectSetDouble(ChartID(),OrderLine,OBJPROP_PRICE,OrderOpenPrices);// Set price
      ObjectSetInteger(ChartID(),OrderLine, OBJPROP_XDISTANCE, 20);
      ObjectSetInteger(ChartID(),OrderLine, OBJPROP_YDISTANCE, 20*iii);
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_ANCHOR,ANCHOR_UPPER);    // Set the arrow code
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_CORNER,CORNER_LEFT_LOWER);    // Set the arrow code
      //ObjectSetInteger(ChartID(),OrderLine,OBJPROP_FONTSIZE,8); 
         //ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER);
      OrderLine="FeOrderLoad"+Symbol()+"-"+iii;
      ObjectDelete(OrderLine);
      //OrderTime=Time[WindowFirstVisibleBar()-20];
      ObjectCreate(ChartID(),OrderLine,OBJ_LABEL,0,0,0,0,0);          // Create an arrow
      //ObjectSetInteger(ChartID(),OrderLine,OBJPROP_ARROWCODE,108);    // Set the arrow code
      //ObjectSetInteger(ChartID(),OrderLine,OBJPROP_TIME,OrderTime);        // Set timeOrderTime+20*PeriodSeconds()
      //ObjectSetDouble(ChartID(),OrderLine,OBJPROP_PRICE,OrderOpenPrices);// Set price
      ObjectSetText(OrderLine,"l",13,"WingDings",clrAliceBlue);
      ObjectSetInteger(ChartID(),OrderLine, OBJPROP_XDISTANCE, 50);
      ObjectSetInteger(ChartID(),OrderLine, OBJPROP_YDISTANCE, 20*iii);      
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_ANCHOR,ANCHOR_UPPER);    // Set the arrow code
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_CORNER,CORNER_LEFT_LOWER);    // Set the arrow code
      //ObjectSetInteger(ChartID(),OrderLine,OBJPROP_FONTSIZE,8); 
      //ObjectSetInteger(ChartID(),OrderLine,OBJPROP_COLOR,clrAliceBlue);      
      if ( tpl_files_find ) ObjectSetInteger(ChartID(),OrderLine,OBJPROP_COLOR,clrDarkGreen);
      if ( tpl_files_per_find ) ObjectSetInteger(ChartID(),OrderLine,OBJPROP_COLOR,clrLimeGreen);
      if ( tpl_files_find ) ObjectSetString(ChartID(),OrderLine,OBJPROP_TOOLTIP,tpl_files_time);
      
      int small_time_dk = StringFind(tpl_files_time,"dk",0);
      if ( small_time_dk != -1 ) {ObjectSetInteger(ChartID(),OrderLine,OBJPROP_COLOR,clrYellow);            
      ObjectSetText(OrderLine,"«",13,"WingDings",clrYellow);
      }

      int small_time_sa = StringFind(tpl_files_time,"s",0);
      if ( small_time_sa != -1 ) {ObjectSetInteger(ChartID(),OrderLine,OBJPROP_COLOR,clrLightBlue);                  
      ObjectSetText(OrderLine,"«",13,"WingDings",clrLightBlue);
      }
      
      
      
         //ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER);

      OrderLine="FeOrderDelete"+Symbol()+"-"+iii;
      ObjectDelete(OrderLine);
      //OrderTime=Time[WindowFirstVisibleBar()-40];
      ObjectCreate(ChartID(),OrderLine,OBJ_LABEL,0,0,0,0,0);          // Create an arrow
      //ObjectSetInteger(ChartID(),OrderLine,OBJPROP_ARROWCODE,108);    // Set the arrow code
      //ObjectSetInteger(ChartID(),OrderLine,OBJPROP_TIME,OrderTime);        // Set timeOrderTime+40*PeriodSeconds()
      //ObjectSetDouble(ChartID(),OrderLine,OBJPROP_PRICE,OrderOpenPrices);// Set price
      ObjectSetText(OrderLine,"l",13,"WingDings",clrBlack);
      ObjectSetInteger(ChartID(),OrderLine, OBJPROP_XDISTANCE, 80);
      ObjectSetInteger(ChartID(),OrderLine, OBJPROP_YDISTANCE, 20*iii);        
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_ANCHOR,ANCHOR_UPPER);    // Set the arrow code
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_CORNER,CORNER_LEFT_LOWER);    // Set the arrow code
      //ObjectSetInteger(ChartID(),OrderLine,OBJPROP_FONTSIZE,8); 
      //ObjectSetInteger(ChartID(),OrderLine,OBJPROP_COLOR,clrBlack);
         //ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER);
         
                           
         
         
      ChartRedraw(ChartID()); 
      
          
    
    }
    
    //}
    
    
    
  
    
    
    }

}



void FeAnalizEvent(string sparam,int id){



  if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_ARROW ) {
  
  //Alert("Sparam:",sparam);
  
////////////////////////////////////////////////////////////////////////////      
   string sym_line="";
   string ord="";
   
   //if ( sym_periyod == "" ) {  
   string sep=" ";                // A separator as a character
   ushort u_sep;                  // The code of the separator character
   string results[];               // An array to get strings
   //--- Get the separator code
   u_sep=StringGetCharacter(sep,0);
   //--- Split the string to substrings
   
   //string ButtonSinyalTip = "";
   
   int k=StringSplit(sparam,u_sep,results);
   //Print("k",k);
   
   if(k>1) {
   //sym_line = results[0];
   ord = results[0]; 
   
   int indextic = StringFind(sparam,"#", 0);
   int indexsym = StringFind(sparam,Symbol(), 0);
   
   if ( indextic != -1 && indexsym != -1 ) {
   
   int replaced=StringReplace(ord,"#",""); 
   
   //Alert("ORD:",ord); 
   
   
long sinyal_charid;
string tpl_files=ord;
//int replaced=StringReplace(tpl_files,"-Load","");    
    /*if(FileIsExist(tpl_files +".tpl",1)) {
    tpl_files = "\\Files\\"+tpl_files +".tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    //sinyal_charid=ChartOpen(Symbol(),Period());    
    //ChartApplyTemplate(sinyal_charid,tpl_files);
    //ChartSetSymbolPeriod(sinyal_charid,Symbol(),Period());
    }  */
    
    if(FileIsExist(tpl_files +"-1-.tpl",1)  && Period() == 1) {
    tpl_files = "\\Files\\"+tpl_files +"-1-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_M1);
    } 
        
    if(FileIsExist(tpl_files +"-5-.tpl",1)  && Period() == 5) {
    tpl_files = "\\Files\\"+tpl_files +"-5-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_M5);
    }     
    
    if(FileIsExist(tpl_files +"-15-.tpl",1)  && Period() == 15) {
    tpl_files = "\\Files\\"+tpl_files +"-15-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_M15);
    }     
            

    if(FileIsExist(tpl_files +"-30-.tpl",1)  && Period() == 30) {
    tpl_files = "\\Files\\"+tpl_files +"-30-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_M30);
    }     
    
    if(FileIsExist(tpl_files +"-60-.tpl",1)  && Period() == 60) {
    tpl_files = "\\Files\\"+tpl_files +"-60-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_H1);
    }     
    
    if(FileIsExist(tpl_files +"-240-.tpl",1)  && Period() == 240) {
    tpl_files = "\\Files\\"+tpl_files +"-240-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_H4);
    } 
    
    if(FileIsExist(tpl_files +"-1440-.tpl",1)  && Period() == 1440) {
    tpl_files = "\\Files\\"+tpl_files +"-1440-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_D1);
    } 

    if(FileIsExist(tpl_files +"-10080-.tpl",1) && Period() == 10080) {
    tpl_files = "\\Files\\"+tpl_files +"-10080-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_W1);
    } 

    if(FileIsExist(tpl_files +"-43200-.tpl",1)  && Period() == 43200) {
    tpl_files = "\\Files\\"+tpl_files +"-43200-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_MN1);
    } 
        
        
      ObjectDelete("FeOrderLoad"+ord);
      ObjectDelete("FeOrderSave"+ord);
      ObjectDelete("FeOrderDelete"+ord);  
      ObjectsDeleteAlls(ChartID(),"FeOrder",0,-1);          
      Sleep(100);
      FeAnaliz();

   
     
   }  
     
   }
   
   
   
   //}
       
   //Print(sym,"/",sym_line);  
///////////////////////////////////////////////////////////////////////////   
  }
  
  
  
  
  
  
  
  
//---
   
//Print("Sparam",sparam,"/",id);
//////////////////////////////////////////////////////////////////////
int indexfel = StringFind(sparam,"FeOrderLoad", 0);
int indexfes = StringFind(sparam,"FeOrderSave", 0);
int indexfed = StringFind(sparam,"FeOrderDelete", 0);

// Normal çalışması için OrderTicket yerine Symbol konulabilinir.

if ( indexfes != -1 && id==1) {

//Alert("Kayıt:",sparam);

         string ord = sparam;
      int replacedz = StringReplace(ord,"FeOrderSave","");
      
    
       string tpl_files = ord +"-"+Period()+"-.tpl";
//Alert("TPL:",tpl_files);


//////////////////////////////////////////////////////////////////////////////////////////////////
bool filefund = false;
int savenum_find=-1;

  for(int iii=0;iii<=5;iii++)
  {


string tpl_files=Symbol()+"-"+iii;

    if(FileIsExist(tpl_files +"-"+Period()+"-.tpl",1)) {
    
    string saveid= "id="+ChartID();//132620466158983609
    string savesym = "symbol="+Symbol();//USDMXN
    string saveper = "period="+Period();//240
    

string str,word;
   int handle = FileOpen(tpl_files +"-"+Period()+"-.tpl",FILE_READ|FILE_TXT);

//if(handle==-1)return(0);// if not exist
//if(FileSize(handle)==0){FileClose(handle); return(0); } //if empty

int x=0;
int y=0;

bool saveid_find=false;
bool savesym_find=false;
bool saveper_find=false;


while(!FileIsEnding(handle))//read file to the end by paragraph. if you have only one string, omit it
   {
   str=FileReadString(handle);//read one paragraph to the string variable
   if(str!="")//if string not empty
      {
      x=x+1;
      //Print(x,"/",str);
      
      
      
      
      
      if ( x==2 && saveid==str ) {
      saveid_find=true;
      }
      
      if ( x==3 ) {
      int indexofcmt=StringFind(str, "comment=", 0);
      if ( indexofcmt != -1 ) {
      y=1;
      }
      savenum_find=iii;      
      }
      
      if ( x==3+y && savesym==str ) {
      savesym_find=true;
      }
      
      if ( x==4+y && saveper==str ) {
      saveper_find=true;
      }      
 
      
      }  
      
      } 
      
      
FileClose(handle); //close file
//return(0);   


if ( saveid_find == true && savesym_find == true && saveper_find == true ) {
filefund = true;
}


    
    
    
    } 



 }


if ( filefund == true ) {
Alert("Bu şablon önceden kaydedilmiş ("+savenum_find+")");
return;
}
//////////////////////////////////////////////////////////////////////////////////////////








      ObjectDelete("FeOrderLoad"+ord);
      ObjectDelete("FeOrderSave"+ord);
      ObjectDelete("FeOrderDelete"+ord);
      ObjectsDeleteAlls(ChartID(),"FeOrder",0,-1);

      //FileDelete("\\Files\\"+tpl_files,1);
      FileDelete(tpl_files,1);
      Sleep(100);
      //ChartSaveTemplate(ChartID(),"\\Files\\"+tpl_files);
      ChartSaveTemplate(ChartID(),"\\Files\\"+tpl_files);
      
               
      Print("OrderTicket",ord);
      
      //ObjectDelete("FeOrderLoad"+ord);
      //ObjectDelete("FeOrderSave"+ord);
      //ObjectDelete("FeOrderDelete"+ord);
      Sleep(100);
      FeAnaliz();
      
      
}




if ( indexfed != -1 && id==1) {



         string ord = sparam;
      int replacedz = StringReplace(ord,"FeOrderDelete","");
      
      Print("OrderTicket",ord);
      
long sinyal_charid;
string tpl_files=ord;

//Alert("Delete",tpl_files);
    
    if(FileIsExist(tpl_files +"-1-.tpl",1) && Period() == 1 ) {
    tpl_files = tpl_files +"-1-.tpl";
    FileDelete(tpl_files,1);
    } 
        
    if(FileIsExist(tpl_files +"-5-.tpl",1)  && Period() == 5) {
    tpl_files = tpl_files +"-5-.tpl";
    FileDelete(tpl_files,1);
    }     
    
    if(FileIsExist(tpl_files +"-15-.tpl",1) && Period() == 15) {
    tpl_files = tpl_files +"-15-.tpl";
    FileDelete(tpl_files,1);
    }     
                

    if(FileIsExist(tpl_files +"-30-.tpl",1) && Period() == 30) {
    tpl_files = tpl_files +"-30-.tpl";
    FileDelete(tpl_files,1);
    }     
        
    if(FileIsExist(tpl_files +"-60-.tpl",1)  && Period() == 60) {
    tpl_files = tpl_files +"-60-.tpl";
    FileDelete(tpl_files,1);
    }     
    
    if(FileIsExist(tpl_files +"-240-.tpl",1)  && Period() == 240) {
    tpl_files = tpl_files +"-240-.tpl";
    FileDelete(tpl_files,1);
    } 
    
    if(FileIsExist(tpl_files +"-1440-.tpl",1) && Period() == 1440 ) {
    tpl_files = tpl_files +"-1440-.tpl";
    FileDelete(tpl_files,1);
    } 

    if(FileIsExist(tpl_files +"-10080-.tpl",1)  && Period() == 10080) {
    tpl_files = tpl_files +"-10080-.tpl";
    FileDelete(tpl_files,1);
    } 

    if(FileIsExist(tpl_files +"-43200-.tpl",1)  && Period() == 43200) {
    tpl_files = tpl_files +"-43200-.tpl";
    FileDelete(tpl_files,1);
    } 
        
        
      ObjectDelete("FeOrderLoad"+ord);
      ObjectDelete("FeOrderSave"+ord);
      ObjectDelete("FeOrderDelete"+ord);
      ObjectsDeleteAlls(ChartID(),"FeOrder",0,-1);          
      Sleep(100);
      FeAnaliz();
      
      
}



if ( indexfel != -1 && id==1) {

         string ord = sparam;
      int replacedz = StringReplace(ord,"FeOrderLoad","");
      
      Print("OrderTicket",ord);
      
long sinyal_charid;
string tpl_files=ord;
//int replaced=StringReplace(tpl_files,"-Load","");    
    /*if(FileIsExist(tpl_files +".tpl",1)) {
    tpl_files = "\\Files\\"+tpl_files +".tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    //sinyal_charid=ChartOpen(Symbol(),Period());    
    //ChartApplyTemplate(sinyal_charid,tpl_files);
    //ChartSetSymbolPeriod(sinyal_charid,Symbol(),Period());
    }  */
    
    if(FileIsExist(tpl_files +"-1-.tpl",1)  && Period() == 1) {
    tpl_files = "\\Files\\"+tpl_files +"-1-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_M1);
    } 
        
    if(FileIsExist(tpl_files +"-5-.tpl",1)  && Period() == 5) {
    tpl_files = "\\Files\\"+tpl_files +"-5-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_M5);
    }     
    
    if(FileIsExist(tpl_files +"-15-.tpl",1)  && Period() == 15) {
    tpl_files = "\\Files\\"+tpl_files +"-15-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_M15);
    }     
            

    if(FileIsExist(tpl_files +"-30-.tpl",1)  && Period() == 30) {
    tpl_files = "\\Files\\"+tpl_files +"-30-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_M30);
    }     
    
    if(FileIsExist(tpl_files +"-60-.tpl",1)  && Period() == 60) {
    tpl_files = "\\Files\\"+tpl_files +"-60-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_H1);
    }     
    
    if(FileIsExist(tpl_files +"-240-.tpl",1)  && Period() == 240) {
    tpl_files = "\\Files\\"+tpl_files +"-240-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_H4);
    } 
    
    if(FileIsExist(tpl_files +"-1440-.tpl",1)  && Period() == 1440) {
    tpl_files = "\\Files\\"+tpl_files +"-1440-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_D1);
    } 

    if(FileIsExist(tpl_files +"-10080-.tpl",1) && Period() == 10080) {
    tpl_files = "\\Files\\"+tpl_files +"-10080-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_W1);
    } 

    if(FileIsExist(tpl_files +"-43200-.tpl",1)  && Period() == 43200) {
    tpl_files = "\\Files\\"+tpl_files +"-43200-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_MN1);
    } 
        
        
      ObjectDelete("FeOrderLoad"+ord);
      ObjectDelete("FeOrderSave"+ord);
      ObjectDelete("FeOrderDelete"+ord);  
      ObjectsDeleteAlls(ChartID(),"FeOrder",0,-1);          
      Sleep(100);
      FeAnaliz();
      
      
}
////////////////////////////////////////////////////////////////////////////


}



///////////////////////////////////////////////////////////////////////////////////////////////////////////
/// İşlem Kapama
//////////////////////////////////////////////////////////////////////////////////////////////////////////
void CloseTrades(string cmt,string islem,int typ)
 {
 
 //return;
 
 //Alert(cmt,"/",typ);
 
 
 bool sil=false;
 
 
 if ( islem == "PEN" ) { 
 
 //Alert("Selam",cmt);
 
    if ( OrdersTotal() == 1 ) {

      if(OrderSelect(0,SELECT_BY_POS,MODE_TRADES))
        {
        
        //Alert("Evet 1 İşlem Ticket:",OrderTicket());
        
          int index=StringFind(OrderComment(), cmt, 0);
          if ( index != -1 || cmt == "") {
          
          //if(OrderType()==OP_BUY || OrderType()==OP_SELL){
          
          if ( (OrderType() == OP_BUYLIMIT || OrderType() == OP_SELLLIMIT || OrderType() == OP_BUYSTOP || OrderType() == OP_SELLSTOP ) //&& OrderSymbol() == Symbol()
          ){ 
          
          //Alert(OrderTicket());
          
          OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),50,clrRed);
          OrderDelete(OrderTicket());
               int Err=GetLastError();
          
          
          } 
        
        }
   
   }
   }
 
 //if((cmt=="ALL" || cmt=="PEN") && OrderSymbol() == Symbol()){sil=true;}; // Hepsi veya Pending
 
   int total = OrdersTotal();
   //Alert(total);
   
   for(int i=total-1;i>=0;i--)
  //for(int i=total;i>=0;i--)
  {
    OrderSelect(i, SELECT_BY_POS);
    int type   = OrderType();
/*
 if ( (OrderType() == OP_BUYLIMIT || OrderType() == OP_SELLLIMIT || OrderType() == OP_BUYSTOP || OrderType() == OP_SELLSTOP ) && OrderSymbol() == Symbol()){ 
          
          //Alert(OrderTicket());
          
          OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),50,clrRed);
          OrderDelete(OrderTicket());
               int Err=GetLastError();
          
          
          } */

    
   /* 

    

    
if(index!=-1 && OrderSymbol() == Symbol()){sil=true;};

};

if(OrderComment()=="" && cmt=="" && OrderSymbol() == Symbol()){sil=true;};
if(cmt=="*" && OrderSymbol() == Symbol()){sil=true;};*/
       
    int index=StringFind(OrderComment(), cmt, 0);
    
    if(index==-1) continue;
    
    sil=true;
      
          

    bool result = false;
    //if ( Symbol()==OrderSymbol() ) {
    switch(type)
    {
      //Close opened long positions
      //case OP_BUYSTOP    : result = OrderDelete( OrderTicket());
      //                    break;
      
      //Close opened short positions
      case OP_SELLSTOP   : if (sil==true)result = OrderDelete( OrderTicket());
                           break;
            //Close opened long positions
      case OP_BUYLIMIT    : if (sil==true)result = OrderDelete( OrderTicket());
                          break;
      
      //Close opened short positions
      case OP_SELLLIMIT   : if (sil==true)result = OrderDelete( OrderTicket());
                          break;
      case OP_BUYSTOP    : if (sil==true)result = OrderDelete( OrderTicket());
                          break;
    }
    //};
    
    //if(result == false)
    //{
      //Alert("Order " , OrderTicket() , " All Pending Orders Removed " );
    //  break;
    //}  
  }
 
 }
 
 
 
 sil=false;
 int ind;
 
 if ( islem == "LIVE" ) {
 
 //if((cmt=="ALL" || cmt=="OPEN") ){sil=true;}; // Hepsi veya Acik
 
 //Alert("Sil Live:",sil,OrdersTotal()-1);
 
 
 
 if ( cmt=="" ) {sil=true;}
 
  int Attempts=0;
  bool AllClosed=false;
  while(AllClosed==false && Attempts<500)
   { 
   int counter =0;
   
   /////////////////////////////////////////////////////////////////////
   if ( OrdersTotal() == 1 ) {

      if(OrderSelect(0,SELECT_BY_POS,MODE_TRADES))
        {
        
        //Alert("Evet 1 İşlem Ticket:",OrderTicket());
        
          int index=StringFind(OrderComment(), cmt, 0);
          if ( index != -1 || cmt == "") {
          
          //if(OrderType()==OP_BUY || OrderType()==OP_SELL){
          
          if ( OrderType() == typ && OrderSymbol() == Symbol()){ 
          
          //Alert(OrderTicket());
          
          OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),50,clrRed);
               int Err=GetLastError();
          
          
          } 
        
        }
   
   }
   }
   ///////////////////////////////////////////////////////////////////
   
   for(int index=OrdersTotal()-1;index>=0;index--)   
     {
      if(!OrderSelect(index,SELECT_BY_POS,MODE_TRADES))
        {
        
    int index=StringFind(OrderComment(), cmt, 0);
    
    if(index==-1) continue;
    
    sil=true;


   //Alert("Sil Live:",sil,"CMT");


        
         //Print("Error with OrderSelect-",ErrorDescription(GetLastError()));
         counter++;
         continue;
        }
        //OrderMagicNumber()==MagicNumber && 
      if(OrderSymbol()==Symbol() && sil==true)
         {
         if(OrderType()==typ || OrderType()==typ //|| OrderType() == OP_BUYSTOP || OrderType() == OP_SELLSTOP || OrderType() == OP_BUYLIMIT || OrderType() == OP_SELLLIMIT 
         
         )
            {
            if(!OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),50,clrRed))
               {
               int Err=GetLastError();
               //Print("Error closing order ",OrderTicket(),". Error code ",Err,". ",ErrorDescription(Err));
               counter++;
               }
            }
         
         /*else
            {
            if(!OrderDelete(OrderTicket()))
               {
               int Err=GetLastError();
               //Print("Error deleting order ",OrderTicket(),". Error code ",Err,". ",ErrorDescription(Err));
               counter++;
               }
            
            }*/
         
         }
     }
  Attempts++ ;
  if(counter==0)
    AllClosed=true;
  else
    Sleep(5000);
  }
  
  }
  
  
  
  
 }     
  
  
///////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////

int WFVB = WindowFirstVisibleBar();
   int mumanaliz_shift=0;
   int mumanaliz_shiftb=WindowFirstVisibleBar();
   
void MumAnaliz() {

if ( WFVB == WindowFirstVisibleBar() ) return;

//if ( WindowFirstVisibleBar()-WindowBarsPerChart() < 0 && WFVB < WindowFirstVisibleBar() ) ChartSetInteger(ChartID(),CHART_AUTOSCROLL,true);



if ( WFVB > WindowFirstVisibleBar() ) {ChartSetInteger(ChartID(),CHART_AUTOSCROLL,false);} else {

if ( WindowFirstVisibleBar()-WindowBarsPerChart() < 0 && WFVB < WindowFirstVisibleBar() ) ChartSetInteger(ChartID(),CHART_AUTOSCROLL,true);
}
  
  WFVB = WindowFirstVisibleBar();

   
   //ChartAngle(Symbol(),ChartID(),Period());
   
   //ObjectsDeleteAll();
   
   if ( WindowFirstVisibleBar()-WindowBarsPerChart() > 0 ) {
   mumanaliz_shift=WindowFirstVisibleBar()-WindowBarsPerChart();
   } else {
   mumanaliz_shift=0;
   }
   mumanaliz_shiftb=WindowFirstVisibleBar();
   
   int bar_toplam = mumanaliz_shiftb-mumanaliz_shift;
   double bar_pip = 0;
   double bar_ortalama=0;
   
   for (int t=mumanaliz_shift;t<=mumanaliz_shiftb;t++) {
   
   //if ( t > Bars ) continue;
   
   //Print("Hata",Close[t],"/",Open[t],"/",MathAbs(Close[t]-Open[t]));
   bar_pip = bar_pip + MathAbs(Close[t]-Open[t]);   
   //int Err=GetLastError();
   //Print("Eror:",Err);
   
   }
   
   
   
   //bar_ortalama = bar_pip / bar_toplam;
   bar_ortalama = DivZero(bar_pip, bar_toplam);

   for (int t=mumanaliz_shift;t<=mumanaliz_shiftb;t++) {
   
   
   
   ObjectDelete(ChartID(),"VLINE"+t);
   if ( MathAbs(Close[t]-Open[t]) < bar_ortalama/10 ) {

   
   //ObjectCreate(ChartID(),"VLINE"+t,OBJ_VLINE,0,Time[t],Ask);   
   
   
   
   if ( (High[t] - Low[t]) < bar_ortalama/10 ) {
   
   
   /*if ( Open[t] > Close[t] ) {
   ObjectCreate(ChartID(),"VLINE"+t,OBJ_TRENDBYANGLE,0,Time[t],,Time[t],);   
   }
   
   if ( Close[t] > Open[t] ) {
   ObjectCreate(ChartID(),"VLINE"+t,OBJ_TRENDBYANGLE,0,Time[t],,Time[t],);   
   }

   if ( Close[t] == Open[t] ) {
   ObjectCreate(ChartID(),"VLINE"+t,OBJ_TRENDBYANGLE,0,Time[t],,Time[t],);   
   }   */
   
      
   ObjectCreate(ChartID(),"VLINE"+t,OBJ_TRENDBYANGLE,0,Time[t],High[t]+bar_ortalama,Time[t],Low[t]-bar_ortalama);   
   
   
   } else {
   ObjectCreate(ChartID(),"VLINE"+t,OBJ_TRENDBYANGLE,0,Time[t],High[t],Time[t],Low[t]);   
   }
   
   
   ObjectSetInteger(ChartID(),"VLINE"+t,OBJPROP_BACK,true);
   ObjectSetInteger(ChartID(),"VLINE"+t,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),"VLINE"+t,OBJPROP_WIDTH,3);
   ObjectSetInteger(ChartID(),"VLINE"+t,OBJPROP_SELECTABLE,false);
   ObjectSetInteger(ChartID(),"VLINE"+t,OBJPROP_SELECTED,false);
   
   if ( Open[t] > Close[t] ) {
   ObjectSetInteger(ChartID(),"VLINE"+t,OBJPROP_COLOR,clrRed);
   ObjectSetString(ChartID(),"VLINE"+t,OBJPROP_TOOLTIP,"DOWN");
   }

   if ( Close[t] > Open[t] ) {
   ObjectSetInteger(ChartID(),"VLINE"+t,OBJPROP_COLOR,clrLimeGreen);
   ObjectSetString(ChartID(),"VLINE"+t,OBJPROP_TOOLTIP,"UP");
   }

   if ( Close[t] == Open[t] ) {
   ObjectSetInteger(ChartID(),"VLINE"+t,OBJPROP_COLOR,clrDarkGray);
   ObjectSetString(ChartID(),"VLINE"+t,OBJPROP_TOOLTIP,"MIDDLE");
   }      
      
      
   
   
   }
   
   }
   
      
   
   
///Comment("Bars:",Bars,"WindowBarsPerChart",WindowBarsPerChart(),"WindowFirstVisibleBar()",WindowFirstVisibleBar(),"WindowPriceMax()",WindowPriceMax(),"WindowPriceMin()",WindowPriceMin(),"WindowFirstVisibleBar()-WindowBarsPerChart()",WindowFirstVisibleBar()-WindowBarsPerChart(),"shift:",mumanaliz_shift,"/",mumanaliz_shiftb,"=",mumanaliz_shiftb-mumanaliz_shift,"\n bar_pip",bar_pip,"\n bar_ortalama",bar_ortalama);

   
   /*ObjectDelete(ChartID(),"VLINE");
   ObjectCreate(ChartID(),"VLINE",OBJ_VLINE,0,Time[WindowFirstVisibleBar()],Ask);

   if ( WindowFirstVisibleBar()-WindowBarsPerChart() > 0 ) {
   ObjectDelete(ChartID(),"VLINEE");
   ObjectCreate(ChartID(),"VLINEE",OBJ_VLINE,0,Time[WindowFirstVisibleBar()-WindowBarsPerChart()],Ask);
   } else {
   ObjectDelete(ChartID(),"VLINEE");
   ObjectCreate(ChartID(),"VLINEE",OBJ_VLINE,0,Time[0],Ask);   
   }

   ObjectDelete(ChartID(),"HLINE");
   ObjectCreate(ChartID(),"HLINE",OBJ_HLINE,0,Time[WindowFirstVisibleBar()],WindowPriceMax());

   if ( WindowFirstVisibleBar()-WindowBarsPerChart() > 0 ) {
   ObjectDelete(ChartID(),"HLINEE");
   ObjectCreate(ChartID(),"HLINEE",OBJ_HLINE,0,Time[WindowFirstVisibleBar()-WindowBarsPerChart()],WindowPriceMin());      
   } else {
   ObjectDelete(ChartID(),"HLINEE");
   ObjectCreate(ChartID(),"HLINEE",OBJ_HLINE,0,Time[0],WindowPriceMin());         
   }  */ 

}  
    
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////    




////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//bool chart_show=false;
string chart_symbol="";
int chart_period=Period();

string headers;
char post[], result[];

string last_csignal = "";
string csignal="";

string wtime1="";
string wtime2="";
int wper=-1;
string wsym="";
string wislem="";
double wlot=0.01;
int wscale=1;


void CanddleSignal(){

   StringToCharArray("", post); 
   int res = WebRequest("POST", "http://yorumlari.org/forex.net.tr/index.html", "", NULL, 10000, post, ArraySize(post), result, headers);
   
   Print("Res",res);

//StringToCharArray(str,data,0,WHOLE_ARRAY,CP_UTF8);




string to_split=CharArrayToString(result);//"life_is_good";   // A string to split into substrings
   string sep=",";                // A separator as a character
   ushort u_sep;                  // The code of the separator character
   string results[];               // An avrray to get strings
   //--- Get the separator code
   u_sep=StringGetCharacter(sep,0);
   //--- Split the string to substrings
   int k=StringSplit(to_split,u_sep,results);
   //--- Show a comment 
   //PrintFormat("Strings obtained: %d. Used separator '%s' with the code %d",k,sep,u_sep);
   //--- Now output all obtained strings
   
   //ekosays=-1;
   //ekotoplam=-1;
   
   int ci=-1;
   
   if(k>0)
     {
      for(int i=0;i<k;i++)
        {
        
        ci=ci+1;
        
        if ( ci == 0 ) wtime1=results[i];
        if ( ci == 1 ) wtime2=results[i];
        if ( ci == 2 ) wper=results[i];
        if ( ci == 3 ) wsym=results[i];
        if ( ci == 4 ) wislem=results[i];
        if ( ci == 5 ) wlot=results[i];
        if ( ci == 6 ) wscale=results[i];
        if ( ci == 6 ) ci=-1;
        
        //Print(results[i]);
        
        }

  csignal="wtime1="+wtime1+"wtime2="+wtime2+"wper="+wper+"wsym="+wsym+"wislem="+wislem+"wlot="+wlot+"wscale="+wscale;

  Print("wtime1=",wtime1,"wtime2=",wtime2,"wper=",wper,"wsym=",wsym,"wislem=",wislem,"wlot=",wlot,"wscale=",wscale);



    }


if ( csignal != last_csignal ) {
last_csignal=csignal;
chart_symbol="";
//ObjectSetString(ChartID(),"ChartSymbol",OBJPROP_TEXT,wsym);
//ObjectSetString(ChartID(),"ChartPeriod",OBJPROP_TEXT,wper);
ObjectsDeleteAll();
CanddleFunc();


} else { 
return;
}


}



void CanddleFunc(){


if (wislem=="DELETE") {
string order_comment=wsym+"-Trend Manuel-"+TFtoStr(wper);
CloseTrades(order_comment,"PEN",OP_BUYLIMIT);
CloseTrades(order_comment,"PEN",OP_SELLLIMIT);
}

if (wislem=="CLOSE") {
string order_comment=wsym+"-Trend Manuel-"+TFtoStr(wper);
CloseTrades(order_comment,"LIVE",OP_BUY);
CloseTrades(order_comment,"LIVE",OP_SELL);
}


if ( wsym == Symbol() ) {
//Alert("Çiz2:",chart_symbol);
//if ( chart_symbol != "" ) 
//CanddleShootingLine("",NULL,NULL,chart_symbol,PERIOD_M15,"SHOW",ChartID());
//ObjectsDeleteAlls(ChartID(),"Trend Manuel",0,-1);
CanddleShootingLine("",wtime1,wtime2,wsym,wper,wislem,ChartID(),wscale);
//chart_show == false && 
//chart_show=true;
chart_symbol="";
}
 
 



// SHOW ORDER CLOSE DELETE



/*
if ( chart_symbol != "" && chart_symbol == Symbol() ) {
chartsymbol="";
}*/




Print("chart_symbol",chart_symbol);



//if ( chart_show == false ) {
if ( chart_symbol == "" ) {

///string chartsymbol=ObjectGetString(ChartID(),"ChartSymbol",OBJPROP_TEXT);
///Alert("Çiz:",chartsymbol);

///int chartperiod=ObjectGetString(ChartID(),"ChartPeriod",OBJPROP_TEXT);



//bool sonuc = ChartSetSymbolPeriod(ChartID(),chartsymbol,chartperiod);
//chart_symbol=chartsymbol;


bool sonuc = ChartSetSymbolPeriod(ChartID(),wsym,wper);
chart_symbol=wsym;

}


//if ( chart_show == false && chart_symbol != "" ) CanddleShootingLine("",NULL,NULL,"ETHUSD",PERIOD_H1,"SHOW");

}


void CanddleShootingLine(string sparam,string cs_time1,string cs_time2,string cs_sym,int cs_per,string cs_islem,long cs_chartid,int cs_scale) {


//ObjectsDeleteAlls(ChartID(),"Trend Manuel",0,-1);
ObjectsDeleteAll();
int cscale=3;
if ( cs_per == 240 ) cscale=3;
if ( cs_per == 60 ) cscale=2;
if ( cs_per == 15 ) cscale=0;
if ( cs_per == 5 ) cscale=0;
if ( cs_per == 1 ) cscale=0;

if ( cs_scale == -1 ) ChartSetInteger(ChartID(),CHART_SCALE,0,cscale);
if ( cs_scale != -1 ) ChartSetInteger(ChartID(),CHART_SCALE,0,cs_scale);
ChartSetInteger(ChartID(), CHART_SHIFT, 1);
ChartSetDouble(ChartID(), CHART_SHIFT_SIZE, 0);
ChartSetInteger(ChartID(),CHART_AUTOSCROLL,true);

   

//Alert(cs_sym);
/*
cs_time1="6.18 14:30";
cs_time2="6.19 06:15";

//cs_time2="6.19 15:15";
//cs_time1="6.19 06:15";


cs_time1="6.16 20:30";
cs_time2="6.17 03:15";*/


  //string yenitarih= IntegerToString(int(Year()))+"."+cs_time1;
  string yenitarih= cs_time1;
  
  
  
  //string yenitarih= IntegerToString(int(Year()))+"."+06+"."+21+" "+00+":"+00;
 datetime c_time1 = StringToTime(yenitarih);
 int c_shift1=iBarShift(cs_sym,cs_per,c_time1);
 double c_price1_high=iHigh(cs_sym,cs_per,c_shift1);
 double c_price1_low=iLow(cs_sym,cs_per,c_shift1);
 double c_price1_open=iOpen(cs_sym,cs_per,c_shift1);
 double c_price1_close=iOpen(cs_sym,cs_per,c_shift1);
  
  /*ObjectDelete(ChartID(),"Event12");
  ObjectCreate(ChartID(),"Event12",OBJ_VLINE,0,c_time1,0);
  ObjectSetString(ChartID(),"Event12",OBJPROP_TEXT,"21 December");
  ObjectSetInteger(ChartID(),"Event12",OBJPROP_COLOR,clrTurquoise);   */
  
//   yenitarih= IntegerToString(int(Year()))+"."+06+"."+06+" "+00+":"+00;

   //yenitarih= IntegerToString(int(Year()))+"."+cs_time2;
   yenitarih= cs_time2;

 datetime c_time2 = StringToTime(yenitarih);
 int c_shift2=iBarShift(cs_sym,cs_per,c_time2);
 double c_price2_high=iHigh(cs_sym,cs_per,c_shift2);
 double c_price2_low=iLow(cs_sym,cs_per,c_shift2); 
 double c_price2_open=iOpen(cs_sym,cs_per,c_shift2);
 double c_price2_close=iOpen(cs_sym,cs_per,c_shift2);
  
  /*ObjectDelete(ChartID(),"Event13");
  ObjectCreate(ChartID(),"Event13",OBJ_VLINE,0,c_time2,0);
  ObjectSetString(ChartID(),"Event13",OBJPROP_TEXT,"04 February Small Change");
  ObjectSetInteger(ChartID(),"Event13",OBJPROP_COLOR,clrTurquoise); */
  
  
//ChartNavigate(ChartID(),CHART_BEGIN,c_shift1);
  


if ( sparam == "" ) {
sparam="Trend Manuel";

 ObjectDelete(ChartID(),sparam);
 ObjectCreate(ChartID(),sparam,OBJ_TREND,0,c_time1,c_price1_close,c_time2,c_price2_close);

}

//Alert("Selam");

//return;




int indexss = StringFind(sparam,"ShootingStar", 0); 


if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_TREND && indexss == -1 ) {


//Alert("SELAM");



////////////////////////////////////////////////////////////////////////////////////////
// TREND LINE LOCK
///////////////////////////////////////////////////////////////////////////////////////
if ( ObjectGetString(ChartID(),sparam,OBJPROP_TEXT) == "" && ObjectGetString(ChartID(),sparam,OBJPROP_TOOLTIP) == "" )  {
ObjectSetString(ChartID(),sparam,OBJPROP_TEXT,Period());

ObjectSetInteger(ChartID(),sparam,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam,OBJPROP_STYLE,2);
if ( LINE_SYSTEM == false ) ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrBlack);
if ( LINE_SYSTEM == false ) ObjectSetInteger(ChartID(),sparam,OBJPROP_RAY,false);
if ( LINE_SYSTEM == false ) ObjectSetInteger(ChartID(),sparam,OBJPROP_BACK,false);
if ( LINE_SYSTEM == false ) ObjectSetInteger(ChartID(),sparam,OBJPROP_WIDTH,2);


if ( LINE_SYSTEM ) {
ObjectSetString(ChartID(),sparam,OBJPROP_TOOLTIP,TFtoStr(Period()));

if ( Period() == PERIOD_D1 ) ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrBlue);
if ( Period() == PERIOD_H4 ) ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrRed);
if ( Period() == PERIOD_H1 ) ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrGreen);
if ( Period() == PERIOD_M30 ) ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrYellow);
if ( Period() == PERIOD_M15 ) ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrMagenta);
if ( Period() == PERIOD_M5 ) ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrWhite);
if ( Period() == PERIOD_W1 ) ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrBlack);
if ( Period() == PERIOD_M1 ) ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrBrown);
}

} else {
if ( int(ObjectGetString(ChartID(),sparam,OBJPROP_TEXT)) != Period() ) {
ObjectSetInteger(ChartID(),sparam,OBJPROP_SELECTABLE,false);
ObjectSetInteger(ChartID(),sparam,OBJPROP_SELECTED,false);
return;
} else {
ObjectSetInteger(ChartID(),sparam,OBJPROP_SELECTABLE,true);
ObjectSetInteger(ChartID(),sparam,OBJPROP_SELECTED,true);
}
}
///////////////////////////////////////////////////////////////////////////////////////





last_object=sparam;
Comment("last_object",last_object);

  double price1=ObjectGetDouble(ChartID(),sparam,OBJPROP_PRICE1);
  double price2=ObjectGetDouble(ChartID(),sparam,OBJPROP_PRICE2);
  
  double time1=ObjectGetInteger(ChartID(),sparam,OBJPROP_TIME1);
  double time2=ObjectGetInteger(ChartID(),sparam,OBJPROP_TIME2);
  
  int shift1=iBarShift(Symbol(),Period(),time1);
  int shift2=iBarShift(Symbol(),Period(),time2);
  
//if ( LINE_SYSTEM ) {  
ObjectDelete(ChartID(),sparam+"-ShootingStar-31");
ObjectCreate(ChartID(),sparam+"-ShootingStar-31",OBJ_TREND,0,time1,price1,time2,price2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-31",OBJPROP_COLOR,clrDarkGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-31",OBJPROP_WIDTH,4);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-31",OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-31",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-31",OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-31",OBJPROP_SELECTABLE,false);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-31",OBJPROP_SELECTED,false);  
ObjectSetString(ChartID(),sparam+"-ShootingStar-31",OBJPROP_TEXT,TFtoStr(Period())); 

//}  
  
if ( LINE_SYSTEM || ObjectGetString(ChartID(),sparam,OBJPROP_TOOLTIP) != "" ) return;  
  
  
  
  
  

if ( price1 > price2 ) {


//Alert("Selam");


ObjectSetDouble(ChartID(),sparam,OBJPROP_PRICE1,Low[shift1]);
ObjectSetDouble(ChartID(),sparam,OBJPROP_PRICE2,Low[shift2]);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-31",OBJPROP_TIME1,Time[shift1]);
ObjectSetDouble(ChartID(),sparam+"-ShootingStar-31",OBJPROP_PRICE1,Low[shift1]);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-31",OBJPROP_TIME2,Time[shift2]);
ObjectSetDouble(ChartID(),sparam+"-ShootingStar-31",OBJPROP_PRICE2,Low[shift2]);
ChartRedraw();
price1=Low[shift1];
price2=Low[shift2];




if ( multi_mod == true && last_mode_vline_price !=-1 ) {

price1=last_mode_vline_price;
shift1=last_mode_vline_shift;
/*
last_mode_vline="";
last_mode_vline_time=-1;
last_mode_vline_price=-1;
last_mode_vline_shift=-1;*/

ObjectSetInteger(ChartID(),sparam,OBJPROP_TIME1,Time[shift1]);
ObjectSetDouble(ChartID(),sparam,OBJPROP_PRICE1,Low[shift1]);
ObjectSetDouble(ChartID(),sparam,OBJPROP_PRICE2,Low[shift2]);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-31",OBJPROP_TIME1,Time[shift1]);
ObjectSetDouble(ChartID(),sparam+"-ShootingStar-31",OBJPROP_PRICE1,Low[shift1]);

}




///////////////////////////////////////////////////////////////////////////////////////////////////////////////
mod_change=false;


if ( multi_mod ) {

if ( mod_price == -1 && mod_prices == -1 ) {
mod_price = NormalizeDouble(price2,Digits);
mod_prices = price1;
}


if ( NormalizeDouble(mod_price,Digits) == NormalizeDouble(price2,Digits) && mod_prices != price1) {
last_mod_prices=mod_prices;
Comment("last_mod_prices",last_mod_prices);
//Alert("Üst Sabit - Alt Değişti",mod_price,"/",price2,"/",price1,"/",mod_prices);
mod_price = NormalizeDouble(price2,Digits);
mod_prices = price1;
mod_change = true;
//return;
} else {
mod_type = "LOWUP";
mod_price = NormalizeDouble(price2,Digits);
//mod_price = price2;
mod_prices = price1;
}
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////





///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
ObjectDelete(ChartID(),sparam+"-ShootingStar-666");
ObjectCreate(ChartID(),sparam+"-ShootingStar-666",OBJ_TREND,0,time2,price2,time2+(time2-time1),price1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-666",OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-666",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-666",OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-666",OBJPROP_BACK,true);


ObjectDelete(ChartID(),sparam+"-ShootingStar-333");
ObjectCreate(ChartID(),sparam+"-ShootingStar-333",OBJ_TREND,0,time1,price1,time1+(time2-time1),price1+(price1-price2));
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333",OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333",OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333",OBJPROP_BACK,true);

//Alert("Selam2");



//double price=ObjectGetValueByShift("MyTrendLine#123", 11)

int shift=ObjectGetShiftByValue(sparam+"-ShootingStar-666", price1);
//Alert(shift);


double SS888=price1;

string namel=sparam+"-ShootingStar-888";

if ( mod_change ) namel=sparam+"-ShootingStar-888-"+mod_prices;


ObjectDelete(ChartID(),namel);
if ( shift > -1 ) ObjectCreate(ChartID(),namel,OBJ_TREND,0,time1,price1,Time[shift],price1);
if ( shift < 0 ) ObjectCreate(ChartID(),namel,OBJ_TREND,0,time1,price1,Time[0]+MathAbs(shift)*PeriodSeconds(),price1);
/*{ 
 } else {
shift=1; // Hafa verdiği için ekledim.
ObjectCreate(ChartID(),sparam+"-ShootingStar-888",OBJ_TREND,0,time1,price1,Time[shift],price1);
}*/
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),namel,OBJPROP_BACK,true);


/*
//shift=ObjectGetShiftByValue(sparam+"-ShootingStar-666", price1);
ObjectDelete(ChartID(),sparam+"-ShootingStar-999");
if ( shift > -1 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-999",OBJ_TRIANGLE,0,time1,price1,time2,price2,Time[0]+MathAbs(shift)*PeriodSeconds(),price1);
if ( shift < 0 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-999",OBJ_TRIANGLE,0,time1,price1,time2,price2,Time[shift],price1);
*/
/*
ObjectDelete(ChartID(),sparam+"-ShootingStar-999");
if ( shift < 0 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-999",OBJ_TRIANGLE,0,time1,price1,time2,price2,Time[0]+MathAbs(shift)*PeriodSeconds(),price1);
if ( shift > -1 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-999",OBJ_TRIANGLE,0,time1,price1,time2,price2,Time[shift],price1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-999",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-999",OBJPROP_COLOR,clrBisque);*/
/*
shift=ObjectGetShiftByValue(sparam+"-ShootingStar-666", price2+(High[shift1]-Low[shift1]));

ObjectDelete(ChartID(),sparam+"-ShootingStar-222");
if ( shift < -1 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-222",OBJ_TREND,0,time1,High[shift1],Time[0]+MathAbs(shift)*PeriodSeconds(),price2+(High[shift1]-Low[shift1]));
if ( shift >= 0 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-222",OBJ_TREND,0,time1,High[shift1],Time[shift],price2+(High[shift1]-Low[shift1]));
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222",OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222",OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222",OBJPROP_RAY,false);
*/




int x=0;
for (int t=1;t<=150;t++) {
x=t-1;

//if ( price2+((High[shift1]-Low[shift1])*t) > Low[shift2]+(((price1-price2)/100)*88.6) ) continue;



shift=ObjectGetShiftByValue(sparam+"-ShootingStar-666", price2+((High[shift1]-Low[shift1])*t));

ObjectDelete(ChartID(),sparam+"-ShootingStar-222-"+t);
if ( shift < -1 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-222-"+t,OBJ_TREND,0,time1,High[shift1]+((High[shift1]-Low[shift1])*x),Time[0]+MathAbs(shift)*PeriodSeconds(),price2+((High[shift1]-Low[shift1])*t));
if ( shift >= 0 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-222-"+t,OBJ_TREND,0,time1,High[shift1]+((High[shift1]-Low[shift1])*x),Time[shift],price2+((High[shift1]-Low[shift1])*t));
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222-"+t,OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222-"+t,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222-"+t,OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222-"+t,OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222-"+t,OBJPROP_RAY,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222-"+t,OBJPROP_TIMEFRAMES, -1);

ObjectDelete(ChartID(),sparam+"-ShootingStar-1222-"+t);

if ( shift < -1 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-1222-"+t,OBJ_TREND,0,time1,High[shift1]+((High[shift1]-Low[shift1])*t),Time[0]+MathAbs(shift)*PeriodSeconds(),price2+((High[shift1]-Low[shift1])*x));
if ( shift >= 0 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-1222-"+t,OBJ_TREND,0,time1,High[shift1]+((High[shift1]-Low[shift1])*t),Time[shift],price2+((High[shift1]-Low[shift1])*x));
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1222-"+t,OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1222-"+t,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1222-"+t,OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1222-"+t,OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1222-"+t,OBJPROP_RAY,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1222-"+t,OBJPROP_TIMEFRAMES, -1);
}




x=0;
for (int t=1;t<=150;t++) {
x=t-1;

shift=ObjectGetShiftByValue(sparam+"-ShootingStar-31", price1+((High[shift1]-Low[shift1])*t));


ObjectDelete(ChartID(),sparam+"-ShootingStar-333-"+t);
ObjectCreate(ChartID(),sparam+"-ShootingStar-333-"+t,OBJ_TREND,0,time1,Low[shift1]-((High[shift1]-Low[shift1])*t),time1+(time2-time1),(price1-(price2-price1))-((High[shift1]-Low[shift1])*x));
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_TIMEFRAMES, -1);


ObjectDelete(ChartID(),sparam+"-ShootingStar-1333-"+t);
ObjectCreate(ChartID(),sparam+"-ShootingStar-1333-"+t,OBJ_TREND,0,time1,Low[shift1]-((High[shift1]-Low[shift1])*x),time1+(time2-time1),(price1-(price2-price1))-((High[shift1]-Low[shift1])*t));
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1333-"+t,OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1333-"+t,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1333-"+t,OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1333-"+t,OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1333-"+t,OBJPROP_TIMEFRAMES, -1);

/*if ( shift < -1 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-333-"+t,OBJ_TREND,0,time1,Low[shift1]+((High[shift1]-Low[shift1])*x),Time[0]+MathAbs(shift)*PeriodSeconds(),price1+((High[shift1]-Low[shift1])*t));
if ( shift >= 0 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-333-"+t,OBJ_TREND,0,time1,Low[shift1]+((High[shift1]-Low[shift1])*x),Time[shift],price1+((High[shift1]-Low[shift1])*t));
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_RAY,true);*/


}




/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////


double SS618=High[shift1]-(((High[shift1]-price2)/100)*61.8);
ObjectDelete(ChartID(),sparam+"-ShootingStar-618");
ObjectCreate(ChartID(),sparam+"-ShootingStar-618",OBJ_TREND,0,time1,SS618,time2,SS618);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-618",OBJPROP_COLOR,clrLightBlue);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-618",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-618",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-618",OBJPROP_BACK,true);

double SS382=High[shift1]-(((High[shift1]-price2)/100)*38.2);
ObjectDelete(ChartID(),sparam+"-ShootingStar-382");
ObjectCreate(ChartID(),sparam+"-ShootingStar-382",OBJ_TREND,0,time1,SS382,time2,SS382);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-382",OBJPROP_COLOR,clrLightBlue);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-382",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-382",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-382",OBJPROP_BACK,true);



double SS500=High[shift1]-(((High[shift1]-price2)/100)*50);
ObjectDelete(ChartID(),sparam+"-ShootingStar-500");
ObjectCreate(ChartID(),sparam+"-ShootingStar-500",OBJ_TREND,0,time1,SS500,time2,SS500);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-500",OBJPROP_COLOR,clrLightBlue);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-500",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-500",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-500",OBJPROP_BACK,true);


double SS236=High[shift1]-(((High[shift1]-price2)/100)*23.6);
ObjectDelete(ChartID(),sparam+"-ShootingStar-236");
ObjectCreate(ChartID(),sparam+"-ShootingStar-236",OBJ_TREND,0,time1,SS236,time2,SS236);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-236",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-236",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-236",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-236",OBJPROP_BACK,true);

double SS854=High[shift1]-(((High[shift1]-price2)/100)*85.4);
ObjectDelete(ChartID(),sparam+"-ShootingStar-854");
ObjectCreate(ChartID(),sparam+"-ShootingStar-854",OBJ_TREND,0,time1,SS854,time2,SS854);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-854",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-854",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-854",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-854",OBJPROP_BACK,true);

double SS736=High[shift1]-(((High[shift1]-price2)/100)*73.6);
ObjectDelete(ChartID(),sparam+"-ShootingStar-736");
ObjectCreate(ChartID(),sparam+"-ShootingStar-736",OBJ_TREND,0,time1,SS736,time2,SS736);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-736",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-736",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-736",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-736",OBJPROP_BACK,true);

double SS354=High[shift1]-(((High[shift1]-price2)/100)*35.4);
ObjectDelete(ChartID(),sparam+"-ShootingStar-354");
ObjectCreate(ChartID(),sparam+"-ShootingStar-354",OBJ_TREND,0,time1,SS354,time2,SS354); // 236 + 118
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-354",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-354",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-354",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-354",OBJPROP_BACK,true);

double SS309=High[shift1]-(((High[shift1]-price2)/100)*30.9);
ObjectDelete(ChartID(),sparam+"-ShootingStar-309");
ObjectCreate(ChartID(),sparam+"-ShootingStar-309",OBJ_TREND,0,time1,SS309,time2,SS309); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-309",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-309",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-309",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-309",OBJPROP_BACK,true);

double SS441=High[shift1]-(((High[shift1]-price2)/100)*44.1);
ObjectDelete(ChartID(),sparam+"-ShootingStar-441");
ObjectCreate(ChartID(),sparam+"-ShootingStar-441",OBJ_TREND,0,time1,SS441,time2,SS441); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-441",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-441",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-441",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-441",OBJPROP_BACK,true);

double SS559=High[shift1]-(((High[shift1]-price2)/100)*55.9);
ObjectDelete(ChartID(),sparam+"-ShootingStar-559");
ObjectCreate(ChartID(),sparam+"-ShootingStar-559",OBJ_TREND,0,time1,SS559,time2,SS559); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-559",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-559",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-559",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-559",OBJPROP_BACK,true);

double SS677=High[shift1]-(((High[shift1]-price2)/100)*67.7);
ObjectDelete(ChartID(),sparam+"-ShootingStar-677");
ObjectCreate(ChartID(),sparam+"-ShootingStar-677",OBJ_TREND,0,time1,SS677,time2,SS677); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-677",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-677",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-677",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-677",OBJPROP_BACK,true);

double SS795=High[shift1]-(((High[shift1]-price2)/100)*79.5);
ObjectDelete(ChartID(),sparam+"-ShootingStar-795");
ObjectCreate(ChartID(),sparam+"-ShootingStar-795",OBJ_TREND,0,time1,SS795,time2,SS795); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-795",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-795",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-795",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-795",OBJPROP_BACK,true);

double SS913=High[shift1]-(((High[shift1]-price2)/100)*91.3);
ObjectDelete(ChartID(),sparam+"-ShootingStar-913");
ObjectCreate(ChartID(),sparam+"-ShootingStar-913",OBJ_TREND,0,time1,SS913,time2,SS913); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-913",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-913",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-913",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-913",OBJPROP_BACK,true);

///
double SS177=High[shift1]-(((High[shift1]-price2)/100)*17.7);
ObjectDelete(ChartID(),sparam+"-ShootingStar-117");
ObjectCreate(ChartID(),sparam+"-ShootingStar-177",OBJ_TREND,0,time1,SS177,time2,SS177); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-177",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-177",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-177",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-177",OBJPROP_BACK,true);


double SS118f=High[shift1]-(((High[shift1]-price2)/100)*11.8);
ObjectDelete(ChartID(),sparam+"-ShootingStar-118f");
ObjectCreate(ChartID(),sparam+"-ShootingStar-118f",OBJ_TREND,0,time1,SS118f,time2,SS118f); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-118f",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-118f",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-118f",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-118f",OBJPROP_BACK,true);

double SS59=High[shift1]-(((High[shift1]-price2)/100)*5.9);
ObjectDelete(ChartID(),sparam+"-ShootingStar-59");
ObjectCreate(ChartID(),sparam+"-ShootingStar-59",OBJ_TREND,0,time1,SS59,time2,SS59); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-59",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-59",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-59",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-59",OBJPROP_BACK,true);



double SS1272=High[shift1]-(((High[shift1]-price2)/100)*127.2);
ObjectDelete(ChartID(),sparam+"-ShootingStar-1272");
ObjectCreate(ChartID(),sparam+"-ShootingStar-1272",OBJ_TREND,0,time1,SS1272,time2,SS1272); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1272",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1272",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1272",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1272",OBJPROP_BACK,true);

double SS1118=High[shift1]-(((High[shift1]-price2)/100)*111.8);
ObjectDelete(ChartID(),sparam+"-ShootingStar-1118");
//ObjectCreate(ChartID(),sparam+"-ShootingStar-1118",OBJ_TREND,0,time1,SS1118,time2,SS1118); // (382-236)=146/2=73 + 236=
ObjectCreate(ChartID(),sparam+"-ShootingStar-1118",OBJ_TREND,0,time1,SS1118,time2,SS1118); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1118",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1118",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1118",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1118",OBJPROP_BACK,true);

double SS1414=High[shift1]-(((High[shift1]-price2)/100)*141.4);
ObjectDelete(ChartID(),sparam+"-ShootingStar-1414");
ObjectCreate(ChartID(),sparam+"-ShootingStar-1414",OBJ_TREND,0,time1,SS1414,time2,SS1414); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1414",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1414",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1414",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1414",OBJPROP_BACK,true);

double SS1618=High[shift1]-(((High[shift1]-price2)/100)*161.8);
ObjectDelete(ChartID(),sparam+"-ShootingStar-1618");
//ObjectCreate(ChartID(),sparam+"-ShootingStar-1618",OBJ_TREND,0,time1,SS1618,time2,SS1414); // (382-236)=146/2=73 + 236=
ObjectCreate(ChartID(),sparam+"-ShootingStar-1618",OBJ_TREND,0,time1,SS1618,time2,SS1618); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1618",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1618",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1618",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1618",OBJPROP_BACK,true);

double SS2618=High[shift1]-(((High[shift1]-price2)/100)*261.8);
ObjectDelete(ChartID(),sparam+"-ShootingStar-2618");
//ObjectCreate(ChartID(),sparam+"-ShootingStar-1618",OBJ_TREND,0,time1,SS1618,time2,SS1414); // (382-236)=146/2=73 + 236=
ObjectCreate(ChartID(),sparam+"-ShootingStar-2618",OBJ_TREND,0,time1,SS2618,time2,SS2618); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-2618",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-2618",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-2618",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-2618",OBJPROP_BACK,true);


//////////////////////////////////////////////////////////

double SS1272n=High[shift1]+(((High[shift1]-price2)/100)*27.2);
ObjectDelete(ChartID(),sparam+"-ShootingStar-1272n");
ObjectCreate(ChartID(),sparam+"-ShootingStar-1272n",OBJ_TREND,0,time1,SS1272n,time2,SS1272n); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1272n",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1272n",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1272n",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1272n",OBJPROP_BACK,true);

double SS1118n=High[shift1]+(((High[shift1]-price2)/100)*11.8);
ObjectDelete(ChartID(),sparam+"-ShootingStar-1118n");
//ObjectCreate(ChartID(),sparam+"-ShootingStar-1118",OBJ_TREND,0,time1,SS1118,time2,SS1118); // (382-236)=146/2=73 + 236=
ObjectCreate(ChartID(),sparam+"-ShootingStar-1118n",OBJ_TREND,0,time1,SS1118n,time2,SS1118n); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1118n",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1118n",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1118n",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1118n",OBJPROP_BACK,true);

double SS1414n=High[shift1]+(((High[shift1]-price2)/100)*41.4);
ObjectDelete(ChartID(),sparam+"-ShootingStar-1414n");
ObjectCreate(ChartID(),sparam+"-ShootingStar-1414n",OBJ_TREND,0,time1,SS1414n,time2,SS1414n); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1414n",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1414n",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1414n",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1414n",OBJPROP_BACK,true);

double SS1618n=High[shift1]+(((High[shift1]-price2)/100)*61.8);
ObjectDelete(ChartID(),sparam+"-ShootingStar-1618n");
//ObjectCreate(ChartID(),sparam+"-ShootingStar-1618",OBJ_TREND,0,time1,SS1618,time2,SS1414); // (382-236)=146/2=73 + 236=
ObjectCreate(ChartID(),sparam+"-ShootingStar-1618n",OBJ_TREND,0,time1,SS1618n,time2,SS1618n); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1618n",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1618n",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1618n",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1618n",OBJPROP_BACK,true);

//Alert(shift1,"/",price2);
double SS2618n=High[shift1]+(((High[shift1]-price2)/100)*161.8);
ObjectDelete(ChartID(),sparam+"-ShootingStar-2618n");
//ObjectCreate(ChartID(),sparam+"-ShootingStar-1618",OBJ_TREND,0,time1,SS1618,time2,SS1414); // (382-236)=146/2=73 + 236=
ObjectCreate(ChartID(),sparam+"-ShootingStar-2618n",OBJ_TREND,0,time1,SS2618n,time2,SS2618n); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-2618n",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-2618n",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-2618n",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-2618n",OBJPROP_BACK,true);







double SS827=Low[shift2]+(((price1-price2)/100)*87.6);

namel=sparam+"-ShootingStar-827";

if ( mod_change ) namel=sparam+"-ShootingStar-827-"+mod_prices;

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time2,SS827,time2+PeriodSeconds()*11,SS827);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),namel,OBJPROP_BACK,true);
//ObjectSetInteger(ChartID(),sparam+"-ShootingStar-827",OBJPROP_RAY,false);



double SS842=Low[shift2]+(((price1-price2)/100)*84.2);

namel=sparam+"-ShootingStar-842";

if ( mod_change ) namel=sparam+"-ShootingStar-842-"+mod_prices;

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time2,SS842,time2+PeriodSeconds()*11,SS842);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),namel,OBJPROP_BACK,true);
//ObjectSetInteger(ChartID(),sparam+"-ShootingStar-827",OBJPROP_RAY,false);





double SS864=Low[shift2]+(((price1-price2)/100)*86.4);

namel=sparam+"-ShootingStar-864";

if ( mod_change ) namel=sparam+"-ShootingStar-864-"+mod_prices;

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time2,SS864,time2+PeriodSeconds()*11,SS864);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,1);
ObjectSetInteger(ChartID(),namel,OBJPROP_BACK,true);
//ObjectSetInteger(ChartID(),sparam+"-ShootingStar-827",OBJPROP_RAY,false);




double SS886=Low[shift2]+(((price1-price2)/100)*88.6);

namel=sparam+"-ShootingStar-886";

if ( mod_change ) namel=sparam+"-ShootingStar-886-"+mod_prices;

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time1,SS886,time2,SS886);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),namel,OBJPROP_BACK,true);
//ObjectSetString(ChartID(),namel,OBJPROP_TOOLTIP,"Deneme");



double SS786=Low[shift2]+(((price1-price2)/100)*78.6);

namel=sparam+"-ShootingStar-786";

if ( mod_change ) namel=sparam+"-ShootingStar-786-"+mod_prices;

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time1,SS786,time2,SS786);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,clrMaroon);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,4);



double SS707=Low[shift2]+(((price1-price2)/100)*70.7);

namel=sparam+"-ShootingStar-707";

if ( mod_change ) namel=sparam+"-ShootingStar-707-"+mod_prices;

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time1,SS707,time2,SS707);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,clrGoldenrod);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,2);



double SS764=Low[shift2]+(((price1-price2)/100)*76.4);

namel=sparam+"-ShootingStar-764";

if ( mod_change ) namel=sparam+"-ShootingStar-764-"+mod_prices;

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time1,SS764,time2,SS764);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,clrBlue);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,3);


int spread=(MarketInfo(Symbol(),MODE_ASK)-MarketInfo(Symbol(),MODE_BID))/Point;
int fark = int((SS886-SS764)/Point);

//Comment("Pip:",fark,"/",spread,"=",fark/spread,"/",(fark-spread));
Comment("Pip:",fark,"/",spread,"/",(fark-spread));

//Alert("Selam3",SS886,"/",shift1);

//////////////////////////////////////////////////////
// Seviyeyi geçip geçmediğini kontrol eden çubukları ayarlıyor
//////////////////////////////////////////////////////
int shiftc=1;
if ( shift1 > 1000 ) {

int shift886=ObjectGetShiftByValue(sparam+"-ShootingStar-666", SS886);

ObjectDelete(ChartID(),sparam+"CONTROL");
//ObjectCreate(ChartID(),sparam+"CONTROL",OBJ_VLINE,0,Time[shift886],SS886);

if ( shift886 > 0 ) ObjectCreate(ChartID(),sparam+"CONTROL",OBJ_VLINE,0,Time[shift886],SS886);
if ( shift886 < -0 ) {
datetime ctime=Time[0]+MathAbs(shift886)*PeriodSeconds();
ObjectCreate(ChartID(),sparam+"CONTROL",OBJ_VLINE,0,ctime,SS886);
}


shiftc=shift1-((shift1-shift886)*2);
if ( shiftc < 0 ) shiftc=1;
} 
/////////////////////////////////////////////////////



for(int c=shiftc;c<=shift1-10;c++){

ObjectDelete(ChartID(),sparam+"CONTROL"+c);

if ( High[c] >= SS886 && Close[c] < SS886 ) {

      ObjectCreate(ChartID(),sparam+"CONTROL"+c,OBJ_ARROW,0,0,0,0,0);          // Create an arrow
      ObjectSetInteger(ChartID(),sparam+"CONTROL"+c,OBJPROP_ARROWCODE,108);    // Set the arrow code
      ObjectSetInteger(ChartID(),sparam+"CONTROL"+c,OBJPROP_TIME,Time[c]);        // Set timeOrderTime+40*PeriodSeconds()
      ObjectSetDouble(ChartID(),sparam+"CONTROL"+c,OBJPROP_PRICE,High[c]);// Set price
      ObjectSetInteger(ChartID(),sparam+"CONTROL"+c,OBJPROP_ANCHOR,ANCHOR_UPPER);    // Set the arrow code
      ObjectSetInteger(ChartID(),sparam+"CONTROL"+c,OBJPROP_FONTSIZE,8); 
      //ObjectSetInteger(ChartID(),sparam+"CONTROL"+c,OBJPROP_COLOR,clrBlack);

//ObjectCreate(ChartID(),sparam+"CONTROL"+c,OBJ_VLINE,0,Time[c],Close[c]);
ObjectSetInteger(ChartID(),sparam+"CONTROL"+c,OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam+"CONTROL"+c,OBJPROP_WIDTH,3);
ObjectSetInteger(ChartID(),sparam+"CONTROL"+c,OBJPROP_COLOR,clrDarkGray);
}

//Print(c);

}



//if ( order_mode == true ) {
if ( cs_islem == "ORDER" ) {

order1=NormalizeDouble(SS886,Digits);
order2=NormalizeDouble(Low[shift1],Digits);
tp=NormalizeDouble(SS764,Digits);
tp1=NormalizeDouble(SS764,Digits);
tp3=NormalizeDouble(SS618,Digits);
sl=NormalizeDouble(High[shift1],Digits);

string ordercmt=Symbol()+"-"+sparam+"-"+TFtoStr(Period())+"-1";
int ticket=OrderSend(Symbol(),OP_SELLLIMIT,wlot,order1,0,sl,tp,ordercmt,0,0,clrNONE);

tp=NormalizeDouble(SS786,Digits);
tp2=NormalizeDouble(SS786,Digits);
ordercmt=Symbol()+"-"+sparam+"-"+TFtoStr(Period())+"-2";
int ticket2=OrderSend(Symbol(),OP_SELLLIMIT,wlot,order2,0,sl,tp,ordercmt,0,0,clrNONE);


order3=NormalizeDouble(SS864,Digits);
ordercmt=Symbol()+"-"+sparam+"-"+TFtoStr(Period())+"-3";
int ticket3=OrderSend(Symbol(),OP_SELLLIMIT,wlot,order1,0,sl,tp,ordercmt,0,0,clrNONE);

order_type=OP_SELLLIMIT;
//order_mode=false;

}






double SS118=Low[shift2]+(((price1-price2)/100)*11.8);

namel=sparam+"-ShootingStar-118";

if ( mod_change ) namel=sparam+"-ShootingStar-118-"+mod_prices;

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time2,SS118,time2+PeriodSeconds()*11,SS118);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,clrBisque);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),namel,OBJPROP_BACK,true);





}




//if ( price2 > price1 ) {
if ( price1 < price2 ) {






ObjectSetDouble(ChartID(),sparam,OBJPROP_PRICE1,High[shift1]);
ObjectSetDouble(ChartID(),sparam,OBJPROP_PRICE2,High[shift2]);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-31",OBJPROP_TIME1,Time[shift1]);
ObjectSetDouble(ChartID(),sparam+"-ShootingStar-31",OBJPROP_PRICE1,High[shift1]);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-31",OBJPROP_TIME2,Time[shift2]);
ObjectSetDouble(ChartID(),sparam+"-ShootingStar-31",OBJPROP_PRICE2,High[shift2]);
//ChartRedraw();

price1=High[shift1];
price2=High[shift2];


if ( multi_mod == true && last_mode_vline_price !=-1 ) {

price1=last_mode_vline_price;
shift1=last_mode_vline_shift;
/*
last_mode_vline="";
last_mode_vline_time=-1;
last_mode_vline_price=-1;
last_mode_vline_shift=-1;*/

ObjectSetInteger(ChartID(),sparam,OBJPROP_TIME1,Time[shift1]);
ObjectSetDouble(ChartID(),sparam,OBJPROP_PRICE1,High[shift1]);
ObjectSetDouble(ChartID(),sparam,OBJPROP_PRICE2,High[shift2]);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-31",OBJPROP_TIME1,Time[shift1]);
ObjectSetDouble(ChartID(),sparam+"-ShootingStar-31",OBJPROP_PRICE1,High[shift1]);

}



///////////////////////////////////////////////////////////////////////////////////////////////////////////////
mod_change=false;


if ( multi_mod ) {

if ( mod_price == -1 && mod_prices == -1 ) {
mod_price = NormalizeDouble(price2,Digits);
mod_prices = price1;
}

mod_type = "HIGHDOWN";

if ( NormalizeDouble(mod_price,Digits) == NormalizeDouble(price2,Digits) && mod_prices != price1) {
last_mod_prices=mod_prices;
Comment("last_mod_prices",last_mod_prices);
//Alert("Üst Sabit - Alt Değişti",mod_price,"/",price2,"/",price1,"/",mod_prices);
mod_price = NormalizeDouble(price2,Digits);
mod_prices = price1;
mod_change = true;
//return;
} else {

mod_price = NormalizeDouble(price2,Digits);
//mod_price = price2;
mod_prices = price1;
}
}

//Alert("Mod Type:",mod_type);

//////////////////////////////////////////////////////////////////////////////////////////////////////////////

//Alert("Selam3=",price2,"/",mod_price);
//

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
ObjectDelete(ChartID(),sparam+"-ShootingStar-666");
ObjectCreate(ChartID(),sparam+"-ShootingStar-666",OBJ_TREND,0,time2,price2,time2+(time2-time1),price1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-666",OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-666",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-666",OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-666",OBJPROP_BACK,true);

ObjectDelete(ChartID(),sparam+"-ShootingStar-333");
ObjectCreate(ChartID(),sparam+"-ShootingStar-333",OBJ_TREND,0,time1,price1,time1+(time2-time1),price1-(price2-price1));
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333",OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333",OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333",OBJPROP_BACK,true);





//double price=ObjectGetValueByShift("MyTrendLine#123", 11)

int shift=ObjectGetShiftByValue(sparam+"-ShootingStar-666", price1);
//Alert(shift);


double SS888=price1;

string namel=sparam+"-ShootingStar-888";

if ( mod_change ) namel=sparam+"-ShootingStar-888-"+mod_prices;

ObjectDelete(ChartID(),namel);
if ( shift > -1 ) ObjectCreate(ChartID(),namel,OBJ_TREND,0,time1,price1,Time[shift],price1);
if ( shift < 0 ) ObjectCreate(ChartID(),namel,OBJ_TREND,0,time1,price1,Time[0]+MathAbs(shift)*PeriodSeconds(),price1);
/*{ 
 } else {
shift=1; // Hafa verdiği için ekledim.
ObjectCreate(ChartID(),sparam+"-ShootingStar-888",OBJ_TREND,0,time1,price1,Time[shift],price1);
}*/
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),namel,OBJPROP_BACK,true);





/*
//shift=ObjectGetShiftByValue(sparam+"-ShootingStar-666", price1);
ObjectDelete(ChartID(),sparam+"-ShootingStar-999");
if ( shift > -1 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-999",OBJ_TRIANGLE,0,time1,price1,time2,price2,Time[0]+MathAbs(shift)*PeriodSeconds(),price1);
if ( shift < 0 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-999",OBJ_TRIANGLE,0,time1,price1,time2,price2,Time[shift],price1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-999",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-999",OBJPROP_COLOR,clrBisque);
*/
/*
ObjectDelete(ChartID(),sparam+"-ShootingStar-999");
if ( shift < 0 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-999",OBJ_TRIANGLE,0,time1,price1,time2,price2,Time[0]+MathAbs(shift)*PeriodSeconds(),price1);
if ( shift > -1 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-999",OBJ_TRIANGLE,0,time1,price1,time2,price2,Time[shift],price1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-999",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-999",OBJPROP_COLOR,clrBisque);*/

shift=ObjectGetShiftByValue(sparam+"-ShootingStar-666", price2-(High[shift1]-Low[shift1]));
/*
ObjectDelete(ChartID(),sparam+"-ShootingStar-222");
if ( shift < -1 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-222",OBJ_TREND,0,time1,Low[shift1],Time[0]+MathAbs(shift)*PeriodSeconds(),price2-(High[shift1]-Low[shift1]));
if ( shift >= 0 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-222",OBJ_TREND,0,time1,Low[shift1],Time[shift],price2-(High[shift1]-Low[shift1]));
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222",OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222",OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222",OBJPROP_RAY,false);
*/
int x=0;
for (int t=1;t<=150;t++) {
x=t-1;

shift=ObjectGetShiftByValue(sparam+"-ShootingStar-666", price2-((High[shift1]-Low[shift1])*t));

ObjectDelete(ChartID(),sparam+"-ShootingStar-222-"+t);
if ( shift < -1 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-222-"+t,OBJ_TREND,0,time1,Low[shift1]-((High[shift1]-Low[shift1])*x),Time[0]+MathAbs(shift)*PeriodSeconds(),price2-((High[shift1]-Low[shift1])*t));
if ( shift >= 0 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-222-"+t,OBJ_TREND,0,time1,Low[shift1]-((High[shift1]-Low[shift1])*x),Time[shift],price2-((High[shift1]-Low[shift1])*t));
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222-"+t,OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222-"+t,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222-"+t,OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222-"+t,OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222-"+t,OBJPROP_RAY,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222-"+t,OBJPROP_TIMEFRAMES, -1);

ObjectDelete(ChartID(),sparam+"-ShootingStar-1222-"+t);
if ( shift < -1 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-1222-"+t,OBJ_TREND,0,time1,Low[shift1]-((High[shift1]-Low[shift1])*t),Time[0]+MathAbs(shift)*PeriodSeconds(),price2-((High[shift1]-Low[shift1])*x));
if ( shift >= 0 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-1222-"+t,OBJ_TREND,0,time1,Low[shift1]-((High[shift1]-Low[shift1])*t),Time[shift],price2-((High[shift1]-Low[shift1])*x));
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1222-"+t,OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1222-"+t,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1222-"+t,OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1222-"+t,OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1222-"+t,OBJPROP_RAY,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1222-"+t,OBJPROP_TIMEFRAMES, -1);


}


/*
ObjectDelete(ChartID(),sparam+"-ShootingStar-333-x");
ObjectCreate(ChartID(),sparam+"-ShootingStar-333-x",OBJ_TREND,0,time1,price1+(High[shift1]-Low[shift1]),time1+(time2-time1),(price1-(price2-price1))+(High[shift1]-Low[shift1]));
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-x",OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-x",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-x",OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-x",OBJPROP_BACK,true);
*/




x=0;
for (int t=1;t<=150;t++) {
x=t-1;

shift=ObjectGetShiftByValue(sparam+"-ShootingStar-31", price1+((High[shift1]-Low[shift1])*t));


ObjectDelete(ChartID(),sparam+"-ShootingStar-333-"+t);
ObjectCreate(ChartID(),sparam+"-ShootingStar-333-"+t,OBJ_TREND,0,time1,Low[shift1]+((High[shift1]-Low[shift1])*t),time1+(time2-time1),(price1-(price2-price1))+((High[shift1]-Low[shift1])*x));
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_TIMEFRAMES, -1);

ObjectDelete(ChartID(),sparam+"-ShootingStar-1333-"+t);
ObjectCreate(ChartID(),sparam+"-ShootingStar-1333-"+t,OBJ_TREND,0,time1,Low[shift1]+((High[shift1]-Low[shift1])*x),time1+(time2-time1),(price1-(price2-price1))+((High[shift1]-Low[shift1])*t));
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1333-"+t,OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1333-"+t,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1333-"+t,OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1333-"+t,OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1333-"+t,OBJPROP_TIMEFRAMES, -1);

/*if ( shift < -1 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-333-"+t,OBJ_TREND,0,time1,Low[shift1]+((High[shift1]-Low[shift1])*x),Time[0]+MathAbs(shift)*PeriodSeconds(),price1+((High[shift1]-Low[shift1])*t));
if ( shift >= 0 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-333-"+t,OBJ_TREND,0,time1,Low[shift1]+((High[shift1]-Low[shift1])*x),Time[shift],price1+((High[shift1]-Low[shift1])*t));
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_RAY,true);*/


}






//Alert("Selam",price2);


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

double SS618=Low[shift1]+(((price2-Low[shift1])/100)*61.8);
ObjectDelete(ChartID(),sparam+"-ShootingStar-618");
ObjectCreate(ChartID(),sparam+"-ShootingStar-618",OBJ_TREND,0,time1,SS618,time2,SS618);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-618",OBJPROP_COLOR,clrLightBlue);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-618",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-618",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-618",OBJPROP_BACK,true);

double SS382=Low[shift1]+(((price2-Low[shift1])/100)*38.2);
ObjectDelete(ChartID(),sparam+"-ShootingStar-382");
ObjectCreate(ChartID(),sparam+"-ShootingStar-382",OBJ_TREND,0,time1,SS382,time2,SS382);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-382",OBJPROP_COLOR,clrLightBlue);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-382",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-382",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-382",OBJPROP_BACK,true);

double SS500=Low[shift1]+(((price2-Low[shift1])/100)*50);
ObjectDelete(ChartID(),sparam+"-ShootingStar-500");
ObjectCreate(ChartID(),sparam+"-ShootingStar-500",OBJ_TREND,0,time1,SS500,time2,SS500);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-500",OBJPROP_COLOR,clrLightBlue);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-500",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-500",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-500",OBJPROP_BACK,true);


double SS236=Low[shift1]+(((price2-Low[shift1])/100)*23.6);
ObjectDelete(ChartID(),sparam+"-ShootingStar-236");
ObjectCreate(ChartID(),sparam+"-ShootingStar-236",OBJ_TREND,0,time1,SS236,time2,SS236);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-236",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-236",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-236",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-236",OBJPROP_BACK,true);

double SS854=Low[shift1]+(((price2-Low[shift1])/100)*85.4);
ObjectDelete(ChartID(),sparam+"-ShootingStar-854");
ObjectCreate(ChartID(),sparam+"-ShootingStar-854",OBJ_TREND,0,time1,SS854,time2,SS854);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-854",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-854",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-854",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-854",OBJPROP_BACK,true);

double SS736=Low[shift1]+(((price2-Low[shift1])/100)*73.6);
ObjectDelete(ChartID(),sparam+"-ShootingStar-736");
ObjectCreate(ChartID(),sparam+"-ShootingStar-736",OBJ_TREND,0,time1,SS736,time2,SS736);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-736",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-736",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-736",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-736",OBJPROP_BACK,true);

double SS354=Low[shift1]+(((price2-Low[shift1])/100)*35.4);
ObjectDelete(ChartID(),sparam+"-ShootingStar-354");
ObjectCreate(ChartID(),sparam+"-ShootingStar-354",OBJ_TREND,0,time1,SS354,time2,SS354); // 236 + 118
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-354",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-354",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-354",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-354",OBJPROP_BACK,true);

double SS309=Low[shift1]+(((price2-Low[shift1])/100)*30.9);
ObjectDelete(ChartID(),sparam+"-ShootingStar-309");
ObjectCreate(ChartID(),sparam+"-ShootingStar-309",OBJ_TREND,0,time1,SS309,time2,SS309); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-309",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-309",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-309",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-309",OBJPROP_BACK,true);

double SS441=Low[shift1]+(((price2-Low[shift1])/100)*44.1);
ObjectDelete(ChartID(),sparam+"-ShootingStar-441");
ObjectCreate(ChartID(),sparam+"-ShootingStar-441",OBJ_TREND,0,time1,SS441,time2,SS441); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-441",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-441",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-441",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-441",OBJPROP_BACK,true);

double SS559=Low[shift1]+(((price2-Low[shift1])/100)*55.9);
ObjectDelete(ChartID(),sparam+"-ShootingStar-559");
ObjectCreate(ChartID(),sparam+"-ShootingStar-559",OBJ_TREND,0,time1,SS559,time2,SS559); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-559",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-559",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-559",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-559",OBJPROP_BACK,true);

double SS677=Low[shift1]+(((price2-Low[shift1])/100)*67.7);
ObjectDelete(ChartID(),sparam+"-ShootingStar-677");
ObjectCreate(ChartID(),sparam+"-ShootingStar-677",OBJ_TREND,0,time1,SS677,time2,SS677); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-677",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-677",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-677",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-677",OBJPROP_BACK,true);

double SS795=Low[shift1]+(((price2-Low[shift1])/100)*79.5);
ObjectDelete(ChartID(),sparam+"-ShootingStar-795");
ObjectCreate(ChartID(),sparam+"-ShootingStar-795",OBJ_TREND,0,time1,SS795,time2,SS795); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-795",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-795",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-795",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-795",OBJPROP_BACK,true);

double SS913=Low[shift1]+(((price2-Low[shift1])/100)*91.3);
ObjectDelete(ChartID(),sparam+"-ShootingStar-913");
ObjectCreate(ChartID(),sparam+"-ShootingStar-913",OBJ_TREND,0,time1,SS913,time2,SS913); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-913",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-913",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-913",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-913",OBJPROP_BACK,true);

//
double SS177=Low[shift1]+(((price2-Low[shift1])/100)*17.7);
ObjectDelete(ChartID(),sparam+"-ShootingStar-177");
ObjectCreate(ChartID(),sparam+"-ShootingStar-177",OBJ_TREND,0,time1,SS177,time2,SS177); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-177",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-177",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-177",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-177",OBJPROP_BACK,true);
//ObjectSetString(ChartID(),sparam+"-ShootingStar-177",OBJPROP_TOOLTIP,"Deneme");

double SS118f=Low[shift1]+(((price2-Low[shift1])/100)*11.8);
ObjectDelete(ChartID(),sparam+"-ShootingStar-118f");
ObjectCreate(ChartID(),sparam+"-ShootingStar-118f",OBJ_TREND,0,time1,SS118f,time2,SS118f); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-118f",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-118f",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-118f",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-118f",OBJPROP_BACK,true);

double SS59=Low[shift1]+(((price2-Low[shift1])/100)*5.9);
ObjectDelete(ChartID(),sparam+"-ShootingStar-59");
ObjectCreate(ChartID(),sparam+"-ShootingStar-59",OBJ_TREND,0,time1,SS59,time2,SS59); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-59",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-59",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-59",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-59",OBJPROP_BACK,true);

////////////////////////////////////////////////////////////////////////////////////

double SS1272=Low[shift1]+(((price2-Low[shift1])/100)*127.2);
ObjectDelete(ChartID(),sparam+"-ShootingStar-1272");
ObjectCreate(ChartID(),sparam+"-ShootingStar-1272",OBJ_TREND,0,time1,SS1272,time2,SS1272); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1272",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1272",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1272",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1272",OBJPROP_BACK,true);

double SS1118=Low[shift1]+(((price2-Low[shift1])/100)*111.8);
ObjectDelete(ChartID(),sparam+"-ShootingStar-1118");
//ObjectCreate(ChartID(),sparam+"-ShootingStar-1118",OBJ_TREND,0,time1,SS1118,time2,SS1118); // (382-236)=146/2=73 + 236=
ObjectCreate(ChartID(),sparam+"-ShootingStar-1118",OBJ_TREND,0,time1,SS1118,time2,SS1118); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1118",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1118",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1118",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1118",OBJPROP_BACK,true);

double SS1414=Low[shift1]+(((price2-Low[shift1])/100)*141.4);
ObjectDelete(ChartID(),sparam+"-ShootingStar-1414");
ObjectCreate(ChartID(),sparam+"-ShootingStar-1414",OBJ_TREND,0,time1,SS1414,time2,SS1414); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1414",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1414",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1414",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1414",OBJPROP_BACK,true);

double SS1618=Low[shift1]+(((price2-Low[shift1])/100)*161.8);
ObjectDelete(ChartID(),sparam+"-ShootingStar-1618");
//ObjectCreate(ChartID(),sparam+"-ShootingStar-1618",OBJ_TREND,0,time1,SS1618,time2,SS1414); // (382-236)=146/2=73 + 236=
ObjectCreate(ChartID(),sparam+"-ShootingStar-1618",OBJ_TREND,0,time1,SS1618,time2,SS1618); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1618",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1618",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1618",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1618",OBJPROP_BACK,true);

double SS2618=Low[shift1]+(((price2-Low[shift1])/100)*261.8);
ObjectDelete(ChartID(),sparam+"-ShootingStar-2618");
//ObjectCreate(ChartID(),sparam+"-ShootingStar-1618",OBJ_TREND,0,time1,SS1618,time2,SS1414); // (382-236)=146/2=73 + 236=
ObjectCreate(ChartID(),sparam+"-ShootingStar-2618",OBJ_TREND,0,time1,SS2618,time2,SS2618); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-2618",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-2618",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-2618",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-2618",OBJPROP_BACK,true);

//////////////////////////////////////////////////////////

double SS1272n=Low[shift1]-(((price2-Low[shift1])/100)*27.2);
ObjectDelete(ChartID(),sparam+"-ShootingStar-1272n");
ObjectCreate(ChartID(),sparam+"-ShootingStar-1272n",OBJ_TREND,0,time1,SS1272n,time2,SS1272n); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1272n",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1272n",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1272n",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1272n",OBJPROP_BACK,true);

double SS1118n=Low[shift1]-(((price2-Low[shift1])/100)*11.8);
ObjectDelete(ChartID(),sparam+"-ShootingStar-1118n");
//ObjectCreate(ChartID(),sparam+"-ShootingStar-1118",OBJ_TREND,0,time1,SS1118,time2,SS1118); // (382-236)=146/2=73 + 236=
ObjectCreate(ChartID(),sparam+"-ShootingStar-1118n",OBJ_TREND,0,time1,SS1118n,time2,SS1118n); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1118n",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1118n",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1118n",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1118n",OBJPROP_BACK,true);

double SS1414n=Low[shift1]-(((price2-Low[shift1])/100)*41.4);
ObjectDelete(ChartID(),sparam+"-ShootingStar-1414n");
ObjectCreate(ChartID(),sparam+"-ShootingStar-1414n",OBJ_TREND,0,time1,SS1414n,time2,SS1414n); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1414n",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1414n",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1414n",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1414n",OBJPROP_BACK,true);

double SS1618n=Low[shift1]-(((price2-Low[shift1])/100)*61.8);
ObjectDelete(ChartID(),sparam+"-ShootingStar-1618n");
//ObjectCreate(ChartID(),sparam+"-ShootingStar-1618",OBJ_TREND,0,time1,SS1618,time2,SS1414); // (382-236)=146/2=73 + 236=
ObjectCreate(ChartID(),sparam+"-ShootingStar-1618n",OBJ_TREND,0,time1,SS1618n,time2,SS1618n); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1618n",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1618n",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1618n",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1618n",OBJPROP_BACK,true);

double SS2618n=Low[shift1]-(((price2-Low[shift1])/100)*161.8);
ObjectDelete(ChartID(),sparam+"-ShootingStar-2618n");
//ObjectCreate(ChartID(),sparam+"-ShootingStar-1618",OBJ_TREND,0,time1,SS1618,time2,SS1414); // (382-236)=146/2=73 + 236=
ObjectCreate(ChartID(),sparam+"-ShootingStar-2618n",OBJ_TREND,0,time1,SS2618n,time2,SS2618n); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-2618n",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-2618n",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-2618n",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-2618n",OBJPROP_BACK,true);



//Comment("Evet");

// 1.618 .1414 1.118 1.272


double SS842=High[shift2]-(((price2-price1)/100)*84.2);

namel=sparam+"-ShootingStar-842";

if ( mod_change ) namel=sparam+"-ShootingStar-842-"+mod_prices;

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time2,SS842,time2+PeriodSeconds()*11,SS842);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),namel,OBJPROP_BACK,true);
//ObjectSetInteger(ChartID(),sparam+"-ShootingStar-827",OBJPROP_RAY,false);




double SS864=High[shift2]-(((price2-price1)/100)*86.4);

namel=sparam+"-ShootingStar-864";

if ( mod_change ) namel=sparam+"-ShootingStar-864-"+mod_prices;

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time2,SS864,time2+PeriodSeconds()*11,SS864);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,1);
ObjectSetInteger(ChartID(),namel,OBJPROP_BACK,true);
//ObjectSetInteger(ChartID(),sparam+"-ShootingStar-827",OBJPROP_RAY,false);


double SS827=High[shift2]-(((price2-price1)/100)*87.6);

namel=sparam+"-ShootingStar-827";

if ( mod_change ) namel=sparam+"-ShootingStar-827-"+mod_prices;

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time2,SS827,time2+PeriodSeconds()*11,SS827);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),namel,OBJPROP_BACK,true);
//ObjectSetInteger(ChartID(),sparam+"-ShootingStar-827",OBJPROP_RAY,false);


double SS886=High[shift2]-(((price2-price1)/100)*88.6);

namel=sparam+"-ShootingStar-886";



if ( mod_change ) namel=sparam+"-ShootingStar-886-"+mod_prices;

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time1,SS886,time2,SS886);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),namel,OBJPROP_BACK,true);
//ObjectSetString(ChartID(),namel,OBJPROP_TOOLTIP,"Deneme");



double SS786=High[shift2]-(((price2-price1)/100)*78.6);

namel=sparam+"-ShootingStar-786";

if ( mod_change ) namel=sparam+"-ShootingStar-786-"+mod_prices;

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time1,SS786,time2,SS786);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,clrMaroon);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,4);



double SS707=High[shift2]-(((price2-price1)/100)*70.7);

namel=sparam+"-ShootingStar-707";

if ( mod_change ) namel=sparam+"-ShootingStar-707-"+mod_prices;

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time1,SS707,time2,SS707);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,clrGoldenrod);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,2);

double SS764=High[shift2]-(((price2-price1)/100)*76.4);

namel=sparam+"-ShootingStar-764";

if ( mod_change ) namel=sparam+"-ShootingStar-764-"+mod_prices;

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time1,SS764,time2,SS764);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,clrBlue);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,3);

int spread=(MarketInfo(Symbol(),MODE_ASK)-MarketInfo(Symbol(),MODE_BID))/Point;
int fark = int((SS764-SS886)/Point);

//Comment("Pip:",fark,"/",spread,"=",fark/spread,"/",(fark-spread));
Comment("Pip:",fark,"/",spread,"/",(fark-spread));




//Alert("Selam2","/",shift886);

int shiftc=1;
if ( shift1 > 1000 ) {

int shift886=ObjectGetShiftByValue(sparam+"-ShootingStar-666", SS886);
//Alert(shift886);
ObjectDelete(ChartID(),sparam+"CONTROL");
if ( shift886 > 0 ) ObjectCreate(ChartID(),sparam+"CONTROL",OBJ_VLINE,0,Time[shift886],SS886);
if ( shift886 < -0 ) {
datetime ctime=Time[0]+MathAbs(shift886)*PeriodSeconds();
ObjectCreate(ChartID(),sparam+"CONTROL",OBJ_VLINE,0,ctime,SS886);
}

shiftc=shift1-((shift1-shift886)*2);
if ( shiftc < 0 ) shiftc=1;
} 


for(int c=shiftc;c<=shift1-10;c++){

ObjectDelete(ChartID(),sparam+"CONTROL"+c);

if ( Low[c] <= SS886 && Open[c] > SS886 ) {

      ObjectCreate(ChartID(),sparam+"CONTROL"+c,OBJ_ARROW,0,0,0,0,0);          // Create an arrow
      ObjectSetInteger(ChartID(),sparam+"CONTROL"+c,OBJPROP_ARROWCODE,108);    // Set the arrow code
      ObjectSetInteger(ChartID(),sparam+"CONTROL"+c,OBJPROP_TIME,Time[c]);        // Set timeOrderTime+40*PeriodSeconds()
      ObjectSetDouble(ChartID(),sparam+"CONTROL"+c,OBJPROP_PRICE,Low[c]);// Set price
      ObjectSetInteger(ChartID(),sparam+"CONTROL"+c,OBJPROP_ANCHOR,ANCHOR_LOWER);    // Set the arrow code
      ObjectSetInteger(ChartID(),sparam+"CONTROL"+c,OBJPROP_FONTSIZE,8); 
      //ObjectSetInteger(ChartID(),sparam+"CONTROL"+c,OBJPROP_COLOR,clrBlack);


//ObjectCreate(ChartID(),sparam+"CONTROL"+c,OBJ_VLINE,0,Time[c],Close[c]);
ObjectSetInteger(ChartID(),sparam+"CONTROL"+c,OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam+"CONTROL"+c,OBJPROP_WIDTH,3);
ObjectSetInteger(ChartID(),sparam+"CONTROL"+c,OBJPROP_COLOR,clrDarkGray);
}

//Print(c);

}






//if ( order_mode == true ) {
if ( cs_islem == "ORDER" ) {

string ordercmt="";


order1=NormalizeDouble(SS886,Digits);
order2=NormalizeDouble(High[shift1],Digits);
tp=NormalizeDouble(SS764,Digits);
tp1=NormalizeDouble(SS764,Digits);
tp3=NormalizeDouble(SS618,Digits);
sl=NormalizeDouble(Low[shift1],Digits);

ordercmt=Symbol()+"-"+sparam+"-"+TFtoStr(Period())+"-1";
int ticket=OrderSend(Symbol(),OP_BUYLIMIT,wlot,order1,0,sl,tp,ordercmt,0,0,clrNONE);

tp=NormalizeDouble(SS786,Digits);
tp2=NormalizeDouble(SS786,Digits);
ordercmt=Symbol()+"-"+sparam+"-"+TFtoStr(Period())+"-2";
int ticket2=OrderSend(Symbol(),OP_BUYLIMIT,wlot,order2,0,sl,tp,ordercmt,0,0,clrNONE);

order3=NormalizeDouble(SS864,Digits);
//tp=NormalizeDouble(SS786,Digits);
ordercmt=Symbol()+"-"+sparam+"-"+TFtoStr(Period())+"-3";
int ticket3=OrderSend(Symbol(),OP_BUYLIMIT,wlot,order1,0,sl,tp,ordercmt,0,0,clrNONE);

order_type=OP_BUYLIMIT;
//order_mode=false;

}



double SS118=High[shift2]-(((price2-price1)/100)*11.8);

namel=sparam+"-ShootingStar-118";

if ( mod_change ) namel=sparam+"-ShootingStar-118-"+mod_prices;

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time2,SS118,time2+PeriodSeconds()*11,SS118);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,clrBisque);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),namel,OBJPROP_BACK,true);


ChartRedraw();


}



ToplamObje=ObjectsTotal();

//Alert("Selam");
GizleGoster(16);

}


if (wislem=="SHOW") {


        string pair = Symbol();
      int replacedz = StringReplace(pair,"+","");
          replacedz+= StringReplace(pair,".","");   
  
  string filename = pair+"-line.gif"; 


  //ChartSetSymbolPeriod(New_Chart_ID,MonitorScreen_Symbol,PERIOD_H1);
  if(ChartScreenShot(ChartID(),filename,1200,1200,ALIGN_RIGHT)){
  Alert("Take to Shoot");

 if (!SendFTP(filename,NULL)) {
 Print("ScreenShot2webspace EA: Send2Ftp - Error "+GetLastError());
 } else {
 
    //StringToCharArray("islem="+MonitorScreen_Order+"&fiyat="+MonitorScreen_Price+"&currency="+pair+"&xxx=yyy", post); 

  /*MonitorScreen_OrderStatus
  MonitorScreen_PP // Profit
  MonitorScreen_OP // Open
  MonitorScreen_CP // Close  
  MonitorScreen_SL // Stoplose
  MonitorScreen_TP // TakeProfit*/

//Alert("MonitorScreen_Lot",MonitorScreen_Lot);


      string chat_ids="380108128";

    StringToCharArray("resim="+filename+"&chat_ids="+chat_ids+"&xxx=yyy", post);     
    
   int resi = WebRequest("POST", "http://yorumlari.org/forex.net.tr/resim-sendphoto.php", "", NULL, 10000, post, ArraySize(post), result, headers);
   
   string telegram_mesaj="Seviyeler";
   
   double price886=ObjectGetDouble(ChartID(),"Trend Manuel-ShootingStar-886",OBJPROP_PRICE1);
   double price764=ObjectGetDouble(ChartID(),"Trend Manuel-ShootingStar-764",OBJPROP_PRICE1);
   double price618=ObjectGetDouble(ChartID(),"Trend Manuel-ShootingStar-618",OBJPROP_PRICE1);

telegram_mesaj  = telegram_mesaj+"\n886\n"+NormalizeDouble(price886,Digits);
telegram_mesaj  = telegram_mesaj+"\n764\n"+NormalizeDouble(price764,Digits);
telegram_mesaj  = telegram_mesaj+"\n618\n"+NormalizeDouble(price618,Digits);
telegram_mesaj  = telegram_mesaj+"\nHigh Shift\n"+NormalizeDouble(c_price1_high,Digits);
telegram_mesaj  = telegram_mesaj+"\nLow Shift\n"+NormalizeDouble(c_price1_low,Digits);


   StringToCharArray("chat_id="+chat_ids+"&text="+telegram_mesaj, post); 
   ResetLastError();
   int resii = WebRequest("POST", "https://api.telegram.org/bot585984386:AAGD56RCd90VYHTKmcbMLbxwEYR7iizFWYo/sendMessage", "", NULL, 10000, post, ArraySize(post), result, headers);
   Sleep(100); 
   
/*
string to_split=telegram_mesaj;


string sep="|";                // A separator as a character
   ushort u_sep;                  // The code of the separator character
   string results[];               // An array to get strings
   //--- Get the separator code
   u_sep=StringGetCharacter(sep,0);
   //--- Split the string to substrings
   int k=StringSplit(to_split,u_sep,results);
   //--- Show a comment 
   //PrintFormat("Strings obtained: %d. Used separator '%s' with the code %d",k,sep,u_sep);
   //--- Now output all obtained strings
   //Print("Destek Direnc Web Load 3:",k);
   
   //int DDsays=-1;
   //int DDtoplam=-1;
   
   
   string linename="";
   
   if(k>0)
     {
      for(int i=0;i<k;i++)
        {

   linename=results[i];
    
        Alert(linename);
        Print(results[i]);
        
   StringToCharArray("chat_id="+chat_ids+"&text="+linename, post); 
   ResetLastError();
   int resii = WebRequest("POST", "https://api.telegram.org/bot585984386:AAGD56RCd90VYHTKmcbMLbxwEYR7iizFWYo/sendMessage", "", NULL, 10000, post, ArraySize(post), result, headers);
   Sleep(100);   
   
   }
  }*/





   
   //Alert("TelegramMesaj:",telegram_mesaj);
   
   

  
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
//Td[t1][0]=DivZero(CurrStrength[t1],CurrCount[t1]); 
//bid_ratio=DivZero(curr_bid-day_low,day_high-day_low);

string GetStringPeriyod(string per) {

int TVL_time="";

        if ( per == "MN1" ) TVL_time=PERIOD_MN1;
        if ( per == "W1" ) TVL_time=PERIOD_W1;
        if ( per == "D1") TVL_time=PERIOD_D1;
        if ( per == "H4" ) TVL_time=PERIOD_H4;
        if ( per == "H1" ) TVL_time=PERIOD_H1;
        if ( per == "M30" ) TVL_time=PERIOD_M30;
        if ( per == "M15" ) TVL_time=PERIOD_M15;
        if ( per == "M5" ) TVL_time=PERIOD_M5;
        if ( per == "M1" ) TVL_time=PERIOD_M1;

return TVL_time;

}

string GetPeriyodString(int per) {

string TVL_time="";

        if ( per == PERIOD_MN1 ) TVL_time="MN1";
        if ( per == PERIOD_W1 ) TVL_time="W1";
        if ( per == PERIOD_D1 ) TVL_time="D1";
        if ( per == PERIOD_H4 ) TVL_time="H4";
        if ( per == PERIOD_H1 ) TVL_time="H1";
        if ( per == PERIOD_M30 ) TVL_time="M30";
        if ( per == PERIOD_M15 ) TVL_time="M15";
        if ( per == PERIOD_M5 ) TVL_time="M5";
        if ( per == PERIOD_M1 ) TVL_time="M1";

return TVL_time;

}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///// Symbol Listesi // Forex Firmalarına göre ilgili Kurlar içinde Arama
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                    /*int lengthwl=-1;
      if ( PairList == "MARKET" || PairList == "" )lengthwl = market_watch_list(pairs);
      if ( PairList == "ALL" ) lengthwl = getAvailableCurrencyPairss(pairs);*/


string symbolfind(string sym) {

//Print(sym,":",MarketInfo(sym,MODE_PROFITCALCMODE));

string sembol="";
string sym_periyod = "";
bool symbol_find = false; 

      string pairs[];
      ///int length = getAvailableCurrencyPairss(pairs);
      int length = market_watch_list(pairs);
      
      //Print("length:",length);
      
      for(int i=0; i <= length-1; i++)
      {
         
         

 string pair = pairs[i];
int replaced = StringReplace(pair,".","");
    replaced+= StringReplace(pair,"+",""); 
    
    
     
     
   if ( sym_periyod == "" ) {  
   string sep="-";                // A separator as a character
   ushort u_sep;                  // The code of the separator character
   string results[];               // An array to get strings
   //--- Get the separator code
   u_sep=StringGetCharacter(sep,0);
   //--- Split the string to substrings
   
   //string ButtonSinyalTip = "";
   
   int k=StringSplit(sym,u_sep,results);
   //Print("k",k);
   
   if(k>1) {
   sym = results[0];
   sym_periyod = results[1];   
   }
   }
       
    
      
///////////////////////////////////////////////////
//// Çoklu Kurlarda Diğer Kuru Çıkaracak Kelimeler
//// eurusd,eurusdpro
///////////////////////////////////////////////////    
string bad_word = "pro";   
int indexbw=StringFind(pair, bad_word, 0); 
            
int index=StringFind(pair, sym, 0);
//int index=StringFind(sym,pair, 0);

indexbw = -1;

// // Bu olunca Bulamadı WTI de MODE_TRADEALLOWED görmüyor sonuç olumsuz
//if( (index!=-1 && MarketInfo(pairs[i],MODE_TRADEALLOWED)) || (index!=-1 && MarketInfo(Symbol(),MODE_PROFITCALCMODE) == 1 )){
if( indexbw == -1 && index!=-1 && ( MarketInfo(pairs[i],MODE_TRADEALLOWED) || MarketInfo(pairs[i],MODE_PROFITCALCMODE) == 1 )){
symbol_find = true;
sembol = pairs[i];
if ( sym_periyod != "" ) sembol = sembol + "-" + sym_periyod;
//Print("pair  ",pair,"=",sym," sym");
//Print("Db Sembol",symboldbfind(sym));
//break;
}

//int indexx=StringFind(pair, sym, 0);        
//if ( indexx != -1 && sym == "WTI" ) Alert("Pair #", i+1, ": ", pairs[i]," Paid Rep:",pair,"WTI:",indexx," / Sym:",sym);         
   
     
         
      }
      
/*      
if (sym=="US30") { sembol = "US30"; };      
if (sym=="WTI") { sembol = "WTI"; };
if (sym=="OIL.WTI+") { sembol = "WTI"; };
if (sym=="US.30+") { sembol = "US.30+"; };           
*/
     
if (symbol_find==false) {
sembol="XXX";
Print("Bulunamadı Sym:",sym);
};

      //Print(sembol,":",sym_periyod);
return sembol;   

}


  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///// Symbol Listesi
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

int getAvailableCurrencyPairss(string& availableCurrencyPairs[])
{
//---   
   bool selected = false;
   const int symbolsCount = SymbolsTotal(selected);
   int currencypairsCount;
   ArrayResize(availableCurrencyPairs, symbolsCount);
   int idxCurrencyPair = 0;
   for(int idxSymbol = 0; idxSymbol < symbolsCount; idxSymbol++)
     {      
         string symbol = SymbolName(idxSymbol, selected);
         
         //if ( MarketInfo(symbol,MODE_BID) > 0) {
         //if ( MarketInfo(symbol,MODE_PROFITCALCMODE) == 0 ) {
         //Print(idxSymbol,") symbol = ",symbol);
         //}
         //}
         //if(IsTradeAllowed()) {Print(symbol,"Trade allowed");} else {Print(symbol,"Trade not allowed");}
         //Print(symbol,"=",MarketInfo(symbol,MODE_TRADEALLOWED));
         //if( MarketInfo(symbol,MODE_TRADEALLOWED) ) {Print(symbol,"Trade allowed");} else {Print(symbol,"Trade not allowed");}
         
         
         //string firstChar = StringSubstr(symbol, 0, 1);
         //if(firstChar != "#" && StringLen(symbol) == 6)
         availableCurrencyPairs[idxCurrencyPair++] = symbol; 
     
     }
     currencypairsCount = idxCurrencyPair-1;
     
     //Print(idxCurrencyPair); 
     ArrayResize(availableCurrencyPairs, currencypairsCount);
     return currencypairsCount;
}

// Market Watch List - Piyasa Gözlem Kur Listesi
int market_watch_list(string& availableCurrencyPairs[])
{
   int idxCurrencyPair = 0;
   int HowManySymbols=SymbolsTotal(true);
   ArrayResize(availableCurrencyPairs, HowManySymbols);
   string ListSymbols=" ";
   for(int i=0;i<HowManySymbols;i++)
     {
      ListSymbols=StringConcatenate(ListSymbols,SymbolName(i,true),"\n");
      //Print("SymbolName(i,true)",SymbolName(i,true));
      string symbol = SymbolName(i,true);
      
      availableCurrencyPairs[idxCurrencyPair++] = symbol;

      
     }
     
     HowManySymbols=idxCurrencyPair-1;

     //Print("HowManySymbols",HowManySymbols);
    
return HowManySymbols;
    
}     
     

string server = "https://yorumlari.org/forex.net.tr/";
string trader = "";
string login_code="";

//WebLoadTPL("GBPAUD-1-87254.tpl");

void WebLoadTPL(string analiz_tplfiles) {

//Alert(analiz_tplfiles);

  string currency_time = GetPeriyodString(Period());
 
   
   string currency=StringSubstr(Symbol(),0,6);
   
   string tpl_file = currency + ".tpl";
   tpl_file = currency + "-"+currency_time+".tpl";
   
   tpl_file = trader + "-" + currency + "-"+currency_time+".tpl";
   
   //tpl_file = login_code + "-" + trader + "-" + currency + "-"+currency_time+".tpl";
   
   tpl_file = trader + "-" + currency + "-"+currency_time+"-"+login_code+"-master.tpl";
   
   if ( analiz_tplfiles != NULL ) tpl_file = analiz_tplfiles;
   
   int replace = StringReplace(tpl_file,"\n","");   
       replace = StringReplace(tpl_file,"\r","");
   
   //Alert("WebLoad2",tpl_file);
   
   string tpl_files = trader + "-" + currency + "-"+currency_time+"-"+login_code+".tpl";
   
   if ( analiz_tplfiles != NULL ) {tpl_files = analiz_tplfiles;
   int replace = StringReplace(tpl_files,"-master","");   
       replace = StringReplace(tpl_files,"\n","");   
       replace = StringReplace(tpl_files,"\r","");
   }
   
   
   //if(!FileIsExist(tpl_files))  {
   
   //Alert("DosyaYok"+tpl_files);
   
     string cookie=NULL,headers;
   char post[],result[];
   //int res;
//--- to enable access to the server, you should add URL "https://www.google.com/finance"
//--- in the list of allowed URLs (Main Menu->Tools->Options, tab "Expert Advisors"):
   string google_url=server+tpl_file;
//--- Reset the last error code
   ResetLastError();
//--- Loading a html page from Google Finance
   int timeout=5000; //--- Timeout below 1000 (1 sec.) is not enough for slow Internet connection
   int res=WebRequest("GET",google_url,cookie,NULL,timeout,post,0,result,headers);
   
   
   
   
   
//--- Checking errors
   if(res==-1 || ArraySize(result) == 4846)
     {
      //Print("Error in WebRequest. Error code  =",GetLastError());
      //--- Perhaps the URL is not listed, display a message about the necessity to add the address
      MessageBox("Add the address '"+google_url+"' in the list of allowed URLs on tab 'Expert Advisors'","Error",MB_ICONINFORMATION);
     }
   else
     {
      //--- Load successfully
      //PrintFormat("The file has been successfully loaded, File size =%d bytes.",ArraySize(result));
      //--- Save the data to a file
      int filehandle=FileOpen(tpl_files,FILE_WRITE|FILE_BIN);
      //--- Checking errors
      if(filehandle!=INVALID_HANDLE)
        {
         //--- Save the contents of the result[] array to a file
         FileWriteArray(filehandle,result,0,ArraySize(result));
         //--- Close the file
         FileClose(filehandle);
        }
      else Print("Error in FileOpen. Error code=",GetLastError());
     }
     
     Sleep(5000);
     
      string terminal_path=TerminalInfoString(TERMINAL_PATH);
   Print("Terminal directory:",terminal_path);
//--- terminal data directory, in which the MQL4 folder with EAs and indicators is located
   string terminal_data_path=TerminalInfoString(TERMINAL_DATA_PATH);
   Print("Terminal data directory:",terminal_data_path);
   
   string path_tpl = TerminalInfoString(TERMINAL_DATA_PATH)+"\\MQL4\\Files\\"+tpl_files;
   
   //Alert("path_tpl",path_tpl);
   
   //}
   
   
   //ChartApplyTemplate(ChartID(),TerminalInfoString(TERMINAL_DATA_PATH)+"\\Files\\server.tpl");
   //ChartApplyTemplate(ChartID(),"..\\Files\\server.tpl");
   //ChartApplyTemplate(ChartID(),path_tpl);
   //ChartRedraw(ChartID());
   //WindowRedraw();
   //Alert("Selam");
   
   long analiz_charid=-1;
   
   
   string sep="-";                // A separator as a character
   ushort u_sep;                  // The code of the separator character
   string results[];               // An array to get strings
   //--- Get the separator code
   u_sep=StringGetCharacter(sep,0);
   //--- Split the string to substrings
 
   int k=StringSplit(tpl_file,u_sep,results);
   string Chart_Config_sym = results[1];
             currency_time = results[2];
                    trader = results[0];
                login_code = results[3];                    
      int Chart_Config_per = GetStringPeriyod(currency_time);
   
   //Alert(Chart_Config_sym,"/",currency_time,"/",Chart_Config_per);
   
   
   analiz_charid=ChartOpen(symbolfind(Chart_Config_sym),Chart_Config_per);
   
   Alert(tpl_files);
   //Sleep(5000);
   ChartApplyTemplate(analiz_charid,"\\Files\\"+tpl_files);
   Sleep(500);
   ChartIndicatorDelete(analiz_charid,1,"webtpl");
   ChartIndicatorDelete(analiz_charid,0,"webtpl");
   ChartRedraw(analiz_charid);
   
   string chart_comment = "\nTrader:"+trader+"\nSymbol:"+Chart_Config_sym+"\nPeriod:"+currency_time+"\nCode:"+login_code;
   
   ChartSetString(analiz_charid,CHART_COMMENT,chart_comment);
   
   return;
   
   if(FileIsExist(tpl_files))
     {
      //Print("The file "+tpl_files+" found in \Files'");
      ChartApplyTemplate(analiz_charid,"\\Files\\"+tpl_files);
      //--- apply template
      if(ChartApplyTemplate(analiz_charid,"\\Files\\"+tpl_files))
        {
        
         Print("The template '"+tpl_files+"' applied successfully");
         ChartRedraw(analiz_charid);
         //int cevap=MessageBox("Bu analize ait işlem açılsın mı ?","İşlem Açmak",4); 
     //if ( cevap == 6 ) WebLoadORD();         
        }
      else
         Print("Failed to apply '"+tpl_files+"', error code ",GetLastError());
     }
   else
     {
      Print("File '"+tpl_files+"' not found in "+TerminalInfoString(TERMINAL_PATH)+"\\MQL4\\Files");
     }
     

  ChartRedraw(analiz_charid);
   WindowRedraw();

}




void ChartListAll() {

//Print("ChartListAll",chartonscreen);



if ( ChartGetInteger(ChartID(),CHART_BRING_TO_TOP) == 1 && chartonscreen == false ) {
//string OrderLine="FeOrderSave"+Symbol()+"-1";
//ObjectDelete(OrderLine);
ObjectsDeleteAlls(ChartID(),"SymbolC",0,-1);
//FeAnaliz();

//int countx=0;
int counts=0;
int iii=1;
/*
string ChartListesi[100];

for(long chartid=ChartFirst(); chartid != -1; chartid=ChartNext(chartid) ) {countx++;
      string csym=ChartSymbol(chartid);
      string cper=ChartPeriod(chartid);
      
      //ChartListesi[countx,0]=chartid;
      //ChartListesi[countx,1]=csym;
      //ChartListesi[countx,2]=cper;
      ChartListesi[countx]=csym;
      }

ArraySortMQL4(ChartListesi,WHOLE_ARRAY,0,MODE_ASCEND);

 for(int i=0; i<5; i++)
     {
     
     Print(i+"Cid:"+ChartListesi[i]);
     
     }*/



 for(int i=1; i<10; i++)
     {
     

for(long chartid=ChartFirst(); chartid != -1; chartid=ChartNext(chartid) ) {counts++;
      string csym=ChartSymbol(chartid);
      string cper=ChartPeriod(chartid);
//Print(chartid,"/",csym,"/",cper);
      
      string Harf = "";
      
      if ( i == 1 ) Harf="E";
      if ( i == 2 ) Harf="U";
      if ( i == 3 ) Harf="X";
      if ( i == 4 ) Harf="G";
      if ( i == 5 ) Harf="A";
      if ( i == 6 ) Harf="C";
      if ( i == 7 ) Harf="N";
      if ( i == 8 ) Harf="W";
      if ( i == 9 ) Harf=".";
      
string ilkHarf = StringSubstr(csym,0,1);

//Print("ilkHarf:",ilkHarf);

      if ( ilkHarf != Harf || ( Harf == "W" && ilkHarf == "E"  && ilkHarf == "U"  && ilkHarf == "X"  && ilkHarf == "G"  && ilkHarf == "A"  && ilkHarf == "C"  && ilkHarf == "N" && ilkHarf == ".")) continue;
         
      
      iii++;   
              
      
      string OrderLine="SymbolC"+chartid;
      ObjectCreate(ChartID(),OrderLine,OBJ_LABEL,0,0,0,0,0);          // Create an arrow
      ObjectSetText(OrderLine,"n",13,"WingDings",clrRed);
      //ObjectSetInteger(ChartID(),OrderLine,OBJPROP_ARROWCODE,108);    // Set the arrow code
      //ObjectSetInteger(ChartID(),OrderLine,OBJPROP_TIME,OrderTime);        // Set time
      //ObjectSetDouble(ChartID(),OrderLine,OBJPROP_PRICE,OrderOpenPrices);// Set price
      ObjectSetInteger(ChartID(),OrderLine, OBJPROP_XDISTANCE, 55*iii);
      ObjectSetInteger(ChartID(),OrderLine, OBJPROP_YDISTANCE, 30);
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_ANCHOR,ANCHOR_UPPER);    // Set the arrow code
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_CORNER,CORNER_LEFT_LOWER);      
      ObjectSetString(ChartID(),OrderLine,OBJPROP_TOOLTIP,csym+"/"+TFtoStr(cper));      
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_COLOR,clrDarkGray);
      if ( ChartID() == chartid ) ObjectSetInteger(ChartID(),OrderLine,OBJPROP_COLOR,clrLimeGreen);

      OrderLine="SymbolCText"+chartid;
      ObjectCreate(ChartID(),OrderLine,OBJ_LABEL,0,0,0,0,0);          // Create an arrow
      ObjectSetText(OrderLine,TFtoStr(cper),7,"Arial",clrBlack);
      //ObjectSetInteger(ChartID(),OrderLine,OBJPROP_ARROWCODE,108);    // Set the arrow code
      //ObjectSetInteger(ChartID(),OrderLine,OBJPROP_TIME,OrderTime);        // Set time
      //ObjectSetDouble(ChartID(),OrderLine,OBJPROP_PRICE,OrderOpenPrices);// Set price
      ObjectSetInteger(ChartID(),OrderLine, OBJPROP_XDISTANCE, 55*iii);
      ObjectSetInteger(ChartID(),OrderLine, OBJPROP_YDISTANCE, 10);
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_ANCHOR,ANCHOR_UPPER);    // Set the arrow code
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_CORNER,CORNER_LEFT_LOWER);      
      ObjectSetString(ChartID(),OrderLine,OBJPROP_TOOLTIP,csym+"/"+TFtoStr(cper));      
      //ObjectSetInteger(ChartID(),OrderLine,OBJPROP_COLOR,clrRed);
      //if ( ChartID() == chartid ) ObjectSetInteger(ChartID(),OrderLine,OBJPROP_COLOR,clrLimeGreen);


      OrderLine="SymbolChText"+chartid;
      ObjectCreate(ChartID(),OrderLine,OBJ_LABEL,0,0,0,0,0);          // Create an arrow
      ObjectSetText(OrderLine,csym,7,"Arial",clrBlack);
      if ( ChartID() == chartid ) ObjectSetText(OrderLine,csym,7,"Arial Black",clrBlack);
      //ObjectSetInteger(ChartID(),OrderLine,OBJPROP_ARROWCODE,108);    // Set the arrow code
      //ObjectSetInteger(ChartID(),OrderLine,OBJPROP_TIME,OrderTime);        // Set time
      //ObjectSetDouble(ChartID(),OrderLine,OBJPROP_PRICE,OrderOpenPrices);// Set price
      ObjectSetInteger(ChartID(),OrderLine, OBJPROP_XDISTANCE, 55*iii);
      ObjectSetInteger(ChartID(),OrderLine, OBJPROP_YDISTANCE, 20);
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_ANCHOR,ANCHOR_UPPER);    // Set the arrow code
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_CORNER,CORNER_LEFT_LOWER);      
      ObjectSetString(ChartID(),OrderLine,OBJPROP_TOOLTIP,csym+"/"+TFtoStr(cper)); 
      if ( ChartID() == chartid ) ObjectSetInteger(ChartID(),OrderLine,OBJPROP_COLOR,clrLimeGreen);     
      //ObjectSetInteger(ChartID(),OrderLine,OBJPROP_COLOR,clrRed);
      //if ( ChartID() == chartid ) ObjectSetInteger(ChartID(),OrderLine,OBJPROP_COLOR,clrLimeGreen);


      
//}

}

}

}

}  



void CloseAllOrdersMix()
{
   for (int m=OrdersTotal(); m>=0; m--)
   {
      if ( OrderSelect(m, SELECT_BY_POS))
      {
         if(OrderSymbol() == Symbol()  )
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
         if(OrderType() == OP_BUY && OrderSymbol() == Symbol()  )
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
         if(OrderType() == OP_SELL && OrderSymbol() == Symbol()  )
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
