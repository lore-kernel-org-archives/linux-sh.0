From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 30 Jun 2014 00:41:14 +0000
Subject: Re: [PATCH 07/10 v2] ASoC: rsnd: enable SRC setting via DT
Message-Id: <871tu7dyaj.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87d2e6zjhf.wl%kuninori.morimoto.gx@gmail.com>
	<8761jstphc.wl%kuninori.morimoto.gx@gmail.com>
	<87vbrssar8.wl%kuninori.morimoto.gx@renesas.com>
	<20140628134046.GW2520@sirena.org.uk>
In-Reply-To: <20140628134046.GW2520@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, linux-sh@vger.kernel.org


Hi Mark

Thank you for your feedback

> >  SRC subnode properties:
> > -no properties at this point
> > +- convert-rate			: SRC convert rate if needed
> 
> It's not clear to me why this is something that we'd control in the
> device tree.  Are there some systems which can't support this, if the
> hardware can do it it's hard to see why someone wouldn't want to use it
> (and why it wouldn't be a runtime decision anyway).

This is because we might have special codec or
very simple DA/AD converter which can accept only 1 rate
The image is like this.
(This image indicates codec accept 48kHz only)

48kHz   --->      48kHz
44.1kHz ---> [SRC] ---> [codec]
96kHz   --->

Then, this codec shouldn't return error
when it gets rate other than 48kHz on
snd_soc_dai_ops :: hw_params.

I can send v3 patch which has above explain
if you can accept this.

Now, this patch-set is...

o : accepted
x : this patch
- : not accepted

o ASoC: fsi: use SNDRV_DMA_TYPE_DEV for sound buffer
o ASoC: fsi: add fsi_pointer_update() for common pointer method
o ASoC: fsi: use dmaengine_prep_dma_cyclic() for DMA transfer
o ASoC: rsnd: SSI + DMA can select BUSIF
o ASoC: rsnd: use dmaengine_prep_dma_cyclic() instead of original method
o ASoC: rsnd: enable DVC when capture
x ASoC: rsnd: enable SRC setting via DT
- ASoC: rsnd: DMA cleanup for flexible SSI/SRC selection
- ASoC: rsnd: DMA start address is properly used for each DMAC
- ASoC: rsnd: add DT support to DVC

Can you please skit "x" patch (= ASoC: rsnd: enable SRC setting via DT),
and consider about last "-" patches ?
Because "x" is independent patch, no relationship to "-" patches.
