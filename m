From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 15 Oct 2013 00:47:52 +0000
Subject: Re: [PATCH 06/10] ARM: shmobile: r8a7778: add SDHI support on DTSI
Message-Id: <87vc0ze4wa.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87d2nc1fi8.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87d2nc1fi8.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Magnus, Simon

> > "The name of a node should be somewhat generic, reflecting the
> > function of the device and not its precise programming model." So I
> > suggest using "mmc" or "sd" instead.
> > 
> > [1] http://www.power.org/resources/downloads/Power_ePAPR_APPROVED_v1.0.pdf
> 
> Morimoto-san,
> 
> would it be possible for you to either update this patch or provide a
> subsequent incremental to use "mmc" or "sd" as Sergei suggests. I have a
> slight preference for "mmc" but please use your own judgement.
> 
> If you could also provide patches to update existing dts/dtsi files
> that would be awesome.

I see.
But, we already have both SDHI and MMCIF now.
I guess below naming seems good.

 - SDHI  -> sd
 - MMCIF -> mmc

what do you think ?



Best regards
---
Kuninori Morimoto
