From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 05 Apr 2013 02:12:17 +0000
Subject: Re: [PATCH 0/6] ARM: shmobile: r8a73a4: detailed clock topology support
Message-Id: <87txnlk9oh.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87bo9x5h1h.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87bo9x5h1h.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon, Magnus

> > These patches adds detailed r8a73a4 clock topology support.
> > These patches are tested on APE6EVM board.
> > 
> > Kuninori Morimoto (6):
> >       clk: sh: add sh_clk_reparent_register()
> >       ARM: shmobile: r8a73a4: add main clock
> >       ARM: shmobile: r8a73a4: add pll clocks
> >       ARM: shmobile: r8a73a4: add div4 clocks
> >       ARM: shmobile: r8a73a4: add div6 clocks
> >       ARM: shmobile: ape6evm: MP clock parent become EXTAL2
> 
> These seem sane to me.
> 
> Magnus, can I get a review from you?

I talked about this patch set with Magnus few days ago,
and I guess Magnus don't like [1/6] patch (= new API).
I will re-post v2 patches.

Best regards
---
Kuninori Morimoto
