From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 16 May 2013 15:07:21 +0000
Subject: Re: [PATCH 05/12] ARM: shmobile: r8a7778: add HSPI support
Message-Id: <5194F629.8050503@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87bo8bwg3b.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87bo8bwg3b.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 16-05-2013 11:15, Kuninori Morimoto wrote:

> Signed-off-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

[...]

> diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
> index 87b74a5..8f011cb 100644
> --- a/arch/arm/mach-shmobile/setup-r8a7778.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7778.c
> @@ -198,6 +198,29 @@ void __init r8a7778_add_i2c_device(int id)
>   		i2c_resources + (2 * id), 2);
>   }
>
> +/* HSPI */
> +static struct resource hspi_resources[] = {

    You can annotate this with '__initdata'.

> +	/* HSPI0 */
> +	DEFINE_RES_MEM(0xfffc7000, 0x18),
> +	DEFINE_RES_IRQ(gic_iid(0x5f)),
> +	/* HSPI1 */
> +	DEFINE_RES_MEM(0xfffc8000, 0x18),
> +	DEFINE_RES_IRQ(gic_iid(0x74)),
> +	/* HSPI2 */
> +	DEFINE_RES_MEM(0xfffc6000, 0x18),
> +	DEFINE_RES_IRQ(gic_iid(0x75)),
> +};
> +
> +void __init r8a7778_add_hspi_device(int id)
> +{
> +	BUG_ON(id < 0 || id > 2);
> +
> +	platform_device_register_simple(
> +		"sh-hspi", id,
> +		hspi_resources + (2 * id), 2);
> +}
> +
> +

WBR, Sergei


