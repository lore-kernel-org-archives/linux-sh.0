From: Simon Horman <horms@verge.net.au>
Date: Thu, 17 Oct 2013 01:40:37 +0000
Subject: Re: [PATCH 1/2] ARM: shmobile: r8a7790: add QSPI support
Message-Id: <20131017014037.GK21728@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1368173119-27345-2-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1368173119-27345-2-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

On Wed, Oct 16, 2013 at 08:03:25PM +0900, カオ ミン ヒェップ wrote:
> Hi Magnus-san, Simon-san
> 
> Thanks for your replying
> 
> 
> >>>---
> >>>  arch/arm/mach-shmobile/clock-r8a7790.c        |    4 ++++
> >>>  arch/arm/mach-shmobile/include/mach/r8a7790.h |    2 ++
> >>>  arch/arm/mach-shmobile/setup-r8a7790.c        |   16 ++++++++++++++++
> >>>  3 files changed, 22 insertions(+)
> >>>
> >>>diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
> >>>index fc36d3d..baabceb 100644
> >>>--- a/arch/arm/mach-shmobile/clock-r8a7790.c
> >>>+++ b/arch/arm/mach-shmobile/clock-r8a7790.c
> >>>@@ -52,6 +52,7 @@
> >>>  #define SMSTPCR5 0xe6150144
> >>>  #define SMSTPCR7 0xe615014c
> >>>  #define SMSTPCR8 0xe6150990
> >>>+#define SMSTPCR9 0xE6150994
> >>Please follow same style as other MSTP registers - use "e6" instead of "E6".
> >>
> I will do it!
> >>>  #define SDCKCR         0xE6150074
> >>>  #define SD2CKCR                0xE6150078
> >>>@@ -181,6 +182,7 @@ static struct clk div6_clks[DIV6_NR] = {
> >>>
> >>>  /* MSTP */
> >>>  enum {
> >>>+       MSTP917,
> >>>         MSTP813,
> >>>         MSTP721, MSTP720,
> >>>         MSTP717, MSTP716,
> >>>@@ -192,6 +194,7 @@ enum {
> >>>  };
> >>>
> >>>  static struct clk mstp_clks[MSTP_NR] = {
> >>>+       [MSTP917] = SH_CLK_MSTP32(&qspi_clk, SMSTPCR9, 17, 0), /* QSPI */
> >>>         [MSTP813] = SH_CLK_MSTP32(&p_clk, SMSTPCR8, 13, 0), /* Ether */
> >>>         [MSTP721] = SH_CLK_MSTP32(&p_clk, SMSTPCR7, 21, 0), /* SCIF0 */
> >>>         [MSTP720] = SH_CLK_MSTP32(&p_clk, SMSTPCR7, 20, 0), /* SCIF1 */
> >>>@@ -276,6 +279,7 @@ static struct clk_lookup lookups[] = {
> >>>         CLKDEV_DEV_ID("ee220000.mmcif", &mstp_clks[MSTP305]),
> >>>         CLKDEV_DEV_ID("sh_mmcif.1", &mstp_clks[MSTP305]),
> >>>         CLKDEV_DEV_ID("sh_cmt.0", &mstp_clks[MSTP124]),
> >>>+       CLKDEV_DEV_ID("qspi.0", &mstp_clks[MSTP917]),
> >>Is "qspi" the name of the driver? If so, where can I find it?
> I porting SPI driver to SPI-Mailing-list and Mark Brown replied that
> they are applied,
> I have tried to find them on
> https://patchwork.kernel.org/project/spi-devel-general/list/
> but not found. I am asking Mark Brown where he put them on.

Thanks, please let us know when you find out.

> >>>--- a/arch/arm/mach-shmobile/include/mach/r8a7790.h
> >>>+++ b/arch/arm/mach-shmobile/include/mach/r8a7790.h
> >>>@@ -1,5 +1,6 @@
> >>>  #ifndef __ASM_R8A7790_H__
> >>>  #define __ASM_R8A7790_H__
> >>>+#include <linux/spi/rspi.h>
> >>>
> >>>  void r8a7790_add_standard_devices(void);
> >>>  void r8a7790_add_dt_devices(void);
> >>>@@ -7,6 +8,7 @@ void r8a7790_clock_init(void);
> >>>  void r8a7790_pinmux_init(void);
> >>>  void r8a7790_init_delay(void);
> >>>  void r8a7790_timer_init(void);
> >>>+void r8a7790_add_qspi_device(struct rspi_plat_data *pdata);
> >>Please don't add these kind of functions. Do it all inside
> >>board-lager.c instead.
> >>
> >>name Simon may want you to split the board code and the SoC code as well.
> >I think that the best thing would be to move all of the device
> >initialisation code into patch two of this series and just leave the clock
> >portion in the first patch. That way Magnus's request above will be
> >addressed and there will be a board patch and an SoC patch.
> >
> >
> OK, I will modify them.
> 
> thanks,
> 
> Hiep.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
