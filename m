From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Mar 2014 09:23:52 +0000
Subject: Re: [RFC] spi: Using Trigger number to transmit/receive data
Message-Id: <CAMuHMdUpm_4f7LynObRA+NDn4vqeUc0a2XZW-E=4LKL_Ro3XZw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1394699364-5669-1-git-send-email-cm-hiep@jinso.co.jp>
	<1394699364-5669-2-git-send-email-cm-hiep@jinso.co.jp>
In-Reply-To: <1394699364-5669-2-git-send-email-cm-hiep@jinso.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Cc: Mark Brown <broonie@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Geert Uytterhoeven <geert+renesas@linux-m68k.org>

On Thu, Mar 13, 2014 at 9:29 AM, Cao Minh Hiep <cm-hiep@jinso.co.jp> wrote:
> In order to transmit and receive data when have 32 bytes of data that
> ready has prepared on Transmit/Receive Buffer to transmit or receive.
> Instead transmits/receives a byte data using Transmit/Receive Buffer
> Data Triggering Number will improve the speed of transfer data.

Thanks for your patch, this looks like a valuable improvement!

Unfortunately your patch doesn't apply against spi/for-next anymore, as
the driver has changed a lot lately, due to the addition of RZ/A1H and
Quad/Dual support.

> +static void qspi_update(const struct rspi_data *rspi, u8 mask, u8 val, u8 reg)
> +{
> +       u8 data;
> +
> +       data = rspi_read8(rspi, reg);
> +       data &= ~mask;
> +       data |= (val & mask);

I think this "& mask" is superfluous.

> +       rspi_write8(rspi, data, reg);
> +}

> +static int qspi_set_send_trigger(struct rspi_data *rspi, int remain)
> +{
> +       int n;
> +
> +       n = min(remain, QSPI_BUFFER_SIZE);
> +
> +       if (remain >= QSPI_BUFFER_SIZE) {
> +               /* sets triggering number to 32 bytes */

"0 bytes"? (comment copied from qspi_set_receive_trigger())

> +               qspi_update(rspi, SPBFCR_TXTRG_MASK,
> +                            SPBFCR_TXTRG_0B, QSPI_SPBFCR);
> +       } else {
> +               /* sets triggering number to 1 byte */

"31 bytes"?

> +               qspi_update(rspi, SPBFCR_TXTRG_MASK,
> +                            SPBFCR_TXTRG_31B, QSPI_SPBFCR);
> +       }

> @@ -389,9 +443,10 @@ static int qspi_send_pio(struct rspi_data *rspi, struct spi_message *mesg,
>  {
>         int remain = t->len;
>         const u8 *data = t->tx_buf;
> +       int i, n;
>
>         rspi_write8(rspi, SPBFCR_TXRST, QSPI_SPBFCR);
> -       rspi_write8(rspi, 0x00, QSPI_SPBFCR);
> +       rspi_write8(rspi, DUMMY_DATA, QSPI_SPBFCR);

I think this should stay "0x00", as it's not dummy data written to the
transmit data register.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
