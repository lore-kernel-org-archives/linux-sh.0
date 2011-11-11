From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 11 Nov 2011 08:30:46 +0000
Subject: Re: Question about clk->usecount
Message-Id: <8739dv9i2x.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87fwihj3x8.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fwihj3x8.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Paul

> > But I have 1 thing to worry about on this rough patch.
> > it is clock parent.
> > I'm not sure who/how control clock parent.
(snip)
> Incidentally I also seem to see some issues on SH7786 with the late clock
> disabling and runtime PM built in, even though there really isn't any
> specific runtime PM support for the platform. I expect we're somehow
> getting in to a refcounting war somehow which is causing unexpected
> disabling behaviour.
> 
> I'll see about getting runtime PM support properly enabled on SH7786 to
> see if the issues persist, but for now I'm just leaving it turned off.
> You may wish to see if that also helps in your case.

Thank you.
I try it when I had free time.

Best regards
---
Kuninori Morimoto
