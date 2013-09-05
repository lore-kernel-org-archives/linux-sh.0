From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 05 Sep 2013 07:40:19 +0000
Subject: Re: [PATCH 4/5 v2] ARM: shmobile: bockw: add R-Car sound support (PIO)
Message-Id: <874n9zyaw0.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <874nb2jgc4.wl%kuninori.morimoto.gx@renesas.com>
	<87haecvns0.wl%kuninori.morimoto.gx@renesas.com>
	<87bo4kvnow.wl%kuninori.morimoto.gx@renesas.com>
	<20130905055749.GF14960@verge.net.au>
	<20130905071946.GA8334@verge.net.au>
	<20130905073117.GB8334@verge.net.au>
In-Reply-To: <20130905073117.GB8334@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon <horms@verge.net.au>
Cc: Mark Brown <broonie@kernel.org>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Laurent <laurent.pinchart@ideasonboard.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>


Hi Simon, Mark

Thank you for your hard work

> > > > This patch enables R-Car sound,
> > > > AK4643 (CN19) and AK4554 (CN20/CN21) codec chip
> > > > on Bock-W.
> > > > 
> > > > But, it supports PIO transfer only at this point.
> > > > User can check sound settings (Dip-switch/PFC etc)
> > > > via this patch, but will get under/over flow error
> > > > when playback/capture.
> > > > Because PIO transfer via SSI will be interrupted
> > > > "sampling rate" times per 1 second.
> > > > 
> > > > DMA transfer will be supported when HPB-DMAC was
> > > > enabled on r8a7778.
> > > > 
> > > > You will notice strange ALSA sound card HW
> > > > numbering on Bock-W board.
> > > > This came from AK4554 strange format on playback/capture.
> > > > The format on playback/capture is same on "normal" codec chip,
> > > > but AK4554 was different.
> > > > Because of that, AK4554 playback/capture are
> > > > registered as a different sound card.
> > > > 
> > > > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > > ---
> > > > v1 -> v2
> > > 
> > > Thanks, I have queued this up for v3.13.
> > > 
> > > There was a bit of diff-noise, please make sure I have applied it
> > > correctly. The patch I applied is below:
> > 
> > Unfortunately I didn't read your cover email carefully before queuing this up.
> > I now see that it has dependencies that aren't present in v3.11-rc and
> > thus I have temporarily dropped it.
> > 
> > It seems to me that the dependencies could be provided by
> > the topic/car branch of
> > git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git.

Yes, exactly.

But

 - topic/car
 + topic/rcar

;P

> > Morimoto-san, is this correct?
> > If so, Mark, would it be possible for you to provide topic/car
> > or similar as stable branch for me to use as a base?
> > My intention is to queue these up for v3.13.
> 
> Alternatively, if the dependencies are likely to
> appear in v3.12-rc1 or v3.12-rc2 then I can just wait until
> they are available there.

Can you help Mark ?

Best regards
---
Kuninori Morimoto
