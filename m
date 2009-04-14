From: morimoto.kuninori@renesas.com
Date: Tue, 14 Apr 2009 02:08:50 +0000
Subject: Re: [Review request] sh-sci clock
Message-Id: <uiql82dhp.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <ur5zxgnmk.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <ur5zxgnmk.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Paul

> >  static inline int scbrr_calc(struct uart_port *port, int bps, int clk)
> >  {
> >  	if (port->type = PORT_SCIF)
> > -		return (clk+16*bps)/(32*bps)-1;
> > +		return (clk/(32*bps))-1;
> >  	else
> > -		return ((clk*2)+16*bps)/(16*bps)-1;
> > +		return (clk/(16*bps))-1;
> >  }
> >  #define SCBRR_VALUE(bps, clk) scbrr_calc(port, bps, clk)
> >  #elif defined(__H8300H__) || defined(__H8300S__)
> 
> This looks like an unrelated change, can you explain what this is about?

When SCIFA of SH7723/SH7724 use bus_clk,
SCBRR value calculation will be changed.

Current SCIFA use module_clk,
and above calculation for SH7723 is (mey be) depend on ap325 board.
module_clk of ap325 is 33MHz and bus_clk is 66MHz,
mey be (clk*2) mean it.
But ms7724se module_clk is 33MHz and bus_clk is 83MHz.
So, ms7724se board's SCIFA can not work on it.

And current SCIF(SCIFA also) calculation is wrong.
I don't know why this calculation is used.

return (clk+16*bps)/(32*bps)-1;
=>
return clk/(32*bps) - 1/2;

This calculation might be OK by lucky. 


Best regards
--
Kuninori Morimoto
 
