From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 23 May 2013 12:54:44 +0000
Subject: Re: [PATCH 07/17 v2] ARM: shmobile: r8a7778: add HSPI support
Message-Id: <519E1194.6040404@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8738te4c3u.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8738te4c3u.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 23-05-2013 7:19, Kuninori Morimoto wrote:

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

    You forgot to specify __initdata here -- you're just wasting memory.

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

WBR, Sergei

