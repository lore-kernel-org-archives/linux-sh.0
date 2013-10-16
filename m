From: Simon Horman <horms@verge.net.au>
Date: Wed, 16 Oct 2013 00:39:22 +0000
Subject: Re: [PATCH 1/2] ARM: shmobile: r8a7790: add QSPI support
Message-Id: <20131016003922.GO22321@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1368173119-27345-2-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1368173119-27345-2-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Oct 15, 2013 at 06:08:23PM +0900, Cao Minh Hiep wrote:
> From: Hiep Cao Minh <cm-hiep@jinso.co.jp>
> 
> Add platform device and clock for the r8a7790 QSPI.
> 
> Signed-off-by: Hiep Cao Minh <cm-hiep@jinso.co.jp>

Hi Hiep-san,

thanks for your nice patches :)

Morimoto-san, Magnus,

It seems to me that moving all of the device registration
into the board-lager.c would be more in keeping with our
recent work. Could you confirm this or otherwise?

> ---
>  arch/arm/mach-shmobile/clock-r8a7790.c        |    4 ++++
>  arch/arm/mach-shmobile/include/mach/r8a7790.h |    2 ++
>  arch/arm/mach-shmobile/setup-r8a7790.c        |   16 ++++++++++++++++
>  3 files changed, 22 insertions(+)
> 
> diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
> index fc36d3d..baabceb 100644
> --- a/arch/arm/mach-shmobile/clock-r8a7790.c
> +++ b/arch/arm/mach-shmobile/clock-r8a7790.c
> @@ -52,6 +52,7 @@
>  #define SMSTPCR5 0xe6150144
>  #define SMSTPCR7 0xe615014c
>  #define SMSTPCR8 0xe6150990
> +#define SMSTPCR9 0xE6150994
>  
>  #define SDCKCR		0xE6150074
>  #define SD2CKCR		0xE6150078
> @@ -181,6 +182,7 @@ static struct clk div6_clks[DIV6_NR] = {
>  
>  /* MSTP */
>  enum {
> +	MSTP917,
>  	MSTP813,
>  	MSTP721, MSTP720,
>  	MSTP717, MSTP716,
> @@ -192,6 +194,7 @@ enum {
>  };
>  
>  static struct clk mstp_clks[MSTP_NR] = {
> +	[MSTP917] = SH_CLK_MSTP32(&qspi_clk, SMSTPCR9, 17, 0), /* QSPI */
>  	[MSTP813] = SH_CLK_MSTP32(&p_clk, SMSTPCR8, 13, 0), /* Ether */
>  	[MSTP721] = SH_CLK_MSTP32(&p_clk, SMSTPCR7, 21, 0), /* SCIF0 */
>  	[MSTP720] = SH_CLK_MSTP32(&p_clk, SMSTPCR7, 20, 0), /* SCIF1 */
> @@ -276,6 +279,7 @@ static struct clk_lookup lookups[] = {
>  	CLKDEV_DEV_ID("ee220000.mmcif", &mstp_clks[MSTP305]),
>  	CLKDEV_DEV_ID("sh_mmcif.1", &mstp_clks[MSTP305]),
>  	CLKDEV_DEV_ID("sh_cmt.0", &mstp_clks[MSTP124]),
> +	CLKDEV_DEV_ID("qspi.0", &mstp_clks[MSTP917]),
>  };
>  
>  #define R8A7790_CLOCK_ROOT(e, m, p0, p1, p30, p31)		\
> diff --git a/arch/arm/mach-shmobile/include/mach/r8a7790.h b/arch/arm/mach-shmobile/include/mach/r8a7790.h
> index 788d559..d590cad 100644
> --- a/arch/arm/mach-shmobile/include/mach/r8a7790.h
> +++ b/arch/arm/mach-shmobile/include/mach/r8a7790.h
> @@ -1,5 +1,6 @@
>  #ifndef __ASM_R8A7790_H__
>  #define __ASM_R8A7790_H__
> +#include <linux/spi/rspi.h>
>  
>  void r8a7790_add_standard_devices(void);
>  void r8a7790_add_dt_devices(void);
> @@ -7,6 +8,7 @@ void r8a7790_clock_init(void);
>  void r8a7790_pinmux_init(void);
>  void r8a7790_init_delay(void);
>  void r8a7790_timer_init(void);
> +void r8a7790_add_qspi_device(struct rspi_plat_data *pdata);
>  
>  #define MD(nr) BIT(nr)
>  u32 r8a7790_read_mode_pins(void);
> diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
> index d0f5c9f..30e3362 100644
> --- a/arch/arm/mach-shmobile/setup-r8a7790.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7790.c
> @@ -30,6 +30,22 @@
>  #include <mach/irqs.h>
>  #include <mach/r8a7790.h>
>  #include <asm/mach/arch.h>
> +#include <linux/spi/spi.h>
> +#include <linux/spi/rspi.h>
> +
> +/* QSPI resource */
> +static struct resource qspi_resources[] __initdata = {
> +	DEFINE_RES_MEM(0xe6b10000, 0x1000),
> +	DEFINE_RES_IRQ(gic_spi(184)),
> +};
> +
> +void __init r8a7790_add_qspi_device(struct rspi_plat_data *pdata)
> +{
> +	platform_device_register_resndata(
> +		&platform_bus, "qspi", 0,
> +		qspi_resources, ARRAY_SIZE(qspi_resources),
> +		pdata, sizeof(*pdata));
> +}
>  
>  static struct resource pfc_resources[] __initdata = {
>  	DEFINE_RES_MEM(0xe6060000, 0x250),
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
