From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 25 Nov 2015 23:54:06 +0000
Subject: Re: [PATCH] ASoC: rcar: remove unused variable
Message-Id: <87ziy1d4j8.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4929159.b95vLdVRYU@wuerfel>
	<878u5m8ut0.wl%kuninori.morimoto.gx@renesas.com>
	<4083363.2bJPz8BMy4@wuerfel>
In-Reply-To: <4083363.2bJPz8BMy4@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Mengdong Lin <mengdong.lin@linux.intel.com>, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>


Hi Mark, Arnd

> > /opt/home/morimoto/WORK/linux/sound/soc/sh/rcar/core.c: In function '__rsnd_kctrl_new':
> > /opt/home/morimoto/WORK/linux/sound/soc/sh/rcar/core.c:807:18: error: 'soc_card' undeclared (first use in this function)
> >    .index  = rtd - soc_card->rtd,
> >                   ^
> > /opt/home/morimoto/WORK/linux/sound/soc/sh/rcar/core.c:807:18: note: each undeclared identifier is reported only once for each function it appears in
> > make[6]: *** [sound/soc/sh/rcar/core.o] エラー 1
> > make[6]: *** 未完了のジョブを待っています....
> > make[5]: *** [sound/soc/sh/rcar] エラー 2
> > make[4]: *** [sound/soc/sh] エラー 2
> > 
> > This __rsnd_kctrl_new() is using "soc_card"...
> 
> It looks like the commit that removed the user of that variable is in the
> "topic/pcm-list" branch instead of "topic/rcar".

Mark

It is possible to remove this patch from topic/rcar,
and, apply it to topic/pcm-list ?

ccae40fa973f5b0eec5d5ad27e81c5a2b95f7b7c
(" ASoC: rcar: remove unused variable")
