From: Simon Horman <horms@verge.net.au>
Date: Thu, 18 Dec 2014 00:22:33 +0000
Subject: Re: [PATCH v2 00/05] ARM: shmobile: sh73a0 and kzm9g Multiplatform revisit
Message-Id: <20141218002231.GC1421@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20141217094204.7039.45337.sendpatchset@w520>
In-Reply-To: <20141217094204.7039.45337.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Dec 17, 2014 at 06:42:04PM +0900, Magnus Damm wrote:
> ARM: shmobile: sh73a0 and kzm9g Multiplatform revisit
> 
> [PATCH v2 01/05] ARM: shmobile: kzm9g-reference: 0x48008000 load address
> [PATCH v2 02/05] ARM: shmobile: sh73a0: Introduce generic setup callback
> [PATCH v2 03/05] ARM: shmobile: sh73a0: Add Multiplatform support
> [PATCH v2 04/05] ARM: shmobile: kzm9g: Sync with DT reference
> [PATCH v2 05/05] ARM: shmobile: kzm9g: Build DTS for Multiplatform
> 
> This patch series enables sh73a0 Multiplatform support. At this point
> the KZM9G board code written in C is left as-is, but future updates will
> make sure to get rid of DT reference DTS and C board code.
> 
> To make it work you need the sh73a0 CCF v7 series and the DIV6 v7
> series from Ulrich Hecht.
> 
> Patch 1-3 should be possible to merge without any special dependencies.

Thanks. I agree that should be possible.

I see there has been some discussion of at least patches 1 and 3.
I would like that discussion to come to a conclusion (has it already?)
before I merge any patches from this series. And ideally I would like
some Acks from Geert.

> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
> 
>  Built on top of renesas-devel-20141217-v3.18
> 
>  arch/arm/boot/dts/Makefile            |    3 
>  arch/arm/boot/dts/sh73a0-kzm9g.dts    |  342 ++++++++++++++++++++++++++++++++-
>  arch/arm/mach-shmobile/Kconfig        |    5 
>  arch/arm/mach-shmobile/Makefile       |    4 
>  arch/arm/mach-shmobile/Makefile.boot  |    2 
>  arch/arm/mach-shmobile/setup-sh73a0.c |   21 +-
>  arch/arm/mach-shmobile/smp-sh73a0.c   |    2 
>  7 files changed, 369 insertions(+), 10 deletions(-)
> 
