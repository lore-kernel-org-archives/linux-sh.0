From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 09 Aug 2012 04:53:05 +0000
Subject: Re: irqdomain breaks ap4 boot
Message-Id: <87hasc3bv5.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <878vdxd3mq.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <878vdxd3mq.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Paul

Thank you for your hard work

> commit 1026023705b0baa2b37df2a0d1da0022fc7b985e
> Author: Paul Mundt <lethal@linux-sh.org>
> Date:   Thu Aug 9 12:59:40 2012 +0900
> 
>     sh: intc: Handle domain association for sparseirq pre-allocated vectors.
>     
>     Presently it's assumed that the irqdomain code handles the irq_desc
>     allocation for us, but this isn't necessarily the case when we've
>     pre-allocated IRQs via sparseirq. Previously we had a -EEXIST check in
>     the code that attempted to trap these cases and simply update them
>     in-place, but this behaviour was inadvertently lost in the transition to
>     irqdomains.
>     
>     This simply restores the previous behaviour, first attempting to let the
>     irqdomain core fetch the allocation for us, and falling back to an
>     in-place domain association in the extant IRQ case. Fixes up regressions
>     on platforms that pre-allocate legacy IRQs (specifically ARM-based
>     SH-Mobile platforms, as SH stopped pre-allocating vectors some time ago).
>     
>     Reported-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>     Signed-off-by: Paul Mundt <lethal@linux-sh.org>

This patch solved mackerel board crush bug on linus/master


Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Best regards
---
Kuninori Morimoto
