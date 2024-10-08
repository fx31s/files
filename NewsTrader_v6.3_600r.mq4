//+------------------------------------------------------------------+
//|                                         NewsTrader_v6.3 600+.mq4 |
//|                        Copyright © 2007-17, TrendLaboratory Ltd. |
//|         https://groups.yahoo.com/neo/groups/TrendLaboratory/info |
//|                                   E-mail: igorad2003@yahoo.co.uk |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2007-17, TrendLaboratory"
#property link      "https://groups.yahoo.com/neo/groups/TrendLaboratory/info"
#property link      "http://newdigital-world.com/forum.php"

#property strict
#include <stdlib.mqh>

//---- input parameters
input string     ExpertName           = "NewsTrader_v6.3 600+";

input int        Magic                =      5959;       //Magic Number 
input int        Slippage             =         3;       //Slippage in pips 

input string     calInputs            = "===== Calendar settings: =====";
input string     CalendarDirectory    = "FX News";       //Calendar Directory
input string     CalendarName         = "Investing.com";//Calendar Name 
input int        DownloadPause        =       120;       //Pause Between Downloads (sec) 
input bool       UseAutoTimeZone      =      true;       //Auto TimeZone Detection
input int        TimeZone             =         3;       //Manual TimeZone
input bool       ReadFromFile         =     false;       //Read Calendar From File: false-from site,true-from file
input bool       PrintInLog           =     false;       //Print in Log: false-off,true-on
input bool       DisplayLines         =      true;       //Display Lines Option: false-off,true-on
input bool       DisplayText          =     false;       //Display Text Option: false-off,true-on
input bool       DisplayEvents        =      true;       //Display Events Option: false-off,true-on
input int        LineStyle            =         3;       //Line Style
input int        MaxEventLength       =        27;       //News Max Length(in symbols) 


input string     timeInputs           = "===== Timing settings: =====";
input bool       OpenOnClose          =     false;       //Open On Bar Close  
input int        TimeFrame            =         0;       //TimeFrame 
input double     TimeGap              =         2;       //Time Gap between News(Bar Close) Time and Order Open Time in min 
input double     OrderDuration        =        15;       //Order Duratiton Time in min
input double     ProcessTime          =         2;       //Order Processing Time in min
input int        SessionEndHour       =        23;       //Session End Time
input int        FridayEndHour        =        22;       //Session End Time in Friday

input string     ordInputs            = "===== Order settings: =====";
input int        OrdersNum            =         2;       //Number of pending orders from one side
input int        HiPrice              =         0;       //Buy Price
input int        LoPrice              =         0;       //Sell Price
input int        PriceShift           =         0;       //Price Shift
input double     PendOrdGap           =        15;       //Gap for Pending Orders from current price in pips
input double     OrdersStep           =        10;       //Step between orders in pips
input bool       DeleteOpposite       =      true;       //Opposite Orders delete
input bool       TrailOpposite        =      true;       //Opposite Orders trailing
input bool       CloseOnNewEvent      =      true;       //Close Orders On New Event

input double     InitialStop          =       100;       //Initial Stop in pips
input double     TakeProfit           =       100;       //Take Profit in pips       	

input double     TrailingStop         =        15;       //Trailing Stop in pips      
input double     TrailingStep         =         0;       //Trailing Stop Step in pips    

input double     BreakEven            =         0;       //Breakeven in pips  
input double     PipsLock             =         0;       //Lock in pips

input bool       ECN_Mode             =     false;       //ECN Mode 
input bool       Straddle_Mode        =      true;       //Straddle Mode 
input bool       DisplayLevels        =      true;       //Display Levels for ECN Mode
input bool       ShowComments         =      true;       //Show Comments: false-off,true-on(use only for Live Trading and Visual Testing)
input bool       ShowCalendar         =      true;       //Show Calendar  
input bool       SaveHTMFormat        =     false;       //Save HTM Format

input string     countryFilter        = "===== Country Filter(None-off, color-on): ====="; 
 
input color      EUR                  =    clrPink;      //Euro Zone(EUR)    
input color      USD                  =  clrDodgerBlue;  //US(USD)
input color      JPY                  =  clrOrange;      //Japan(JPY)
input color      GBP                  =     clrRed;      //UK(GBP) 
input color      CHF                  =  clrMagenta;     //Switzerland(CHF) 
input color      AUD                  =   clrGreen;      //Australia(AUD)
input color      CAD                  =  clrTomato;      //Canada(CAD) 
input color      NZD                  =    clrGray;      //New Zealand(NZD)   
input color      CNY                  =  clrOrange;      //China(CNY) 

input string     impFilter            = "===== Importance Filter: =====";
input string     NewsImportance       =    "H";      //News Importance Filter ("" - all)

input string     mmInputs             = "===== Money Management settings: =====";
input int        MM_Mode              =          0;      //MM Mode: 0-off,1-by free Margin
input double     Lots                 =        0.1;      //Lot size
input double     RiskFactor           =          0;      //Risk Factor(in decimals) for MM formula 
input double     MaxLots              =          0;      //Max Lot Size

#define DAY_SECONDS 86400

string   sDate[];          // Date
string   sTime[];          // Time
string   sCurrency[];      // Currency
string   sEvent[];         // Event
string   sImportance[];    // Importance
string   sActChange[];     // Actual change
string   sActual[];        // Actual value
string   sForecast[];      // Forecast value
string   sPrevChange[];    // Previous change
string   sPrevious[];      // Previous value

string   event[];
datetime dt[]; 
string   sImpact[];
int      country[];   

double   BuyLevel[], SellLevel[]; 
int      BuyNum[], SellNum[];
int      NewsNum, TriesNum = 5, BuyEvent, SellEvent;
bool     firstTime, NewEvent;
datetime gmtime, prevWeekTime, pEventTime, nTime, OpenTime, tabTime, revtime, savedtime;
int      tz, counter, ECN_Buy, ECN_Sell;
double   totalPips, totalProfits;
double   dRatio, contract, lot_min, lot_step, lot_max, tick_val, _point, minstop, pAsk, pBid;
string   StartYear, StartMonth, uniqueName = "dfx";
//+------------------------------------------------------------------+
//| expert initialization function                                   |
//+------------------------------------------------------------------+
int init()
{
//---- 
   dRatio = MathPow(10,Digits%2);  
   _point = MarketInfo(Symbol(),MODE_POINT)*dRatio;
   
   ArrayResize(BuyLevel ,OrdersNum);
   ArrayResize(SellLevel,OrdersNum);
   ArrayResize(BuyNum   ,OrdersNum);
   ArrayResize(SellNum  ,OrdersNum);
   
   pEventTime = TimeCurrent(); 
   firstTime  = true;
//----
   return(0);
}
  
//---- Money Management
double MoneyManagement (int mode,double maxloss)
{
   double Lotsi = 0, maxlots = MaxLots;
   
   lot_step = MarketInfo(Symbol(),MODE_LOTSTEP); 
   lot_max  = MarketInfo(Symbol(),MODE_MAXLOT);
   lot_min  = MarketInfo(Symbol(),MODE_MINLOT);
   contract = MarketInfo(Symbol(),MODE_LOTSIZE);   
   
   if(mode == 1 && RiskFactor > 0) Lotsi = NormalizeDouble(AccountFreeMargin()*0.01*RiskFactor*AccountLeverage()/contract,2);  
   else
   if(mode == 2 && RiskFactor > 0 && maxloss > 0) Lotsi = NormalizeDouble(AccountFreeMargin()*10*RiskFactor/maxloss*AccountLeverage()/contract,2);   
   else
   Lotsi = Lots;
      
   Lotsi = NormalizeDouble(Lotsi/lot_step,0)*lot_step;
 
   if(maxlots == 0) maxlots = lot_max;
   if(maxlots > 0 && Lotsi > maxlots) Lotsi = maxlots;  
   if(Lotsi < lot_min) Lotsi = lot_min;
   
   return(Lotsi);
}   

//---- Trailing Stops
void TrailStop(double ts,double step,double be,double pl)
{
   int    k, error, total = OrdersTotal();  
   bool   result;
   double Gain, BuyStop, SellStop;
   
   minstop  = MarketInfo(Symbol(),MODE_STOPLEVEL)/dRatio;  
   
   for(int cnt=total-1;cnt>=0;cnt--)
   { 
   if(!OrderSelect(cnt, SELECT_BY_POS)) continue;  
   if(OrderMagicNumber() != Magic || OrderSymbol() != Symbol()) continue;             
   
   double open = OrderOpenPrice();
   double stop = OrderStopLoss();
      
      if(OrderType() == OP_BUY)
      { 
      Gain = 0; BuyStop = 0;
	   double _Bid = MarketInfo(Symbol(),MODE_BID);	   
               
         if(be > 0 && NormalizeDouble(stop - open,Digits) < NormalizeDouble(pl*_point,Digits))
		   {
		   Gain = NormalizeDouble((_Bid - open)/_point,Digits);   
         if(Gain >= be) BuyStop = NormalizeDouble(open + pl*_point,Digits);
		   }
			else
			if(ts > 0 || step > 0) 
			{			   
			BuyStop = NormalizeDouble(_Bid - ts*_point,Digits);
			   if(step > 0 && stop > 0)
			   {
			   if(BuyStop >= NormalizeDouble(stop + step *_point,Digits)) BuyStop = BuyStop; 
			   else BuyStop = OrderStopLoss();
			   }
			}			   			   
			
			if(BuyStop <= 0) continue; 
				   
			if(_Bid - BuyStop < minstop*_point) BuyStop = NormalizeDouble(_Bid - minstop*_point,Digits);   
              
			if(NormalizeDouble(OrderOpenPrice(),Digits) <= BuyStop) 
         {   
			   if(NormalizeDouble(BuyStop,Digits) > NormalizeDouble(stop,Digits) || stop == 0) 
			   {
			      for(k = 0 ; k < TriesNum; k++)
               {
               result = OrderModify(OrderTicket(),open,NormalizeDouble(BuyStop,Digits),OrderTakeProfit(),0,Lime);
               
               error = GetLastError();
               
                  if(error == 0 && result) break;
                  else 
                  if(error == 130 && !result)
                  {
                     while(!result)
                     {
                     BuyStop -= _point;
                     RefreshRates();
                     result = OrderModify(OrderTicket(),open,BuyStop,OrderTakeProfit(),0,Lime);
                     }  
                  }
                  else {Sleep(5000); RefreshRates(); continue;}
               }            
            }
         }
      }         
      else
      if(OrderType() == OP_SELL)
      {
      Gain = 0; SellStop = 0;
      double _Ask = MarketInfo(Symbol(),MODE_ASK);
   
         if(be > 0 && (NormalizeDouble(open - stop,Digits) < NormalizeDouble(pl*_point,Digits) || stop == 0))
			{
			Gain = (open - _Ask)/_point;
			if(Gain >= be) SellStop = NormalizeDouble(open - pl*_point,Digits);
			}
			else
			if(ts > 0 || step > 0) 
			{			   
			SellStop = NormalizeDouble(_Ask + ts*_point,Digits);
			   if(step > 0 && stop > 0)
			   {
			   if(SellStop <= NormalizeDouble(stop - step *_point,Digits)) SellStop = SellStop; 
			   else SellStop = stop;
			   }
         }
                       
         if(SellStop <= 0) continue;
                        
         if(SellStop - _Ask < minstop*_point) SellStop = NormalizeDouble(_Ask + minstop*_point,Digits);   
                        
         if(NormalizeDouble(open,Digits) >= SellStop && SellStop > 0) 
         {
            if(NormalizeDouble(SellStop,Digits) < NormalizeDouble(stop,Digits) || stop == 0) 
            {
               for( k = 0 ; k < TriesNum; k++)
               {
               result = OrderModify(OrderTicket(),open,NormalizeDouble(SellStop,Digits),OrderTakeProfit(),0,Orange);
                  
               error = GetLastError();
                  
                  if(error == 0 && result) break;
                  else 
                  if(error == 130 && !result)
                  {
                     while(!result)
                     {
                     SellStop += _point;
                     RefreshRates();
                     result = OrderModify(OrderTicket(),open,NormalizeDouble(SellStop,Digits),OrderTakeProfit(),0,Orange);
                     }  
                  }
                  else {Sleep(5000); RefreshRates(); continue;}
               }   
   			}	    
         }
      }
   }     
}

//---- Open Sell Orders
int SellOrdOpen(int ord,double price,double sl,double tp,int num) 
{		     
   int ticket = 0, tr = 1;
   double maxloss = 0;
   
   tick_val = MarketInfo(Symbol(),MODE_TICKVALUE)*dRatio;
   minstop  = MarketInfo(Symbol(),MODE_STOPLEVEL)/dRatio;
   
   if(MM_Mode == 2 && sl > 0) maxloss = (sl - price)*tick_val/_point; 
   
   double lots = MoneyManagement(MM_Mode,maxloss);   
   
   while(ticket <= 0 && tr <= TriesNum)
   {
   ticket = OrderSend(Symbol(),ord,lots,
	                   NormalizeDouble(price,Digits),
	                   (int)(dRatio*Slippage),
	                   NormalizeDouble(sl,Digits),
	                   NormalizeDouble(tp,Digits),
	                   ExpertName+" SELL:"+(string)num,Magic,0,Red);
      
      if(ticket > 0) 
      {
         if(OrderSelect(ticket,SELECT_BY_TICKET,MODE_TRADES)) 
         {
         Print("SELL order opened : ",OrderOpenPrice());
         SellNum[num-1] = 1;
         ECN_Sell = 0;
         }
      }
	   else 	
      if(ticket < 0)
	   { 	
      Sleep(5000);
      RefreshRates();
      tr += 1;
      if(GetLastError() > 0) Print("SELL: OrderSend failed with error #",ErrorDescription(GetLastError()));
      }
   }   
   return(ticket);
}

//---- Open Buy Orders
int BuyOrdOpen(int ord,double price,double sl,double tp,int num)
{		     
   int ticket = 0, tr = 1;
   double maxloss = 0;
   
   tick_val = MarketInfo(Symbol(),MODE_TICKVALUE)*dRatio;
   minstop  = MarketInfo(Symbol(),MODE_STOPLEVEL)/dRatio;
   
   if(MM_Mode == 2 && sl > 0) maxloss = (price - sl)*tick_val/_point; 
   
   double lots = MoneyManagement(MM_Mode,maxloss);  
         
   while(ticket <= 0 && tr <= TriesNum)
   {
   ticket = OrderSend(Symbol(),ord,lots,
	                   NormalizeDouble(price,Digits),
	                   (int)(dRatio*Slippage),
	                   NormalizeDouble(sl,Digits), 
	                   NormalizeDouble(tp,Digits),
	                   ExpertName+" BUY:"+(string)num,Magic,0,Blue);
      
      if(ticket > 0) 
      {
         if (OrderSelect(ticket, SELECT_BY_TICKET, MODE_TRADES)) 
         {
         Print("BUY order opened : ",OrderOpenPrice());
         BuyNum[num-1] = 1;
         ECN_Buy = 0;
         }
      }
      else 
	   if(ticket < 0)
	   { 	
      Sleep(5000);
      RefreshRates();
      tr += 1;
      if(GetLastError() > 0) Print("BUY : OrderSend failed with error #",ErrorDescription(GetLastError()));
      }
   }   
   return(ticket);
} 

//---- Scan Trades
int ScanTrades(int& buy,int& sell,int& buylimit,int& selllimit,int& buystop,int& sellstop)
{   
   buy = 0; sell = 0; buylimit = 0; selllimit = 0; buystop = 0; sellstop = 0;
     
   for(int cnt=0; cnt <OrdersTotal(); cnt++) 
   {        
   if(!OrderSelect(cnt, SELECT_BY_POS)) continue;            
   if(OrderSymbol() != Symbol() || OrderMagicNumber() != Magic) continue;  
      
      if(OrderType() == OP_BUY ) buy++;
      if(OrderType() == OP_SELL) sell++;         
      if(OrderType() == OP_BUYLIMIT ) buylimit++;
      if(OrderType() == OP_SELLLIMIT) selllimit++;
      if(OrderType() == OP_BUYSTOP ) buystop++;
      if(OrderType() == OP_SELLSTOP) sellstop++;        
   }
   
   return(buy + sell + buylimit + selllimit + buystop + sellstop);
}  

//-----   
datetime FinishTime(double duration)
{   
   int i, total = OrdersTotal();
   datetime finTime = 0;
         
   for(i=0;i<total;i++) 
   {        
   if(!OrderSelect(i,SELECT_BY_POS)) continue;            
   if(OrderMagicNumber() != Magic || OrderSymbol() != Symbol()) continue;
    
   if(OrderType() <= OP_SELLSTOP) finTime = (datetime)(OrderOpenTime() + duration*60);
   }
   
   return(finTime);
}

// Closing of Pending Orders      
bool PendOrdDel(int mode)
{
   bool result = false;
   
   for(int i=0;i<OrdersTotal();i++)  
   {
   if(!OrderSelect(i,SELECT_BY_POS,MODE_TRADES)) continue;
   if(OrderMagicNumber() != Magic || OrderSymbol() != Symbol()) continue;     
   
      if((mode == 0 || mode == 1) && OrderType() == OP_BUYSTOP)
      {     
      result = OrderDelete(OrderTicket());
      if(!result) Print("BUYSTOP: OrderDelete failed with error #",GetLastError());
      }
      
      if((mode == 0 || mode == 2) && OrderType() == OP_SELLSTOP)
      {     
      result = OrderDelete( OrderTicket() );  
      if(!result) Print("SELLSTOP: OrderDelete failed with error #",GetLastError());
      }
   }
   
   return(result);
}    

//-----
bool ReadnPlotCalendar(string fName)
{    
   int    i, k, handle, rating = 0;
   bool   rates = false;
   string sYear, sMon, sDay, info;
   
   
   ArrayResize(sDate       ,0);
   ArrayResize(sTime       ,0);
   ArrayResize(sCurrency   ,0);
   ArrayResize(sEvent      ,0);
   ArrayResize(sImportance ,0);
   ArrayResize(sActChange  ,0);
   ArrayResize(sActual     ,0);
   ArrayResize(sForecast   ,0);
   ArrayResize(sPrevChange ,0);
   ArrayResize(sPrevious   ,0);
         
   ArrayResize(dt          ,0);
   ArrayResize(sImpact     ,0);
   ArrayResize(country     ,0);
    
   handle = FileOpen(fName,FILE_CSV|FILE_READ,';');
   
   if(handle == INVALID_HANDLE)
   {
   Print("File not found ", GetLastError());
   return(false);
   }
   else
   {
   i = 0;
   
      while(!FileIsEnding(handle))
      {
      k = ArraySize(sDate);
   
      ArrayResize(sDate       ,k + 1);
      ArrayResize(sTime       ,k + 1);
      ArrayResize(sCurrency   ,k + 1);
      ArrayResize(sImportance ,k + 1);
      ArrayResize(sEvent      ,k + 1);
      ArrayResize(sActChange  ,k + 1);
      ArrayResize(sActual     ,k + 1);
      ArrayResize(sForecast   ,k + 1);
      ArrayResize(sPrevChange ,k + 1);
      ArrayResize(sPrevious   ,k + 1);
            
      ArrayResize(dt          ,k + 1);
      ArrayResize(event       ,k + 1);
      ArrayResize(sImpact     ,k + 1);
      ArrayResize(country     ,k + 1);
      
      
      
      sDate[i]       = FileReadString(handle);           // Date
      sTime[i]       = FileReadString(handle);           // Time
      sCurrency[i]   = FileReadString(handle);           // Currency
      sImportance[i] = FileReadString(handle);           // Rating
      sEvent[i]      = FileReadString(handle);           // Event
      sActChange[i]  = FileReadString(handle);           // Actual value change
      sActual[i]     = FileReadString(handle);           // Actual value
      sForecast[i]   = FileReadString(handle);           // Forecast value
      sPrevChange[i] = FileReadString(handle);           // Previous value change
      sPrevious[i]   = FileReadString(handle);           // Previous value
     
      FileReadString(handle);
      
      if(StringFind(sTime[i],":",0) < 0) continue;
      
      if(sImportance[i] == "L") sImpact[i] = "L";
      if(sImportance[i] == "M") sImpact[i] = "M";
      if(sImportance[i] == "H") sImpact[i] = "H";  
      
      if(!ImpactFilter(sImpact[i])) continue;
    
      color clr  =-1;//clrNONE;
      country[i] =-1;
       
      if(sCurrency[i] == "USD" && USD != clrNONE) {country[i] = 1; clr = USD;} 
      if(sCurrency[i] == "EUR" && EUR != clrNONE) {country[i] = 1; clr = EUR;} 
      if(sCurrency[i] == "GBP" && GBP != clrNONE) {country[i] = 1; clr = GBP;} 
      if(sCurrency[i] == "JPY" && JPY != clrNONE) {country[i] = 1; clr = JPY;} 
      if(sCurrency[i] == "AUD" && AUD != clrNONE) {country[i] = 1; clr = AUD;} 
      if(sCurrency[i] == "NZD" && NZD != clrNONE) {country[i] = 1; clr = NZD;} 
      if(sCurrency[i] == "CAD" && CAD != clrNONE) {country[i] = 1; clr = CAD;} 
      if(sCurrency[i] == "CHF" && CHF != clrNONE) {country[i] = 1; clr = CHF;} 
      if(sCurrency[i] == "CNY" && CNY != clrNONE) {country[i] = 1; clr = CNY;} 
      
      if(country[i] < 0) continue;   
      
       
           
      dt[i] = StrToTime(sDate[i] + " " + sTime[i]) + tz*3600;           
         
      if(StringSubstr(sEvent[i],0,3) != sCurrency[i]) event[i] = sEvent[i]; else event[i] = StringSubstr(sEvent[i],4,0);
   
      info  = TimeToStr(dt[i]) + " " + sCurrency[i] + " " + event[i] + " " + sImpact[i] + " " + sActual[i] + " " + sForecast[i] + " " + sPrevious[i];
                    
      if(PrintInLog) Print((string)i + " " + info);
                  
         if(country[i] > 0)
         {   
            if(DisplayLines)
            {         
            string linename = uniqueName + "line" + (string)i;
            ObjectCreate    (0,linename,OBJ_VLINE    ,0,dt[i],Close[0]);
            ObjectSetInteger(0,linename,OBJPROP_COLOR,      clr);                    
            ObjectSetInteger(0,linename,OBJPROP_STYLE,LineStyle);                    
            ObjectSetInteger(0,linename,OBJPROP_BACK ,     true);          
            ObjectSetString (0,linename,OBJPROP_TEXT ,     info);
            ObjectSetInteger(0,linename,OBJPROP_SELECTABLE,true);
            }
  
            if(DisplayText)
            {
            string textname = uniqueName + "text" + (string)i;
            ObjectCreate    (0,textname,OBJ_TEXT        ,0,dt[i],Close[0]);
            ObjectSetString (0,textname,OBJPROP_TEXT    ,  info);
            ObjectSetInteger(0,textname,OBJPROP_COLOR   ,   clr); 
            ObjectSetInteger(0,textname,OBJPROP_FONTSIZE,     8); 
            ObjectSetDouble (0,textname,OBJPROP_ANGLE   ,    90);          
            }
            
            if(DisplayEvents)
            {         
            string eventname = uniqueName + "event" + (string)i;
            ObjectCreate    (0,eventname,OBJ_EVENT    ,0,dt[i],0);
            ObjectSetInteger(0,eventname,OBJPROP_COLOR,      clr);                    
            ObjectSetInteger(0,eventname,OBJPROP_BACK ,     true);          
            ObjectSetString (0,eventname,OBJPROP_TEXT ,     info);
            ObjectSetInteger(0,eventname,OBJPROP_SELECTABLE,true);
            }
         }
      i++;
      }
   NewsNum = i;
   }
   
   FileClose(handle);
   
   return(0);
}

//-----   
bool ImpactFilter(string impact)
{
	if(NewsImportance == "" || StringFind(NewsImportance,impact) >= 0) return(true);

	return(false);
}

//-----   
string ToUpper(string str) 
{
   ushort ch;
   int len = StringLen(str);
   
   for(int j=0;j<len;j++) 
   {
   ch = StringGetChar(str, j);
      
      if(ch >= 'a' && ch <= 'z') 
      {
      ch += 'A' - 'a'; 
      str = StringSetChar(str, j, ch);
      }
   }
   return(str);
}

//-----   
datetime GetWeekStart(datetime date) 
{ 
   int weekday = TimeDayOfWeek(date); 
   datetime start = date; 
     
   for (int i=weekday;i>0;i--) start = decDateOnDay(start); 
   
   return(start);
}

//-----   
datetime decDateOnDay(datetime date) 
{ 
  int ty = TimeYear(date); 
  int tm = TimeMonth(date); 
  int td = TimeDay(date); 
  int th = TimeHour(date); 
  int ti = TimeMinute(date); 
    
   td--; 
   if(td == 0) 
   { 
   tm--; 
      if(tm == 0) 
      { 
      ty--; 
      tm = 12; 
      } 
    
   if(tm == 1 || tm == 3 || tm == 5 || tm == 7 || tm == 8 || tm == 10 || tm == 12) td = 31; 
   if(tm == 2) if(MathMod(ty,4) == 0) td = 29; else td = 28; 
   if(tm == 4 || tm == 6 || tm == 9 || tm == 11) td = 30; 
   } 
  
   return(StrToTime((string)ty+"."+(string)tm+"."+(string)td));
}

//----
void ObjectDel(string name)
{
   int _GetLastError = 0;
   
   while(ObjFind(name,0,0) > 0)
   {
   int obtotal = ObjectsTotal();
      
      for(int i=0;i<obtotal;i++)
      {
         if(StringFind(ObjectName(i),name,0) >= 0)
         {
            if(!ObjectDelete(ObjectName(i)))
            {
            _GetLastError = GetLastError();
            Print( "ObjectDelete( \"",ObjectName(i),"\" ) - Error #", _GetLastError );
            }
         }
      }
   }
}

//-----
int ObjFind(string name,int start, int num)
{
   int cnt = 0;
   
   for (int i=0;i<ObjectsTotal();i++)
      if(StringFind(ObjectName(i),name,start) == num) cnt += 1;
   
   return(cnt);
}

//---- Close of Orders
bool CloseOrder(int mode)  
{
   bool result = false; 
   int  total  = OrdersTotal();
   
   for(int i=0;i<total;i++)  
   {
   if(!OrderSelect(i,SELECT_BY_POS,MODE_TRADES)) continue;
   if(OrderMagicNumber() != Magic || OrderSymbol() != Symbol()) continue; 
   
   if((mode == 0 || mode == 1) && OrderType() == OP_BUY ) result = CloseAtMarket(OrderTicket(),OrderLots(),Aqua);
   if((mode == 0 || mode == 2) && OrderType() == OP_SELL) result = CloseAtMarket(OrderTicket(),OrderLots(),Pink);
   }
   
   return(result);
}

//-----   
bool CloseAtMarket(int ticket,double lot,color clr) 
{
   bool result = false; 
   int  ntr;
      
   int tries = 0;
   while(!result && tries < TriesNum) 
   {
   ntr = 0; 
   while(ntr < 5 && !IsTradeAllowed()) {ntr++; Sleep(5000);}
      
   RefreshRates();
      
   result = OrderClose(ticket,lot,OrderClosePrice(),Slippage,clr);
   tries++;
   }
   if(!result) Print("Error closing order : ",ErrorDescription(GetLastError()));
   
   return(result);
}

//------
datetime barCloseTime; 

datetime TimeToOpen()
{
   int i;
   double procTime;
   datetime oTime, result = 0;
      
   if(ECN_Mode) procTime = OrderDuration; else procTime = ProcessTime;
   
   for (i=0;i<NewsNum;i++)
   { 
      if(OpenOnClose)
      {
      if(dt[i] >= iTime(Symbol(),TimeFrame,0) && dt[i] < (iTime(Symbol(),TimeFrame,0) + TimeFrame*60)) barCloseTime = iTime(Symbol(),TimeFrame,0) + TimeFrame*60;
      oTime = (datetime)(barCloseTime - TimeGap*60);
      }
      else oTime = (datetime)(dt[i] - TimeGap*60);
   
      if(TimeCurrent() >= oTime && TimeCurrent() <= oTime + procTime*60 && oTime >= pEventTime)
      {
      result = oTime; 
      break;
      }
   }
      
   return(result);
}

//-----
bool IsNewEvent()
{
   bool result    = false;
   datetime oTime = 0;
        
   for (int i=0;i<NewsNum;i++)
   { 
      if(OpenOnClose)
      {
      if(dt[i] >= iTime(Symbol(),TimeFrame,0) && dt[i] < (iTime(Symbol(),TimeFrame,0) + TimeFrame*60)) barCloseTime = iTime(Symbol(),TimeFrame,0) + TimeFrame*60;
      oTime = (datetime)(barCloseTime - TimeGap*60);
      }
      else oTime = (datetime)(dt[i] - TimeGap*60);
   
      if(TimeCurrent() >= oTime && oTime > pEventTime)
      {
      result     = true; 
      pEventTime = oTime;
      break;
      }
   }
   
   return(result);
}

//-----        
void TrailOppositeOrder(int mode)
{
   int    k, nt, error;  
   bool   result = false;
   double Gain   = 0, BuyPrice, mBuyPrice, mBuyStop, mBuyProfit, SellPrice, mSellPrice, mSellStop, mSellProfit;
    
   for (int cnt=0;cnt<OrdersTotal();cnt++)
   { 
   if(!OrderSelect(cnt, SELECT_BY_POS)) continue;  
   if(OrderMagicNumber() != Magic || OrderSymbol() != Symbol()) continue;
          
      if(mode == 1 && OrderType() == OP_BUYSTOP) 
      {
		BuyPrice = MarketInfo(Symbol(),MODE_ASK);   
		
         for(nt=1;nt<=OrdersNum;nt++)
         {
            if(VerifyComment(1,nt))
			   {
			   mBuyPrice = BuyPrice + (2*PendOrdGap + OrdersStep*(nt - 1))*_point;
		      if(InitialStop > 0) mBuyStop   = mBuyPrice - InitialStop*_point; else mBuyStop   = 0;
            if(TakeProfit  > 0) mBuyProfit = mBuyPrice + TakeProfit *_point; else mBuyProfit = 0; 
			   			     
               if(NormalizeDouble(OrderOpenPrice(),Digits) > NormalizeDouble(mBuyPrice,Digits) && OrderType() == OP_BUYSTOP) 
               {   
			         for(k=0;k<TriesNum;k++)
                  {
                  result = OrderModify(OrderTicket(),
                                       NormalizeDouble(mBuyPrice ,Digits),
                                       NormalizeDouble(mBuyStop  ,Digits),
			                              NormalizeDouble(mBuyProfit,Digits),0,Aqua);
                  
                  error = GetLastError();
                  
                     if(error == 0) break; 
                     else 
                     {
                     Print("Error trail BUYSTOP # ",OrderComment()," order=",OrderType(),"! Price=",DoubleToStr(mBuyPrice,Digits)," Stop=",DoubleToStr(mBuyStop,Digits)," Take=",DoubleToStr(mBuyProfit,Digits));  
                     Sleep(5000); 
                     RefreshRates(); 
                     continue;
                     }
                  }
               }            
            }
         }
      }
                  
// - SELL Orders          
      if(mode == 2 && OrderType() == OP_SELLSTOP)
      {
      SellPrice = MarketInfo(Symbol(),MODE_BID);  
         
         for(nt=1;nt<=OrdersNum;nt++)
         {
            if(VerifyComment(2,nt))
			   {
            mSellPrice = SellPrice - (2*PendOrdGap + OrdersStep*(nt - 1))*_point;
            if(InitialStop > 0) mSellStop   = mSellPrice + InitialStop*_point; else mSellStop   = 0;
            if(TakeProfit  > 0) mSellProfit = mSellPrice - TakeProfit *_point; else mSellProfit = 0;  	   
         
               if(NormalizeDouble(OrderOpenPrice(),Digits) < NormalizeDouble(mSellPrice,Digits) && OrderType() == OP_SELLSTOP) 
               {
                  for(k = 0;k<TriesNum;k++)
                  {
                  result = OrderModify(OrderTicket(),
                                       NormalizeDouble(mSellPrice ,Digits),
			                              NormalizeDouble(mSellStop  ,Digits),
			                              NormalizeDouble(mSellProfit,Digits),0,Magenta);
                  
                  error  = GetLastError();
                  
                     if(error == 0) break; 
                     else 
                     {
                     Print("Error trail SELLSTOP # ",OrderComment()," order=",OrderType(),"! Price=",DoubleToStr(mSellPrice,Digits)," Stop=",DoubleToStr(mSellStop,Digits)," Take=",DoubleToStr(mSellProfit,Digits));  
                     Sleep(5000); 
                     RefreshRates(); 
                     continue;
                     }
                  }   
               }   
   			}	    
         }
      }
   }     
}

//-----   
bool VerifyComment(int mode, int num)
{
   int total   = OrdersTotal();
   bool result = false; 
      
   for(int cnt=0;cnt<total;cnt++) 
   {        
   if(!OrderSelect(cnt,SELECT_BY_POS)) continue;            
   if(OrderMagicNumber() != Magic || OrderSymbol() != Symbol()) continue;
      
      if(mode == 1 && OrderComment() == ExpertName + " BUY:" + (string)num)  
      {
      result = true;
      break;
      }
      
      if(mode == 2 && OrderComment() == ExpertName + " SELL:" + (string)num) 
      {
      result = true;
      break;
      }
   }
   
   return(result);
}                                   

//-----   
string economicCalendar()
{
   int      handle_htm, handle_csv, _GetLastError;
   string   calendarName = "", fileName = "", strHTM = "", strCSV = "";
   
   datetime StartWeek = GetWeekStart(gmtime);// + tz*3600);
   
   string StartDay, strStartWeek = TimeToStr(StartWeek);
      
   StartYear  = (string)TimeYear (StartWeek);
   if(TimeMonth(StartWeek) > 9) StartMonth = (string)TimeMonth(StartWeek); else StartMonth = "0" + (string)TimeMonth(StartWeek);
   if(TimeDay  (StartWeek) > 9) StartDay   = (string)TimeDay  (StartWeek); else StartDay   = "0" + (string)TimeDay  (StartWeek);
   
   string StartTime = StartYear + "." + StartMonth + "." + StartDay; 
   string CalName   = CalendarName + " " + StartTime;
   
   if(!ReadFromFile)
   {
   int handle = FileOpen(CalendarDirectory + "\\" + CalName + ".csv",FILE_READ|FILE_CSV,";");
   FileClose(handle);
        
   string WebAdress = "http://ec.forexprostools.com/";
   
   strHTM = "";
	
	strHTM = httpGET(WebAdress);
   
      if(strHTM != "" || StringFind(strHTM,"Access Denied",0) < 0) 
      {
         if(SaveHTMFormat)
         {
         handle_htm = FileOpen(CalendarDirectory + "\\" + CalName + ".htm",FILE_WRITE|FILE_CSV);   
            
            if(handle_htm > 0)
            {
            FileWrite(handle_htm,strHTM);
            FileClose(handle_htm);
            }
            else 
	         {
	         _GetLastError = GetLastError();
	         Print("LoadWeek() - FileOpen() Error #",_GetLastError,"!");
	         //return("");
	         }
	      }   
	     
	   strCSV = "";
	   Print( "LoadWeek(", StartTime, "): writing csv..." );   
	   handle_csv = FileOpen(CalendarDirectory + "\\" + CalName + ".csv",FILE_WRITE|FILE_CSV,";");   
	   
	      if(ConvertHTMtoCSV(StartWeek,strHTM,strCSV))
	      {   
	         if(handle_csv > 0)
	         {
		      FileWrite(handle_csv,strCSV);
		      FileClose(handle_csv);
	         }
	         else
	         {
		      _GetLastError = GetLastError();
		      Print("LoadWeek() - FileOpen() Error #",_GetLastError,"!");
		      return("");
	         }
	      }   
	   }
	}   
   
   return(CalendarDirectory + "\\" + CalName);   
}

bool ConvertHTMtoCSV(datetime StartWeekTime,string htm,string& csv)
{
	int month = 0;
	string year, day, time;
	
	int table_start = StringFind(htm,"<tbody pageStartAt>",0);
	int table_end	 = StringFind(htm,"</tbody>",table_start + 1);
	
	if(table_start < 0 || table_end < 0)
	{
	Alert("ConvertHTMtoCSV(",TimeToStr(StartWeekTime,TIME_DATE),"): invalid htm format!");
	return(false);
	}

	int curr_row = StringFind(htm,"<tr id=\"eventRow" ,table_start );//"<tr class=\"e-cal-row",table_start );
	int next_row = StringFind(htm,"<tr id=\"eventInfo",curr_row + 1);

	int	 rows_count	= 0;
	string rows[999];

	while(curr_row >= 0 && curr_row < table_end)
	{
	rows[rows_count] = StringSubstr(htm,curr_row,next_row - curr_row + 5);

	rows_count ++;
   
	curr_row = StringFind(htm,"<tr id=\"eventRow" ,curr_row + 1);
	next_row = StringFind(htm,"<tr id=\"eventInfo",curr_row + 1);
	}
   
	if(rows_count <= 0)
	{
	Alert("ConvertHTMtoCSV(",TimeToStr(StartWeekTime,TIME_DATE),"): invalid htm format (no rows in table)!" );
	return(false);
	}
   string startweek = GetVal(rows[0],"event_timestamp=\"","\" onclick=");
   StringReplace(startweek,"-",".");
	datetime		curDayTime	= StringToTime(startweek);//StartWeekTime;
	
	
	for(int r=0;r<rows_count;r++)
	{
	int	 columns_count	= 0;
	string columns[999];

	int curr_col = 0, next_col = 0;
   
		while(columns_count <= 8)
		{
		if(columns_count == 0) {curr_col = StringFind(rows[r],"<tr id="); next_col = StringFind(rows[r],";\">");}
		else {curr_col = StringFind(rows[r],"<td class=",curr_col + 1); next_col = StringFind(rows[r],"</td>",curr_col + 1);} 
		
		columns[columns_count] = StringSubstr(rows[r],curr_col,next_col - curr_col + 5);
	
		if(columns_count == 0) next_col = StringFind(rows[r],";\">",curr_col + 1); else next_col = StringFind(rows[r],"</td>",curr_col + 1);
		columns_count ++;
		}
 
		if(columns_count > 6)
		{
		   if(StringFind(columns[1],"center time") < 0) 
		   {
   		string timestamp = GetVal(columns[0],"event_timestamp=\"","\" onclick=");;
		   StringReplace(timestamp,"-",".");
		      
		   curDayTime = StringToTime(timestamp);
		
		   csv = StringConcatenate(csv,TimeToStr(curDayTime,TIME_DATE));
		
         time = TimeToStr(curDayTime,TIME_MINUTES);//GetVal(columns[0],">","</td>");
				
		   csv = StringConcatenate(csv,";",time);
			
  	      csv = StringConcatenate(csv,";",GetVal(columns[2],"</span> ","</td>"));
   		
		   string impact = GetVal(columns[3],"title=\""," Volatility");
		  
		      if(impact == "High"    ) impact = "H"; 
		      else 
		      if(impact == "Moderate") impact = "M";
		      else 
		      if(impact == "Low"     ) impact = "L";
		      else impact = "N";
         
         csv = StringConcatenate(csv,";",impact);   
		
		   string newevent = "";
		      
		      if(StringFind(columns[4],"Speaks") > 0) newevent = GetVal(columns[4],"left event\">","                        &nbsp;");
		      else 
		      if(StringFind(columns[4],"Preliminary Release") > 0) newevent = GetVal(columns[4],"left event\">","&nbsp;");
		      else newevent = GetVal(columns[4],"left event\">", "</td>"); 
		
		   csv = StringConcatenate(csv,";",newevent);
		
		      if(StringFind(columns[5],"greenFont") > 0) csv = StringConcatenate(csv,";",">");
		      else 
		      if(StringFind(columns[5],"redFont"  ) > 0) csv = StringConcatenate(csv,";","<");
		      else csv = StringConcatenate(csv,";","=");
		
		   string actual = GetVal(columns[5],"\">","</td>");
		   if(actual == "&nbsp;") actual = "";  	      
         csv = StringConcatenate(csv,";",actual);
		
		  
		   string forecast = GetVal(columns[6],"\">","</td>");
		   if(forecast == "&nbsp;") forecast = ""; 
		   csv = StringConcatenate(csv,";",forecast);
      
            if(StringFind(columns[7],"greenFont") > 0) csv = StringConcatenate(csv,";",">");
		      else 
		      if(StringFind(columns[7],"redFont"  ) > 0) csv = StringConcatenate(csv,";","<");
		      else csv = StringConcatenate(csv,";","=");
		
		   string previous = GetVal(columns[7],"\">","</td>");
		   if(previous == "&nbsp;") previous = ""; 
		   csv = StringConcatenate(csv,";",previous);
		
		   csv = StringConcatenate(csv,";\n");
		   }
		}
	}
	
	return(true);
}

string GetVal(string text,string s_from,string s_to)
{
	int len  = StringLen(s_from);
	int pos1 = StringFind(text,s_from,0);
	int pos2 = StringFind(text,s_to,pos1 + 1);

	if(pos2 == pos1 + len)
	{
	return("");
	}
	else
	{
		if(pos1 >= 0 && pos2 >= 0)
		{
		string res = StringSubstr(text,pos1 + len,pos2 - (pos1 + len));
		if(StringFind(res,"&lt") >= 0) res = stringReplace(res,"&lt","<");
		return( res );
		}
		else return("GetValError");
	}
}

string stringReplace(string InputString,string MatchedText,string NewText )
{
	string res;
	string temp, source;
	string first, third;
	int    pos, matchLength, k;
	
	source  = InputString;
	NewText = NewText;

	matchLength = StringLen(MatchedText);
	k = 0;
	while(StringFind(source,MatchedText) != -1)
 	{
 	pos = StringFind(source,MatchedText);
 		if(pos != -1)
    	{
    	if(pos != 0) first = StringSubstr(source,0,pos); else first="";
    	third  = StringSubstr(source,pos + matchLength,StringLen(source) - pos - matchLength);
    	temp   = StringConcatenate(first,NewText,third);
    	source = temp;
    	k++;
    	if(k > 2000) break;
    	}
 	}
	res = source; 
	return(res); 
}

int monthToNum(string month)
{
   if(month == "January"   ) return( 1);
   if(month == "February"  ) return( 2);
   if(month == "March"     ) return( 3);
   if(month == "April"     ) return( 4);
   if(month == "May"       ) return( 5);
   if(month == "June"      ) return( 6);
   if(month == "July"      ) return( 7);
   if(month == "August"    ) return( 8);
   if(month == "September" ) return( 9);
   if(month == "October"   ) return(10);
   if(month == "November"  ) return(11);
   if(month == "December"  ) return(12);
   
   return(0);
}

//-----   
void ChartComment()
{
   int i;
   string sComment   = "";
   string sp1        = "---------------------------------------------------\n";
   string NL         = "\n";
   string upcomNews  = "";
   string upcomTime  = "";
   string prevNews   = "";
   string prevTime   = "";
   string nextNews   = "";
   string nextTime   = "";
   string currevent  = "";
   string prevevent  = "";
   
   TotalProfit();    
   int prTime = 0; 
   int upTime = 0;
   int nxTime = 0;
   
   for(i=0;i<NewsNum;i++)
   { 
   if(StringLen(event[i]) > MaxEventLength)  currevent = StringSubstr(event[i],0,MaxEventLength-3 ) + "..."; else currevent = event[i];
            
      if((i == 0 && (int)dt[i] > 0 && TimeCurrent() <= dt[i])||(i > 0 && (int)dt[i] > 0 && dt[i-1] < dt[i] && TimeCurrent() > dt[i-1] && TimeCurrent() <= dt[i])||((int)dt[i] > 0 && upTime == dt[i] && TimeCurrent() <= dt[i]))
      {
         if(upTime == dt[i] && event[i] != event[i-1])   
         {
         upcomNews = upcomNews + (sCurrency[i] + "  " + sImpact[i] + "  " + currevent + NL); 
         upcomTime = TimeToStr(upTime);  
         }
         else
         {
         upcomNews = sCurrency[i] + "  " + sImpact[i] + "  " + currevent + NL; 
         upcomTime = TimeToStr(dt[i]);  
         }
      upTime = (int)dt[i];
      }   
         
      if(i > 0 && TimeCurrent() > dt[i-1] && (int)dt[i-1] > 0)
      {
      if(StringLen(event[i-1]) > MaxEventLength)  prevevent = StringSubstr(event[i-1],0,MaxEventLength-3 ) + "..."; else prevevent = event[i-1];
          
         if(prTime == dt[i-1] && event[i-1] != event[i-2])   
         {
         
         prevNews = prevNews + (sCurrency[i-1]+"  " + sImpact[i-1] + "  " + prevevent + NL); 
         prevTime = TimeToStr(prTime);
         }
         else
         {
         prevNews = sCurrency[i-1] + "  " + sImpact[i-1] + "  " + prevevent + NL; 
         prevTime = TimeToStr(dt[i-1]);
         }
      
      if(i == 0) {prevNews =""; prevTime = "";}  
      prTime = (int)dt[i-1];
      }
            
      if((int)dt[i] > 0 && upTime > 0 && upTime < dt[i])
      {
         if(dt[i] > nxTime && nxTime > 0) break;
         if(nxTime == dt[i] && event[i] != event[i-1])
         {      
         nextNews = nextNews + (sCurrency[i]+ "  " + sImpact[i] + "  " + currevent + NL);
         nextTime = TimeToStr(nxTime);
         }
         else
         {
         nextNews = sCurrency[i]+"  " + sImpact[i] + "  " + currevent + NL;
         nextTime = TimeToStr(dt[i]);
         }
      nxTime = (int)dt[i];
      }
   }
   
   int buy, sell, buylimit, selllimit, buystop, sellstop;
   int total = ScanTrades(buy, sell, buylimit, selllimit, buystop, sellstop);
   
   sComment = sp1;
   sComment = sComment + "ExpertName : " + ExpertName+NL;
   
   if(TimeZone >= 0)
   sComment = sComment + "Broker\'s Name :  "+AccountCompany()+ NL +"Time Zone : GMT + " + (string)tz + NL + sp1;
   else
   sComment = sComment + "Broker\'s Name :  "+AccountCompany()+ NL +"Time Zone : GMT - " + DoubleToStr(MathAbs(tz),0) + NL + sp1;
   sComment = sComment + "Time: Current= " + TimeToStr(TimeCurrent()) + NL;
   sComment = sComment + "Orders: Open= "+(string)(buy+sell)+" Pending= "+(string)(buylimit+selllimit+buystop+sellstop)+" Total= "+(string)total+NL;
   sComment = sComment + "Current Profit :  Pips = " + DoubleToStr(totalPips,2) + " " +AccountCurrency()+" = " + DoubleToStr(totalProfits,2) + NL + NL; 
   
   if(ShowCalendar)
   {
   sComment = sComment + "  N E W S :" + NL + NL;
   sComment = sComment + "- Previous  :  "   + prevTime  + NL + sp1 + prevNews  + NL;
   sComment = sComment + "- Upcoming :  "    + upcomTime + NL + sp1 + upcomNews + NL;
   sComment = sComment + "- Next        :  " + nextTime  + NL + sp1 + nextNews  + NL + sp1;
   }
   
   //sComment = sComment + "prevTime=" + TimeToStr(pEventTime) + " NewEvent=" + (string)NewEvent + NL;   
   
   string smins, ssecs;
   
   if(ECN_Mode)
   {
      if(OpenTime > 0)
      { 
      int mins = (int)(MathFloor(((OpenTime + OrderDuration*60) - TimeCurrent())/60.0));
      int secs = (int)((((OpenTime + OrderDuration*60) - TimeCurrent())/60.0 - mins)*60);
      
      if(mins < 10) smins = StringConcatenate("0",mins); else smins = (string)mins; 
      if(secs < 10) ssecs = StringConcatenate("0",secs); else ssecs = (string)secs;
      
      sComment = sComment +  "ACTIVE from " + TimeToStr(OpenTime,TIME_SECONDS) +"  "+ smins +":"+ ssecs + " min left";
      }
      else 
      sComment = sComment +  "NOT ACTIVE";
   }
   
   Comment(sComment);
}      

//-----   
void TotalProfit()
{
   int total = OrdersTotal();
   totalPips = 0;
   totalProfits = 0;
   
   for (int cnt=0;cnt<total;cnt++)
   { 
   if(!OrderSelect(cnt,SELECT_BY_POS)) continue;   
   int mode = OrderType();
   bool condition = false;
   if(Magic > 0 && OrderMagicNumber() == Magic) condition = true; else if(Magic == 0) condition = true;   
      if(condition)
      {      
         switch (mode)
         {
         case OP_BUY:
            totalPips    += MathRound((MarketInfo(OrderSymbol(),MODE_BID) - OrderOpenPrice())/_point);
            totalProfits += (OrderProfit() + OrderSwap() + OrderCommission());
            break;
            
         case OP_SELL:
            totalPips    += MathRound((OrderOpenPrice() - MarketInfo(OrderSymbol(),MODE_ASK))/_point);
            totalProfits += (OrderProfit() + OrderSwap() + OrderCommission());
            break;
         }
      }            
	}
}

//-----   
void ECN_StopAndProfit()
{
   int    k, error;  
   bool   result = false;
   double spread = Ask - Bid, BuyStop, BuyProfit, SellStop, SellProfit;
       
   for (int cnt=0;cnt<OrdersTotal();cnt++)
   { 
   if(!OrderSelect(cnt,SELECT_BY_POS)) continue;   
   if(OrderMagicNumber() != Magic || OrderSymbol() != Symbol()) continue;
   
   int mode = OrderType();    
      
      if((mode == OP_BUY || mode == OP_BUYLIMIT || mode == OP_BUYSTOP) && ECN_Buy != OrderTicket()) 
      {
		   if(InitialStop > 0) BuyStop   = OrderOpenPrice() - InitialStop*_point; else BuyStop   = OrderStopLoss();
         if(TakeProfit  > 0) BuyProfit = OrderOpenPrice() + TakeProfit *_point; else BuyProfit = OrderTakeProfit();  
			
		BuyStop   = NormalizeDouble(BuyStop  ,Digits);
		BuyProfit = NormalizeDouble(BuyProfit,Digits);     
			   
		   if((OrderStopLoss() == 0 && BuyStop > 0)||(OrderTakeProfit() == 0 && BuyProfit > 0)) 
         {   
			   for(k=0;k<TriesNum;k++)
            {
            result = OrderModify(OrderTicket(),NormalizeDouble(OrderOpenPrice(),Digits),
			                        BuyStop,
			                        BuyProfit,0,Lime);
      
            error = GetLastError();
               
               if(error == 0) 
               {
               ECN_Buy = OrderTicket(); 
               break;
               }
               else 
               {
               Print("BUY: OrderModify failed with error #",ErrorDescription(GetLastError()));
               Sleep(5000); 
               RefreshRates(); 
               continue;
               }
            }            
         }
      }   
// - SELL Orders          
      if((mode == OP_SELL || mode == OP_SELLLIMIT || mode == OP_SELLSTOP) && ECN_Sell != OrderTicket())
      {
         if(InitialStop > 0) SellStop   = OrderOpenPrice() + InitialStop*_point; else SellStop   = OrderStopLoss();
	      if(TakeProfit  > 0) SellProfit = OrderOpenPrice() - TakeProfit*_point;  else SellProfit = OrderTakeProfit();
			               
      SellStop   = NormalizeDouble(SellStop,Digits);
		SellProfit = NormalizeDouble(SellProfit,Digits);    
            
         if((OrderStopLoss() == 0 && SellStop > 0)||(OrderTakeProfit() == 0 && SellProfit > 0)) 
         {
            for(k=0;k<TriesNum;k++)
            {
            result = OrderModify(OrderTicket(),NormalizeDouble(OrderOpenPrice(),Digits),
			                        SellStop,
			                        SellProfit,0,Orange);
            
            error = GetLastError();
               
               if(error==0) 
               {
               ECN_Sell = OrderTicket(); 
               break; 
               }
               else 
               {
               Print("SELL: OrderModify failed with error #",ErrorDescription(GetLastError()));
               Sleep(5000); 
               RefreshRates(); 
               continue;
               }
            }   
   		}	    
      }
   }     
}

//-----   
string FormatDateTime(int nYear,int nMonth,int nDay,int nHour,int nMin,int nSec)
{
   string sMonth,sDay,sHour,sMin,sSec;
//----
   sMonth = (string)(100 + nMonth);
   sMonth = StringSubstr(sMonth,1);
   sDay   = (string)(100 + nDay);
   sDay   = StringSubstr(sDay,1);
   sHour  = (string)(100 + nHour);
   sHour  = StringSubstr(sHour,1);
   sMin   = (string)(100 + nMin);
   sMin   = StringSubstr(sMin,1);
   sSec   = (string)(100 + nSec);
   sSec   = StringSubstr(sSec,1);
//----
   return(StringConcatenate(nYear,".",sMonth,".",sDay," ",sHour,":",sMin,":",sSec));
}   

//-----   
#import "wininet.dll"
int InternetOpenW(string sAgent, int lAccessType=0, string sProxyName="", string sProxyBypass="", uint lFlags=0);
int InternetOpenUrlW(int hInternetSession, string sUrl, string sHeaders="", int lHeadersLength=0, uint lFlags=0, int lContext=0);
int InternetReadFile(int hFile, uchar& sBuffer[], int lNumBytesToRead, int& lNumberOfBytesRead[]);
int InternetCloseHandle(int hInet);
#import

#define INTERNET_FLAG_PRAGMA_NOCACHE    0x00000100 // Tell proxy not to read cache
#define INTERNET_FLAG_NO_CACHE_WRITE    0x04000000 // Don't write cache
#define INTERNET_FLAG_RELOAD            0x80000000 // Don't read cache
#define INTERNET_AGENT                  "Mozilla/4.0 (compatible; MT4-News/1.0;)"
#define INTERNET_READ_BUFFER_SIZE       4096

string httpGET(string url)
{
   uint flags = INTERNET_FLAG_NO_CACHE_WRITE | INTERNET_FLAG_PRAGMA_NOCACHE | INTERNET_FLAG_RELOAD;
   int inetsesshandle = InternetOpenW(INTERNET_AGENT);
   
   if(inetsesshandle == 0) return("Error: InternetOpen");
  
   int ineturlhandle = InternetOpenUrlW(inetsesshandle,url,NULL,0,flags);
  
   if(ineturlhandle == 0) {InternetCloseHandle(inetsesshandle); return("Error: InternetOpenUrl");}
  
   int lreturn[1], ineterr = 0;
   uchar buffer[INTERNET_READ_BUFFER_SIZE];
   string content = "";
  
   while (!IsStopped())
   {
   if(InternetReadFile(ineturlhandle,buffer,INTERNET_READ_BUFFER_SIZE,lreturn) == 0){content="Error: InternetReadFile"; break;}
   
   if(lreturn[0] <= 0) break;
   content = content + CharArrayToString(buffer,0,lreturn[0],CP_ACP);
   }
   
   InternetCloseHandle(ineturlhandle);
   InternetCloseHandle(inetsesshandle);
   
   return(content);
}
               
//+------------------------------------------------------------------+
//| expert deinitialization function                                 |
//+------------------------------------------------------------------+
int deinit()
  {
//---- 
   ObjectDel(uniqueName);
   Comment("");
//----
   
   return(0);
  }
//+------------------------------------------------------------------+
//| expert start function                                            |
//+------------------------------------------------------------------+
int start()
{
   if(iBars(Symbol(),0) < 100) {Print("Bars=",iBars(Symbol(),0)," < 100!"); return(0);}
   if(GetLastError() == 134)   {Print("We have no money. Free Margin = ", AccountFreeMargin()); return(0);}
   if(!IsTradeAllowed())    {Print("Trade is not allowed!"); return(0);}
   if(IsTradeContextBusy()) {Print("Trade context is busy. Please wait"); return(0);} 
//---- 
//---- 
   if(UseAutoTimeZone)
   {
   if(counter <  4) {TimeCurrent(); counter++; Comment("Please wait! ",4 - counter," ticks left"); return(0);}
   if(counter == 4) Comment(""); 
   }
      
   datetime currentWeekTime = iTime(NULL,PERIOD_W1,0);
                
   if(TimeCurrent() - currentWeekTime > PERIOD_W1*60) return(0);
 
   if(firstTime || (TimeCurrent() > currentWeekTime && currentWeekTime > prevWeekTime))
   {
   gmtime = TimeGMT();
   
   if(UseAutoTimeZone) tz = (int)MathMin(NormalizeDouble((TimeCurrent() - gmtime)/3600.0,0),24); else tz = TimeZone; 
   
   string calName = economicCalendar();
   
      if(calName != "")
      {   
      ObjectDel(uniqueName);
      ReadnPlotCalendar(calName + ".csv");
      firstTime    = false;
      prevWeekTime = currentWeekTime;
      }
      else return(0);
   }
   
   int buy, sell, buylimit, selllimit, buystop, sellstop, cnt;
   int trades  = ScanTrades(buy, sell, buylimit, selllimit, buystop, sellstop);
   int open    = buy + sell;
   int pending = buylimit + buystop + selllimit + sellstop;
   
   if(ShowComments) ChartComment();
   
   NewEvent = IsNewEvent(); 
   
   if(IsTesting() || IsVisualMode())
   {
      if(!NewEvent && trades < 1) return(0);
   } 
   
   if(trades > 0)
   {
      if(DeleteOpposite)
      {
         if(buy  > 0) PendOrdDel(2); //while(ScanTrades(2,2) > 0) 
         if(sell > 0) PendOrdDel(1); //while(ScanTrades(1,2) > 0) 
          
         if(open == 0 && (buystop == 0 || sellstop == 0)) PendOrdDel(0);
      }      
      
      datetime FinTime = FinishTime(OrderDuration); 
      if(TimeCurrent() >= FinTime) PendOrdDel(0); //while(ScanTrades(0,2) > 0) 
      
      datetime EndTime;
      
      if(DayOfWeek() != 5) EndTime = StrToTime((string)SessionEndHour+":00") - Period()*60; 
      else EndTime = StrToTime((string)FridayEndHour+":00") - Period()*60;
      
      bool EOD = false;
      EOD = TimeCurrent() >= EndTime;
      
      if(NewEvent || EOD)
      {
         while(trades > 0) 
         {
         if(CloseOnNewEvent) CloseOrder(0); 
         PendOrdDel(0);
         trades = ScanTrades(buy, sell, buylimit, selllimit, buystop, sellstop);
         } 
      }
     
      if(ECN_Mode && trades > 0) ECN_StopAndProfit();
      
      if(open > 0 && (TrailingStop > 0 || BreakEven > 0)) TrailStop(TrailingStop,TrailingStep,BreakEven,PipsLock);
   
      if(TrailOpposite && !DeleteOpposite)
      {
         if(buy  > 0 && sellstop > 0) TrailOppositeOrder(2); 
         if(sell > 0 && buystop  > 0) TrailOppositeOrder(1);
      }   
   }
   
   if(ECN_Mode && NewEvent && trades < 1) 
   {
   BuyEvent  = 0; 
   SellEvent = 0; 
      
      for(cnt=0;cnt<OrdersNum;cnt++)
      {
      BuyNum[cnt]  = 0;
      SellNum[cnt] = 0;    
      }   
   
   ObjectDel(uniqueName + " arr");
   }
         
   double BuyStop, BuyProfit, SellStop, SellProfit;
   
   if((!ECN_Mode && pending < OrdersNum) || (ECN_Mode && trades < OrdersNum))
   { 
   OpenTime = TimeToOpen();
   //Print("OpT=",TimeToStr(OpenTime));
      if(OpenTime > 0)
      {
      
      double BuyPrice  = iMA(NULL,TimeFrame,1,0,0,HiPrice,PriceShift); //MarketInfo(Symbol(),MODE_ASK);   
      double SellPrice = iMA(NULL,TimeFrame,1,0,0,LoPrice,PriceShift);   
         
         for(cnt=1;cnt<=OrdersNum;cnt++)
         {
            if(!ECN_Mode)
		      {
		      double oBuyPrice = BuyPrice + (PendOrdGap + OrdersStep*(cnt - 1))*_point;
		      if (InitialStop > 0) BuyStop   = oBuyPrice - InitialStop*_point; else BuyStop   = 0;
            if (TakeProfit  > 0) BuyProfit = oBuyPrice + TakeProfit*_point ; else BuyProfit = 0;   
            BuyOrdOpen(OP_BUYSTOP,oBuyPrice,BuyStop,BuyProfit,cnt); 
            }
            else
            if(ECN_Mode && ((!Straddle_Mode && sell == 0) || Straddle_Mode))
            {
            BuyStop   = 0; 
            BuyProfit = 0;
               if(BuyEvent == 0)
               {
               BuyLevel[cnt-1] = BuyPrice + (PendOrdGap+OrdersStep*(cnt-1))*_point;
                  if (DisplayLevels)
                  {         
                  ObjectCreate (uniqueName + " arrbl "+(string)cnt,OBJ_ARROW,0,OpenTime,BuyLevel[cnt-1]);
                  ObjectSet    (uniqueName + " arrbl "+(string)cnt,OBJPROP_ARROWCODE,1);
                  ObjectSet    (uniqueName + " arrbl "+(string)cnt,OBJPROP_COLOR,clrLightBlue);                    
                  ObjectSetText(uniqueName + " arrbl "+(string)cnt,Symbol() + " " + "Buy Level #" + (string)cnt,8);          
                  }
               
               if(cnt == OrdersNum) BuyEvent = 1;
               } 
                              
               if(Ask >= BuyLevel[cnt-1] && pAsk < BuyLevel[cnt-1] && !VerifyComment(1,cnt) && BuyNum[cnt-1] == 0)
               { 
               BuyOrdOpen(OP_BUY,Ask,BuyStop,BuyProfit,cnt); 
               }
            }
         
            if(!ECN_Mode)
		      {
            double oSellPrice = SellPrice - (PendOrdGap+OrdersStep*(cnt-1))*_point;
		      if (InitialStop > 0) SellStop  = oSellPrice + InitialStop*_point; else SellStop=0;
            if (TakeProfit  > 0) SellProfit= oSellPrice - TakeProfit*_point ; else SellProfit=0;
            SellOrdOpen(OP_SELLSTOP,oSellPrice,SellStop,SellProfit,cnt);
            }
            else
            if(ECN_Mode && ((!Straddle_Mode && buy == 0) || Straddle_Mode))
            {
            SellStop   = 0; 
            SellProfit = 0;
               if(SellEvent == 0)
               {
               SellLevel[cnt-1] = SellPrice - (PendOrdGap+OrdersStep*(cnt-1))*_point;
                  if (DisplayLevels)
                  {         
                  ObjectCreate (uniqueName + " arrsl "+(string)cnt,OBJ_ARROW,0,OpenTime,SellLevel[cnt-1]);
                  ObjectSet    (uniqueName + " arrsl "+(string)cnt,OBJPROP_ARROWCODE,2); 
                  ObjectSet    (uniqueName + " arrsl "+(string)cnt,OBJPROP_COLOR,clrTomato);                    
                  ObjectSetText(uniqueName + " arrsl "+(string)cnt,Symbol() + " " + "Sell Level #" + (string)cnt,8);          
                  }
               if(cnt == OrdersNum) SellEvent = 1;
               } 
               
               if(Bid <= SellLevel[cnt-1] && pBid > SellLevel[cnt-1] && !VerifyComment(2,cnt) && SellNum[cnt-1] == 0)
               { 
               SellOrdOpen(OP_SELL,Bid,SellStop,SellProfit,cnt);
               }
            }
         }
      }
   }
   
   pBid = Bid; 
   pAsk = Ask;  
      
   return(0);
}
//+------------------------------------------------------------------+





