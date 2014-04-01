From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 01 Apr 2014 11:26:07 +0000
Subject: Re: [PATCH 2/6] mmc: sh-mmcif: use devm_ for ioremap
Message-Id: <533AA24F.8050705@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1396347954-13740-1-git-send-email-ben.dooks@codethink.co.uk> <1396347954-13740-3-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1396347954-13740-3-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben.dooks@codethink.co.uk>, linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, magnus.damm@opensource.se, linux-kernel@lists.codethink.co.uk

Hello.

On 01-04-2014 14:25, Ben Dooks wrote:

> Start tidying the probe/release code by using devm_ioremap_resource() to
> map the IO registers.

> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>   drivers/mmc/host/sh_mmcif.c | 20 +++++---------------
>   1 file changed, 5 insertions(+), 15 deletions(-)

> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index c48df98..be6be2b 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -1379,22 +1379,17 @@ static int sh_mmcif_probe(struct platform_device *pdev)
>   		dev_err(&pdev->dev, "Get irq error\n");
>   		return -ENXIO;
>   	}
> +
>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!res) {
> -		dev_err(&pdev->dev, "platform_get_resource error.\n");
> -		return -ENXIO;
> -	}
> -	reg = ioremap(res->start, resource_size(res));
> -	if (!reg) {
> +	reg = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(reg)) {
>   		dev_err(&pdev->dev, "ioremap error.\n");
>   		return -ENOMEM;

    Should propagate devm_ioremap_resource() error instead.

[...]

WBR, Sergei

