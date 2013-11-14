From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 14 Nov 2013 13:32:48 +0000
Subject: Re: [PATCH 03/17] mmc: tmio: Fix odd size access
Message-Id: <3858815.JLZBehKaxi@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <87li0rz3to.wl%kuninori.morimoto.gx@renesas.com> <87habfz3kd.wl%kuninori.morimoto.gx@renesas.com> <87fvqzz3hk.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fvqzz3hk.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-mmc@vger.kernel.org

Hi Morimoto-san,

Thank you for the patch.

On Thursday 14 November 2013 02:23:23 Kuninori Morimoto wrote:
> From: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
> 
> Current sd_ctrl_read/write16_rep() doesn't care odd size
> 
> Signed-off-by: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
> Signed-off-by: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  drivers/mmc/host/tmio_mmc_pio.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/tmio_mmc_pio.c
> b/drivers/mmc/host/tmio_mmc_pio.c index b380225..05ae15c 100644
> --- a/drivers/mmc/host/tmio_mmc_pio.c
> +++ b/drivers/mmc/host/tmio_mmc_pio.c
> @@ -386,9 +386,11 @@ static void tmio_mmc_pio_irq(struct tmio_mmc_host
> *host)
> 
>  	/* Transfer the data */
>  	if (data->flags & MMC_DATA_READ)
> -		sd_ctrl_read16_rep(host, CTL_SD_DATA_PORT, buf, count >> 1);
> +		sd_ctrl_read16_rep(host,
> +			CTL_SD_DATA_PORT, buf, (count + 1) >> 1);
>  	else
> -		sd_ctrl_write16_rep(host, CTL_SD_DATA_PORT, buf, count >> 1);
> +		sd_ctrl_write16_rep(host,
> +			CTL_SD_DATA_PORT, buf, (count + 1) >> 1);

This means that the hardware will transfer one more byte than the requested 
value. Have you verified that the buffer will always have room for that extra 
byte (when reading from the hardware), and that the extra byte will not have 
any side effect (when writing to the hardware) ? I'm also a bit surprised, do 
upper layers transfer data to/from the card using odd number of bytes ?

>  	host->sg_off += count;
-- 
Regards,

Laurent Pinchart

