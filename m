From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Mon, 24 Mar 2014 03:33:37 +0000
Subject: Re: [PATCH] ARM: bockw: fixup SND_SOC_DAIFMT_CBx_CFx flags
Message-Id: <87eh1si835.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87ha6oi8dg.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87ha6oi8dg.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-sh@vger.kernel.org


Hi Mark, Simon again

> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> SND_SOC_DAIFMT_CBx_CFx means "codec" side master/slave mode.
> Then, rcar will be master mode if it was SND_SOC_DAIFMT_CBS_CFS.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> >> Mark, Simon
> 
> I'm so sorry. current Mark's fix/rcar branch has
> SND_SOC_DAIFMT_CBx_CFx fixup patches,
> but it didn't care about bockw board.
> This patch is for it.
> This Subject is using "ARM: bockw:" prefix,
> but, should it be "ASoC: rcar" ?

>> Simon

Lager board needs similar patch,
but, it is not in linus/master branch yet.
I will send it to SH-ARM ML.
But, linus/master branch already has bockw board.
