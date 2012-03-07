From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Wed, 07 Mar 2012 21:57:39 +0000
Subject: Re: [PATCH 00/06] ARM: mach-shmobile: map_io and init_early update
Message-Id: <201203072301.00280.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <20120229123656.28584.90874.sendpatchset@w520>
In-Reply-To: <20120229123656.28584.90874.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wednesday, February 29, 2012, Magnus Damm wrote:
>  ARM: mach-shmobile: map_io and init_early update
> 
> [PATCH 01/06] ARM: mach-shmobile: sh7367 map_io and init_early update
> [PATCH 02/06] ARM: mach-shmobile: sh7377 map_io and init_early update
> [PATCH 03/06] ARM: mach-shmobile: sh7372 map_io and init_early update
> [PATCH 04/06] ARM: mach-shmobile: sh73a0 map_io and init_early update
> [PATCH 05/06] ARM: mach-shmobile: r8a7740 map_io and init_early update
> [PATCH 06/06] ARM: mach-shmobile: r8a7779 map_io and init_early update
> 
> This patch series converts the mach-shmobile subarch to properly
> make use of a per-soc map_io and a separate init_early callback for
> early serial console support on platforms where that is possible.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Applied.

Thanks,
Rafael


> ---
> 
>  arch/arm/mach-shmobile/board-ag5evm.c        |   25 +------------
>  arch/arm/mach-shmobile/board-ap4evb.c        |   25 +------------
>  arch/arm/mach-shmobile/board-bonito.c        |   28 +--------------
>  arch/arm/mach-shmobile/board-g3evm.c         |   25 +------------
>  arch/arm/mach-shmobile/board-g4evm.c         |   25 +------------
>  arch/arm/mach-shmobile/board-kota2.c         |   25 +------------
>  arch/arm/mach-shmobile/board-mackerel.c      |   25 +------------
>  arch/arm/mach-shmobile/board-marzen.c        |   48 +-------------------------
>  arch/arm/mach-shmobile/include/mach/common.h |    6 +++
>  arch/arm/mach-shmobile/setup-r8a7740.c       |   35 ++++++++++++++++++
>  arch/arm/mach-shmobile/setup-r8a7779.c       |   39 +++++++++++++++++++++
>  arch/arm/mach-shmobile/setup-sh7367.c        |   22 +++++++++++
>  arch/arm/mach-shmobile/setup-sh7372.c        |   22 +++++++++++
>  arch/arm/mach-shmobile/setup-sh7377.c        |   22 +++++++++++
>  arch/arm/mach-shmobile/setup-sh73a0.c        |   22 +++++++++++
>  15 files changed, 184 insertions(+), 210 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

