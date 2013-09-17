From: Mark Brown <broonie@kernel.org>
Date: Tue, 17 Sep 2013 13:23:16 +0000
Subject: Re: [PATCH] SPI: EMMA Mobile SPI master driver
Message-Id: <20130917132316.GF21013@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="B0ZU/rjo5v6h4DpE"
List-Id: <linux-sh.vger.kernel.org>
References: <1378386669-9920-2-git-send-email-ian.molton@codethink.co.uk>
In-Reply-To: <1378386669-9920-2-git-send-email-ian.molton@codethink.co.uk>
To: linux-sh@vger.kernel.org


--B0ZU/rjo5v6h4DpE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 05, 2013 at 02:11:09PM +0100, Ian Molton wrote:

> +void em_spi_set_clock(struct em_spi_data *em_spi, unsigned long freq)
> +{
> +	int rate = clk_round_rate(em_spi->sclk, freq);
> +
> +	clk_set_rate(em_spi->sclk, rate);
> +
> +	/* Plenty long enough for clocks to stabilise */
> +	msleep(1);
> +}

The clock API ought to be making sure the clock is ready here.

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

The comment leaves me none the wiser as to what this is actually doing.
As Simon noted some sort of timeout would seem to be in order too.

> +		if (em_spi->status & EMXX_SPI_ERR_STAT)
> +			return -EINVAL;

The driver should really tell people what the error was, there's a
bitmask there.

> +	list_for_each_entry(t, &mesg->transfers, transfer_list) {
> +
> +		if (t->tx_buf && t->rx_buf) {
> +			/* Do not yet support concurrent transfers */
> +			BUG();

WARN_ON() at most.

> +	em_spi_set_cs(em_spi, em_spi->chip_select, 0);

This is ignoring any /CS fiddling options in the transfer.  We really
ought to be factoring this GPIO bashing out of the drivers...

> +	if (!spi->bits_per_word)
> +		spi->bits_per_word = 8;

The core ought to do this for you.

> +	if (spi->bits_per_word != 8)
> +		BUG(); /* We dont support >8 bit transfers */

Again this is too much, you're also not setting bits_per_word_mask.

> +
> +	if (em_spi->cs_gpio)
> +		actual_cs = em_spi->hard_chip_select;
> +	else
> +		actual_cs = spi->chip_select;

This test looks the wrong way round or hard_chip_select seems misnamed?
Or some comments might be in order.

> +static void em_spi_power_on(struct em_spi_data *em_spi)
> +{
> +	clk_enable(em_spi->clk);
> +	clk_enable(em_spi->sclk);
> +}

> +static void em_spi_power_off(struct em_spi_data *em_spi)

These look like they should be runtime PM callbacks.

> +static irqreturn_t em_spi_irq(int irq, void *data)
> +{
> +	struct em_spi_data *em_spi = (struct em_spi_data *)data;
> +	unsigned long status;
> +
> +	status = readl(em_spi->addr + EMXX_SPI_STAT);
> +
> +	if (status) {
> +		em_spi->status = status;
> +		writel(status, em_spi->addr + EMXX_SPI_ENCLR);
> +
> +		wake_up(&em_spi->wait);
> +	}
> +
> +	return IRQ_HANDLED;

So if status isn't set we say the IRQ was handled...  should it not be
returning IRQ_NONE?

> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (unlikely(res == NULL)) {
> +		dev_err(&pdev->dev, "invalid resource\n");
> +		return -EINVAL;
> +	}

> +	em_spi->addr = devm_ioremap(&pdev->dev, res->start, resource_size(res));
> +	if (em_spi->addr == NULL) {
> +		dev_err(&pdev->dev, "ioremap error.\n");
> +		ret = -ENOMEM;
> +		goto error1;
> +	}

devm_ioremap_resource().

> +	writel(0x1, em_spi->addr + EMXX_SPI_BLOCK_MODE_SWITCH_EN);
> +	writel(0x1, em_spi->addr + EMXX_SPI_BLOCK_MODE);

> +	/* Reset, int off */
> +	em_spi_soft_reset(em_spi);

We initialise some registers and then we do a soft reset - that looks
odd?

> +	ret = devm_request_irq(&pdev->dev, irq, em_spi_irq, 0, "spi-em",
> +				em_spi);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Could not request IRQ.\n");

Say what the error was.

> +	ret = spi_register_master(master);

devm_spi_register_master().

> +static struct of_device_id em_spi_ids[] = {
> +	{ .compatible = "renesas,em-spi", },
> +	{ }
> +};

There is no DT binding documentation for this, all new bindings must be
documented.

--B0ZU/rjo5v6h4DpE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSOFfBAAoJELSic+t+oim9V1AP/3rlzHv2F1bOxNNmNXOJzudv
FB2pmphqE8y09ZUpNsuJ+txsTFmh02FlPOA5GYSaDm7xcBftWz9Mis39KGEMhxll
5aJiiSIhdo3vyG7a7fHYldOJklgBrIOEj3Fnj7Ex4RG+Z7NxN0mdYPw+19P+0dXX
Hrr8iNull/C2JljPEQklJwZvd+NqCGrKTDozPDzO/zvURY6JoTpwWOB0YBjEszi0
tNnfUn1ypSHeLTlK17EFcXJxEtrsRxhXwKKJn0RqptOs8iABun/VTl3jRN3m4qeP
+3esPnS6IwrqR5l2RGfVTj3AGWciO8Hn3nfCqvaSx+IVrsKCkla3i8x4PT8L5Fqb
ZbBRhDEeTqniiiQxe0wBUwc+Kch/DIvn8oFmLfP0ow0MamvzEwusijGtbi4+EInx
pB6gFCjAGlFJQ+yE4DrR3kay45+JLwy5R+gh+CNyAZwkfSwbphy2hKDnDLSwcE1V
YaJAgicJJN4lrZCNUJm5ZXzgh3AkHRQbwfjRH2iFn7y20pMbRNsfvjVhmUT+52qI
eqSSBlz+e4c4IQrZ5LJjUzUemQUbcZwQ/mqS+R7G+gx3WBZi0BUSJg+A4d8YWo8x
aBzyLTEwJ47R7KO4RODK7uK2WhN1YVddcSfCNMnTtesR3pb3oQ7hS6DvQ+Db9nFl
p2/1flJlPsU1Oz9x+sFn
=pRzH
-----END PGP SIGNATURE-----

--B0ZU/rjo5v6h4DpE--
