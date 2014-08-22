From: Simon Horman <horms@verge.net.au>
Date: Fri, 22 Aug 2014 02:23:32 +0000
Subject: Re: [PATCH 00/10] ARM: shmobile: shmobile_init_delay() conversion
Message-Id: <20140822022326.GG9099@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20140820130201.32075.45257.sendpatchset@w520>
In-Reply-To: <20140820130201.32075.45257.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Thanks.

I have queued these up though its a little awkward that SoC
changes depend on DT changes.

On Wed, Aug 20, 2014 at 10:02:01PM +0900, Magnus Damm wrote:
> ARM: shmobile: shmobile_init_delay() conversion
> 
> [PATCH 01/10] ARM: shmobile: sh7372: Update DTS to include CPU frequency
> [PATCH 02/10] ARM: shmobile: sh73a0: Update DTS to include CPU frequency
> [PATCH 03/10] ARM: shmobile: r8a7778: Update DTS to include CPU frequency
> [PATCH 04/10] ARM: shmobile: sh7372: Use shmobile_init_delay()
> [PATCH 05/10] ARM: shmobile: sh73a0: Use shmobile_init_delay() 
> [PATCH 06/10] ARM: shmobile: r8a7778: Use shmobile_init_delay()
> [PATCH 07/10] ARM: shmobile: r8a73a4: Use shmobile_init_delay() 
> [PATCH 08/10] ARM: shmobile: Remove shmobile_setup_delay()
> [PATCH 09/10] ARM: shmobile: bockw: Use shmobile_init_delay() 
> [PATCH 10/10] ARM: shmobile: kzm9g: Use shmobile_init_delay()
> 
> Convert the ARM mach-shmobile subarch to use shmobile_init_delay()
> together with CPU Frequency information in DTS instead of specifying
> these things in C. Remove the now redundant shmobile_setup_delay().
> 
> Merge-wise, for this to remain bisectable patch 1-3 needs to be merged
> first (DTS) - any order is however fine. After that patch 4-7 can be
> applied in any order (SoC) followed by any order of the last patches
> 8-10 (core + board).
> 
> After this one more SoC series is needed to remove local now unused
> delay functions, but it needs to happen after the board code in patch
> 9 and 10 are merged, so to avoid cicular dependecy this has been
> omitted for now.
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
> 
>  Written on top of renesas-devel-20140820-v3.17-rc1
> 
>  Untested, but should be safe enough. Seems to build with shmobile_defconfig.
> 
>  arch/arm/boot/dts/r8a7778.dtsi                 |    6 ++++++
>  arch/arm/boot/dts/sh7372.dtsi                  |    1 +
>  arch/arm/boot/dts/sh73a0.dtsi                  |    2 ++
>  arch/arm/mach-shmobile/board-bockw-reference.c |    2 +-
>  arch/arm/mach-shmobile/board-bockw.c           |    2 +-
>  arch/arm/mach-shmobile/board-kzm9g-reference.c |    2 +-
>  arch/arm/mach-shmobile/common.h                |    2 --
>  arch/arm/mach-shmobile/r8a73a4.h               |    1 -
>  arch/arm/mach-shmobile/setup-r8a73a4.c         |    9 +--------
>  arch/arm/mach-shmobile/setup-r8a7778.c         |    2 +-
>  arch/arm/mach-shmobile/setup-sh7372.c          |    2 +-
>  arch/arm/mach-shmobile/setup-sh73a0.c          |    2 +-
>  arch/arm/mach-shmobile/timer.c                 |   21 ++-------------------
>  13 files changed, 18 insertions(+), 36 deletions(-)
> 
