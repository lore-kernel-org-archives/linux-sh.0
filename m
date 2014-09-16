From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 16 Sep 2014 16:16:09 +0000
Subject: [PATCH] ARM: shmobile: r8a7790: lager: SCIF DMA RX test setup
Message-Id: <1410884169-5958-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

This is my configuration and setup to debug the DMA RX issue of the
SCIF. This is only interesting for people who want to debug the issue as
well. Definately not for upstream!

The target platform for this patch is the r8a7790 Lager board.
It is based on top of the SYS-DMAC-AUXDATA patches by Magnus.

First, free SCIF0 from the console, so we have better control over it
when debugging. Then, simplify the kernel config a little and do
activate DMA for SCIF and enable verbose DMA output.

Add the DMAC-AUXDATA settings into lager boardcode. This part is based
on a patch by Magnus Damm.

Finally, enable debug output and add some more to investigate the
issue.

Not-Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
---

The following patches are needed on top of renesas-devel-20140911-v3.17-rc4:

mmc: sdhi: enable .dma_rx_offset for platform prototype
DMA: shdma: 40-bit address prototype
ARM: shmobile: Lager SYS-DMAC prototype
ARM: shmobile: Lager SYS-DMAC and MMCIF prototype
ARM: shmobile: Lager SYS-DMAC and SDHI prototype
ARM: shmobile: Lager SYS-DMAC and SCIF prototype
serial: sh-sci: Allow AUXDATA DMAC parameters

 arch/arm/boot/dts/r8a7790-lager.dts            |  2 +-
 arch/arm/configs/lager_defconfig               | 45 ++++++++------------------
 arch/arm/mach-shmobile/board-lager-reference.c | 30 +++++++----------
 drivers/tty/serial/sh-sci.c                    |  7 +++-
 4 files changed, 32 insertions(+), 52 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 782f0aa938b3..47406ec234f0 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -24,7 +24,7 @@
 	};
 
 	chosen {
-		bootargs = "console=ttySC6,115200 ignore_loglevel rw root=/dev/nfs ip=dhcp";
+		bootargs = "console=ttySC7,115200 ignore_loglevel rw ip2.168.64.90";
 	};
 
 	memory@40000000 {
diff --git a/arch/arm/configs/lager_defconfig b/arch/arm/configs/lager_defconfig
index 929c571ea29b..8b450538960e 100644
--- a/arch/arm/configs/lager_defconfig
+++ b/arch/arm/configs/lager_defconfig
@@ -3,6 +3,9 @@ CONFIG_NO_HZ=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS_SOURCE="rootfs.cpio.xz"
+CONFIG_RD_XZ=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_SYSCTL_SYSCALL=y
 CONFIG_EMBEDDED=y
@@ -12,28 +15,20 @@ CONFIG_SLAB=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_SHMOBILE_LEGACY=y
+CONFIG_ARCH_SHMOBILE_MULTI=y
 CONFIG_ARCH_R8A7790=y
 CONFIG_MACH_LAGER=y
-# CONFIG_SH_TIMER_TMU is not set
-# CONFIG_EM_TIMER_STI is not set
 CONFIG_ARM_ERRATA_430973=y
-CONFIG_ARM_ERRATA_458693=y
-CONFIG_ARM_ERRATA_460075=y
-CONFIG_ARM_ERRATA_743622=y
 CONFIG_ARM_ERRATA_754322=y
 CONFIG_PCI=y
 CONFIG_PCI_RCAR_GEN2=y
 CONFIG_PCI_RCAR_GEN2_PCIE=y
 CONFIG_HAVE_ARM_ARCH_TIMER=y
 CONFIG_AEABI=y
-# CONFIG_OABI_COMPAT is not set
-CONFIG_FORCE_MAX_ZONEORDER
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_KEXEC=y
-CONFIG_AUTO_ZRELADDR=y
 CONFIG_VFP=y
 CONFIG_NEON=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
@@ -57,9 +52,6 @@ CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_MTD=y
 CONFIG_MTD_M25P80=y
 CONFIG_MTD_SPI_NOR=y
-CONFIG_BLK_DEV_SD=y
-CONFIG_ATA=y
-CONFIG_SATA_RCAR=y
 CONFIG_NETDEVICES=y
 # CONFIG_NET_CORE is not set
 # CONFIG_NET_VENDOR_ARC is not set
@@ -88,15 +80,17 @@ CONFIG_KEYBOARD_GPIO=y
 CONFIG_SERIAL_SH_SCI=y
 CONFIG_SERIAL_SH_SCI_NR_UARTS
 CONFIG_SERIAL_SH_SCI_CONSOLE=y
+CONFIG_SERIAL_SH_SCI_DMA=y
 # CONFIG_HW_RANDOM is not set
+CONFIG_I2C=y
+CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_GPIO=y
+CONFIG_I2C_RIIC=y
 CONFIG_I2C_SH_MOBILE=y
 CONFIG_I2C_RCAR=y
 CONFIG_SPI=y
 CONFIG_SPI_RSPI=y
 CONFIG_SPI_SH_MSIOF=y
-CONFIG_GPIO_SH_PFC=y
-CONFIG_GPIOLIB=y
 CONFIG_GPIO_RCAR=y
 # CONFIG_HWMON is not set
 CONFIG_THERMAL=y
@@ -105,29 +99,15 @@ CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_DA9210=y
 CONFIG_REGULATOR_GPIO=y
-CONFIG_MEDIA_SUPPORT=y
-CONFIG_MEDIA_CAMERA_SUPPORT=y
-CONFIG_V4L_PLATFORM_DRIVERS=y
-CONFIG_SOC_CAMERA=y
-CONFIG_SOC_CAMERA_PLATFORM=y
-CONFIG_VIDEO_RCAR_VIN=y
-# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
-CONFIG_VIDEO_ADV7180=y
-CONFIG_DRM=y
-CONFIG_DRM_RCAR_DU=y
-CONFIG_SOUND=y
-CONFIG_SND=y
-CONFIG_SND_SOC=y
-CONFIG_SND_SOC_RCAR=y
+# CONFIG_VGA_ARB is not set
 # CONFIG_USB_SUPPORT is not set
-CONFIG_MMC=y
-CONFIG_MMC_SDHI=y
-CONFIG_MMC_SH_MMCIF=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_GPIO=y
 CONFIG_RTC_CLASS=y
 CONFIG_DMADEVICES=y
+CONFIG_DMADEVICES_DEBUG=y
+CONFIG_DMADEVICES_VDEBUG=y
 CONFIG_SH_DMAE=y
 # CONFIG_IOMMU_SUPPORT is not set
 # CONFIG_DNOTIFY is not set
@@ -143,8 +123,11 @@ CONFIG_NFS_V4_1=y
 CONFIG_ROOT_NFS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
+CONFIG_PRINTK_TIME=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
+CONFIG_DEBUG_FS=y
 # CONFIG_ARM_UNWIND is not set
+CONFIG_CRYPTO_SHA256=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
diff --git a/arch/arm/mach-shmobile/board-lager-reference.c b/arch/arm/mach-shmobile/board-lager-reference.c
index 0efa35621725..57d132244493 100644
--- a/arch/arm/mach-shmobile/board-lager-reference.c
+++ b/arch/arm/mach-shmobile/board-lager-reference.c
@@ -73,7 +73,7 @@ static const struct resource du_resources[] __initconst = {
 };
 
 #include <linux/sh_dma.h>
-#include <mach/dma-register.h>
+#include "dma-register.h"
 #include <linux/mmc/host.h>
 #include <linux/mmc/sh_mmcif.h>
 #include <linux/mfd/tmio.h>
@@ -135,29 +135,21 @@ enum {
 	.mid_rid	= r,					\
 }
 
-#define SYS_DMAC_SLAVE_TX(_id, _bit, _addr, toffset, roffset, t, r)	\
-{								\
-	.slave_id	= SYS_DMAC_SLAVE_## _id ##_TX,		\
-	.addr		= _addr + toffset,			\
-	.chcr		= CHCR_TX(XMIT_SZ_## _bit ##BIT),	\
-	.mid_rid	= t,					\
-}
-
 static const struct sh_dmae_slave_config r8a7790_sys_dmac_slaves[] = {
 	SYS_DMAC_SLAVE(MMCIF0, 32, 0xee200000, 0x34, 0x34, 0xd1, 0xd2),
 	SYS_DMAC_SLAVE(MMCIF1, 32, 0xee220000, 0x34, 0x34, 0xe1, 0xe2),
 	SYS_DMAC_SLAVE(SDHI0, 16, 0xee100000, 0x60, 0x2060, 0xcd, 0xce),
 	SYS_DMAC_SLAVE(SDHI2, 16, 0xee140000, 0x30, 0x2030, 0xc1, 0xc2),
-	SYS_DMAC_SLAVE_TX(SCIF0, 8, 0xe6e60000, 0xc, 0x14, 0x29, 0x2a),
-	SYS_DMAC_SLAVE_TX(SCIF1, 8, 0xe6e68000, 0xc, 0x14, 0x2d, 0x2e),
-	SYS_DMAC_SLAVE_TX(SCIFA0, 8, 0xe6c40000, 0x20, 0x24, 0x21, 0x22),
-	SYS_DMAC_SLAVE_TX(SCIFA1, 8, 0xe6c50000, 0x20, 0x24, 0x25, 0x26),
-	SYS_DMAC_SLAVE_TX(SCIFA2, 8, 0xe6c60000, 0x20, 0x24, 0x27, 0x28),
-	SYS_DMAC_SLAVE_TX(SCIFB0, 8, 0xe6c20000, 0x40, 0x60, 0x3d, 0x3e),
-	SYS_DMAC_SLAVE_TX(SCIFB1, 8, 0xe6c30000, 0x40, 0x60, 0x19, 0x1a),
-	SYS_DMAC_SLAVE_TX(SCIFB2, 8, 0xe6ce0000, 0x40, 0x60, 0x1d, 0x1e),
-	SYS_DMAC_SLAVE_TX(HSCIF0, 8, 0xe62c0000, 0xc, 0x14, 0x39, 0x3a),
-	SYS_DMAC_SLAVE_TX(HSCIF1, 8, 0xe62c8000, 0xc, 0x14, 0x4d, 0x4e),
+	SYS_DMAC_SLAVE(SCIF0, 8, 0xe6e60000, 0xc, 0x14, 0x29, 0x2a),
+	SYS_DMAC_SLAVE(SCIF1, 8, 0xe6e68000, 0xc, 0x14, 0x2d, 0x2e),
+	SYS_DMAC_SLAVE(SCIFA0, 8, 0xe6c40000, 0x20, 0x24, 0x21, 0x22),
+	SYS_DMAC_SLAVE(SCIFA1, 8, 0xe6c50000, 0x20, 0x24, 0x25, 0x26),
+	SYS_DMAC_SLAVE(SCIFA2, 8, 0xe6c60000, 0x20, 0x24, 0x27, 0x28),
+	SYS_DMAC_SLAVE(SCIFB0, 8, 0xe6c20000, 0x40, 0x60, 0x3d, 0x3e),
+	SYS_DMAC_SLAVE(SCIFB1, 8, 0xe6c30000, 0x40, 0x60, 0x19, 0x1a),
+	SYS_DMAC_SLAVE(SCIFB2, 8, 0xe6ce0000, 0x40, 0x60, 0x1d, 0x1e),
+	SYS_DMAC_SLAVE(HSCIF0, 8, 0xe62c0000, 0xc, 0x14, 0x39, 0x3a),
+	SYS_DMAC_SLAVE(HSCIF1, 8, 0xe62c8000, 0xc, 0x14, 0x4d, 0x4e),
 };
 
 static const struct sh_dmae_channel r8a7790_sys_dmac_channels[] = {
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index b11819bc95c4..1edc69a66628 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -21,7 +21,7 @@
 #define SUPPORT_SYSRQ
 #endif
 
-#undef DEBUG
+#define DEBUG
 
 #include <linux/clk.h>
 #include <linux/console.h>
@@ -1396,6 +1396,8 @@ static void work_fn_rx(struct work_struct *work)
 
 	if (dma_async_is_tx_complete(s->chan_rx, s->active_rx, NULL, NULL) ! 	    DMA_COMPLETE) {
+		u16 ssr;
+
 		/* Handle incomplete DMA receive */
 		struct dma_chan *chan = s->chan_rx;
 		struct shdma_desc *sh_desc = container_of(desc,
@@ -1409,6 +1411,9 @@ static void work_fn_rx(struct work_struct *work)
 
 		spin_lock_irqsave(&port->lock, flags);
 		count = sci_dma_rx_push(s, sh_desc->partial);
+ssr = serial_port_in(port, SCxSR);
+printk(KERN_INFO "****** ssr1: %08x\n", ssr);
+serial_port_out(port, SCxSR, ssr & ~(1 | SCxSR_RDxF(port)));
 		spin_unlock_irqrestore(&port->lock, flags);
 
 		if (count)
-- 
2.0.0

