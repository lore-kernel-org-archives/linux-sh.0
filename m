From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 08 Nov 2012 01:33:55 +0000
Subject: [PATCH 2/2] sh: add sh7752evb board support
Message-Id: <509B0C03.2000500@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This adds support for the Renesas R0P7752C00000RZ board.

This patch supports two Gigabit-Ethernets, eMMC, SDHI, UART,
USB Host, and USB peripheral.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 arch/sh/Makefile                    |    1 +
 arch/sh/boards/Kconfig              |    5 +
 arch/sh/boards/Makefile             |    1 +
 arch/sh/boards/board-sh7752evb.c    |  590 +++++++++++++++++++++++++++++++++++
 arch/sh/configs/sh7752evb_defconfig |  130 ++++++++
 arch/sh/tools/mach-types            |    1 +
 6 files changed, 728 insertions(+), 0 deletions(-)
 create mode 100644 arch/sh/boards/board-sh7752evb.c
 create mode 100644 arch/sh/configs/sh7752evb_defconfig

diff --git a/arch/sh/Makefile b/arch/sh/Makefile
index aed701c..38bdaa3 100644
--- a/arch/sh/Makefile
+++ b/arch/sh/Makefile
@@ -86,6 +86,7 @@ defaultimage-$(CONFIG_SH_RSK)			:= uImage
 defaultimage-$(CONFIG_SH_URQUELL)		:= uImage
 defaultimage-$(CONFIG_SH_MIGOR)			:= uImage
 defaultimage-$(CONFIG_SH_AP325RXA)		:= uImage
+defaultimage-$(CONFIG_SH_SH7752EVB)		:= uImage
 defaultimage-$(CONFIG_SH_SH7757LCR)		:= uImage
 defaultimage-$(CONFIG_SH_7724_SOLUTION_ENGINE)	:= uImage
 defaultimage-$(CONFIG_SH_7206_SOLUTION_ENGINE)	:= vmlinux
diff --git a/arch/sh/boards/Kconfig b/arch/sh/boards/Kconfig
index fb58057..dc8cded 100644
--- a/arch/sh/boards/Kconfig
+++ b/arch/sh/boards/Kconfig
@@ -172,6 +172,11 @@ config SH_HIGHLANDER
 	select SYS_SUPPORTS_PCI
 	select IO_TRAPPED if MMU

+config SH_SH7752EVB
+	bool "SH7752EVB"
+	depends on CPU_SUBTYPE_SH7752
+	select ARCH_REQUIRE_GPIOLIB
+
 config SH_SH7757LCR
 	bool "SH7757LCR"
 	depends on CPU_SUBTYPE_SH7757
diff --git a/arch/sh/boards/Makefile b/arch/sh/boards/Makefile
index 975a0f6..a38da39 100644
--- a/arch/sh/boards/Makefile
+++ b/arch/sh/boards/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_SH_EDOSK7760)	+= board-edosk7760.o
 obj-$(CONFIG_SH_ESPT)		+= board-espt.o
 obj-$(CONFIG_SH_POLARIS)	+= board-polaris.o
 obj-$(CONFIG_SH_TITAN)		+= board-titan.o
+obj-$(CONFIG_SH_SH7752EVB)	+= board-sh7752evb.o
 obj-$(CONFIG_SH_SH7757LCR)	+= board-sh7757lcr.o
 obj-$(CONFIG_SH_APSH4A3A)	+= board-apsh4a3a.o
 obj-$(CONFIG_SH_APSH4AD0A)	+= board-apsh4ad0a.o
diff --git a/arch/sh/boards/board-sh7752evb.c b/arch/sh/boards/board-sh7752evb.c
new file mode 100644
index 0000000..4a4d2ec
--- /dev/null
+++ b/arch/sh/boards/board-sh7752evb.c
@@ -0,0 +1,590 @@
+/*
+ * Renesas R0P7752C00000RZ Support.
+ *
+ * Copyright (C) 2012  Renesas Solutions Corp.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/gpio.h>
+#include <linux/irq.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/flash.h>
+#include <linux/io.h>
+#include <linux/regulator/fixed.h>
+#include <linux/regulator/machine.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/sh_mmcif.h>
+#include <linux/mmc/sh_mobile_sdhi.h>
+#include <linux/serial_8250.h>
+#include <linux/usb/renesas_usbhs.h>
+#include <linux/sh_eth.h>
+#include <cpu/sh7752.h>
+#include <asm/heartbeat.h>
+
+static struct resource heartbeat_resource = {
+	.start	= 0xffec005c,	/* PUDR */
+	.end	= 0xffec005c,
+	.flags	= IORESOURCE_MEM | IORESOURCE_MEM_8BIT,
+};
+
+static unsigned char heartbeat_bit_pos[] = { 0, 1, 2, 3 };
+
+static struct heartbeat_data heartbeat_data = {
+	.bit_pos	= heartbeat_bit_pos,
+	.nr_bits	= ARRAY_SIZE(heartbeat_bit_pos),
+};
+
+static struct platform_device heartbeat_device = {
+	.name		= "heartbeat",
+	.id		= -1,
+	.dev	= {
+		.platform_data	= &heartbeat_data,
+	},
+	.num_resources	= 1,
+	.resource	= &heartbeat_resource,
+};
+
+/* GETHER */
+static void sh7752_eth_set_mdio_gate(void *addr)
+{
+	if (((u32)addr & 0x00000fff) < 0x0800)
+		gpio_set_value(GPIO_PTG1, 1);
+	else
+		gpio_set_value(GPIO_PTG1, 0);
+}
+
+static struct resource sh_eth0_resources[] = {
+	{
+		.start  = 0xfee00000,
+		.end    = 0xfee007ff,
+		.flags  = IORESOURCE_MEM,
+	}, {
+		/* TSU */
+		.start  = 0xfee01800,
+		.end    = 0xfee01fff,
+		.flags  = IORESOURCE_MEM,
+	}, {
+		.start  = evt2irq(0x2960),
+		.end    = evt2irq(0x2960),
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static struct sh_eth_plat_data sh7752_eth0_pdata = {
+	.phy = 18,
+	.edmac_endian = EDMAC_LITTLE_ENDIAN,
+	.register_type = SH_ETH_REG_GIGABIT,
+	.set_mdio_gate = sh7752_eth_set_mdio_gate,
+	.phy_interface = PHY_INTERFACE_MODE_RGMII_ID,
+};
+
+static struct platform_device sh7752_eth0_device = {
+	.name		= "sh-eth",
+	.resource	= sh_eth0_resources,
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(sh_eth0_resources),
+	.dev		= {
+		.platform_data = &sh7752_eth0_pdata,
+	},
+};
+
+static struct resource sh_eth1_resources[] = {
+	{
+		.start  = 0xfee00800,
+		.end    = 0xfee00fff,
+		.flags  = IORESOURCE_MEM,
+	}, {
+		/* TSU */
+		.start  = 0xfee01800,
+		.end    = 0xfee01fff,
+		.flags  = IORESOURCE_MEM,
+	}, {
+		.start  = evt2irq(0x2980),
+		.end    = evt2irq(0x2980),
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static struct sh_eth_plat_data sh7752_eth1_pdata = {
+	.phy = 19,
+	.edmac_endian = EDMAC_LITTLE_ENDIAN,
+	.register_type = SH_ETH_REG_GIGABIT,
+	.set_mdio_gate = sh7752_eth_set_mdio_gate,
+	.phy_interface = PHY_INTERFACE_MODE_RGMII_ID,
+};
+
+static struct platform_device sh7752_eth1_device = {
+	.name		= "sh-eth",
+	.resource	= sh_eth1_resources,
+	.id		= 1,
+	.num_resources	= ARRAY_SIZE(sh_eth1_resources),
+	.dev		= {
+		.platform_data = &sh7752_eth1_pdata,
+	},
+};
+
+/* Fixed 3.3V regulator to be used by SDHI0, MMCIF */
+static struct regulator_consumer_supply fixed3v3_power_consumers[] = {
+	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.0"),
+	REGULATOR_SUPPLY("vqmmc", "sh_mobile_sdhi.0"),
+	REGULATOR_SUPPLY("vmmc", "sh_mmcif.0"),
+	REGULATOR_SUPPLY("vqmmc", "sh_mmcif.0"),
+};
+
+/* SH_MMCIF */
+static struct resource sh_mmcif_resources[] = {
+	[0] = {
+		.start	= 0xffcb0000,
+		.end	= 0xffcb00ff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= evt2irq(0x1c60),
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start	= evt2irq(0x1c80),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct sh_mmcif_plat_data sh_mmcif_plat = {
+	.sup_pclk	= 0x0f,
+	.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA |
+			  MMC_CAP_NONREMOVABLE,
+	.ocr		= MMC_VDD_32_33 | MMC_VDD_33_34,
+	.slave_id_tx	= SHDMA_SLAVE_MMCIF_TX,
+	.slave_id_rx	= SHDMA_SLAVE_MMCIF_RX,
+};
+
+static struct platform_device sh_mmcif_device = {
+	.name		= "sh_mmcif",
+	.id		= 0,
+	.dev		= {
+		.platform_data		= &sh_mmcif_plat,
+	},
+	.num_resources	= ARRAY_SIZE(sh_mmcif_resources),
+	.resource	= sh_mmcif_resources,
+};
+
+/* SDHI0 */
+static struct sh_mobile_sdhi_info sdhi_info = {
+	.dma_slave_tx	= SHDMA_SLAVE_SDHI_TX,
+	.dma_slave_rx	= SHDMA_SLAVE_SDHI_RX,
+	.tmio_caps	= MMC_CAP_SD_HIGHSPEED,
+};
+
+static struct resource sdhi_resources[] = {
+	[0] = {
+		.start  = 0xffe50000,
+		.end    = 0xffe501ff,
+		.flags  = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start  = evt2irq(0x480),
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device sdhi_device = {
+	.name           = "sh_mobile_sdhi",
+	.num_resources  = ARRAY_SIZE(sdhi_resources),
+	.resource       = sdhi_resources,
+	.id             = 0,
+	.dev	= {
+		.platform_data	= &sdhi_info,
+	},
+};
+
+/*
+ * The hardware manual says SCIF0, SCIF1. But, the register configuration is
+ * similar to 8250 UART.
+ */
+static struct plat_serial8250_port scif01_platform_data[] = {
+	{
+		.membase	= (void __iomem *)0xfe410000,
+		.mapbase	= 0xfe410000,
+		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
+		.iotype		= UPIO_MEM,
+		.uartclk	= 48000000 / 26,
+		.irq		= evt2irq(0xb40),
+	}, {
+		.membase	= (void __iomem *)0xfe420000,
+		.mapbase	= 0xfe420000,
+		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
+		.iotype		= UPIO_MEM,
+		.uartclk	= 48000000 / 26,
+		.irq		= evt2irq(0xb60),
+	}, {
+	},
+};
+
+static struct platform_device scif01_device = {
+	.name		= "serial8250",
+	.id		= PLAT8250_DEV_PLATFORM,
+	.dev = {
+		.platform_data = scif01_platform_data,
+	},
+};
+
+static int usbhs0_get_id(struct platform_device *pdev)
+{
+	return USBHS_GADGET;
+}
+
+static struct renesas_usbhs_platform_info usb0_data = {
+	.platform_callback = {
+		.get_id = usbhs0_get_id,
+	},
+	.driver_param = {
+		.buswait_bwait = 2,
+	}
+};
+
+static struct resource usb0_resources[] = {
+	[0] = {
+		.start	= 0xfe450000,
+		.end	= 0xfe4501ff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= evt2irq(0x840),
+		.end	= evt2irq(0x840),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device usb0_device = {
+	.name		= "renesas_usbhs",
+	.id		= 0,
+	.dev = {
+		.platform_data		= &usb0_data,
+	},
+	.num_resources	= ARRAY_SIZE(usb0_resources),
+	.resource	= usb0_resources,
+};
+
+static struct resource usb_ehci_resources[] = {
+	[0] = {
+		.start	= 0xfe4f1000,
+		.end	= 0xfe4f10ff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= evt2irq(0x920),
+		.end	= evt2irq(0x920),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device usb_ehci_device = {
+	.name		= "sh_ehci",
+	.id		= -1,
+	.dev = {
+		.dma_mask = &usb_ehci_device.dev.coherent_dma_mask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
+	},
+	.num_resources	= ARRAY_SIZE(usb_ehci_resources),
+	.resource	= usb_ehci_resources,
+};
+
+static struct resource usb_ohci_resources[] = {
+	[0] = {
+		.start	= 0xfe4f1800,
+		.end	= 0xfe4f18ff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= evt2irq(0x920),
+		.end	= evt2irq(0x920),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device usb_ohci_device = {
+	.name		= "sh_ohci",
+	.id		= -1,
+	.dev = {
+		.dma_mask = &usb_ohci_device.dev.coherent_dma_mask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
+	},
+	.num_resources	= ARRAY_SIZE(usb_ohci_resources),
+	.resource	= usb_ohci_resources,
+};
+
+static struct platform_device *sh7752evb_devices[] __initdata = {
+	&heartbeat_device,
+	&sh7752_eth0_device,
+	&sh7752_eth1_device,
+	&sh_mmcif_device,
+	&sdhi_device,
+	&scif01_device,
+	&usb0_device,
+	&usb_ehci_device,
+	&usb_ohci_device,
+};
+
+static struct flash_platform_data spi_flash_data = {
+	.name = "m25p80",
+	.type = "mx25l6405d",
+};
+
+static struct spi_board_info spi_board_info[] = {
+	{
+		.modalias = "m25p80",
+		.max_speed_hz = 25000000,
+		.bus_num = 0,
+		.chip_select = 0,
+		.platform_data = &spi_flash_data,
+	},
+	{
+		.modalias = "m25p80",
+		.max_speed_hz = 25000000,
+		.bus_num = 1,
+		.chip_select = 0,
+		.platform_data = &spi_flash_data,
+	},
+};
+
+static int __init sh7752evb_devices_setup(void)
+{
+	regulator_register_always_on(0, "fixed-3.3V", fixed3v3_power_consumers,
+				     ARRAY_SIZE(fixed3v3_power_consumers),
+				     3300000);
+	/* RGMII (PTA) */
+	gpio_request(GPIO_FN_ET0_MDC, NULL);
+	gpio_request(GPIO_FN_ET0_MDIO, NULL);
+	gpio_request(GPIO_FN_ET1_MDC, NULL);
+	gpio_request(GPIO_FN_ET1_MDIO, NULL);
+
+	/* PWMU0 (PTC) */
+	gpio_request(GPIO_FN_PWMU0, NULL);
+	gpio_request(GPIO_FN_PWMU1, NULL);
+
+	/* IRQ8 and IRQ5 to 0 (PTB, PTC) */
+	gpio_request(GPIO_FN_IRQ8, NULL);
+	gpio_request(GPIO_FN_IRQ5, NULL);
+	gpio_request(GPIO_FN_IRQ4, NULL);
+	gpio_request(GPIO_FN_IRQ3, NULL);
+	gpio_request(GPIO_FN_IRQ2, NULL);
+	gpio_request(GPIO_FN_IRQ1, NULL);
+	gpio_request(GPIO_FN_IRQ0, NULL);
+
+	/* SPI0 (PTD) */
+	gpio_request(GPIO_FN_SP0_MISO, NULL);
+	gpio_request(GPIO_FN_SP0_SCK_FB, NULL);
+	gpio_request(GPIO_FN_SP0_SS1, NULL);
+	gpio_request(GPIO_FN_SP0_SS2, NULL);
+	gpio_request(GPIO_FN_SP0_SS3, NULL);
+
+	/* RMII 0/1 (PTE, PTF) */
+	gpio_request(GPIO_FN_RMII0_CRS_DV, NULL);
+	gpio_request(GPIO_FN_RMII0_TXD1, NULL);
+	gpio_request(GPIO_FN_RMII0_TXD0, NULL);
+	gpio_request(GPIO_FN_RMII0_TXEN, NULL);
+	gpio_request(GPIO_FN_RMII0_REFCLK, NULL);
+	gpio_request(GPIO_FN_RMII0_RXD1, NULL);
+	gpio_request(GPIO_FN_RMII0_RXD0, NULL);
+	gpio_request(GPIO_FN_RMII0_RX_ER, NULL);
+	gpio_request(GPIO_FN_RMII1_CRS_DV, NULL);
+	gpio_request(GPIO_FN_RMII1_TXD1, NULL);
+	gpio_request(GPIO_FN_RMII1_TXD0, NULL);
+	gpio_request(GPIO_FN_RMII1_TXEN, NULL);
+	gpio_request(GPIO_FN_RMII1_REFCLK, NULL);
+	gpio_request(GPIO_FN_RMII1_RXD1, NULL);
+	gpio_request(GPIO_FN_RMII1_RXD0, NULL);
+	gpio_request(GPIO_FN_RMII1_RX_ER, NULL);
+
+	/* eMMC (PTG) */
+	gpio_request(GPIO_FN_MMCCLK, NULL);
+	gpio_request(GPIO_FN_MMCCMD, NULL);
+	gpio_request(GPIO_FN_MMCDAT7, NULL);
+	gpio_request(GPIO_FN_MMCDAT6, NULL);
+	gpio_request(GPIO_FN_MMCDAT5, NULL);
+	gpio_request(GPIO_FN_MMCDAT4, NULL);
+	gpio_request(GPIO_FN_MMCDAT3, NULL);
+	gpio_request(GPIO_FN_MMCDAT2, NULL);
+	gpio_request(GPIO_FN_MMCDAT1, NULL);
+	gpio_request(GPIO_FN_MMCDAT0, NULL);
+
+	/* SPI1 (PTH) */
+	gpio_request(GPIO_FN_SP1_MISO, NULL);
+	gpio_request(GPIO_FN_SP1_SCK_FB, NULL);
+	gpio_request(GPIO_FN_SP1_SS1, NULL);
+
+	/* SDHI (PTI) */
+	gpio_request(GPIO_FN_SD_WP, NULL);
+	gpio_request(GPIO_FN_SD_CD, NULL);
+	gpio_request(GPIO_FN_SD_CLK, NULL);
+	gpio_request(GPIO_FN_SD_CMD, NULL);
+	gpio_request(GPIO_FN_SD_D3, NULL);
+	gpio_request(GPIO_FN_SD_D2, NULL);
+	gpio_request(GPIO_FN_SD_D1, NULL);
+	gpio_request(GPIO_FN_SD_D0, NULL);
+
+	/* SCIF3/4 (PTJ, PTW) */
+	gpio_request(GPIO_FN_RTS3, NULL);
+	gpio_request(GPIO_FN_CTS3, NULL);
+	gpio_request(GPIO_FN_TXD3, NULL);
+	gpio_request(GPIO_FN_RXD3, NULL);
+	gpio_request(GPIO_FN_RTS4, NULL);
+	gpio_request(GPIO_FN_RXD4, NULL);
+	gpio_request(GPIO_FN_TXD4, NULL);
+	gpio_request(GPIO_FN_CTS4, NULL);
+
+	/* SERMUX (PTK, PTL, PTO, PTV) */
+	gpio_request(GPIO_FN_COM2_TXD, NULL);
+	gpio_request(GPIO_FN_COM2_RXD, NULL);
+	gpio_request(GPIO_FN_COM2_RTS, NULL);
+	gpio_request(GPIO_FN_COM2_CTS, NULL);
+	gpio_request(GPIO_FN_COM2_DTR, NULL);
+	gpio_request(GPIO_FN_COM2_DSR, NULL);
+	gpio_request(GPIO_FN_COM2_DCD, NULL);
+	gpio_request(GPIO_FN_COM2_RI, NULL);
+	gpio_request(GPIO_FN_RAC_RXD, NULL);
+	gpio_request(GPIO_FN_RAC_RTS, NULL);
+	gpio_request(GPIO_FN_RAC_CTS, NULL);
+	gpio_request(GPIO_FN_RAC_DTR, NULL);
+	gpio_request(GPIO_FN_RAC_DSR, NULL);
+	gpio_request(GPIO_FN_RAC_DCD, NULL);
+	gpio_request(GPIO_FN_RAC_TXD, NULL);
+	gpio_request(GPIO_FN_COM1_TXD, NULL);
+	gpio_request(GPIO_FN_COM1_RXD, NULL);
+	gpio_request(GPIO_FN_COM1_RTS, NULL);
+	gpio_request(GPIO_FN_COM1_CTS, NULL);
+
+	/* SCIF01 */
+	__raw_writeb(0x06, 0xffd8ee0f);	/* from the manual 27.4.3 [1] */
+	__raw_writeb(0x03, 0xfe410008);	/* SCIFCR0 */
+	__raw_writeb(0x03, 0xfe420008);	/* SCIFCR1 */
+	__raw_writeb(0x00, 0xfe410008);	/* SCIFCR0 */
+	__raw_writeb(0x00, 0xfe420008);	/* SCIFCR1 */
+
+	/* IIC (PTM, PTR, PTS) */
+	gpio_request(GPIO_FN_SDA7, NULL);
+	gpio_request(GPIO_FN_SCL7, NULL);
+	gpio_request(GPIO_FN_SDA6, NULL);
+	gpio_request(GPIO_FN_SCL6, NULL);
+	gpio_request(GPIO_FN_SDA5, NULL);
+	gpio_request(GPIO_FN_SCL5, NULL);
+	gpio_request(GPIO_FN_SDA4, NULL);
+	gpio_request(GPIO_FN_SCL4, NULL);
+	gpio_request(GPIO_FN_SDA3, NULL);
+	gpio_request(GPIO_FN_SCL3, NULL);
+	gpio_request(GPIO_FN_SDA2, NULL);
+	gpio_request(GPIO_FN_SCL2, NULL);
+	gpio_request(GPIO_FN_SDA1, NULL);
+	gpio_request(GPIO_FN_SCL1, NULL);
+	gpio_request(GPIO_FN_SDA0, NULL);
+	gpio_request(GPIO_FN_SCL0, NULL);
+
+	/* USB (PTN) */
+	gpio_request(GPIO_FN_VBUS_EN, NULL);
+	gpio_request(GPIO_FN_VBUS_OC, NULL);
+
+	/* SGPIO1/0 (PTN, PTO) */
+	gpio_request(GPIO_FN_SGPIO1_CLK, NULL);
+	gpio_request(GPIO_FN_SGPIO1_LOAD, NULL);
+	gpio_request(GPIO_FN_SGPIO1_DI, NULL);
+	gpio_request(GPIO_FN_SGPIO1_DO, NULL);
+	gpio_request(GPIO_FN_SGPIO0_CLK, NULL);
+	gpio_request(GPIO_FN_SGPIO0_LOAD, NULL);
+	gpio_request(GPIO_FN_SGPIO0_DI, NULL);
+	gpio_request(GPIO_FN_SGPIO0_DO, NULL);
+
+	/* WDT (PTN) */
+	gpio_request(GPIO_FN_SUB_CLKIN, NULL);
+
+	/* System (PTT) */
+	gpio_request(GPIO_FN_STATUS1, NULL);
+	gpio_request(GPIO_FN_STATUS0, NULL);
+
+	/* PWMX (PTT) */
+	gpio_request(GPIO_FN_PWMX1, NULL);
+	gpio_request(GPIO_FN_PWMX0, NULL);
+
+	/* R-SPI (PTV) */
+	gpio_request(GPIO_FN_R_SPI_MOSI, NULL);
+	gpio_request(GPIO_FN_R_SPI_MISO, NULL);
+	gpio_request(GPIO_FN_R_SPI_RSPCK, NULL);
+	gpio_request(GPIO_FN_R_SPI_SSL0, NULL);
+	gpio_request(GPIO_FN_R_SPI_SSL1, NULL);
+
+	/* EVC (PTV, PTW) */
+	gpio_request(GPIO_FN_EVENT7, NULL);
+	gpio_request(GPIO_FN_EVENT6, NULL);
+	gpio_request(GPIO_FN_EVENT5, NULL);
+	gpio_request(GPIO_FN_EVENT4, NULL);
+	gpio_request(GPIO_FN_EVENT3, NULL);
+	gpio_request(GPIO_FN_EVENT2, NULL);
+	gpio_request(GPIO_FN_EVENT1, NULL);
+	gpio_request(GPIO_FN_EVENT0, NULL);
+
+	/* LED for heartbeat */
+	gpio_request(GPIO_PTU7, NULL);
+	gpio_direction_output(GPIO_PTU7, 0);
+	gpio_request(GPIO_PTU6, NULL);
+	gpio_direction_output(GPIO_PTU6, 0);
+	gpio_request(GPIO_PTU5, NULL);
+	gpio_direction_output(GPIO_PTU5, 0);
+	gpio_request(GPIO_PTU4, NULL);
+	gpio_direction_output(GPIO_PTU4, 0);
+	gpio_request(GPIO_PTU3, NULL);
+	gpio_direction_output(GPIO_PTU3, 0);
+	gpio_request(GPIO_PTU2, NULL);
+	gpio_direction_output(GPIO_PTU2, 0);
+	gpio_request(GPIO_PTU1, NULL);
+	gpio_direction_output(GPIO_PTU1, 0);
+	gpio_request(GPIO_PTU0, NULL);
+	gpio_direction_output(GPIO_PTU0, 0);
+
+	/* control for MDIO of Gigabit Ethernet */
+	gpio_request(GPIO_PTG1, NULL);
+	gpio_direction_output(GPIO_PTG1, 1);
+
+	/* register SPI device information */
+	spi_register_board_info(spi_board_info,
+				ARRAY_SIZE(spi_board_info));
+
+	/* General platform */
+	return platform_add_devices(sh7752evb_devices,
+				    ARRAY_SIZE(sh7752evb_devices));
+}
+arch_initcall(sh7752evb_devices_setup);
+
+/* Initialize IRQ setting */
+void __init init_sh7752evb_IRQ(void)
+{
+	plat_irq_setup_pins(IRQ_MODE_IRQ7654);
+	plat_irq_setup_pins(IRQ_MODE_IRQ3210);
+}
+
+/* Initialize the board */
+static void __init sh7752evb_setup(char **cmdline_p)
+{
+	pr_info("Renesas R0P7752C00000RZ support.\n");
+}
+
+static int sh7752evb_mode_pins(void)
+{
+	int value = 0;
+
+	/* This is the factory default setting of S3-8 (OFF). */
+	value |= MODE_PIN0;	/* Clock Mode: 1 */
+
+	return value;
+}
+
+/* The Machine Vector */
+static struct sh_machine_vector mv_sh7752evb __initmv = {
+	.mv_name		= "SH7752EVB",
+	.mv_setup		= sh7752evb_setup,
+	.mv_init_irq		= init_sh7752evb_IRQ,
+	.mv_mode_pins		= sh7752evb_mode_pins,
+};
+
diff --git a/arch/sh/configs/sh7752evb_defconfig b/arch/sh/configs/sh7752evb_defconfig
new file mode 100644
index 0000000..1e332e4
--- /dev/null
+++ b/arch/sh/configs/sh7752evb_defconfig
@@ -0,0 +1,130 @@
+CONFIG_EXPERIMENTAL=y
+# CONFIG_SWAP is not set
+CONFIG_SYSVIPC=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_BSD_PROCESS_ACCT=y
+CONFIG_TASKSTATS=y
+CONFIG_TASK_DELAY_ACCT=y
+CONFIG_TASK_XACCT=y
+CONFIG_TASK_IO_ACCOUNTING=y
+CONFIG_LOG_BUF_SHIFT
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_KALLSYMS_ALL=y
+CONFIG_SLAB=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_IOSCHED_DEADLINE is not set
+CONFIG_CPU_SUBTYPE_SH7752=y
+CONFIG_FORCE_MAX_ZONEORDER
+CONFIG_MEMORY_START=0x40000000
+CONFIG_MEMORY_SIZE=0x20000000
+CONFIG_PMB=y
+CONFIG_FLATMEM_MANUAL=y
+# CONFIG_COMPACTION is not set
+CONFIG_SH_SH7752EVB=y
+CONFIG_SH_DMA=y
+CONFIG_HEARTBEAT=y
+CONFIG_KEXEC=y
+CONFIG_SECCOMP=y
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_LRO is not set
+# CONFIG_INET_DIAG is not set
+CONFIG_IPV6=y
+# CONFIG_INET6_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET6_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET6_XFRM_MODE_BEET is not set
+CONFIG_VLAN_8021Q=y
+# CONFIG_WIRELESS is not set
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+# CONFIG_FW_LOADER is not set
+CONFIG_MTD=y
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_M25P80=y
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_BLK_DEV_RAM=y
+CONFIG_SCSI=y
+CONFIG_BLK_DEV_SD=y
+CONFIG_BLK_DEV_SR=y
+CONFIG_CHR_DEV_SG=y
+# CONFIG_SCSI_LOWLEVEL is not set
+CONFIG_NETDEVICES=y
+# CONFIG_NET_VENDOR_BROADCOM is not set
+# CONFIG_NET_VENDOR_CHELSIO is not set
+# CONFIG_NET_VENDOR_INTEL is not set
+# CONFIG_NET_VENDOR_MARVELL is not set
+# CONFIG_NET_VENDOR_MICREL is not set
+# CONFIG_NET_VENDOR_MICROCHIP is not set
+# CONFIG_NET_VENDOR_NATSEMI is not set
+CONFIG_SH_ETH=y
+# CONFIG_NET_VENDOR_SEEQ is not set
+# CONFIG_NET_VENDOR_SMSC is not set
+# CONFIG_NET_VENDOR_STMICRO is not set
+# CONFIG_NET_VENDOR_WIZNET is not set
+CONFIG_VITESSE_PHY=y
+# CONFIG_WLAN is not set
+CONFIG_INPUT_EVDEV=y
+# CONFIG_KEYBOARD_ATKBD is not set
+# CONFIG_MOUSE_PS2 is not set
+# CONFIG_SERIO is not set
+# CONFIG_LEGACY_PTYS is not set
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_NR_UARTS=2
+CONFIG_SERIAL_8250_RUNTIME_UARTS=2
+CONFIG_SERIAL_SH_SCI=y
+CONFIG_SERIAL_SH_SCI_NR_UARTS=3
+CONFIG_SERIAL_SH_SCI_CONSOLE=y
+# CONFIG_HW_RANDOM is not set
+CONFIG_SPI=y
+CONFIG_SPI_RSPI=y
+CONFIG_SPI_SH=y
+# CONFIG_HWMON is not set
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_SH=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_SH=y
+CONFIG_USB_RENESAS_USBHS=y
+CONFIG_USB_STORAGE=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_RENESAS_USBHS_UDC=y
+CONFIG_USB_ETH=m
+CONFIG_USB_MASS_STORAGE=m
+CONFIG_MMC=y
+CONFIG_MMC_SDHI=y
+CONFIG_MMC_SH_MMCIF=y
+CONFIG_DMADEVICES=y
+CONFIG_SH_DMAE=y
+# CONFIG_IOMMU_SUPPORT is not set
+CONFIG_EXT2_FS=y
+CONFIG_EXT3_FS=y
+CONFIG_ISO9660_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_PROC_KCORE=y
+CONFIG_TMPFS=y
+CONFIG_MINIX_FS=y
+CONFIG_NFS_FS=y
+# CONFIG_NFS_V3 is not set
+CONFIG_ROOT_NFS=y
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_CODEPAGE_932=y
+CONFIG_NLS_ISO8859_1=y
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_DEBUG_BUGVERBOSE is not set
+CONFIG_DEBUG_INFO=y
+# CONFIG_FTRACE is not set
+# CONFIG_CRYPTO_ANSI_CPRNG is not set
+# CONFIG_CRYPTO_HW is not set
diff --git a/arch/sh/tools/mach-types b/arch/sh/tools/mach-types
index 569977e..2762258 100644
--- a/arch/sh/tools/mach-types
+++ b/arch/sh/tools/mach-types
@@ -66,3 +66,4 @@ KFR2R09			SH_KFR2R09
 ECOVEC			SH_ECOVEC
 APSH4A3A		SH_APSH4A3A
 APSH4AD0A		SH_APSH4AD0A
+SH7752EVB		SH_SH7752EVB
-- 
1.7.1
