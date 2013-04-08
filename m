From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 08 Apr 2013 12:06:59 +0000
Subject: Re: [PATCH 05/10] ARM: shmobile: r8a7790: Register GPIO devices
Message-Id: <5162B2E3.6010709@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1365413782-17036-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1365413782-17036-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 08-04-2013 13:36, Laurent Pinchart wrote:

> Move GPIOs handling from the PFC device to separate GPIO devices.

> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>   arch/arm/mach-shmobile/setup-r8a7790.c | 35 +++++++++++++++++++++++++++++++++-
>   1 file changed, 34 insertions(+), 1 deletion(-)

> diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
> index 49de2d5..eeef5f6 100644
> --- a/arch/arm/mach-shmobile/setup-r8a7790.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7790.c
[...]
> @@ -31,13 +32,45 @@
>
>   static const struct resource pfc_resources[] = {
>   	DEFINE_RES_MEM(0xe6060000, 0x250),
> -	DEFINE_RES_MEM(0xe6050000, 0x5050),
>   };
>
> +#define R8A7790_GPIO(idx)						\
> +static struct resource r8a7790_gpio##idx##_resources[] = {		\
> +	DEFINE_RES_MEM(0xe6050000 + 0x1000 * (idx), 0x50),		\
> +	DEFINE_RES_IRQ(gic_spi(4 + (idx))),				\

    Aren't we supposed to abandon the use of gic_spi() for gic_iid() now?

WBR, Sergei

