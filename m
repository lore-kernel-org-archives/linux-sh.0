From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 10 Apr 2013 10:58:47 +0000
Subject: Re: [PATCH 0/4 v2] ARM: shmobile: r8a7778: pinctrl support
Message-Id: <11288232.egrQluWGtp@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <87hajeka2q.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87hajeka2q.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Wednesday 10 April 2013 02:29:37 Kuninori Morimoto wrote:
> Hi Laurent, Simon, Magnus
> 
> These patches are v2 of r8a7778 pinctrl support
> I removed [RFC] from Subject
> 
> These are based on
> 
> renesas-next-20130405v2
>  + simon/defconfig-bockw
>  + simon/soc-r8a7778
>  + simon/boards-bockw
> 
> and Laurent's this patch
> 
> Subject: [PATCH v2 1/3] gpio-rcar: Add RCAR_GP_PIN macro
> Date:	Mon,  8 Apr 2013 12:05:30 +0200
> 
> Kuninori Morimoto (3):
>       sh-pfc: Add r8a7778 pinmux support
>       ARM: shmobile: r8a7778: Register PFC device
>       ARM: shmobile: bockw: add pinctrl support

The patches look good, I just had a couple of comments on 1/3. I've acked 2/3 
and 3/3 already from v1, could you pick up the acks and add them to v3 ? In 
general picking Acked-by, Reviewed-by and Tested-by lines from the list when 
submitting a new version is a good idea, as it helps reviewer skip patches 
they have already reviewed.

>  arch/arm/mach-shmobile/Kconfig                |    1 +
>  arch/arm/mach-shmobile/board-bockw.c          |   13 +
>  arch/arm/mach-shmobile/include/mach/r8a7778.h |    1 +
>  arch/arm/mach-shmobile/setup-r8a7778.c        |   13 +
>  drivers/pinctrl/sh-pfc/Kconfig                |    5 +
>  drivers/pinctrl/sh-pfc/Makefile               |    1 +
>  drivers/pinctrl/sh-pfc/core.c                 |    3 +
>  drivers/pinctrl/sh-pfc/core.h                 |    1 +
>  drivers/pinctrl/sh-pfc/pfc-r8a7778.c          | 2369 ++++++++++++++++++++++
>  9 files changed, 2407 insertions(+)

-- 
Regards,

Laurent Pinchart

