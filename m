From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 06 May 2015 10:00:54 +0000
Subject: Re: [PATCH/RFC] mmc: sh_mmcif: Fix timeout value for command request
Message-Id: <CAPDyKFrVQ7k9iUOnn=h3zv5xu=JBLmF_FgavmFv2popAu8Rm_A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1430327031-8349-1-git-send-email-ykaneko0929@gmail.com>
In-Reply-To: <1430327031-8349-1-git-send-email-ykaneko0929@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-sh list <linux-sh@vger.kernel.org>

On 29 April 2015 at 19:03, Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>
> f9fd54f22e ("mmc: sh_mmcif: Use msecs_to_jiffies() for host->timeout")
> changed the timeout value from 1000 jiffies to 1s. In the case where
> HZ is 1000 the values are the same. However, for smaller HZ values the
> timeout is now smaller, 1s instead of 10s in the case of HZ0.
>
> Since the timeout occurs in spite of a normal data transfer a timeout of
> 10s seems more appropriate. This restores the previous timeout in the
> case where HZ0 and results in an increase over the previous timeout
> for larger values of HZ.
>
> Fixes: f9fd54f22e ("mmc: sh_mmcif: Use msecs_to_jiffies() for host->timeout")
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> [horms: rewrote changelog to refer to HZ]
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>

Thanks, applied for fixes!

Kind regards
Uffe

> ---
>
> This patch is based on the for-next branch of Mark Brown's spi tree.
>
> A survey of the HZ resulting from of defconfigs that enable MMCIF is
> as follows:
>
> bockw_defconfig: CONFIG_HZ24
> kzm9g_defconfig: CONFIG_HZ8
> multi_v7_defconfig: CONFIG_HZ 0
> shmobile_defconfig: CONFIG_HZ0
>
> Simon Horman, SH Mobile maintainer, notes that it is the last defconfig
> that is recommended for use at this time.
>
>  drivers/mmc/host/sh_mmcif.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index 072f670..b82b982 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -1411,7 +1411,7 @@ static int sh_mmcif_probe(struct platform_device *pdev)
>         host            = mmc_priv(mmc);
>         host->mmc       = mmc;
>         host->addr      = reg;
> -       host->timeout   = msecs_to_jiffies(1000);
> +       host->timeout   = msecs_to_jiffies(10000);
>         host->ccs_enable = !pd || !pd->ccs_unsupported;
>         host->clk_ctrl2_enable = pd && pd->clk_ctrl2_present;
>
> --
> 1.9.1
>
