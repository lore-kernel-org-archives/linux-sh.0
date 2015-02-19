From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 19 Feb 2015 08:19:45 +0000
Subject: Re: [PATCH 0/19] ASoC: rsnd: move 2nd DMAC from DMAEngine to rsnd driver
Message-Id: <7023820.M4yQMnvTuN@wuerfel>
List-Id: <linux-sh.vger.kernel.org>
References: <87vbiy1rul.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87vbiy1rul.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Laurent <laurent.pinchart@ideasonboard.com>

On Thursday 19 February 2015 03:50:14 Kuninori Morimoto wrote:
> Hi Mark, Arnd, Vinod
> Cc: Laurent, SH-ML
> 
> Renesas R-Car sound (= rsnd) needs 2 DMAC which are called as
> Audio DMAC (= 1st DMAC) and Audio DMAC peri peri (2nd DMAC).
> And rsnd had assumed that 1st / 2nd DMACs are implemented as DMAEngine.
> But, in result of DMA ML long term discussion, 2nd DMAC was concluded
> that it is not a general purpose DMAC (2nd DMAC is for Device to Device
> inside sound system). Additionally, current DMAEngine can't support Device
> to Device, and we don't have correct DT bindings for it at this point.
> So the easiest solution for it is that move it from DMAEngine to rsnd
> driver.
> http://thread.gmane.org/gmane.linux.ports.sh.devel/41063/focusC829
> 
> These patches add Audio DMAC peri peri implementation in rsnd driver.
> I will remove current DMAEngine side Audio DMAC peri peri implement
> if these are accepted.
> 
> Arnd, Vinod
> 
> I'm happy if you can send Ack for these patches

Looks very good overall, I just have one more idea for simplifying
the binding, please see if that can work or not:

I see that there are already subnodes for the individual ssi, src, dvc
and dai nodes, which contain among other things the interrupt lines
like

                ssi3: ssi@3 {
                        interrupts = <0 373 IRQ_TYPE_LEVEL_HIGH>;
                };


It seems that you are adding for the same set of devices a dma
line per subdevice, but have chosen to have them all in the parent
node:

       dma-names =     "ssi0-rx",      "ssi0-tx",      "ssiu0-rx",     "ssiu0-tx",
		...


Have you considered moving the channels into the slave nodes to avoid
having to construct the names? I think it can just look like

                ssi3: ssi@3 {
                       interrupts = <0 373 IRQ_TYPE_LEVEL_HIGH>;
			dmas = <&audma0 0x07>, <&audma1 0x08>,
				<&audma0 0x6f>, <&audma1 0x70>;
			dma-names = "rx", "tx", "rxu", "txu";
                };

which would be a more logical structure.

	Arnd
