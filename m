From: Liam Girdwood <lrg@slimlogic.co.uk>
Date: Fri, 19 Nov 2010 11:16:09 +0000
Subject: Re: [PATCH 2/6] ARM: mach-shmobile: ap4evb: FSI clock use proper
Message-Id: <1290165369.3276.9.camel@odin>
List-Id: <linux-sh.vger.kernel.org>
References: <w3paal54w0z.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3paal54w0z.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, 2010-11-19 at 16:23 +0900, Kuninori Morimoto wrote:
> Current AP4 FSI set_rate function used bogus clock process
> which didn't care enable/disable and clk->usecound.
> To solve this issue, this patch also modify FSI driver to call
> set_rate with enough options.
> This patch modify it.
> 

Some minor comments below :-

> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  arch/arm/mach-shmobile/board-ap4evb.c |   58 +++++++++++++++++++++++++-------
>  arch/arm/mach-shmobile/clock-sh7372.c |    2 +-
>  include/sound/sh_fsi.h                |    6 ++-
>  sound/soc/sh/fsi.c                    |   19 +++++++++-
>  4 files changed, 67 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
> index d326054..17b8b07 100644
> --- a/arch/arm/mach-shmobile/board-ap4evb.c
> +++ b/arch/arm/mach-shmobile/board-ap4evb.c
> @@ -567,40 +567,72 @@ static struct platform_device *qhd_devices[] __initdata = {
>  
>  /* FSI */
>  #define IRQ_FSI		evt2irq(0x1840)
> +static int __fsi_set_rate(struct clk *clk, long rate, int enable)
> +{
> +	int ret = 0;
> +
> +	if (rate <= 0)
> +		return 0;

why do you need to set ret = 0 here ?

>  
> -static int fsi_set_rate(int is_porta, int rate)
> +	if (enable) {
> +		ret = clk_set_rate(clk, clk_round_rate(clk, rate));
> +		if (0 = ret)
> +			ret = clk_enable(clk);
> +	} else {
> +		clk_disable(clk);
> +	}
> +

braces not needed for else here.

> +	return ret;
> +}
> +
> +static int fsi_set_rate(struct device *dev, int is_porta, int rate, int enable)
>  {
>  	struct clk *fsib_clk;
>  	struct clk *fdiv_clk = &sh7372_fsidivb_clk;
> +	long fsib_rate = 0;
> +	long fdiv_rate = 0;
> +	int ackmd_bpfmd;
>  	int ret;
>  
>  	/* set_rate is not needed if port A */
>  	if (is_porta)
>  		return 0;
>  
> -	fsib_clk = clk_get(NULL, "fsib_clk");
> -	if (IS_ERR(fsib_clk))
> -		return -EINVAL;
> -
>  	switch (rate) {
>  	case 44100:
> -		clk_set_rate(fsib_clk, clk_round_rate(fsib_clk, 11283000));
> -		ret = SH_FSI_ACKMD_256 | SH_FSI_BPFMD_64;
> +		fsib_rate	= 11283000;

I'd expect to see 11289600 here, i.e. 44100 * 256

> +		ackmd_bpfmd	= SH_FSI_ACKMD_256 | SH_FSI_BPFMD_64;
>  		break;
>  	case 48000:
> -		clk_set_rate(fsib_clk, clk_round_rate(fsib_clk, 85428000));
> -		clk_set_rate(fdiv_clk, clk_round_rate(fdiv_clk, 12204000));
> -		ret = SH_FSI_ACKMD_256 | SH_FSI_BPFMD_64;
> +		fsib_rate	= 85428000;
> +		fdiv_rate	= 12204000;

This looks wrong too. 12288000 is 48000 * 256

> +		ackmd_bpfmd	= SH_FSI_ACKMD_256 | SH_FSI_BPFMD_64;
>  		break;
>  	default:
>  		pr_err("unsupported rate in FSI2 port B\n");
> -		ret = -EINVAL;
> -		break;
> +		return -EINVAL;
>  	}
>  
> +	/* FSI B setting */
> +	fsib_clk = clk_get(dev, "ickb");
> +	if (IS_ERR(fsib_clk))
> +		return -EIO;
> +
> +	ret = __fsi_set_rate(fsib_clk, fsib_rate, enable);
>  	clk_put(fsib_clk);
> +	if (ret < 0)
> +		return ret;
>  
> -	return ret;
> +	/* FSI DIV setting */
> +	ret = __fsi_set_rate(fdiv_clk, fdiv_rate, enable);
> +	if (ret < 0) {
> +		/* disable FSI B */
> +		if (enable)
> +			__fsi_set_rate(fsib_clk, fsib_rate, 0);
> +		return ret;
> +	}
> +
> +	return ackmd_bpfmd;
>  }
>  
>  static struct sh_fsi_platform_info fsi_info = {
> diff --git a/arch/arm/mach-shmobile/clock-sh7372.c b/arch/arm/mach-shmobile/clock-sh7372.c
> index 1322632..4191e29 100644
> --- a/arch/arm/mach-shmobile/clock-sh7372.c
> +++ b/arch/arm/mach-shmobile/clock-sh7372.c
> @@ -471,7 +471,7 @@ static int fsidiv_set_rate(struct clk *clk,
>  		return -ENOENT;
>  
>  	__raw_writel(idx << 16, clk->mapping->base);
> -	return fsidiv_enable(clk);
> +	return 0;
>  }
>  
>  static struct clk_ops fsidiv_clk_ops = {
> diff --git a/include/sound/sh_fsi.h b/include/sound/sh_fsi.h
> index fa60cbd..d798941 100644
> --- a/include/sound/sh_fsi.h
> +++ b/include/sound/sh_fsi.h
> @@ -85,7 +85,9 @@
>   *     ACK_MD (FSI2)
>   *     CKG1   (FSI)
>   *
> - * err:  return value < 0
> + * err		: return value <  0
> + * no change	: return value = 0
> + * change xMD	: return value >  0
>   *
>   * 0x-00000AB
>   *
> @@ -111,7 +113,7 @@
>  struct sh_fsi_platform_info {
>  	unsigned long porta_flags;
>  	unsigned long portb_flags;
> -	int (*set_rate)(int is_porta, int rate); /* for master mode */
> +	int (*set_rate)(struct device *dev, int is_porta, int rate, int enable);
>  };
>  
>  #endif /* __SOUND_FSI_H */
> diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
> index 507e709..136414f 100644
> --- a/sound/soc/sh/fsi.c
> +++ b/sound/soc/sh/fsi.c
> @@ -132,6 +132,8 @@ struct fsi_priv {
>  	struct fsi_stream playback;
>  	struct fsi_stream capture;
>  
> +	long rate;
> +
>  	u32 mst_ctrl;
>  };
>  
> @@ -854,10 +856,17 @@ static void fsi_dai_shutdown(struct snd_pcm_substream *substream,
>  {
>  	struct fsi_priv *fsi = fsi_get_priv(substream);
>  	int is_play = fsi_is_play(substream);
> +	struct fsi_master *master = fsi_get_master(fsi);
> +	int (*set_rate)(struct device *dev, int is_porta, int rate, int enable);
>  
>  	fsi_irq_disable(fsi, is_play);
>  	fsi_clk_ctrl(fsi, 0);
>  
> +	set_rate = master->info->set_rate;
> +	if (set_rate && fsi->rate)
> +		set_rate(dai->dev, fsi_is_port_a(fsi), fsi->rate, 0);
> +	fsi->rate = 0;
> +
>  	pm_runtime_put_sync(dai->dev);
>  }
>  
> @@ -891,9 +900,10 @@ static int fsi_dai_hw_params(struct snd_pcm_substream *substream,
>  {
>  	struct fsi_priv *fsi = fsi_get_priv(substream);
>  	struct fsi_master *master = fsi_get_master(fsi);
> -	int (*set_rate)(int is_porta, int rate) = master->info->set_rate;
> +	int (*set_rate)(struct device *dev, int is_porta, int rate, int enable);
>  	int fsi_ver = master->core->ver;
>  	int is_play = fsi_is_play(substream);
> +	long rate = params_rate(params);
>  	int ret;
>  
>  	/* if slave mode, set_rate is not needed */
> @@ -901,10 +911,15 @@ static int fsi_dai_hw_params(struct snd_pcm_substream *substream,
>  		return 0;
>  
>  	/* it is error if no set_rate */
> +	set_rate = master->info->set_rate;
>  	if (!set_rate)
>  		return -EIO;
>  
> -	ret = set_rate(fsi_is_port_a(fsi), params_rate(params));
> +	ret = set_rate(dai->dev, fsi_is_port_a(fsi), rate, 1);
> +	if (ret < 0) /* error */
> +		return ret;
> +
> +	fsi->rate = rate;
>  	if (ret > 0) {
>  		u32 data = 0;
>  

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk

