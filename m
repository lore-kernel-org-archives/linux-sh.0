From: Simon Horman <horms@verge.net.au>
Date: Mon, 17 Aug 2015 15:02:14 +0000
Subject: Re: [PATCH] ARM: shmobile: remove paragraph on DT reference platforms
Message-Id: <20150817150214.GB12227@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1439560444-5111-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1439560444-5111-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Aug 14, 2015 at 03:54:04PM +0200, Ulrich Hecht wrote:
> They have all been eliminated now.
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/shmobile.txt | 4 ----
>  1 file changed, 4 deletions(-)

Thanks, I have queued this up for v4.4.

> diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
> index f8aad0b..1d70e78e 100644
> --- a/Documentation/devicetree/bindings/arm/shmobile.txt
> +++ b/Documentation/devicetree/bindings/arm/shmobile.txt
> @@ -57,7 +57,3 @@ Boards:
>      compatible = "renesas,marzen", "renesas,r8a7779"
>    - Silk
>      compatible = "renesas,silk", "renesas,r8a7794";
> -
> -Note: Reference Device Tree Implementations are temporary implementations
> -      to ease the migration from platform devices to Device Tree, and are
> -      intended to be removed in the future.
> -- 
> 2.4.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
