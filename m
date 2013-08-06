From: Simon Horman <horms@verge.net.au>
Date: Tue, 06 Aug 2013 00:12:25 +0000
Subject: Re: [PATCH 3/4] ARM: shmobile: bockw: add missing __initdata
Message-Id: <20130806001221.GG13274@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87siys98q9.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87siys98q9.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Aug 01, 2013 at 06:34:09PM -0700, Kuninori Morimoto wrote:
> This patch adds missing __initdata to driver data/resource
> which are used from platform_device_register_xxx()
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Hi Morimoto-san,

I have queued this up in v3.12 in the cleanup4 branch.
I had to resolve a minor conflict in the last hunk,
specifically, the cleanup4 branch has "/* MMC */" but
the devel branch, which I assume you based this patch on,
does not - probably due to a miss-merge.

In any case, I have queued up the following.
Please check that it is correct.

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

ARM: shmobile: bockw: add missing __initdata

This patch adds missing __initdata to driver data/resource
which are used from platform_device_register_xxx()

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
[horms+renesas@verge.net.au: Resolved minor conflict]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index d555464..6ad439d 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -64,14 +64,14 @@ static struct regulator_consumer_supply dummy_supplies[] = {
 	REGULATOR_SUPPLY("vdd33a", "smsc911x"),
 };
 
-static struct smsc911x_platform_config smsc911x_data = {
+static struct smsc911x_platform_config smsc911x_data __initdata = {
 	.irq_polarity	= SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
 	.irq_type	= SMSC911X_IRQ_TYPE_PUSH_PULL,
 	.flags		= SMSC911X_USE_32BIT,
 	.phy_interface	= PHY_INTERFACE_MODE_MII,
 };
 
-static struct resource smsc911x_resources[] = {
+static struct resource smsc911x_resources[] __initdata = {
 	DEFINE_RES_MEM(0x18300000, 0x1000),
 	DEFINE_RES_IRQ(irq_pin(0)), /* IRQ 0 */
 };
@@ -80,7 +80,7 @@ static struct resource smsc911x_resources[] = {
 static struct rcar_phy_platform_data usb_phy_platform_data __initdata;
 
 /* SDHI */
-static struct sh_mobile_sdhi_info sdhi0_info = {
+static struct sh_mobile_sdhi_info sdhi0_info __initdata = {
 	.tmio_caps	= MMC_CAP_SD_HIGHSPEED,
 	.tmio_ocr_mask	= MMC_VDD_165_195 | MMC_VDD_32_33 | MMC_VDD_33_34,
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT,
@@ -135,7 +135,7 @@ static struct spi_board_info spi_board_info[] __initdata = {
 };
 
 /* MMC */
-static struct sh_mmcif_plat_data sh_mmcif_plat = {
+static struct sh_mmcif_plat_data sh_mmcif_plat __initdata = {
 	.sup_pclk	= 0,
 	.ocr		= MMC_VDD_165_195 | MMC_VDD_32_33 | MMC_VDD_33_34,
 	.caps		= MMC_CAP_4_BIT_DATA |
