From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 07 Aug 2013 17:21:02 +0000
Subject: Re: [PATCH 4/5] ARM: shmobile: marzen: Add Display Unit support
Message-Id: <520281FE.6090202@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1375892397-5822-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1375892397-5822-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 08/07/2013 08:19 PM, Laurent Pinchart wrote:

> Support the DU0 VGA and DU1 LVDS outputs. DU1 is connected to a
> Mitsubishi AA104XD12 panel (10.4" XGA).

> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>   arch/arm/configs/marzen_defconfig     |  2 ++
>   arch/arm/mach-shmobile/board-marzen.c | 51 +++++++++++++++++++++++++++++++++++
>   2 files changed, 53 insertions(+)

> diff --git a/arch/arm/configs/marzen_defconfig b/arch/arm/configs/marzen_defconfig
> index 82e4040..26f30be 100644
> --- a/arch/arm/configs/marzen_defconfig
> +++ b/arch/arm/configs/marzen_defconfig
> @@ -85,6 +85,8 @@ CONFIG_GPIO_RCAR=y
>   CONFIG_THERMAL=y
>   CONFIG_RCAR_THERMAL=y
>   CONFIG_SSB=y
> +CONFIG_DRM=y
> +CONFIG_DRM_RCAR_DU=y
>   CONFIG_USB=y
>   CONFIG_USB_RCAR_PHY=y
>   CONFIG_MMC=y

    Should be in a separate patch.

> diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
> index 3551b54..325cd0e 100644
> --- a/arch/arm/mach-shmobile/board-marzen.c
> +++ b/arch/arm/mach-shmobile/board-marzen.c
[...]
> +static struct rcar_du_platform_data du_pdata = {

    Should be annotated with '__initdata'.

> +	.encoders = du_encoders,
> +	.num_encoders = ARRAY_SIZE(du_encoders),
> +};
> +

WBR, Sergei

