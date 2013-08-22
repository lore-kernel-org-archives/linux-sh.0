From: Simon Horman <horms@verge.net.au>
Date: Thu, 22 Aug 2013 06:24:58 +0000
Subject: Re: [PATCH v2 6/9] ARM: shmobile: marzen: Select DRM_RCAR_DU in defconfig
Message-Id: <20130822062458.GK11086@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1375916192-22647-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1375916192-22647-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Aug 08, 2013 at 12:56:29AM +0200, Laurent Pinchart wrote:
> A R-Car DU DRM device is registered for the Marzen board, select the
> corresponding driver in its defconfig.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  arch/arm/configs/marzen_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/configs/marzen_defconfig b/arch/arm/configs/marzen_defconfig
> index 82e4040..26f30be 100644
> --- a/arch/arm/configs/marzen_defconfig
> +++ b/arch/arm/configs/marzen_defconfig
> @@ -85,6 +85,8 @@ CONFIG_GPIO_RCAR=y
>  CONFIG_THERMAL=y
>  CONFIG_RCAR_THERMAL=y
>  CONFIG_SSB=y
> +CONFIG_DRM=y
> +CONFIG_DRM_RCAR_DU=y
>  CONFIG_USB=y
>  CONFIG_USB_RCAR_PHY=y
>  CONFIG_MMC=y

Thanks, I have queued this up in the defconfig branch.
