From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 25 Nov 2015 06:45:14 +0000
Subject: Re: [PATCH v2][RFC] pinctrl: sh-pfc: share/reuse same PORT_GP_x() macros
Message-Id: <87k2p67fbt.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87io5ajkz9.wl%kuninori.morimoto.gx@renesas.com>
	<CAMuHMdWSiq3Pna3yxRSYFgZeTMeLYgHaxp115qA-zxw=Ri-BXg@mail.gmail.com>
	<877flmjnp5.wl%kuninori.morimoto.gx@renesas.com>
	<11321076.yAsIxzsHHx@avalon>
In-Reply-To: <11321076.yAsIxzsHHx@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linus Walleij <linus.walleij@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>


Hi LinusW, Laurent, Geert

> > I think your idea was good, but unfortunately we can't use it.
> > Laurent, what do you think about this patch ?
> 
> It would be great to have a more powerful C preprocessor to create a single 
> macro that would take the number of pins as a parameter. I think C++ templates 
> could do so ;-)
> 
> I think your patch is indeed the best that can be done.
> 
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks

>> LinusW ? Geert ?

Is it possible to pickup this patch ?
