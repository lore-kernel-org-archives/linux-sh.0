From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 25 Nov 2013 00:17:42 +0000
Subject: Re: [PATCH 5/6] ARM: shmobile: r8a7790: tidyup clock table order
Message-Id: <87siulnxlo.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8738msep7z.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8738msep7z.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Sergei

> >>      I disagree because the clocks declared via CLKDEV_ICK_ID() are by nature
> >> the same MSTP clocks as the others. This patch looks dangerously close to the
> >> needless churn IMHO.
> 
> >  From MSTP grouping point of view, you are correct.
> >  From PM-Runtime/Clock API point of view, this patch is sane.
> 
>     Please explain what it adds from this PoV. And if this patch is going to 
> be accepted, I at least would like the dubious "ICK" comment to be removed.

Your opinion which is focusing about MSTP grouping is only for r8a7790.
This patch-set is focusing whole SH-ARM SoC.
We don't need minor rule which breaks source code uniformity.
I don't know what is the best comment instead of "ICK",
but, kernal hacker can understand without full explanation ?
