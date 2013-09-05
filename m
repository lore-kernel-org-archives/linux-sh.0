From: Ian Molton <ian.molton@codethink.co.uk>
Date: Thu, 05 Sep 2013 13:11:09 +0000
Subject: [PATCH] SPI: EMMA Mobile SPI master driver
Message-Id: <1378386669-9920-2-git-send-email-ian.molton@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch provides support for the EMMA mobile SPI master controller.

At present, only PIO mode is supported, and unless GPIOs are used for
chipselect, transfers are limited to 4 bytes maximum.

RW transfers are not supported, and only 8 bit words are supported at present.

Signed-off-by: Ian Molton <ian.molton@codethink.co.uk>
---
 drivers/spi/Kconfig  |    8 +
 drivers/spi/Makefile |    1 +
 drivers/spi/spi-em.c |  486 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 495 insertions(+)
 create mode 100644 drivers/spi/spi-em.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 89cbbab..4a648c0 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -164,6 +164,14 @@ config SPI_EP93XX
 	  This enables using the Cirrus EP93xx SPI controller in master
 	  mode.
 
+config SPI_EM
+        tristate "EMXX built in SPI controller"
+        depends on ARCH_EMEV2
+        help
+          This enables the emxx SPI driver in master mode. Only short transfers
+	  are supported without extra chipselect logic in PIO mode. DMA is not
+	  currently supported.
+
 config SPI_FALCON
 	tristate "Falcon SPI controller support"
 	depends on SOC_FALCON
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 33f9c09..41c7a23 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_SPI_DW_MMIO)		+= spi-dw-mmio.o
 obj-$(CONFIG_SPI_DW_PCI)		+= spi-dw-midpci.o
 spi-dw-midpci-objs			:= spi-dw-pci.o spi-dw-mid.o
 obj-$(CONFIG_SPI_EP93XX)		+= spi-ep93xx.o
+obj-$(CONFIG_SPI_EM)			+= spi-em.o
 obj-$(CONFIG_SPI_FALCON)		+= spi-falcon.o
 obj-$(CONFIG_SPI_FSL_CPM)		+= spi-fsl-cpm.o
 obj-$(CONFIG_SPI_FSL_LIB)		+= spi-fsl-lib.o
diff --git a/drivers/spi/spi-em.c b/drivers/spi/spi-em.c
new file mode 100644
index 0000000..2c3e980
--- /dev/null
+++ b/drivers/spi/spi-em.c
@@ -0,0 +1,486 @@
+/*
+ * EMXX SPI Master driver
+ * Based on spi_sh.
+ *
+ * Copyright (C) 2013 Codethink Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/errno.h>
+#include <linux/clk.h>
+#include <linux/timer.h>
+#include <linux/delay.h>
+#include <linux/list.h>
+#include <linux/workqueue.h>
+#include <linux/interrupt.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/of_gpio.h>
+#include <linux/io.h>
+#include <linux/spi/spi.h>
+
+#include <linux/gpio.h>
+
+struct em_spi_data {
+	void __iomem *addr;
+	int irq;
+	struct clk *clk;
+	struct clk *sclk;
+	struct spi_master *master;
+	wait_queue_head_t wait;
+	unsigned int status;
+	unsigned int chip_select;
+	unsigned int hard_chip_select;
+	unsigned int pol_mask;
+	unsigned int pol_data;
+	unsigned int mode;
+	unsigned int *cs_gpio;
+};
+
+#define EMXX_SPI_BLOCK_MODE_SWITCH_EN	0x0000
+#define EMXX_SPI_BLOCK_MODE		0x0004
+
+#define EMXX_SPI_MODE			0x1000
+#define EMXX_SPI_POL			0x1004
+#define EMXX_SPI_CTL			0x1008
+#define EMXX_SPI_TX			0x1010
+#define EMXX_SPI_RX			0x1014
+#define EMXX_SPI_STAT			0x1018
+#define EMXX_SPI_RAWSTAT		0x101c
+#define EMXX_SPI_ENSET			0x1020
+#define EMXX_SPI_ENCLR			0x1024
+#define EMXX_SPI_FFCLR			0x1028
+
+#define EMXX_SPI_TX_STOP		(1 << 6)
+#define EMXX_SPI_RX_STOP		(1 << 5)
+#define EMXX_SPI_TERR			(1 << 4)
+#define EMXX_SPI_RDV			(1 << 3)
+#define EMXX_SPI_END			(1 << 2)
+#define EMXX_SPI_TX_UDR			(1 << 1)
+#define EMXX_SPI_RX_OVR			(1 << 0)
+
+#define EMXX_SPI_ERR_STAT	(EMXX_SPI_RX_OVR | EMXX_SPI_TX_UDR | \
+					EMXX_SPI_TERR)
+
+#define EMXX_SPI_ALL_IRQ	(EMXX_SPI_TERR | EMXX_SPI_RDV | EMXX_SPI_END | \
+					EMXX_SPI_TX_UDR | EMXX_SPI_RX_OVR)
+#define EMXX_SPI_RX_IRQS	(EMXX_SPI_RX_OVR | EMXX_SPI_RDV)
+#define EMXX_SPI_TX_IRQS	(EMXX_SPI_TERR | EMXX_SPI_END | EMXX_SPI_TX_UDR)
+
+#define EMXX_SPI_FLAG_START			(1 << 0)
+#define EMXX_SPI_FLAG_RX		(1 << 2)
+#define EMXX_SPI_FLAG_TX		(1 << 3)
+
+static void em_spi_set_cs(struct em_spi_data *em_spi, int cs, int state)
+{
+	gpio_direction_output(em_spi->cs_gpio[cs], state);
+}
+
+/*
+ * Soft reset. Set bit 8 of the control register.
+ * The chip will reset the interrupt status register, so no need to
+ * disable IRQs.
+ *
+ */
+static void em_spi_soft_reset(struct em_spi_data *em_spi)
+{
+	writel(1 << 8, em_spi->addr + EMXX_SPI_CTL);
+	msleep(1);
+	writel(0, em_spi->addr + EMXX_SPI_CTL);
+	msleep(1);
+}
+
+void em_spi_set_clock(struct em_spi_data *em_spi, unsigned long freq)
+{
+	int rate = clk_round_rate(em_spi->sclk, freq);
+
+	clk_set_rate(em_spi->sclk, rate);
+
+	/* Plenty long enough for clocks to stabilise */
+	msleep(1);
+}
+
+static void em_spi_setup_transfer(struct em_spi_data *em_spi)
+{
+	unsigned long pol_reg;
+
+	pol_reg = readl(em_spi->addr + EMXX_SPI_POL);
+	pol_reg &= em_spi->pol_mask;
+	pol_reg |= em_spi->pol_data;
+	writel(pol_reg, em_spi->addr + EMXX_SPI_POL);
+
+	writel(em_spi->mode, em_spi->addr + EMXX_SPI_MODE);
+
+}
+
+static int em_spi_start_transfer(struct em_spi_data *em_spi,
+				unsigned int flags)
+{
+	unsigned int irqs = 0;
+
+	if (flags = EMXX_SPI_FLAG_RX)
+		irqs |= EMXX_SPI_RX_IRQS;
+
+	if (flags = EMXX_SPI_FLAG_TX)
+		irqs |= EMXX_SPI_TX_IRQS;
+
+	/* Enable IRQs */
+	em_spi->status = 0;
+	writel(irqs, em_spi->addr + EMXX_SPI_ENSET);
+
+	/* Kick off the transfer */
+	writel(flags | EMXX_SPI_FLAG_START, em_spi->addr + EMXX_SPI_CTL);
+
+	return 0;
+}
+
+static int em_spi_tx(struct em_spi_data *em_spi, struct spi_transfer *t)
+{
+	const char *tx_buf = t->tx_buf;
+	int i, ret;
+
+	for (i = 0; i < t->len; i++) {
+
+		writel(tx_buf[i], em_spi->addr + EMXX_SPI_TX);
+
+		em_spi_start_transfer(em_spi, EMXX_SPI_FLAG_TX);
+
+		ret = wait_event_interruptible_timeout(em_spi->wait,
+			em_spi->status & EMXX_SPI_TX_IRQS, HZ);
+
+		/*
+		 * We're abusing the chip a bit so that we can do
+		 * multi-byte operations in PIO mode.
+		 * As a result we need to spin until the START bit drops here.
+		 *
+		 * This only works with GPIO based chipselects, unless the
+		 * transfer size is 4 bytes or less. Verified on a scope.
+		 *
+		 * DMA mode appears not to have this restriction.
+		 */
+
+		while (readl(em_spi->addr + EMXX_SPI_CTL) & 1)
+			;
+
+		if (ret < 0)
+			return -ETIMEDOUT;
+
+		if (em_spi->status & EMXX_SPI_ERR_STAT)
+			return -EINVAL;
+
+		writel(EMXX_SPI_END, em_spi->addr + EMXX_SPI_FFCLR);
+	}
+
+	return 0;
+}
+
+static int em_spi_rx(struct em_spi_data *em_spi, struct spi_transfer *t)
+{
+	char *rx_buf = t->rx_buf;
+	int i, ret;
+
+	for (i = 0; i < t->len; i++) {
+		em_spi_start_transfer(em_spi, EMXX_SPI_FLAG_RX);
+
+		/* We might want to try reading more than one word per irq */
+		ret = wait_event_interruptible_timeout(em_spi->wait,
+			em_spi->status & EMXX_SPI_RX_IRQS, HZ);
+
+		if (ret < 0)
+			return -ETIMEDOUT;
+
+		if (em_spi->status & EMXX_SPI_ERR_STAT)
+			return -EINVAL;
+
+		rx_buf[i] = readl(em_spi->addr + EMXX_SPI_RX);
+
+		writel(EMXX_SPI_RDV, em_spi->addr + EMXX_SPI_FFCLR);
+	}
+
+	return 0;
+}
+
+static int em_spi_setup(struct spi_device *spi);
+
+static int em_spi_transfer_one_message(struct spi_master *master,
+					struct spi_message *mesg)
+{
+	struct em_spi_data *em_spi = spi_master_get_devdata(master);
+	struct spi_transfer *t;
+	int ret;
+
+	em_spi_setup(mesg->spi);
+
+	em_spi_set_cs(em_spi, em_spi->chip_select, 1);
+
+	em_spi_setup_transfer(em_spi);
+
+	list_for_each_entry(t, &mesg->transfers, transfer_list) {
+
+		if (t->tx_buf && t->rx_buf) {
+			/* Do not yet support concurrent transfers */
+			BUG();
+			goto error;
+		}
+
+		if (t->speed_hz)
+			em_spi_set_clock(em_spi, t->speed_hz);
+
+		if (t->tx_buf)
+			ret = em_spi_tx(em_spi, t);
+		else if (t->rx_buf)
+			ret = em_spi_rx(em_spi, t);
+
+		if (ret)
+			goto error;
+
+		mesg->actual_length += t->len;
+	}
+
+	em_spi_set_cs(em_spi, em_spi->chip_select, 0);
+
+	mesg->status = 0;
+	spi_finalize_current_message(master);
+
+	return 0;
+
+error:
+	dev_err(&master->dev, "SPI status = %08x, ret = %d\n",
+		em_spi->status, ret);
+
+	em_spi_soft_reset(em_spi);
+
+	mesg->status = ret;
+	spi_finalize_current_message(master);
+
+	return ret;
+}
+
+static int em_spi_setup(struct spi_device *spi)
+{
+	struct em_spi_data *em_spi = spi_master_get_devdata(spi->master);
+	unsigned long pol = 0, mode = 0, shift, actual_cs;
+
+	if (!spi->bits_per_word)
+		spi->bits_per_word = 8;
+
+	if (spi->bits_per_word != 8)
+		BUG(); /* We dont support >8 bit transfers */
+
+	if (spi->max_speed_hz)
+		em_spi_set_clock(em_spi, spi->max_speed_hz);
+
+	/* Select clock and cs polarity */
+	pol |= !(spi->mode & SPI_CPHA)   ? (1 << 2) : 0;
+	pol |= (spi->mode & SPI_CPOL)    ? (1 << 1) : 0;
+	pol |= (spi->mode & SPI_CS_HIGH) ? (1 << 0) : 0;
+
+	if (em_spi->cs_gpio)
+		actual_cs = em_spi->hard_chip_select;
+	else
+		actual_cs = spi->chip_select;
+
+	shift = actual_cs * 3;
+
+	/* Take into account gap in reg for CSW */
+	if (shift > 9)
+		shift += 4;
+
+	mode |= ((spi->bits_per_word - 1) & 0x1f) << 8;
+	mode |= (actual_cs & 0x7) << 4;
+
+	em_spi->pol_mask = ~((0x7 << shift) | (0xf << 12));
+	em_spi->pol_data = pol << shift;
+	em_spi->mode = mode;
+	em_spi->chip_select = spi->chip_select;
+
+	return 0;
+}
+
+static void em_spi_power_on(struct em_spi_data *em_spi)
+{
+	clk_enable(em_spi->clk);
+	clk_enable(em_spi->sclk);
+}
+
+static void em_spi_power_off(struct em_spi_data *em_spi)
+{
+	clk_disable(em_spi->sclk);
+	clk_disable(em_spi->clk);
+}
+
+static irqreturn_t em_spi_irq(int irq, void *data)
+{
+	struct em_spi_data *em_spi = (struct em_spi_data *)data;
+	unsigned long status;
+
+	status = readl(em_spi->addr + EMXX_SPI_STAT);
+
+	if (status) {
+		em_spi->status = status;
+		writel(status, em_spi->addr + EMXX_SPI_ENCLR);
+
+		wake_up(&em_spi->wait);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int em_spi_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct resource *res;
+	struct spi_master *master;
+	struct em_spi_data *em_spi;
+	int ret, irq, n_cs_gpio;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (unlikely(res = NULL)) {
+		dev_err(&pdev->dev, "invalid resource\n");
+		return -EINVAL;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "platform_get_irq error\n");
+		return -ENODEV;
+	}
+
+	master = spi_alloc_master(&pdev->dev, sizeof(struct em_spi_data));
+	if (master = NULL) {
+		dev_err(&pdev->dev, "spi_alloc_master error.\n");
+		return -ENOMEM;
+	}
+
+	em_spi = spi_master_get_devdata(master);
+	platform_set_drvdata(pdev, em_spi);
+
+	em_spi->clk = devm_clk_get(&pdev->dev, NULL);
+	if (!IS_ERR(em_spi->clk))
+		clk_prepare(em_spi->clk);
+
+	em_spi->sclk = devm_clk_get(&pdev->dev, "sclk");
+	if (!IS_ERR(em_spi->sclk))
+		clk_prepare(em_spi->sclk);
+
+	em_spi->irq = irq;
+	em_spi->master = master;
+	em_spi->addr = devm_ioremap(&pdev->dev, res->start, resource_size(res));
+	if (em_spi->addr = NULL) {
+		dev_err(&pdev->dev, "ioremap error.\n");
+		ret = -ENOMEM;
+		goto error1;
+	}
+
+	n_cs_gpio = of_gpio_named_count(np, "cs-gpios");
+
+	if (n_cs_gpio > 0) {
+		int i;
+
+		master->num_chipselect = n_cs_gpio;
+
+		em_spi->cs_gpio = devm_kzalloc(&pdev->dev,
+				sizeof(unsigned int) * n_cs_gpio,
+				GFP_KERNEL);
+
+		for (i = 0; i < n_cs_gpio; i++) {
+			em_spi->cs_gpio[i] +				of_get_named_gpio(np, "cs-gpios", i);
+			devm_gpio_request(&pdev->dev, em_spi->cs_gpio[i], NULL);
+		}
+
+		of_property_read_u32(np, "hard-chipselect",
+					&em_spi->hard_chip_select);
+
+	} else {
+		of_property_read_u16(np, "num-chipselects",
+					&master->num_chipselect);
+	}
+
+	init_waitqueue_head(&em_spi->wait);
+
+	em_spi_power_on(em_spi);
+
+	writel(0x1, em_spi->addr + EMXX_SPI_BLOCK_MODE_SWITCH_EN);
+	writel(0x1, em_spi->addr + EMXX_SPI_BLOCK_MODE);
+
+	/* Reset, int off */
+	em_spi_soft_reset(em_spi);
+
+	ret = devm_request_irq(&pdev->dev, irq, em_spi_irq, 0, "spi-em",
+				em_spi);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Could not request IRQ.\n");
+		goto error1;
+	}
+
+	master->dev.parent = &pdev->dev;
+	master->dev.of_node = pdev->dev.of_node;
+	master->bus_num = -1;
+	master->setup = em_spi_setup;
+	master->transfer_one_message = em_spi_transfer_one_message;
+	master->mode_bits = SPI_CPHA | SPI_CPOL | SPI_CS_HIGH;
+
+	ret = spi_register_master(master);
+
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Could not register SPI master.\n");
+		goto error1;
+	}
+
+	return 0;
+
+error1:
+	spi_master_put(master);
+
+	return ret;
+}
+
+static int em_spi_remove(struct platform_device *pdev)
+{
+	struct em_spi_data *em_spi = platform_get_drvdata(pdev);
+
+	em_spi_power_off(em_spi);
+	spi_master_put(em_spi->master);
+
+	return 0;
+}
+
+static struct of_device_id em_spi_ids[] = {
+	{ .compatible = "renesas,em-spi", },
+	{ }
+};
+
+static struct platform_driver em_spi_driver = {
+	.probe = em_spi_probe,
+	.remove = em_spi_remove,
+	.driver = {
+		.name = "em-spi",
+		.owner = THIS_MODULE,
+		.of_match_table = em_spi_ids,
+	},
+};
+
+module_platform_driver(em_spi_driver);
+MODULE_DEVICE_TABLE(of, em_spi_ids);
+
+MODULE_DESCRIPTION("EMXX SPI bus driver");
+MODULE_LICENSE("GPLv2");
+MODULE_AUTHOR("Ian Molton");
+MODULE_ALIAS("platform:spi-em");
-- 
1.7.10.4

