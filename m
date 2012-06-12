From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 12 Jun 2012 13:31:49 +0000
Subject: Re: [PATCH] mmc: tmio: Don't access hardware registers after stopping clocks
Message-Id: <Pine.LNX.4.64.1206121517590.6800@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1339505838-8831-1-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1339505838-8831-1-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org

Hi Laurent

On Tue, 12 Jun 2012, Laurent Pinchart wrote:

> The tmio_mmc_set_ios() function configures the MMC power, clock and bus
> width. When the MMC controller gets powered off, runtime PM switches the
> MSTP clock off. Writing to to CTL_SD_MEM_CARD_OPT register afterwards
> fails and prints an error message to the kernel log.
> 
> As configuring the bus width is pointless when the interface gets
> powered down, skip the operation when power is off.

The patch looks good - thanks! But maybe we can make the commit message a 
bit more precise. I think, ios->power_mode refers to powering the card 
down and up, not the controller. We use this information to also try to 
put the controller in a power-saving mode. Depending on the kernel and 
board configuration this can be a NOP, it can switch the MSTP clock off, 
as you correctly notice, or it can power the whole PM domain, to which the 
controller belongs, down. So, maybe something like this would be better:

The tmio_mmc_set_ios() function configures the MMC power, clock and bus 
width. When the mmc core requests the driver to power off the card, we 
inform runtime PM, that the controller can be suspended. This can lead to 
the MSTP clock being turned off. Writing to to CTL_SD_MEM_CARD_OPT 
register afterwards fails and prints an error message to the kernel log.

As conf... (continue as above)

Feel free to further improve the above :)

Thanks
Guennadi

> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  drivers/mmc/host/tmio_mmc_pio.c |   16 +++++++++-------
>  1 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
> index 9a7996a..de1226d 100644
> --- a/drivers/mmc/host/tmio_mmc_pio.c
> +++ b/drivers/mmc/host/tmio_mmc_pio.c
> @@ -816,13 +816,15 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  		tmio_mmc_clk_stop(host);
>  	}
>  
> -	switch (ios->bus_width) {
> -	case MMC_BUS_WIDTH_1:
> -		sd_ctrl_write16(host, CTL_SD_MEM_CARD_OPT, 0x80e0);
> -	break;
> -	case MMC_BUS_WIDTH_4:
> -		sd_ctrl_write16(host, CTL_SD_MEM_CARD_OPT, 0x00e0);
> -	break;
> +	if (host->power) {
> +		switch (ios->bus_width) {
> +		case MMC_BUS_WIDTH_1:
> +			sd_ctrl_write16(host, CTL_SD_MEM_CARD_OPT, 0x80e0);
> +		break;
> +		case MMC_BUS_WIDTH_4:
> +			sd_ctrl_write16(host, CTL_SD_MEM_CARD_OPT, 0x00e0);
> +		break;
> +		}
>  	}
>  
>  	/* Let things settle. delay taken from winCE driver */
> -- 
> 1.7.3.4
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
