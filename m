From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 22 Jan 2015 07:04:26 +0000
Subject: Re: [PATCH 1/6 v5] dmaengine: rcar-audmapp: independent from SH_DMAE_BASE v1
Message-Id: <87egqnl2h9.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87wq4ib4xw.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87wq4ib4xw.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Arnd

> How? shdma_chan_filter has this code
> 
>         /* Only support channels handled by this driver. */
>         if (chan->device->device_alloc_chan_resources !>             shdma_alloc_chan_resources)
>                 return false;
> 
> and that is only used by shdma_init(), which is called from
> shdmac.c, sudmac.c, rcar-audmapp.c and rcar-hpbdma.c, but not
> rcar-dmac.c
> 
> > From compatibility/complexity from point of view,
> > "audmapp independent from SH_DMAE_BASE" is easier than
> > "fixup SH_DMAE_BASE for DT".
> > Because no other R-Car SoC DMAC uses SH_DMAE_BASE driver
> 
> Wouldn't this be enough to fix the bug (short term and for
> backports, not in the long run)?

Thanks !
I double checked audmapp's issue, and your idea seems solved
my problem.

> On a related topic, it seems you are very close to removing the
> legacy sh_dmae_slave_config/hpb_dmae_slave_config arrays, the
> only drivers that still rely on them are sound/soc/sh/siu_pcm.c,
> drivers/usb/renesas_usbhs/fifo.c and drivers/tty/serial/sh-sci.c.
> After those are converted to use dma_slave_config() and the normal
> filter functions, a lot of obsolete code and data could just
> go away.

OK. I will investigate and work for these.

Best regards
---
Kuninori Morimoto
