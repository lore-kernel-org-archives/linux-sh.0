From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 12 Apr 2013 07:59:50 +0000
Subject: Re: [PATCH 1/3 v3] sh-pfc: Add r8a7778 pinmux support
Message-Id: <3200861.Uojmv9yKmn@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <8761zspawj.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8761zspawj.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

Thank you for the patch.

On Thursday 11 April 2013 22:37:20 Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> v2 -> v3
> 
>  - alphabetically sorted
>  - fixup SCIF_PFC_xx() arg
> 
>  drivers/pinctrl/sh-pfc/Kconfig       |    5 +
>  drivers/pinctrl/sh-pfc/Makefile      |    1 +
>  drivers/pinctrl/sh-pfc/core.c        |    3 +
>  drivers/pinctrl/sh-pfc/core.h        |    1 +
>  drivers/pinctrl/sh-pfc/pfc-r8a7778.c | 2369 +++++++++++++++++++++++++++++++
>  5 files changed, 2379 insertions(+)
>  create mode 100644 drivers/pinctrl/sh-pfc/pfc-r8a7778.c

-- 
Regards,

Laurent Pinchart

