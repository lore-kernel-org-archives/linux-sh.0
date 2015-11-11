From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 11 Nov 2015 09:03:04 +0000
Subject: Re: [PATCH] i2c: rcar: make sure clocks are on when doing hw init
Message-Id: <87wptoewvw.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1446146356-26166-1-git-send-email-wsa@the-dreams.de>
	<87io5pgrcr.wl%kuninori.morimoto.gx@renesas.com>
	<20151111082606.GA24344@katana>
In-Reply-To: <20151111082606.GA24344@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>


Hi Wolfram

> >      pm_runtime_get_sync()
> >      myfunc_A()
> >      pm_runtime_put()
> >      ...
> >      pm_runtime_get_sync()
> >      myfunc_B()
> >      pm_runtime_put()
> > 
> > It should be this ?
> > 
> >      pm_runtime_get_sync()
> >      myfunc_A()
> >      myfunc_B()
> >      pm_runtime_put()
> 
> This is for power-off case, right? Wouldn't it be clearer then to add a
> resume function to pm_ops of the I2C driver which reinit the registers?
> Doing it before every transfer might be simpler but is also a bit
> implicit or subtle, I'd think.
> 
> And for completeness: The above is only for the power-off case. In
> module-standby (MSTP bits), register values are always retained.
> Correct?

I'm not sure detail of pm_runtime, but it depends on
power-domain support ?
On SH-Mobile case, it automatically power-off:ed if all driver
user was gone. This feature is not yet supported on R-Car case I think.
So, both case are not problem at this point, but 1st case will be
problem if power-domain was suppored.
(If my memory was correct...)
