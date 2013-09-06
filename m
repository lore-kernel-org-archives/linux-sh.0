From: Simon Horman <horms@verge.net.au>
Date: Fri, 06 Sep 2013 02:16:14 +0000
Subject: Re: [PATCH] SPI: EMMA Mobile SPI master driver
Message-Id: <20130906021614.GA9158@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1378386669-9920-2-git-send-email-ian.molton@codethink.co.uk>
In-Reply-To: <1378386669-9920-2-git-send-email-ian.molton@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Thu, Sep 05, 2013 at 02:11:09PM +0100, Ian Molton wrote:
> This patch provides support for the EMMA mobile SPI master controller.
>=20
> At present, only PIO mode is supported, and unless GPIOs are used for
> chipselect, transfers are limited to 4 bytes maximum.
>=20
> RW transfers are not supported, and only 8 bit words are supported at pre=
sent.
>=20
> Signed-off-by: Ian Molton <ian.molton@codethink.co.uk>

Hi Ian,

I suspect that Magnus is the best person to review this code
(although he may have other ideas). Nonetheless, I have made
a few comments below.

> ---
>  drivers/spi/Kconfig  |    8 +
>  drivers/spi/Makefile |    1 +
>  drivers/spi/spi-em.c |  486 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 495 insertions(+)
>  create mode 100644 drivers/spi/spi-em.c
>=20
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 89cbbab..4a648c0 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -164,6 +164,14 @@ config SPI_EP93XX
>  	  This enables using the Cirrus EP93xx SPI controller in master
>  	  mode.
> =20
> +config SPI_EM
> +        tristate "EMXX built in SPI controller"
> +        depends on ARCH_EMEV2
> +        help
> +          This enables the emxx SPI driver in master mode. Only short tr=
ansfers
> +	  are supported without extra chipselect logic in PIO mode. DMA is not
> +	  currently supported.
> +
>  config SPI_FALCON
>  	tristate "Falcon SPI controller support"
>  	depends on SOC_FALCON
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index 33f9c09..41c7a23 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -28,6 +28,7 @@ obj-$(CONFIG_SPI_DW_MMIO)		+=3D spi-dw-mmio.o
>  obj-$(CONFIG_SPI_DW_PCI)		+=3D spi-dw-midpci.o
>  spi-dw-midpci-objs			:=3D spi-dw-pci.o spi-dw-mid.o
>  obj-$(CONFIG_SPI_EP93XX)		+=3D spi-ep93xx.o
> +obj-$(CONFIG_SPI_EM)			+=3D spi-em.o
>  obj-$(CONFIG_SPI_FALCON)		+=3D spi-falcon.o
>  obj-$(CONFIG_SPI_FSL_CPM)		+=3D spi-fsl-cpm.o
>  obj-$(CONFIG_SPI_FSL_LIB)		+=3D spi-fsl-lib.o
> diff --git a/drivers/spi/spi-em.c b/drivers/spi/spi-em.c
> new file mode 100644
> index 0000000..2c3e980
> --- /dev/null
> +++ b/drivers/spi/spi-em.c
> @@ -0,0 +1,486 @@
> +/*
> + * EMXX SPI Master driver
> + * Based on spi_sh.
> + *
> + * Copyright (C) 2013 Codethink Limited
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301=
  USA
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/sched.h>
> +#include <linux/errno.h>
> +#include <linux/clk.h>
> +#include <linux/timer.h>
> +#include <linux/delay.h>
> +#include <linux/list.h>
> +#include <linux/workqueue.h>
> +#include <linux/interrupt.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/of_gpio.h>
> +#include <linux/io.h>
> +#include <linux/spi/spi.h>
> +
> +#include <linux/gpio.h>
> +
> +struct em_spi_data {
> +	void __iomem *addr;
> +	int irq;
> +	struct clk *clk;
> +	struct clk *sclk;
> +	struct spi_master *master;
> +	wait_queue_head_t wait;
> +	unsigned int status;
> +	unsigned int chip_select;
> +	unsigned int hard_chip_select;
> +	unsigned int pol_mask;
> +	unsigned int pol_data;
> +	unsigned int mode;
> +	unsigned int *cs_gpio;
> +};
> +
> +#define EMXX_SPI_BLOCK_MODE_SWITCH_EN	0x0000
> +#define EMXX_SPI_BLOCK_MODE		0x0004
> +
> +#define EMXX_SPI_MODE			0x1000
> +#define EMXX_SPI_POL			0x1004
> +#define EMXX_SPI_CTL			0x1008
> +#define EMXX_SPI_TX			0x1010
> +#define EMXX_SPI_RX			0x1014
> +#define EMXX_SPI_STAT			0x1018
> +#define EMXX_SPI_RAWSTAT		0x101c
> +#define EMXX_SPI_ENSET			0x1020
> +#define EMXX_SPI_ENCLR			0x1024
> +#define EMXX_SPI_FFCLR			0x1028
> +
> +#define EMXX_SPI_TX_STOP		(1 << 6)
> +#define EMXX_SPI_RX_STOP		(1 << 5)
> +#define EMXX_SPI_TERR			(1 << 4)
> +#define EMXX_SPI_RDV			(1 << 3)
> +#define EMXX_SPI_END			(1 << 2)
> +#define EMXX_SPI_TX_UDR			(1 << 1)
> +#define EMXX_SPI_RX_OVR			(1 << 0)
> +
> +#define EMXX_SPI_ERR_STAT	(EMXX_SPI_RX_OVR | EMXX_SPI_TX_UDR | \
> +					EMXX_SPI_TERR)
> +
> +#define EMXX_SPI_ALL_IRQ	(EMXX_SPI_TERR | EMXX_SPI_RDV | EMXX_SPI_END | \
> +					EMXX_SPI_TX_UDR | EMXX_SPI_RX_OVR)
> +#define EMXX_SPI_RX_IRQS	(EMXX_SPI_RX_OVR | EMXX_SPI_RDV)
> +#define EMXX_SPI_TX_IRQS	(EMXX_SPI_TERR | EMXX_SPI_END | EMXX_SPI_TX_UDR)
> +
> +#define EMXX_SPI_FLAG_START			(1 << 0)
> +#define EMXX_SPI_FLAG_RX		(1 << 2)
> +#define EMXX_SPI_FLAG_TX		(1 << 3)
> +
> +static void em_spi_set_cs(struct em_spi_data *em_spi, int cs, int state)
> +{
> +	gpio_direction_output(em_spi->cs_gpio[cs], state);
> +}
> +
> +/*
> + * Soft reset. Set bit 8 of the control register.
> + * The chip will reset the interrupt status register, so no need to
> + * disable IRQs.
> + *
> + */
> +static void em_spi_soft_reset(struct em_spi_data *em_spi)
> +{
> +	writel(1 << 8, em_spi->addr + EMXX_SPI_CTL);
> +	msleep(1);
> +	writel(0, em_spi->addr + EMXX_SPI_CTL);
> +	msleep(1);
> +}
> +
> +void em_spi_set_clock(struct em_spi_data *em_spi, unsigned long freq)
> +{
> +	int rate =3D clk_round_rate(em_spi->sclk, freq);
> +
> +	clk_set_rate(em_spi->sclk, rate);
> +
> +	/* Plenty long enough for clocks to stabilise */
> +	msleep(1);
> +}
> +
> +static void em_spi_setup_transfer(struct em_spi_data *em_spi)
> +{
> +	unsigned long pol_reg;
> +
> +	pol_reg =3D readl(em_spi->addr + EMXX_SPI_POL);
> +	pol_reg &=3D em_spi->pol_mask;
> +	pol_reg |=3D em_spi->pol_data;
> +	writel(pol_reg, em_spi->addr + EMXX_SPI_POL);
> +
> +	writel(em_spi->mode, em_spi->addr + EMXX_SPI_MODE);
> +
> +}
> +
> +static int em_spi_start_transfer(struct em_spi_data *em_spi,
> +				unsigned int flags)
> +{
> +	unsigned int irqs =3D 0;
> +
> +	if (flags =3D EMXX_SPI_FLAG_RX)
> +		irqs |=3D EMXX_SPI_RX_IRQS;
> +
> +	if (flags =3D EMXX_SPI_FLAG_TX)
> +		irqs |=3D EMXX_SPI_TX_IRQS;
> +
> +	/* Enable IRQs */
> +	em_spi->status =3D 0;
> +	writel(irqs, em_spi->addr + EMXX_SPI_ENSET);
> +
> +	/* Kick off the transfer */
> +	writel(flags | EMXX_SPI_FLAG_START, em_spi->addr + EMXX_SPI_CTL);
> +
> +	return 0;
> +}
> +
> +static int em_spi_tx(struct em_spi_data *em_spi, struct spi_transfer *t)
> +{
> +	const char *tx_buf =3D t->tx_buf;
> +	int i, ret;
> +
> +	for (i =3D 0; i < t->len; i++) {
> +

Minor nit, there is no need for a blank line here.

> +		writel(tx_buf[i], em_spi->addr + EMXX_SPI_TX);
> +
> +		em_spi_start_transfer(em_spi, EMXX_SPI_FLAG_TX);
> +
> +		ret =3D wait_event_interruptible_timeout(em_spi->wait,
> +			em_spi->status & EMXX_SPI_TX_IRQS, HZ);
> +
> +		/*
> +		 * We're abusing the chip a bit so that we can do
> +		 * multi-byte operations in PIO mode.
> +		 * As a result we need to spin until the START bit drops here.
> +		 *
> +		 * This only works with GPIO based chipselects, unless the
> +		 * transfer size is 4 bytes or less. Verified on a scope.
> +		 *
> +		 * DMA mode appears not to have this restriction.
> +		 */
> +
> +		while (readl(em_spi->addr + EMXX_SPI_CTL) & 1)
> +			;

		Please impose some kind of limit on this loop so
		that it can never be endless.

		My na=C3=AFve implementation would be something like this.

		int i;
		bool started =3D false;
		/* 1000 is an arbitrary limit to prevent infinite loop */
		for (i =3D 0; i < 1000; i++) {
			if (!readl(em_spi->addr + EMXX_SPI_CTL) & 1)) {
				started =3D true;
				break;
			}
		}

		if (!started || ret < 0)
			return -ETIMEDOUT;


		Also, should the readl loop occor even if ret is less than 0?
> +
> +		if (ret < 0)
> +			return -ETIMEDOUT;
> +
> +		if (em_spi->status & EMXX_SPI_ERR_STAT)
> +			return -EINVAL;
> +
> +		writel(EMXX_SPI_END, em_spi->addr + EMXX_SPI_FFCLR);
> +	}
> +
> +	return 0;
> +}
> +
> +static int em_spi_rx(struct em_spi_data *em_spi, struct spi_transfer *t)
> +{
> +	char *rx_buf =3D t->rx_buf;
> +	int i, ret;
> +
> +	for (i =3D 0; i < t->len; i++) {
> +		em_spi_start_transfer(em_spi, EMXX_SPI_FLAG_RX);
> +
> +		/* We might want to try reading more than one word per irq */
> +		ret =3D wait_event_interruptible_timeout(em_spi->wait,
> +			em_spi->status & EMXX_SPI_RX_IRQS, HZ);
> +
> +		if (ret < 0)
> +			return -ETIMEDOUT;
> +
> +		if (em_spi->status & EMXX_SPI_ERR_STAT)
> +			return -EINVAL;
> +
> +		rx_buf[i] =3D readl(em_spi->addr + EMXX_SPI_RX);
> +
> +		writel(EMXX_SPI_RDV, em_spi->addr + EMXX_SPI_FFCLR);
> +	}
> +
> +	return 0;
> +}
> +
> +static int em_spi_setup(struct spi_device *spi);
> +
> +static int em_spi_transfer_one_message(struct spi_master *master,
> +					struct spi_message *mesg)
> +{
> +	struct em_spi_data *em_spi =3D spi_master_get_devdata(master);
> +	struct spi_transfer *t;
> +	int ret;
> +
> +	em_spi_setup(mesg->spi);
> +
> +	em_spi_set_cs(em_spi, em_spi->chip_select, 1);
> +
> +	em_spi_setup_transfer(em_spi);
> +
> +	list_for_each_entry(t, &mesg->transfers, transfer_list) {
> +

I'm not a fan of this blank line.

> +		if (t->tx_buf && t->rx_buf) {
> +			/* Do not yet support concurrent transfers */
> +			BUG();

Is this really a bug?
Can it actually happen?
If so I think it should be handled as an error.

I understand that this driver is missing some features
and I assume this is one of them. But none the less
BUG() seems a bit extreme.

> +			goto error;
> +		}
> +
> +		if (t->speed_hz)
> +			em_spi_set_clock(em_spi, t->speed_hz);
> +
> +		if (t->tx_buf)
> +			ret =3D em_spi_tx(em_spi, t);
> +		else if (t->rx_buf)
> +			ret =3D em_spi_rx(em_spi, t);
> +
> +		if (ret)
> +			goto error;
> +
> +		mesg->actual_length +=3D t->len;
> +	}
> +
> +	em_spi_set_cs(em_spi, em_spi->chip_select, 0);
> +
> +	mesg->status =3D 0;
> +	spi_finalize_current_message(master);
> +
> +	return 0;
> +
> +error:
> +	dev_err(&master->dev, "SPI status =3D %08x, ret =3D %d\n",
> +		em_spi->status, ret);
> +
> +	em_spi_soft_reset(em_spi);
> +
> +	mesg->status =3D ret;
> +	spi_finalize_current_message(master);
> +
> +	return ret;
> +}
> +
> +static int em_spi_setup(struct spi_device *spi)
> +{
> +	struct em_spi_data *em_spi =3D spi_master_get_devdata(spi->master);
> +	unsigned long pol =3D 0, mode =3D 0, shift, actual_cs;
> +
> +	if (!spi->bits_per_word)
> +		spi->bits_per_word =3D 8;
> +
> +	if (spi->bits_per_word !=3D 8)
> +		BUG(); /* We dont support >8 bit transfers */

Likewise, I think this would be better handled as an error.

> +
> +	if (spi->max_speed_hz)
> +		em_spi_set_clock(em_spi, spi->max_speed_hz);
> +
> +	/* Select clock and cs polarity */
> +	pol |=3D !(spi->mode & SPI_CPHA)   ? (1 << 2) : 0;
> +	pol |=3D (spi->mode & SPI_CPOL)    ? (1 << 1) : 0;
> +	pol |=3D (spi->mode & SPI_CS_HIGH) ? (1 << 0) : 0;
> +
> +	if (em_spi->cs_gpio)
> +		actual_cs =3D em_spi->hard_chip_select;
> +	else
> +		actual_cs =3D spi->chip_select;
> +
> +	shift =3D actual_cs * 3;
> +
> +	/* Take into account gap in reg for CSW */
> +	if (shift > 9)
> +		shift +=3D 4;
> +
> +	mode |=3D ((spi->bits_per_word - 1) & 0x1f) << 8;
> +	mode |=3D (actual_cs & 0x7) << 4;
> +
> +	em_spi->pol_mask =3D ~((0x7 << shift) | (0xf << 12));
> +	em_spi->pol_data =3D pol << shift;
> +	em_spi->mode =3D mode;
> +	em_spi->chip_select =3D spi->chip_select;
> +
> +	return 0;
> +}
> +
> +static void em_spi_power_on(struct em_spi_data *em_spi)
> +{
> +	clk_enable(em_spi->clk);
> +	clk_enable(em_spi->sclk);
> +}
> +
> +static void em_spi_power_off(struct em_spi_data *em_spi)
> +{
> +	clk_disable(em_spi->sclk);
> +	clk_disable(em_spi->clk);
> +}
> +
> +static irqreturn_t em_spi_irq(int irq, void *data)
> +{
> +	struct em_spi_data *em_spi =3D (struct em_spi_data *)data;
> +	unsigned long status;
> +
> +	status =3D readl(em_spi->addr + EMXX_SPI_STAT);
> +
> +	if (status) {
> +		em_spi->status =3D status;
> +		writel(status, em_spi->addr + EMXX_SPI_ENCLR);
> +
> +		wake_up(&em_spi->wait);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int em_spi_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np =3D pdev->dev.of_node;
> +	struct resource *res;
> +	struct spi_master *master;
> +	struct em_spi_data *em_spi;
> +	int ret, irq, n_cs_gpio;
> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (unlikely(res =3D NULL)) {
> +		dev_err(&pdev->dev, "invalid resource\n");
> +		return -EINVAL;
> +	}
> +
> +	irq =3D platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(&pdev->dev, "platform_get_irq error\n");
> +		return -ENODEV;
> +	}
> +
> +	master =3D spi_alloc_master(&pdev->dev, sizeof(struct em_spi_data));
> +	if (master =3D NULL) {
> +		dev_err(&pdev->dev, "spi_alloc_master error.\n");
> +		return -ENOMEM;
> +	}
> +
> +	em_spi =3D spi_master_get_devdata(master);
> +	platform_set_drvdata(pdev, em_spi);
> +
> +	em_spi->clk =3D devm_clk_get(&pdev->dev, NULL);
> +	if (!IS_ERR(em_spi->clk))
> +		clk_prepare(em_spi->clk);
> +
> +	em_spi->sclk =3D devm_clk_get(&pdev->dev, "sclk");
> +	if (!IS_ERR(em_spi->sclk))
> +		clk_prepare(em_spi->sclk);
> +
> +	em_spi->irq =3D irq;
> +	em_spi->master =3D master;
> +	em_spi->addr =3D devm_ioremap(&pdev->dev, res->start, resource_size(res=
));
> +	if (em_spi->addr =3D NULL) {
> +		dev_err(&pdev->dev, "ioremap error.\n");
> +		ret =3D -ENOMEM;
> +		goto error1;
> +	}
> +
> +	n_cs_gpio =3D of_gpio_named_count(np, "cs-gpios");
> +
> +	if (n_cs_gpio > 0) {
> +		int i;
> +
> +		master->num_chipselect =3D n_cs_gpio;
> +
> +		em_spi->cs_gpio =3D devm_kzalloc(&pdev->dev,
> +				sizeof(unsigned int) * n_cs_gpio,
> +				GFP_KERNEL);

Should this memory be freed at some point?

> +
> +		for (i =3D 0; i < n_cs_gpio; i++) {
> +			em_spi->cs_gpio[i] > +				of_get_named_gpio(np, "cs-gpios", i);
> +			devm_gpio_request(&pdev->dev, em_spi->cs_gpio[i], NULL);
> +		}
> +
> +		of_property_read_u32(np, "hard-chipselect",
> +					&em_spi->hard_chip_select);
> +
> +	} else {
> +		of_property_read_u16(np, "num-chipselects",
> +					&master->num_chipselect);
> +	}
> +
> +	init_waitqueue_head(&em_spi->wait);
> +
> +	em_spi_power_on(em_spi);
> +
> +	writel(0x1, em_spi->addr + EMXX_SPI_BLOCK_MODE_SWITCH_EN);
> +	writel(0x1, em_spi->addr + EMXX_SPI_BLOCK_MODE);
> +
> +	/* Reset, int off */
> +	em_spi_soft_reset(em_spi);
> +
> +	ret =3D devm_request_irq(&pdev->dev, irq, em_spi_irq, 0, "spi-em",
> +				em_spi);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Could not request IRQ.\n");
> +		goto error1;
> +	}
> +
> +	master->dev.parent =3D &pdev->dev;
> +	master->dev.of_node =3D pdev->dev.of_node;
> +	master->bus_num =3D -1;
> +	master->setup =3D em_spi_setup;
> +	master->transfer_one_message =3D em_spi_transfer_one_message;
> +	master->mode_bits =3D SPI_CPHA | SPI_CPOL | SPI_CS_HIGH;
> +
> +	ret =3D spi_register_master(master);
> +
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Could not register SPI master.\n");
> +		goto error1;
> +	}
> +
> +	return 0;
> +
> +error1:
> +	spi_master_put(master);
> +
> +	return ret;
> +}
> +
> +static int em_spi_remove(struct platform_device *pdev)
> +{
> +	struct em_spi_data *em_spi =3D platform_get_drvdata(pdev);
> +
> +	em_spi_power_off(em_spi);
> +	spi_master_put(em_spi->master);
> +
> +	return 0;
> +}
> +
> +static struct of_device_id em_spi_ids[] =3D {
> +	{ .compatible =3D "renesas,em-spi", },
> +	{ }
> +};
> +
> +static struct platform_driver em_spi_driver =3D {
> +	.probe =3D em_spi_probe,
> +	.remove =3D em_spi_remove,
> +	.driver =3D {
> +		.name =3D "em-spi",
> +		.owner =3D THIS_MODULE,
> +		.of_match_table =3D em_spi_ids,
> +	},
> +};
> +
> +module_platform_driver(em_spi_driver);
> +MODULE_DEVICE_TABLE(of, em_spi_ids);
> +
> +MODULE_DESCRIPTION("EMXX SPI bus driver");
> +MODULE_LICENSE("GPLv2");
> +MODULE_AUTHOR("Ian Molton");
> +MODULE_ALIAS("platform:spi-em");
> --=20
> 1.7.10.4
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
