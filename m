From: Simon Horman <horms@verge.net.au>
Date: Fri, 27 Dec 2013 02:41:03 +0000
Subject: Re: [PATCH 0/6][RFC] ARM: shmobile: lager: SDHI support
Message-Id: <20131227024101.GH9184@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87a9g11jxt.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87a9g11jxt.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Dec 15, 2013 at 08:47:14PM -0800, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> These adds SDHI support on Lager.
> But, these need mmc/mmc-next branch
> with renesas-devel-v3.13-rc3-20131214v2

Thanks.

Would it be worth me placing these in a topic branch?
I believe that Ben has some interest in this area and
a branch may be useful to hom.

> 
> git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git :: mmc-next
> 
> especially, commit
> 60eafa0fc4fbddcc1280389746fd5a36acdb3952
> (mmc: SDHI: add SoC specific workaround via HW version)
> 
> #1 - #4 patches are for mmc ML,
> but, mmc-next branch doesn't have latest arch/arm/mach-shmobile.
> So these are still [RFC], and I didn't Cc to mmc ML this time.
> I will post #1 - #4 patches to mmc ML after merge.
> 
> #1 - #4 : for mmc ML, for DT
>           based on mmc-next branch,
>           but, it needs latest Simon's branch.
>           I will re-post these to mmc ML after merge
> 
> #5      : for SH ML, for legacy code
>           based on renesas-devel-v3.13-rc3-20131214v2
>           it needs mmc-next branch
> 
> #6      : for SH ML, for DT
>           based on renesas-devel-v3.13-rc3-20131214v2
>           it needs mmc-next branch, and #1 - #5
> 
> Simon, if you can base mmc-next branch,
> only #5 can be applied without #1 - #4.
> 
> Additionally, #6 needs Ben's sdhi fixup patches
> 
> Kuninori Morimoto (6):
>       1) mmc: SDHI: tidyup sh_mobile_sdhi_of_match position
>       2) mmc: SDHI: updata sh_mobile_sdhi_of_data for r8a7778
>       3) mmc: SDHI: updata sh_mobile_sdhi_of_data for r8a7779
>       4) mmc: SDHI: updata sh_mobile_sdhi_of_data for r8a7790
>       5) ARM: shmobile: lager: add SDHI0/2 support
>       6) ARM: shmobile: lager: add SDHI0/2 support on DTS
> 
>  arch/arm/boot/dts/r8a7778-bockw-reference.dts |    4 +-
>  arch/arm/boot/dts/r8a7778.dtsi                |    6 --
>  arch/arm/boot/dts/r8a7779.dtsi                |    8 ---
>  arch/arm/boot/dts/r8a7790-lager-reference.dts |   76 +++++++++++++++++++++++++
>  arch/arm/boot/dts/r8a7790.dtsi                |    4 --
>  arch/arm/mach-shmobile/board-lager.c          |   64 +++++++++++++++++++++
>  drivers/mmc/host/sh_mobile_sdhi.c             |   41 ++++++++-----
>  7 files changed, 171 insertions(+), 32 deletions(-)
> )
> 
> Best regards
> ---
> Kuninori Morimoto
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
