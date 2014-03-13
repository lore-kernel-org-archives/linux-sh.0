From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 13 Mar 2014 09:27:54 +0000
Subject: Re: [RFC] spi: Using Trigger number to transmit/receive data
Message-Id: <53217A1A.50907@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1394699364-5669-1-git-send-email-cm-hiep@jinso.co.jp> <1394699364-5669-2-git-send-email-cm-hiep@jinso.co.jp>
In-Reply-To: <1394699364-5669-2-git-send-email-cm-hiep@jinso.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Cao Minh Hiep <cm-hiep@jinso.co.jp>, broonie@kernel.org
Cc: devicetree@vger.kernel.org, linux-sh@vger.kernel.org, geert+renesas@linux-m68k.org

Hi Hiep

> In order to transmit and receive data when have 32 bytes of data that
> ready has prepared on Transmit/Receive Buffer to transmit or receive.
> Instead transmits/receives a byte data using Transmit/Receive Buffer
> Data Triggering Number will improve the speed of transfer data.
> 
> Signed-off-by: Hiep Cao Minh <cm-hiep@jinso.co.jp>
> ---
(snip)
> +static int qspi_set_send_trigger(struct rspi_data *rspi, int remain)
> +{
> +	int n;
> +
> +	n = min(remain, QSPI_BUFFER_SIZE);
> +
> +	if (remain >= QSPI_BUFFER_SIZE) {
> +		/* sets triggering number to 32 bytes */
> +		qspi_update(rspi, SPBFCR_TXTRG_MASK,
> +			     SPBFCR_TXTRG_0B, QSPI_SPBFCR);
> +	} else {
> +		/* sets triggering number to 1 byte */
> +		qspi_update(rspi, SPBFCR_TXTRG_MASK,
> +			     SPBFCR_TXTRG_31B, QSPI_SPBFCR);
> +	}
> +
> +	return n;
> +}
(snip)
> +		n = qspi_set_send_trigger(rspi, remain);
> +		if (n >= QSPI_BUFFER_SIZE) {
> +			for (i = 0; i < n; i++)
> +				rspi_write8(rspi, *data++, RSPI_SPDR);
> +			if (rspi_wait_for_interrupt(rspi, SPSR_SPRF,
> +						    SPCR_SPRIE) < 0) {
> +				dev_err(&rspi->master->dev,
> +					"%s: receive timeout\n", __func__);
> +				return -ETIMEDOUT;
> +			}
> +			for (i = 0; i < n; i++)
> +				rspi_read8(rspi, RSPI_SPDR);
> +		} else {
> +			for (i = 0; i < n; i++) {
> +				if (rspi_wait_for_interrupt(rspi, SPSR_SPTEF,
> +							    SPCR_SPTIE) < 0) {
> +					dev_err(&rspi->master->dev,
> +					   "%s: tx empty timeout\n", __func__);
> +				return -ETIMEDOUT;
> +				}
> +				rspi_write8(rspi, *data++, RSPI_SPDR);
> +
> +				if (rspi_wait_for_interrupt(rspi, SPSR_SPRF,
> +							    SPCR_SPRIE) < 0) {
> +					dev_err(&rspi->master->dev,
> +					   "%s: receive timeout\n", __func__);
> +				return -ETIMEDOUT;
> +				}
> +				rspi_read8(rspi, RSPI_SPDR);
> +			}

I guess, this "qspi_set_send_trigger()" is mode "settings",
and, "transfer" is done here.

I think "setting" and "tranfer" in 1 function is readable.
