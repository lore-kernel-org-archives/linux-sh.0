From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 25 Aug 2015 00:13:41 +0000
Subject: Re: [PATCH 01/25 v7][RFC] clk: shmobile: add Renesas R-Car Gen3 CPG support
Message-Id: <87twro6xf2.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87r3mt77ek.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87r3mt77ek.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Geert

> > +/*
> > + *   MD                EXTAL           PLL0    PLL1    PLL2    PLL3    PLL4
> > + * 14 13 19 17 (MHz)           *1      *1      *1
> > + *-------------------------------------------------------------------
> > + * 0  0  0  0  16.66 x 1       x180/2  x192/2  x144/2  x192    x144
> > + * 0  0  0  1  16.66 x 1       x180/2  x192/2  x144/2  x128    x144
> > + * 0  0  1  0  Prohibited setting
> > + * 0  0  1  1  16.66 x 1       x180/2  x192/2  x144/2  x192    x144
> > + * 0  1  0  0  20    x 1       x150/2  x156/2  x120/2  x156    x120
> > + * 0  1  0  1  20    x 1       x150/2  x156/2  x120/2  x106    x120
> > + * 0  1  1  0  Prohibited setting
> > + * 0  1  1  1  20    x 1       x150/2  x156/2  x120/2  x156    x120
> > + * 1  0  0  0  25    x 1       x120/2  x128/2  x96/2   x128    x96
> > + * 1  0  0  1  25    x 1       x120/2  x128/2  x96/2   x84     x96
> > + * 1  0  1  0  Prohibited setting
> > + * 1  0  1  1  25    x 1       x120/2  x128/2  x96/2   x128    x96
> > + * 1  1  0  0  33.33 / 2       x180/2  x192/2  x144/2  x192    x144
> > + * 1  1  0  1  33.33 / 2       x180/2  x192/2  x144/2  x128    x144
> > + * 1  1  1  0  Prohibited setting
> > + * 1  1  1  1  33.33 / 2       x180/2  x192/2  x144/2  x192    x144
> > + *
> > + * *1 : datasheet indicates VCO output (PLLx = VCO/2)
> 
> Do we want to have "pll1" output half the frequency of "PLL1"?
> While most dividers are fed by "PLL1/2", "RPCSRC" is fed by "PLL1".
> 
> On Gen2 we had "pll1_div2_clk" in DT.

This was very un-understandable point of datasheet.
as *1 mentioned, it is VCO/2, not PLL1/2
Next datasheet will update this un-understandable explain.

# Because these patch-set are based on this CPG driver,
# it doesn't indicate "Local" on Subject, but my understanding is that
# this patch (= CPG + MSTP ?) will be updated by Geert ?
# This patch is not cleanly created
