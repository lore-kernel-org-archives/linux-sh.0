From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Tue, 05 Aug 2014 08:57:01 +0000
Subject: Re: [PATCH] clk: shmobile: add missing 0x0100 for SDCKCR
Message-Id: <87lhr31fhf.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87ppgf1kgv.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87ppgf1kgv.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Geert

> > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> >
> > Current cpg_sd01_div_table is missing
> > "0x0100: x 1/8" division ratio.
> > This patch is based on R-Car H2 v0.7, R-Car M2 v0.9.
> >
> > Reported-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> BTW, has this been verified by testing, or is it purely based on the datasheet?

Thank you for your feedback.
I can understand your distrust :)
I just checked datasheet, but, BSP team had tested it.

Best regards
---
Kuninori Morimoto
