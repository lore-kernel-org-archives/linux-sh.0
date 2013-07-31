From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 31 Jul 2013 17:26:25 +0000
Subject: Re: [PATCH] mmc: tmio-mmc: Check the regulator_enable() return value
Message-Id: <Pine.LNX.4.64.1307311925460.5256@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1375280311-6003-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1375280311-6003-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>

Hi Laurent

On Wed, 31 Jul 2013, Laurent Pinchart wrote:

> The regulator_enable() function is marked with __must_check, check its
> return value and return an error in case of failure. This removes the
> following warning during kernel compilation:
> 
> drivers/mmc/host/tmio_mmc_pio.c: In function ‘tmio_mmc_power_on’:
> drivers/mmc/host/tmio_mmc_pio.c:795:19: warning: ignoring return value
> of ‘regulator_enable’, declared with attribute warn_unused_result
> [-Wunused-result]
> 
> The error isn't propagated back to the MMC core, as the .set_ios()
> operation in which the regulator is enabled doesn't have a return value.
> This should be fixed as well.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Should be fixed by now:

http://thread.gmane.org/gmane.linux.kernel.mmc/21294

Thanks
Guennadi

> ---
>  drivers/mmc/host/tmio_mmc_pio.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
> index 4675513..e3e2645 100644
> --- a/drivers/mmc/host/tmio_mmc_pio.c
> +++ b/drivers/mmc/host/tmio_mmc_pio.c
> @@ -770,15 +770,18 @@ static int tmio_mmc_clk_update(struct mmc_host *mmc)
>  	return ret;
>  }
>  
> -static void tmio_mmc_power_on(struct tmio_mmc_host *host, unsigned short vdd)
> +static int tmio_mmc_power_on(struct tmio_mmc_host *host, unsigned short vdd)
>  {
>  	struct mmc_host *mmc = host->mmc;
> -	int ret = 0;
> +	int ret;
>  
>  	/* .set_ios() is returning void, so, no chance to report an error */
>  
>  	if (!IS_ERR(mmc->supply.vmmc)) {
>  		ret = mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
> +		if (ret < 0)
> +			return ret;
> +
>  		/*
>  		 * Attention: empiric value. With a b43 WiFi SDIO card this
>  		 * delay proved necessary for reliable card-insertion probing.
> @@ -791,10 +794,15 @@ static void tmio_mmc_power_on(struct tmio_mmc_host *host, unsigned short vdd)
>  	 * It seems, VccQ should be switched on after Vcc, this is also what the
>  	 * omap_hsmmc.c driver does.
>  	 */
> -	if (!IS_ERR(mmc->supply.vqmmc) && !ret) {
> -		regulator_enable(mmc->supply.vqmmc);
> +	if (!IS_ERR(mmc->supply.vqmmc)) {
> +		ret = regulator_enable(mmc->supply.vqmmc);
> +		if (ret < 0)
> +			return ret;
> +
>  		udelay(200);
>  	}
> +
> +	return 0;
>  }
>  
>  static void tmio_mmc_power_off(struct tmio_mmc_host *host)
> -- 
> 1.8.1.5
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
