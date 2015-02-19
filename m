From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 19 Feb 2015 08:44:30 +0000
Subject: Re: [PATCH 0/19] ASoC: rsnd: move 2nd DMAC from DMAEngine to rsnd driver
Message-Id: <87wq3ez3us.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87vbiy1rul.wl%kuninori.morimoto.gx@renesas.com>
	<7023820.M4yQMnvTuN@wuerfel>
In-Reply-To: <7023820.M4yQMnvTuN@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Laurent <laurent.pinchart@ideasonboard.com>


Hi Arnd

> Looks very good overall, I just have one more idea for simplifying
> the binding, please see if that can work or not:
(snip)
>                 ssi3: ssi@3 {
>                        interrupts = <0 373 IRQ_TYPE_LEVEL_HIGH>;
> 			dmas = <&audma0 0x07>, <&audma1 0x08>,
> 				<&audma0 0x6f>, <&audma1 0x70>;
> 			dma-names = "rx", "tx", "rxu", "txu";
>                 };

I tried this idea before, but I got issues on DT.
I forgot detail, but if my memory was correct, it was
dev->of_node.

	sound {
		...
		ssi3: ssi@3 {
			interrupts = <0 373 IRQ_TYPE_LEVEL_HIGH>;
			dmas = <&audma0 0x07>, <&audma1 0x08>, <&audma0 0x6f>, <&audma1 0x70>;
			dma-names = "rx", "tx", "rxu", "txu";
		};
	}

dma_request_slave_channel_compat() requests "dev",
and this dev means sound here.

This "dev" will be used in dma_request_slave_channel_reason()
and, it uses "dev->of_node".
But, here, "dev->of_node" means "sound" here.

If I use your style, I need to do like below,
or I need new compat function which can select of_node.

	tmp_node = dev->of_node;
	dev->of_node = subnode;
	dma_request_slave_channel_compat(... dev ...);
	dev->of_node = tmp_node;


Best regards
---
Kuninori Morimoto
