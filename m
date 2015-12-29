From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 29 Dec 2015 00:00:40 +0000
Subject: Re: [PATCH 01/06] iommu/ipmmu-vmsa: Remove platform data handling
Message-Id: <1636680.rtxtBRILSH@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <20151215120212.26216.61530.sendpatchset@little-apple> <20151215120221.26216.739.sendpatchset@little-apple>
In-Reply-To: <20151215120221.26216.739.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: iommu@lists.linux-foundation.org, geert+renesas@glider.be, linux-sh@vger.kernel.org, joro@8bytes.org, linux-kernel@vger.kernel.org, horms+renesas@verge.net.au

Hi Magnus,

Thank you for the patch.

On Tuesday 15 December 2015 21:02:21 Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
> 
> The IPMMU driver is using DT these days, and platform data is no longer
> used by the driver. Remove unused code.
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
>  drivers/iommu/ipmmu-vmsa.c |    5 -----
>  1 file changed, 5 deletions(-)
> 
> --- 0001/drivers/iommu/ipmmu-vmsa.c
> +++ work/drivers/iommu/ipmmu-vmsa.c	2015-12-15 11:35:00.490513000 +0900
> @@ -766,11 +766,6 @@ static int ipmmu_probe(struct platform_d
>  	int irq;
>  	int ret;
> 
> -	if (!IS_ENABLED(CONFIG_OF) && !pdev->dev.platform_data) {
> -		dev_err(&pdev->dev, "missing platform data\n");
> -		return -EINVAL;
> -	}
> -
>  	mmu = devm_kzalloc(&pdev->dev, sizeof(*mmu), GFP_KERNEL);
>  	if (!mmu) {
>  		dev_err(&pdev->dev, "cannot allocate device data\n");

-- 
Regards,

Laurent Pinchart

