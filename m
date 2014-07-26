From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Sat, 26 Jul 2014 09:41:05 +0000
Subject: Re: [PATCH 04/11] mmc: tmio: Configure DMA slave bus width
Message-Id: <CAPDyKFpJOi7R8KXQydnEM3wkfrr90M4e_c7ywv+9MMF7CrC-og@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1405464321-4723-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<1405464321-4723-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1405464321-4723-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian.molton@codethink.co.uk>

On 16 July 2014 00:45, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> Even though some implementations support 4-bytes data register access,
> the tmio driver never configures the hardware in such a way and always
> performs 2-bytes accesses. Hardcode the DMA transfer size to 2 bytes.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Thanks! Applied for next.

Kind regards
Uffe


> ---
>  drivers/mmc/host/tmio_mmc_dma.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/tmio_mmc_dma.c b/drivers/mmc/host/tmio_mmc_dma.c
> index 03e7b28..eb8f1d5 100644
> --- a/drivers/mmc/host/tmio_mmc_dma.c
> +++ b/drivers/mmc/host/tmio_mmc_dma.c
> @@ -294,6 +294,7 @@ void tmio_mmc_request_dma(struct tmio_mmc_host *host, struct tmio_mmc_data *pdat
>                         cfg.slave_id = pdata->dma->slave_id_tx;
>                 cfg.direction = DMA_MEM_TO_DEV;
>                 cfg.dst_addr = res->start + (CTL_SD_DATA_PORT << host->pdata->bus_shift);
> +               cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
>                 cfg.src_addr = 0;
>                 ret = dmaengine_slave_config(host->chan_tx, &cfg);
>                 if (ret < 0)
> @@ -312,6 +313,7 @@ void tmio_mmc_request_dma(struct tmio_mmc_host *host, struct tmio_mmc_data *pdat
>                         cfg.slave_id = pdata->dma->slave_id_rx;
>                 cfg.direction = DMA_DEV_TO_MEM;
>                 cfg.src_addr = cfg.dst_addr;
> +               cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
>                 cfg.dst_addr = 0;
>                 ret = dmaengine_slave_config(host->chan_rx, &cfg);
>                 if (ret < 0)
> --
> 1.8.5.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
