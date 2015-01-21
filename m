From: Simon Horman <horms@verge.net.au>
Date: Wed, 21 Jan 2015 01:59:20 +0000
Subject: Re: [PATCH] ARM: shmobile: Enable ape6evm board in multiplatform defconfig
Message-Id: <20150121015919.GA30598@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1421759293-31849-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1421759293-31849-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jan 20, 2015 at 02:08:13PM +0100, Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Untested due to lack of hardware

Thanks. Tested and queued up for v3.21.

> ---
>  arch/arm/configs/shmobile_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
> index e365c31e9dd513f3..6512c41ebcec28c4 100644
> --- a/arch/arm/configs/shmobile_defconfig
> +++ b/arch/arm/configs/shmobile_defconfig
> @@ -12,6 +12,7 @@ CONFIG_SLAB=y
>  CONFIG_ARCH_SHMOBILE_MULTI=y
>  CONFIG_ARCH_EMEV2=y
>  CONFIG_ARCH_R7S72100=y
> +CONFIG_ARCH_R8A73A4=y
>  CONFIG_ARCH_R8A7740=y
>  CONFIG_ARCH_R8A7779=y
>  CONFIG_ARCH_R8A7790=y
> @@ -120,6 +121,7 @@ CONFIG_MFD_DA9063=y
>  CONFIG_REGULATOR_AS3711=y
>  CONFIG_REGULATOR_DA9210=y
>  CONFIG_REGULATOR_GPIO=y
> +CONFIG_REGULATOR_MAX8973=y
>  CONFIG_MEDIA_SUPPORT=y
>  CONFIG_MEDIA_CAMERA_SUPPORT=y
>  CONFIG_MEDIA_CONTROLLER=y
> -- 
> 1.9.1
> 
