From: Simon Horman <horms@verge.net.au>
Date: Thu, 06 Feb 2014 07:16:14 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7790/r8a7778: audio support
Message-Id: <20140206071612.GJ17591@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jan 13, 2014 at 06:24:40PM -0800, Kuninori Morimoto wrote:
> 
> Hi Simon, Laurent
> 
> These are r8a7790 audio clock support v2 patch
> and lager sound support.
> These are based on renesas-devel-v3.13-rc8-20140113 tag
> 
> Kuninori Morimoto (4):
>       1) ARM: shmobile: r8a7778: add audio clock in new style
>       2) ARM: shmobile: r8a7790: add audio clock
>       3) ARM: shmobile: lager: add sound support
>       4) ARM: shmobile: lager: add sound support on defconfig
> 
>  arch/arm/boot/dts/r8a7790.dtsi         |   23 ++++++++
>  arch/arm/configs/lager_defconfig       |    4 ++
>  arch/arm/mach-shmobile/Kconfig         |    1 +
>  arch/arm/mach-shmobile/board-lager.c   |  100 ++++++++++++++++++++++++++++++++
>  arch/arm/mach-shmobile/clock-r8a7778.c |    4 ++
>  arch/arm/mach-shmobile/clock-r8a7790.c |   20 +++++++
>  6 files changed, 152 insertions(+)
> 
> I will fixup sound driver side after merge for DT supporting.
> To avoid merging conflict issue, platform needs new/old style clock now.
>  => #1, #2
> 
> #2 has common clock support too.
> 
> #3 needs below branch
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git :: topic/rcar
> 
> especially, this commit
> 
> 507d466c733e28d132a7be87040a3da126df7947
> (ASoC: rcar: add Gen2 sound support)

Thanks, that dependency is present in v3.14-rc1 and I have queued-up
this series.
