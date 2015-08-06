From: Simon Horman <horms@verge.net.au>
Date: Thu, 06 Aug 2015 00:37:51 +0000
Subject: Re: [PATCH] ARM: shmobile: Add silk device tree bindings documentation
Message-Id: <20150806003751.GC17231@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1438723848-14812-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1438723848-14812-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Aug 05, 2015 at 06:30:48AM +0900, Simon Horman wrote:
> Add Silk Device tree bindings Documentation, listing it as a supported board.
> 
> This allows to use checkpatch to validate DTSes referring to the Silk board.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Thanks, I have queued this up for v4.4 rather than as a fix for v4.3
as it doesn't have any run or build time effect.

> ---
>  Documentation/devicetree/bindings/arm/shmobile.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
> index c4f19b2e7dd9..f3f96b5a7418 100644
> --- a/Documentation/devicetree/bindings/arm/shmobile.txt
> +++ b/Documentation/devicetree/bindings/arm/shmobile.txt
> @@ -57,6 +57,8 @@ Boards:
>      compatible = "renesas,lager", "renesas,r8a7790"
>    - Marzen
>      compatible = "renesas,marzen", "renesas,r8a7779"
> +  - Silk
> +    compatible = "renesas,silk", "renesas,r8a7794";
>  
>  Note: Reference Device Tree Implementations are temporary implementations
>        to ease the migration from platform devices to Device Tree, and are
> -- 
> 2.1.4
> 
