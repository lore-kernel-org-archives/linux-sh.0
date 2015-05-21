From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 21 May 2015 23:59:16 +0000
Subject: Re: [PATCH 4/4 v2] ASoC: rsnd: spin lock for interrupt handler
Message-Id: <87siap8ows.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <878ucitwyh.wl%kuninori.morimoto.gx@renesas.com>
	<87382qtwto.wl%kuninori.morimoto.gx@renesas.com>
	<20150521105940.GV21577@sirena.org.uk>
	<20150521161552.GT3140@localhost>
	<20150521164630.GB21577@sirena.org.uk>
In-Reply-To: <20150521164630.GB21577@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: Vinod Koul <vinod.koul@intel.com>, Simon <horms@verge.net.au>, Nguyen Viet Dung <nv-dung@jinso.co.jp>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Laurent <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Cao Minh Hiep <cm-hiep@jinso.co.jp>, sakato <ryusuke.sakato.bx@renesas.com>, dmaengine@vger.kernel.org


Hi Mark

> > The 1st one looks good to me and was about to apply, but saw this and to
> > sync would you the 1st patch thru ASoC tree or fine with me applying that
> > one
> 
> Morimoto-san, do the two patches need to go through the same tree?  I
> guess it's better to have them both in the ASoC tree given how much work
> you're doing on these drivers.  Vinod, do you want to apply and send a
> pull request or do you just want to ack?

Thank you. Yes in same tree is understandable.

Best regards
---
Kuninori Morimoto
