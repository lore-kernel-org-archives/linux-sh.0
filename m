From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 18 Mar 2014 23:27:41 +0000
Subject: Re: [PATCH] micrel: fix masking off LED bits
Message-Id: <1643301.laIYkMizQV@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <201403190258.16812.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201403190258.16812.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org, ben.dooks@codethink.co.uk

Hi Sergei,

Thank you for the patch.

On Wednesday 19 March 2014 02:58:16 Sergei Shtylyov wrote:
> Commit 20d8435a1cff (phy: micrel: add of configuration for LED mode) made
> the obvious mistake when masking off  the LED mode bits: forgot to do a
> logical NOT to the mask with which it ANDs the register value, so that
> unrelated bits are cleared instead.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Good catch.

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> This patch is against DaveM's 'net-next.git' repo.
> 
>  drivers/net/phy/micrel.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: net-next/drivers/net/phy/micrel.c
> =================================> --- net-next.orig/drivers/net/phy/micrel.c
> +++ net-next/drivers/net/phy/micrel.c
> @@ -167,7 +167,7 @@ static int kszphy_setup_led(struct phy_d
>  	if (temp < 0)
>  		return temp;
> 
> -	temp &= 3 << shift;
> +	temp &= ~(3 << shift);
>  	temp |= val << shift;
>  	rc = phy_write(phydev, reg, temp);


-- 
Regards,

Laurent Pinchart

