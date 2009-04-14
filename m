From: morimoto.kuninori@renesas.com
Date: Tue, 14 Apr 2009 05:01:47 +0000
Subject: Re: [Review request] sh-sci clock
Message-Id: <ueivv3k1w.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <ur5zxgnmk.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <ur5zxgnmk.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Paul

I'm sorry I took miss on explain

> > Current SCIFA use module_clk,
> > and above calculation for SH7723 is (mey be) depend on ap325 board.
> > module_clk of ap325 is 33MHz and bus_clk is 66MHz,
> > mey be (clk*2) mean it.
> > But ms7724se module_clk is 33MHz and bus_clk is 83MHz.
> > So, ms7724se board's SCIFA can not work on it.

This explain was wrong.
bus_clk = module_clk * 2 is correct on SH7723/SH7724

I'm sorry again.

But SCBRR calculation is wrong. I will send patch.

Best regards
--
Kuninori Morimoto
 
