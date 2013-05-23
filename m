From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 23 May 2013 12:56:41 +0000
Subject: Re: [PATCH 06/17 v2] ARM: shmobile: r8a7778: add I2C support
Message-Id: <519E1209.1000107@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <874ndu4c4n.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <874ndu4c4n.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 23-05-2013 7:18, Kuninori Morimoto wrote:

> Signed-off-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
[...]

> diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
> index a02efce..87b74a5 100644
> --- a/arch/arm/mach-shmobile/setup-r8a7778.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7778.c
> @@ -173,6 +173,31 @@ void __init r8a7778_sdhi_init(int id,
>   		info, sizeof(*info));
>   }
>
> +/* I2C */
> +static struct resource i2c_resources[] = {

    You should annotate this with __initdata, otherwise you're wasting 
memory. I seem to remember that I've already told you this.

> +	/* I2C0 */
> +	DEFINE_RES_MEM(0xffc70000, 0x1000),
> +	DEFINE_RES_IRQ(gic_iid(0x63)),
> +	/* I2C1 */
> +	DEFINE_RES_MEM(0xffc71000, 0x1000),
> +	DEFINE_RES_IRQ(gic_iid(0x6e)),
> +	/* I2C2 */
> +	DEFINE_RES_MEM(0xffc72000, 0x1000),
> +	DEFINE_RES_IRQ(gic_iid(0x6c)),
> +	/* I2C3 */
> +	DEFINE_RES_MEM(0xffc73000, 0x1000),
> +	DEFINE_RES_IRQ(gic_iid(0x6d)),
> +};

WBR, Sergei

