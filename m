From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 07 Jan 2014 13:40:28 +0000
Subject: Re: [PATCH 2/4] mmc: tmio: bus_shift become tmio_mmc_data member
Message-Id: <201401071440.28355.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <87iovn8ohs.wl%kuninori.morimoto.gx@renesas.com> <87fvqr8ogb.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fvqr8ogb.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, Chris Ball <cjb@laptop.org>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-mmc@vger.kernel.org

On Wednesday 20 November 2013, Kuninori Morimoto wrote:
>         const struct mfd_cell *cell = mfd_get_cell(pdev);
>         struct tmio_mmc_data *pdata;
>         struct tmio_mmc_host *host;
> +       struct resource *res;
>         int ret = -EINVAL, irq;
>  
>         if (pdev->num_resources != 2)
> @@ -84,6 +85,13 @@ static int tmio_mmc_probe(struct platform_device *pdev)
>                         goto out;
>         }
>  
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!res)
> +               return -EINVAL;
> +
> +       /* SD control register space size is 0x200, 0x400 for bus_shift=1 */
> +       pdata->bus_shift = resource_size(res_ctl) >> 10;
> +
>         ret = tmio_mmc_host_probe(&host, pdev, pdata);
>         if (ret)
>                 goto cell_disable;

Unfortunately, this has introduced a build error, since you use
an incorrect variable name (res_ctl vs. res) in the last line that
was added.

Please add a fix on top.

	Arnd
