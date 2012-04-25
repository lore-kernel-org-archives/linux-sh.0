From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 25 Apr 2012 14:14:15 +0000
Subject: Re: [PATCH v2 01/10] mtd: sh_flctl: Add missing iounmap()
Message-Id: <7143447.AG1jzNJhqs@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1335362618-4559-1-git-send-email-hechtb@gmail.com>
 <1335362618-4559-2-git-send-email-hechtb@gmail.com>
In-Reply-To: <1335362618-4559-2-git-send-email-hechtb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bastian Hecht <hechtb@googlemail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Brian Norris <computersforpeace@gmail.com>, linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org

Hi Bastian,

Thanks for the patch.

On Wednesday 25 April 2012 16:03:29 Bastian Hecht wrote:
> Add the unmapping for the error case and for the driver removal.
> 
> Signed-off-by: Bastian Hecht <hechtb@gmail.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/mtd/nand/sh_flctl.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
> index 2ee9a1b..ed86a64 100644
> --- a/drivers/mtd/nand/sh_flctl.c
> +++ b/drivers/mtd/nand/sh_flctl.c
> @@ -919,6 +919,7 @@ static int __devinit flctl_probe(struct platform_device
> *pdev)
> 
>  err_chip:
>  	pm_runtime_disable(&pdev->dev);
> +	iounmap(flctl->reg);
>  err_iomap:
>  	kfree(flctl);
>  	return ret;
> @@ -930,6 +931,7 @@ static int __devexit flctl_remove(struct platform_device
> *pdev)
> 
>  	nand_release(&flctl->mtd);
>  	pm_runtime_disable(&pdev->dev);
> +	iounmap(flctl->reg);
>  	kfree(flctl);
> 
>  	return 0;

-- 
Regards,

Laurent Pinchart

