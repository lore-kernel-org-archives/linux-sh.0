From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 16 May 2013 15:10:35 +0000
Subject: Re: [PATCH 04/12] ARM: shmobile: r8a7778: add I2C support
Message-Id: <5194F6EB.8020304@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87d2srwg3k.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87d2srwg3k.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 16-05-2013 11:15, Kuninori Morimoto wrote:

    It would be good if you have at least copied my changelog.

> Signed-off-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>   arch/arm/mach-shmobile/clock-r8a7778.c        |   14 +++++++++++++-
>   arch/arm/mach-shmobile/include/mach/r8a7778.h |    2 ++
>   arch/arm/mach-shmobile/setup-r8a7778.c        |   25 +++++++++++++++++++++++++
>   3 files changed, 40 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-shmobile/clock-r8a7778.c b/arch/arm/mach-shmobile/clock-r8a7778.c
> index b251e4d..1386c59 100644
> --- a/arch/arm/mach-shmobile/clock-r8a7778.c
> +++ b/arch/arm/mach-shmobile/clock-r8a7778.c
> @@ -105,7 +105,8 @@ static struct clk *main_clks[] = {
>   enum {
>   	MSTP323, MSTP322, MSTP321,
>   	MSTP114,
> -	MSTP026, MSTP025, MSTP024, MSTP023, MSTP022, MSTP021,
> +	MSTP030,
> +	MSTP029, MSTP028, MSTP027, MSTP026, MSTP025, MSTP024, MSTP023, MSTP022, MSTP021,

    What does checkpatch.pl say here?

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

    You can annotate this with '__initdata'.

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
> +
> +void __init r8a7778_add_i2c_device(int id)
> +{
> +	BUG_ON(id < 0 || id > 3);
> +
> +	platform_device_register_simple(
> +		"i2c-rcar", id,
> +		i2c_resources + (2 * id), 2);

    () around * not needed.

> +}
> +

WBR, Sergei

