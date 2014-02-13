From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Thu, 13 Feb 2014 05:42:02 +0000
Subject: Re: [PATCH 0/2 v4]: ARM: shmobile: lager: add SDHI0/2 support for legacy/DT
Message-Id: <877g8zd0wo.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon again
Cc Magnus

These are v4 patch of SDHI0/2 support for lager.
These are based on...

  renesas-devel-v3.14-rc1-20140207
+ sh-arm/topic/r-car-sdhi
+ git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git :: /topic/gpio

v3 had SoC specific option on dts file,
but it is included in driver side.
v4 removed these from dts

> These are v2 patch of SDHI0/2 support for Lager.
> #1 is same one, #2 patch was updated
> 
> Kuninori Morimoto (2):
>       ARM: shmobile: lager: add SDHI0/2 support
>       ARM: shmobile: lager: add SDHI0/2 support on DTS
> 
>  arch/arm/boot/dts/r8a7790-lager.dts  |   84 ++++++++++++++++++++++++++++++++++
>  arch/arm/mach-shmobile/board-lager.c |   64 ++++++++++++++++++++++++++
>  2 files changed, 148 insertions(+)
