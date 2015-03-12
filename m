From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 12 Mar 2015 00:15:53 +0000
Subject: Re: [PATCH] dmaengine: remove Renesas Audio DMAC peri peri
Message-Id: <87r3svf4v2.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87oao1sjzp.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87oao1sjzp.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Geert

Thank you for your feedback

> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> You can add my
> 
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> if you add the removal of the DT bindings in
> Documentation/devicetree/bindings/dma/rcar-audmapp.txt

Oops ! I have forgotten about it.

> Afer that, there's still a reference in
> arch/arm/configs/multi_v7_defconfig:CONFIG_RCAR_AUDMAC_PP=m
> but that should be handled in a separate patch.

Hmm indeed..

I would like to this in v2
 [1/2] remove dampp from driver/Kconfig/Makefile and DT txt
 [2/2] remove CONFIG_RCAR_AUDMAC_PP under arch/arm/configs

