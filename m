From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 06 Dec 2013 22:53:06 +0000
Subject: Re: [PATCH v2] ARM: shmobile: koelsch: Add DU device
Message-Id: <52A25552.5080508@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1386282891-2698-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1386282891-2698-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 06-12-2013 2:34, Laurent Pinchart wrote:

> Only the LVDS output is currently supported.

> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>   arch/arm/mach-shmobile/board-koelsch.c | 63 ++++++++++++++++++++++++++++++++++
>   1 file changed, 63 insertions(+)

> Changes since v1:

> - Rebased on top of renesas-devel-v3.13-rc2-20131202

> diff --git a/arch/arm/mach-shmobile/board-koelsch.c b/arch/arm/mach-shmobile/board-koelsch.c
> index 6e12914..53846ec 100644
> --- a/arch/arm/mach-shmobile/board-koelsch.c
> +++ b/arch/arm/mach-shmobile/board-koelsch.c
[...]
> @@ -26,13 +27,66 @@
>   #include <linux/leds.h>
>   #include <linux/pinctrl/machine.h>
>   #include <linux/platform_data/gpio-rcar.h>
> +#include <linux/platform_data/rcar-du.h>
>   #include <linux/platform_device.h>
>   #include <mach/common.h>
> +#include <mach/irqs.h>
>   #include <mach/r8a7791.h>
>   #include <mach/rcar-gen2.h>
>   #include <asm/mach-types.h>
>   #include <asm/mach/arch.h>
>
> +/* DU */
> +static struct rcar_du_encoder_data lager_du_encoders[] = {

    Apparently it should be named koelsch_du_encoders[].

> +static const struct rcar_du_platform_data lager_du_pdata __initconst = {

    Again, 'koelsch_du_pdata'...

WBR, Sergei

