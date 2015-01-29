From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 29 Jan 2015 06:45:02 +0000
Subject: Re: [PATCH 0/2 v5] dmaengine: rcar-audmapp: independent from SH_DMAE_BASE
Message-Id: <87zj92rspd.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8761ekokpf.wl%kuninori.morimoto.gx@renesas.com>
	<5155160.jFIrOp4XSG@avalon>
	<877fwab63w.wl%kuninori.morimoto.gx@renesas.com>
	<5977920.SJUic98Q2P@avalon>
	<CANqRtoREqLXGn43e3Jr90gdgpVoe-OGGuorgmjLSFaxt-22HDA@mail.gmail.com>
	<877fw6tm4v.wl%kuninori.morimoto.gx@renesas.com>
	<CANqRtoTNdLh-f6Gn6a-u=zr7b54corK=TO05bBN595gaD4sNMQ@mail.gmail.com>
In-Reply-To: <CANqRtoTNdLh-f6Gn6a-u=zr7b54corK=TO05bBN595gaD4sNMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Mark Brown <broonie@linaro.org>, Mark Brown <broonie@kernel.org>, Vinod Koul <vinod.koul@intel.com>, Simon <horms@verge.net.au>, Rob Herring <robh+dt@kernel.org>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Arnd Bergmann <arnd@arndb.de>, dmaengine@vger.kernel.org


Hi Magnus

> >> From my side anything is fine really, and I agree that the DT
> >> integration patch looked rather "special". =)
> >>
> >> At the same time I do think it makes sense to model the DT after the
> >> hardware. So if there is a separate DMA controller device then I can't
> >> see what is wrong with representing that in DT as a separate device.
> >> That aside, the current implementation may not have been entirely
> >> clean so perhaps we can begin by fixing that and see where that leads
> >> us.
> >>
> >> So I wonder as an incremental approach, how about simply reworking the
> >> DT interface (old code has 200+ channels mapped out individually) to
> >> something more manageable (maybe 20+ groups instead)? If that still
> >> seems completely wrong DT-wise then we can look into how to rework the
> >> architecture.
> >
> > Yes indeed, it needs too many DT nodes in current implementation
> > (total 220 node). and I can agree that it is one of concern about Vinod/Laurent.
> > It could be reduced to 22 node if I fixuped current implementation to calculate ID
> > by DMAEngine driver side.
> > It is not full-patchset, but I send this fixup patch as [RFC]
> 
> Sounds good. Can you please let me know exactly which patch series
> should I look at?

Thank you for your help
I have sent 2 patches as [RFC]
	[RFC] dmaengine: rcar-audmapp: calculate chcr via src/dst addr
	[RFC] ARM: shmobile: r8a7790: sound enables Audio DMAC peri peri entry on DTSI

Actually, sound driver side needs fixup patch related to these change.
But above are focusing to Audio DMAC peri peri at this point.
Main change is 2/2 patch, it is using 22 node on this patch.
(it needed 220 node without theses patches)

Best regards
---
Kuninori Morimoto
