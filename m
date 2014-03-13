From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Thu, 13 Mar 2014 23:55:33 +0000
Subject: Re: [PATCH 0/2][RFC] ASoC: fsi/rcar: fixup SND_SOC_DAIFMT_CBx_CFx flags
Message-Id: <87lhwdpsb1.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87txb3rjzw.wl%kuninori.morimoto.gx@gmail.com>
	<20140313104836.GN366@sirena.org.uk>
In-Reply-To: <20140313104836.GN366@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: Simon <horms@verge.net.au>, Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>


Hi Mark

> > >> Simon
> > 
> > Can you check #1 patch which modifys SH-ARM platform ?
> 
> So, we need to do something quickly here since this affects DT bindings
> but it would be *much* better to avoid having to set the master flags on
> both ends of the link since that's going to make the binding confusing
> if we're stuck with it as an ABI.
> 
> Simon, are you OK with the arch side of cleanups for this going via my
> tree?

Thank you.
But, sorry. I noticed [1/2] patch has bug.
I will send v2 patch soon.
