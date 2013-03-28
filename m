From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 28 Mar 2013 12:46:01 +0000
Subject: Re: [PATCH v2 1/2] ARM: mach-shmobile: r8a7779: Add DU support
Message-Id: <51543B89.1030504@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1364412073-12322-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1364412073-12322-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 27-03-2013 23:21, Laurent Pinchart wrote:

> Add a function to register the DU device with board-specific platform
> data.

> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>   arch/arm/mach-shmobile/include/mach/common.h |  1 +
>   arch/arm/mach-shmobile/setup-r8a7779.c       | 30 ++++++++++++++++++++++++++++
>   2 files changed, 31 insertions(+)

> diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
> index 03f73de..4531872 100644
> --- a/arch/arm/mach-shmobile/include/mach/common.h
> +++ b/arch/arm/mach-shmobile/include/mach/common.h
> @@ -68,6 +68,7 @@ extern void r8a7779_earlytimer_init(void);
>   extern void r8a7779_add_early_devices(void);
>   extern void r8a7779_add_standard_devices(void);
>   extern void r8a7779_add_standard_devices_dt(void);
> +extern void r8a7779_add_du_device(void *pdata);

    Maybe r8a7779_add_du0_device()?

> diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
> index a460ba3..2f817d8 100644
> --- a/arch/arm/mach-shmobile/setup-r8a7779.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7779.c
> @@ -393,6 +393,29 @@ static struct platform_device sata_device = {
[...]
> +static struct platform_device du_device = {
> +	.name		= "rcar-du",
> +	.num_resources	= ARRAY_SIZE(du_resources),
> +	.resource	= du_resources,
> +	.id		= 0,

    You probably should have written in the subject "add DU0 support".

> +	.dev	= {
> +		.coherent_dma_mask = ~0,

    Use DMA_BIT_MASK() please.

WBR, Sergei

