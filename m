From: khiemnguyen <khiem.nguyen.xt@rvc.renesas.com>
Date: Mon, 15 Jun 2015 10:00:55 +0000
Subject: Re: [PATCH 3/6][RFC] clk: shmobile: add Renesas R-Car Gen3 CPG support
Message-Id: <557EA257.2030107@rvc.renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <871thdwp4d.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <871thdwp4d.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Dear Morimoto-san, Inami-san,

Thanks for your patch.

On 6/15/2015 11:53 AM, Kuninori Morimoto wrote:
> From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
>
> This patch adds very initial CPG support.
> R-Car Gen3 write function should use CPG write protection method
> which is shared with MSTP driver. This patch has it but not used.
>
> Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>   drivers/clk/shmobile/Makefile        |   1 +
>   drivers/clk/shmobile/clk-rcar-gen3.c | 243 +++++++++++++++++++++++++++++++++++
>   2 files changed, 244 insertions(+)
>   create mode 100644 drivers/clk/shmobile/clk-rcar-gen3.c
>
> diff --git a/drivers/clk/shmobile/Makefile b/drivers/clk/shmobile/Makefile
> index 6790268..441adcf 100644
> --- a/drivers/clk/shmobile/Makefile
> +++ b/drivers/clk/shmobile/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_ARCH_R8A7790)              += clk-rcar-gen2.o
>   obj-$(CONFIG_ARCH_R8A7791)             += clk-rcar-gen2.o
>   obj-$(CONFIG_ARCH_R8A7793)             += clk-rcar-gen2.o
>   obj-$(CONFIG_ARCH_R8A7794)             += clk-rcar-gen2.o
> +obj-$(CONFIG_ARCH_RCAR_GEN3)           += clk-rcar-gen3.o
>   obj-$(CONFIG_ARCH_SH73A0)              += clk-sh73a0.o
>   obj-$(CONFIG_ARCH_SHMOBILE_MULTI)      += clk-div6.o
>   obj-$(CONFIG_ARCH_SHMOBILE_MULTI)      += clk-mstp.o
> diff --git a/drivers/clk/shmobile/clk-rcar-gen3.c b/drivers/clk/shmobile/clk-rcar-gen3.c
> new file mode 100644
> index 0000000..20ab044
> --- /dev/null
> +++ b/drivers/clk/shmobile/clk-rcar-gen3.c
> @@ -0,0 +1,243 @@
> +/*
> + * rcar_gen3 Core CPG Clocks
> + *
> + * Based on rcar_gen2 Core CPG Clocks driver.

I believe that we should have a copyright statement here,
similar to patch no. 5.

> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; version 2 of the License.
> + */
> +
[....]


Best regards,
KHIEM Nguyen
