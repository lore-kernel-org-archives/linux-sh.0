From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 22 Jan 2015 00:28:44 +0000
Subject: Re: [PATCH 0/4 v2] ARM: shmobile: r8a779x: add SDHI DMA support
Message-Id: <87h9vjmzd8.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <873874oj1q.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <873874oj1q.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Laurent

> > These are v2 of SDHI DMA support for r8a7790/r8a7791.
> > These are based on Ulf's
> > git.linaro.org/people/ulf.hansson/mmc.git tmio
> > 
> > Kuninori Morimoto (4):
> >       ARM: shmobile: r8a7790: tidyup SDHI register size on DTSI
> >       ARM: shmobile: r8a7791: tidyup SDHI register size on DTSI
> >       ARM: shmobile: r8a7790: add SDHI DMA channels on DTSI
> >       ARM: shmobile: r8a7791: add SDHI DMA channels on DTSI
> 
> I've already submitted patches 3 and 4 a few months ago, as
> 
> ARM: shmobile: r8a7790: Reference DMA channels in SDHI DT nodes
> ARM: shmobile: r8a7790: Reference DMA channels in SDHI DT nodes
> 
> You had tested them back then, and reported a performance regression. Has that 
> been fixed ?

I think it was block device issue, and was fixed in upstream.
I forgot to add your Signed-off-by on these patches.
Will send v3 patch soon

Best regards
---
Kuninori Morimoto
