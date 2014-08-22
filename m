From: Simon Horman <horms@verge.net.au>
Date: Fri, 22 Aug 2014 03:05:27 +0000
Subject: Re: [PATCH 00/06] ARM: shmobile: Kconfig and Makefile cleanups
Message-Id: <20140822030523.GI9099@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20140820133121.808.91022.sendpatchset@w520>
In-Reply-To: <20140820133121.808.91022.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Aug 20, 2014 at 10:31:21PM +0900, Magnus Damm wrote:
> ARM: shmobile: Kconfig and Makefile cleanups
> 
> [PATCH 01/06] ARM: shmobile: Consolidate GPIOLIB Kconfig bits
> [PATCH 02/06] ARM: shmobile: Introduce a Kconfig entry for R-Mobile
> [PATCH 03/06] ARM: shmobile: Introduce a Kconfig entry for R-Car Gen1
> [PATCH 04/06] ARM: shmobile: Introduce a Kconfig entry for R-Car Gen2
> [PATCH 05/06] ARM: shmobile: Cleanup pm-rcar.o build using Kconfig
> [PATCH 06/06] ARM: shmobile: Cleanup pm-rmobile.o build using Kconfig
> 
> Update the ARM mach-shmobile Kconfig and Makefile to prepare for
> multiplatform support of R-Mobile SoCs. While at it do various
> cleanups - thanks to Simon Horman for suggesting using Kconfig
> for pm-rmobile.o. I applied the same idea to patch 5. Thanks to
> Geert Uytterhoeven for pointing out the mess in the Kconfig files,
> hopefully this cleanup series is a step in the right direction.

Hi Magnus,

could you let me know what the status of this series is?

> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
> 
>  Written on top of renesas-devel-20140820-v3.17-rc1
> 
>  Only lightly build tested. 
> 
>  arch/arm/mach-shmobile/Kconfig      |   66 +++++++++++++++++++----------------
>  arch/arm/mach-shmobile/Makefile     |   36 ++++++++-----------
>  arch/arm/mach-shmobile/pm-rcar.c    |    4 --
>  arch/arm/mach-shmobile/pm-rmobile.c |    2 -
>  arch/arm/mach-shmobile/pm-rmobile.h |    4 +-
>  5 files changed, 54 insertions(+), 58 deletions(-)
> 
