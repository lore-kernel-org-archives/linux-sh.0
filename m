From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Thu, 13 Feb 2014 05:57:07 +0000
Subject: Re: [PATCH 0/2 v4]: ARM: shmobile: lager: add SDHI0/2 support for legacy/DT
Message-Id: <871tz7d07j.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <877g8zd0wo.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <877g8zd0wo.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi

> These are v4 patch of SDHI0/2 support for lager.
> These are based on...
> 
>   renesas-devel-v3.14-rc1-20140207
> + sh-arm/topic/r-car-sdhi
> + git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git :: /topic/gpio

Today's above topic/gpio branch is broken somehow.
Today, I sent bugifx patch for this issue.
Please check it

Subject: [PATCH] regulator: gpio: reborn necessary prop
Date: Thu, 13 Feb 2014 12:39:08 +0900


> 
> v3 had SoC specific option on dts file,
> but it is included in driver side.
> v4 removed these from dts
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
