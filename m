From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 09 Feb 2015 01:37:41 +0000
Subject: Re: [PATCH 0/3 v3][RFC] dmaengine: rcar-audmapp: calculate chcr via src/dst addr
Message-Id: <87h9uvx3rs.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87mw4xey70.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87mw4xey70.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Vinod, Arnd

Can I have feedback from you about below mail, and this patch ?

http://thread.gmane.org/gmane.linux.ports.sh.devel/41063/focusC372

> Hi all
> 
> These are v3 of rcar-audmapp driver as [RFC].
> We can reduce Audio DMAC peri peri DT entry 220 -> 22 node by these patches.
> 
> Actually, sound driver side needs update for this rcar-audmapp update,
> but it doesn't include these patches at this point.
> These are focuing about rcar-audmapp only at this point.
> 
> Main change on this version is that audmapp driver assumes DTS has reg-names
> 
> Kuninori Morimoto (3):
>       dmaengine: rcar-audmapp: calculate chcr via src/dst addr
>       ARM: shmobile: r8a7790: add SSIU/DTCP/MLM/SCU reg for Audio DMAC peri peri
>       ARM: shmobile: r8a7790: enables Audio DMAC peri peri entry on DTSI
> 
>  arch/arm/boot/dts/r8a7790.dtsi |   26 ++++++-
>  drivers/dma/sh/rcar-audmapp.c  |  164 +++++++++++++++++++++++++++++++++++++---
>  2 files changed, 175 insertions(+), 15 deletions(-)
> 
> Best regards
> ---
> Kuninori Morimoto
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Best regards
---
Kuninori Morimoto
