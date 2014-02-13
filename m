From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Thu, 13 Feb 2014 05:35:54 +0000
Subject: Re: [PATCH 0/2 v3]: ARM: shmobile: lager: add SDHI0/2 support for legacy/DT
Message-Id: <878utfd16w.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87fvnnd4aw.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87fvnnd4aw.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

Sorry many times...
Magnus pointed that this #2 patch was not based on r-car-sdhi driver
Give me v4 chance

> Cc Magnus
> 
> These are v3 patch of SDHI0/2 support for lager.
> These are based on...
> 
>   renesas-devel-v3.14-rc1-20140207
> + sh-arm/topic/r-car-sdhi
> + git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git :: /topic/gpio
> 
> 
> > These are v2 patch of SDHI0/2 support for Lager.
> > #1 is same one, #2 patch was updated
> > 
> > Kuninori Morimoto (2):
> >       ARM: shmobile: lager: add SDHI0/2 support
> >       ARM: shmobile: lager: add SDHI0/2 support on DTS
> > 
> >  arch/arm/boot/dts/r8a7790-lager.dts  |   84 ++++++++++++++++++++++++++++++++++
> >  arch/arm/mach-shmobile/board-lager.c |   64 ++++++++++++++++++++++++++
> >  2 files changed, 148 insertions(+)
