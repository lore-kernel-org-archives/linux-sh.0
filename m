From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 14 Apr 2009 03:08:13 +0000
Subject: Re: [Review request] sh-sci clock
Message-Id: <20090414030812.GC17618@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <ur5zxgnmk.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <ur5zxgnmk.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Apr 14, 2009 at 11:08:50AM +0900, morimoto.kuninori@renesas.com wrote:
> > >  static inline int scbrr_calc(struct uart_port *port, int bps, int clk)
> > >  {
> > >  	if (port->type = PORT_SCIF)
> > > -		return (clk+16*bps)/(32*bps)-1;
> > > +		return (clk/(32*bps))-1;
> > >  	else
> > > -		return ((clk*2)+16*bps)/(16*bps)-1;
> > > +		return (clk/(16*bps))-1;
> > >  }
> > >  #define SCBRR_VALUE(bps, clk) scbrr_calc(port, bps, clk)
> > >  #elif defined(__H8300H__) || defined(__H8300S__)
> > 
> > This looks like an unrelated change, can you explain what this is about?
> 
> When SCIFA of SH7723/SH7724 use bus_clk,
> SCBRR value calculation will be changed.
> 
> Current SCIFA use module_clk,
> and above calculation for SH7723 is (mey be) depend on ap325 board.
> module_clk of ap325 is 33MHz and bus_clk is 66MHz,
> mey be (clk*2) mean it.
> But ms7724se module_clk is 33MHz and bus_clk is 83MHz.
> So, ms7724se board's SCIFA can not work on it.
> 
Ok.

> And current SCIF(SCIFA also) calculation is wrong.
> I don't know why this calculation is used.
> 
Good question.. lets see what git blame has to say about it:

pmundt@dysnomia ~/devel/git/linux-2.6 $ git show ba1d2818
commit ba1d28181c586deec468cc6ae558c0c099f1b956
Author: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date:   Fri Oct 3 17:37:31 2008 +0900

    serial: sh-sci: Add support SCIF of SH7723

    SH7723 has two types of SCIF (SCIF and SCIFA).
    The current sh-sci driver supports only SCIFA, and calculation methods of SCBRR
    are different.
    This patch support this methods.

    Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
    Signed-off-by: Paul Mundt <lethal@linux-sh.org>

diff --git a/drivers/serial/sh-sci.h b/drivers/serial/sh-sci.h
index 511c10d..7cd28b2 100644
--- a/drivers/serial/sh-sci.h
+++ b/drivers/serial/sh-sci.h
@@ -789,7 +789,14 @@ static inline int sci_rxd_in(struct uart_port *port)
       defined(CONFIG_CPU_SUBTYPE_SH7721)
 #define SCBRR_VALUE(bps, clk) (((clk*2)+16*bps)/(32*bps)-1)
 #elif defined(CONFIG_CPU_SUBTYPE_SH7723)
-#define SCBRR_VALUE(bps, clk) (((clk*2)+16*bps)/(16*bps)-1)
+static inline int scbrr_calc(struct uart_port *port, int bps, int clk)
+{
+       if (port->type = PORT_SCIF)
+               return (clk+16*bps)/(32*bps)-1;
+       else
+               return ((clk*2)+16*bps)/(16*bps)-1;
+}
+#define SCBRR_VALUE(bps, clk) scbrr_calc(port, bps, clk)
 #elif defined(__H8300H__) || defined(__H8300S__)
 #define SCBRR_VALUE(bps, clk) (((clk*1000/32)/bps)-1)
 #else /* Generic SH */

> return (clk+16*bps)/(32*bps)-1;
> =>
> return clk/(32*bps) - 1/2;
> 
> This calculation might be OK by lucky. 
> 
I have not looked at the SCIFA SCBRR algorithm, though it seems Iwamatsu-san
has.

Please split this part of the patch out separately, and get some feedback
from Iwamatsu-san on it to make sure it doesn't break any boards. Maybe
there is some strange Hitachi ULSI board with magical clock settings.. or
someone copied the wrong line from the manual (possibly because the data
sheet was suffering from accuracy problems).. :-)
