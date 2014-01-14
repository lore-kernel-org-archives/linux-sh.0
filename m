From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Date: Tue, 14 Jan 2014 04:10:56 +0000
Subject: RE: Possible regression of Mackerel/ASoC Simple Card in next-20130107
Message-Id: <4d593a7756024226a22d93cce2b78b9c@BY2PR03MB505.namprd03.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140108040017.GA11231@verge.net.au>
 <20140114022353.GA7053@verge.net.au>
In-Reply-To: <20140114022353.GA7053@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Mark Brown <broonie@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi 

> >
> > I noticed that next-20130107 does not boot on the Mackerel board does not
> > boot using its defconfig. The boot log is as follows.
> >
> > I have not investigated any further as typically when I investigate
> > problems in next they turn out to be known problems.
> 
> This problem does not appear to be present any more in next-20140113.
> 
 
Maybe the following patch fixed this if the dts is not using.

"ASoC: simple-card: fix a bug where cinfo will be NULL before using it"

Thanks,
