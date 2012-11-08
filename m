From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 08 Nov 2012 05:56:33 +0000
Subject: Re: [PATCH 0/8] ARM: shmobile: board used FSI driver's clock
Message-Id: <87sj8kzlgy.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87625g23os.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87625g23os.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

> > Kuninori Morimoto (8):
> >   1) ARM: shmobile: add fsi external clock on r8a7740
> >   2) ARM: shmobile: add fsi external clock sh7372
> >   3) ARM: shmobile: mackerel: enable DMAEngine on USB Host
> >   4) ARM: shmobile: use FSI driver's audio clock on armadillo800eva
> >   5) ARM: shmobile: use FSI driver's audio clock on mackerel
> >   6) ARM: shmobile: use FSI driver's audio clock on ap4evb
> >   7) ARM: shmobile: sh7372: remove fsidivx clock
> >   8) ARM: shmobile: sh7372: sh7372_fsiXck_clk become non-global
(snip)
> Thanks, I plan to apply 1, 2, 7 & 8 to the soc branch of the renesas tree and;
> 3 - 6 to the boards branch of the reneas stree.
> 
> However, I am getting conflicts when applying your patches.
> Could you either:
> 
> 1. Split the series in two
> 
>    a) 1, 2, 7 & 8 based on the soc branch of the renesas tree and;
>    b) 3 - 6 based on the boards branch of the renesas tree
> 
> 2. Rebase the series on the next branch in the renesas tree.

I see, but I couldn't.
Because FSI patch-set depends on FSI-DVI patch

d5a1a6ca8c142a9b0b1120d303ee90e86a7e83c2
(ARM: shmobile: sh7372: use sh_clk_fsidiv_register() for FSI-DIV clocks)

and I find it on simon/boards branch (not soc branch).
                 ~~~~~~~~~~~~

What should I do in this case ?

Best regards
---
Kuninori Morimoto
