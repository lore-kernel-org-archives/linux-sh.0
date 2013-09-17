From: Ian Molton <ian.molton@codethink.co.uk>
Date: Tue, 17 Sep 2013 14:30:48 +0000
Subject: Re: [PATCH] SPI: EMMA Mobile SPI master driver
Message-Id: <52386798.3010205@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1378386669-9920-2-git-send-email-ian.molton@codethink.co.uk>
In-Reply-To: <1378386669-9920-2-git-send-email-ian.molton@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 17/09/13 14:23, Mark Brown wrote:
> On Thu, Sep 05, 2013 at 02:11:09PM +0100, Ian Molton wrote:
>
>> +void em_spi_set_clock(struct em_spi_data *em_spi, unsigned long freq)
>> +{
>> +	int rate = clk_round_rate(em_spi->sclk, freq);
>> +
>> +	clk_set_rate(em_spi->sclk, rate);
>> +
>> +	/* Plenty long enough for clocks to stabilise */
>> +	msleep(1);
>> +}
>
> The clock API ought to be making sure the clock is ready here.

Im not sure the clock API should be taking into account quirks of the 
SPI block. the incomming clock is, I'm sure, fine. The block takes time 
to sync.

>> +		/*
>> +		 * We're abusing the chip a bit so that we can do
>> +		 * multi-byte operations in PIO mode.
>> +		 * As a result we need to spin until the START bit drops here.
>> +		 *
>> +		 * This only works with GPIO based chipselects, unless the
>> +		 * transfer size is 4 bytes or less. Verified on a scope.
>> +		 *
>> +		 * DMA mode appears not to have this restriction.
>> +		 */
>> +
>> +		while (readl(em_spi->addr + EMXX_SPI_CTL) & 1)
>> +			;
>
> The comment leaves me none the wiser as to what this is actually doing.
> As Simon noted some sort of timeout would seem to be in order too.

Hm, how much more is appropriate to comment within the driver?

What we're doing, is setting a GPIO CS just before the transfer and 
resetting it after.

using the dedicated CS lines hits a chip limit of 4 bytes. If you ignore 
it and keep sending data, the chip behaves correctly, except that 
automatic start/stop doesnt work properly. (it may not work properly, 
period, but I have no way to test).

>> +		if (em_spi->status & EMXX_SPI_ERR_STAT)
>> +			return -EINVAL;
>
> The driver should really tell people what the error was, there's a
> bitmask there.

Fair, will fix.

>> +	list_for_each_entry(t, &mesg->transfers, transfer_list) {
>> +
>> +		if (t->tx_buf && t->rx_buf) {
>> +			/* Do not yet support concurrent transfers */
>> +			BUG();
>
> WARN_ON() at most.

Already fixed locally.

>> +	em_spi_set_cs(em_spi, em_spi->chip_select, 0);
>
> This is ignoring any /CS fiddling options in the transfer.  We really
> ought to be factoring this GPIO bashing out of the drivers...

Perhaps, but how?

>> +	if (!spi->bits_per_word)
>> +		spi->bits_per_word = 8;
>
> The core ought to do this for you.

Paranoia ported forward... will nuke.

>> +	if (spi->bits_per_word != 8)
>> +		BUG(); /* We dont support >8 bit transfers */
>
> Again this is too much, you're also not setting bits_per_word_mask.

Will fix.

>> +
>> +	if (em_spi->cs_gpio)
>> +		actual_cs = em_spi->hard_chip_select;
>> +	else
>> +		actual_cs = spi->chip_select;
>
> This test looks the wrong way round or hard_chip_select seems misnamed?
> Or some comments might be in order.

No, its correct. When using GPIO lines, even if the real CS lines arent 
used, you still must program them properly, or the chip does not respect 
polarity/phase options.

hard_chip_select is used to choose which "real" chipselect is being used 
to back the GPIO based CS.

the idea is that chip_select is always used to refer to the CS as seen 
from the attached devices perspective. when not using GPIOs, it is = 
hard_chip_select.

perhaps s/hard/underlying/ ?
or s/hard/real/ ?

>> +static void em_spi_power_on(struct em_spi_data *em_spi)
>> +{
>> +	clk_enable(em_spi->clk);
>> +	clk_enable(em_spi->sclk);
>> +}
>
>> +static void em_spi_power_off(struct em_spi_data *em_spi)
>
> These look like they should be runtime PM callbacks.

Deleted locally as I cant test this. Im not sure what happened to the 
latest patch, it appears not to have hit the mailinglist.

>> +static irqreturn_t em_spi_irq(int irq, void *data)
>> +{
>> +	struct em_spi_data *em_spi = (struct em_spi_data *)data;
>> +	unsigned long status;
>> +
>> +	status = readl(em_spi->addr + EMXX_SPI_STAT);
>> +
>> +	if (status) {
>> +		em_spi->status = status;
>> +		writel(status, em_spi->addr + EMXX_SPI_ENCLR);
>> +
>> +		wake_up(&em_spi->wait);
>> +	}
>> +
>> +	return IRQ_HANDLED;
>
> So if status isn't set we say the IRQ was handled...  should it not be
> returning IRQ_NONE?

Probably.

>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (unlikely(res = NULL)) {
>> +		dev_err(&pdev->dev, "invalid resource\n");
>> +		return -EINVAL;
>> +	}
>
>> +	em_spi->addr = devm_ioremap(&pdev->dev, res->start, resource_size(res));
>> +	if (em_spi->addr = NULL) {
>> +		dev_err(&pdev->dev, "ioremap error.\n");
>> +		ret = -ENOMEM;
>> +		goto error1;
>> +	}
>
> devm_ioremap_resource().

Nice. will change.

>> +	writel(0x1, em_spi->addr + EMXX_SPI_BLOCK_MODE_SWITCH_EN);
>> +	writel(0x1, em_spi->addr + EMXX_SPI_BLOCK_MODE);
>
>> +	/* Reset, int off */
>> +	em_spi_soft_reset(em_spi);
>
> We initialise some registers and then we do a soft reset - that looks
> odd?

But correct. Those registers control function of the block as either SPI 
or IIS.

>> +	ret = devm_request_irq(&pdev->dev, irq, em_spi_irq, 0, "spi-em",
>> +				em_spi);
>> +	if (ret < 0) {
>> +		dev_err(&pdev->dev, "Could not request IRQ.\n");
>
> Say what the error was.

OK.

>> +	ret = spi_register_master(master);
>
> devm_spi_register_master().

OK.

>> +static struct of_device_id em_spi_ids[] = {
>> +	{ .compatible = "renesas,em-spi", },
>> +	{ }
>> +};
>
> There is no DT binding documentation for this, all new bindings must be
> documented.

No prob.

I'll fix this lot up and resubmit. Thanks for the review.

-Ian

