From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 14 Jan 2015 08:30:35 +0000
Subject: Re: [PATCH] mmc: tmio: add missing EXPORT_SYMBOL for tmio_mmc_host_alloc/free
Message-Id: <CAPDyKFrNFr493FcN3A3k_tGo9J801ga91ooL=sZT6DS0vFwVoQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201501131902.WqokttpY%fengguang.wu@intel.com>
	<87twzvuvl1.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87twzvuvl1.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, "kbuild-all@01.org" <kbuild-all@01.org>

On 14 January 2015 at 03:21, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> tmio_mmc_host_alloc/free were added on tmio_mmc_pio.c,
> but, it is missing EXPORT_SYMBOL for it.
> Compile will be failed without this patch
>
>  ERROR: "tmio_mmc_host_free" [drivers/mmc/host/tmio_mmc.ko] undefined!
>  ERROR: "tmio_mmc_host_alloc" [drivers/mmc/host/tmio_mmc.ko] undefined!
>  ERROR: "tmio_mmc_host_free" [drivers/mmc/host/sh_mobile_sdhi.ko] undefined!
>  ERROR: "tmio_mmc_host_alloc" [drivers/mmc/host/sh_mobile_sdhi.ko] undefined!
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks!

I decided to squashed this change into patch "mmc: tmio: add
tmio_mmc_host_alloc/free()", which was the one adding the related
functions.

Kind regards
Uffe
