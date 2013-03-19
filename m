From: Simon Horman <horms@verge.net.au>
Date: Tue, 19 Mar 2013 09:06:00 +0000
Subject: Re: [PATCH 00/02] sh-pfc: Initial r8a73a4 PFC support
Message-Id: <20130319090557.GA26905@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130318145029.26761.15477.sendpatchset@w520>
In-Reply-To: <20130318145029.26761.15477.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Mar 18, 2013 at 11:50:29PM +0900, Magnus Damm wrote:
> sh-pfc: Initial r8a73a4 PFC support
> 
> [PATCH 01/02] sh-pfc: Add r8a73a4 pinmux support
> [PATCH 02/02] sh-pfc: Add r8a73a4 GPIO IRQ support
> 
> This series is V1 of initial PFC support for the r8a73a4 SoC.
> Nothing out of the ordinary, just similar but different tables
> to describe the pinmux hardware and GPIOs on r8a73a4.
> 
> The header in the mach directory is still used, and in the future
> this will be removed when fully using PINCTRL. Until then a common
> location is needed so this series simply follows what other SoCs
> do. Because of this there is a dependency on the r8a73a4 SoC code.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  Written against "next" renesas.git 811689afc214564c4a5f238ecf4d8bdc0e52b615
>  Requires "r8a73a4.h" provided by
>   [PATCH 00/04] ARM: shmobile: r8a73a4 SoC support V2

For reference, these patches seem to depend on some of
the patches in the pinmux branch, tagged as renesas-pinmux-for-v3.10,
but no other patches in next.

> 
>  arch/arm/mach-shmobile/include/mach/r8a73a4.h |  918 +++++++
>  drivers/pinctrl/sh-pfc/Kconfig                |    5 
>  drivers/pinctrl/sh-pfc/Makefile               |    1 
>  drivers/pinctrl/sh-pfc/core.c                 |    3 
>  drivers/pinctrl/sh-pfc/core.h                 |    1 
>  drivers/pinctrl/sh-pfc/pfc-r8a73a4.c          | 2889 +++++++++++++++++++++++++
>  6 files changed, 3817 insertions(+)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
