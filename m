From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 08 Sep 2014 07:28:48 +0000
Subject: Re: [PATCH] mmc: tmio: enable odd number size transfer
Message-Id: <CAMuHMdUJK1Mmd_S+-hGFoshgRbpHKG5OH2w7AFHNaQG5qyvNaw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87wq9eohuc.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87wq9eohuc.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

Hi Morimoto-san,

On Mon, Sep 8, 2014 at 6:29 AM, Kuninori Morimoto
<kuninori.morimoto.gx@gmail.com> wrote:
> +++ b/drivers/mmc/host/tmio_mmc_pio.c
> @@ -376,6 +376,43 @@ static int tmio_mmc_start_command(struct tmio_mmc_host *host, struct mmc_command
>         return 0;
>  }
>
> +static void tmio_mmc_transfer_data(struct tmio_mmc_host *host,
> +                                  unsigned short *buf,
> +                                  unsigned int count)
> +{
> +       int is_read = host->data->flags & MMC_DATA_READ;
> +       u16 extra;
> +       u8  *extra8;
> +       u8  *buf8;
> +
> +       /*
> +        * Transfer the data
> +        */
> +       if (is_read)
> +               sd_ctrl_read16_rep(host, CTL_SD_DATA_PORT, buf, count >> 1);
> +       else
> +               sd_ctrl_write16_rep(host, CTL_SD_DATA_PORT, buf, count >> 1);
> +
> +       /* count was even number */
> +       if (!(count & 0x1))
> +               return;
> +
> +       /* count was odd number */
> +
> +       extra8 = (u8 *)&extra;

I would drop the extra8 variable, if possible... (see below)

> +       buf8 = (u8 *)(buf + ((count - 1) >> 1));

The "-1" is not really needed.

> +       if (is_read) {
> +               extra = sd_ctrl_read16(host, CTL_SD_DATA_PORT);
> +
> +               buf8[1] = extra8[1];
> +       } else {
> +               extra = buf8[1] << 8;
> +
> +               sd_ctrl_write16(host, CTL_SD_DATA_PORT, extra);
> +       }
> +}

Shouldn't this use buf8[0] instead of buf8[1]?
Originally, this is a byte buffer, right? Or is it a byte-swapped 16-bit
buffer?

Does this code need to care about endianness?
Due to using byte array accesses on read, and shifts on write, the result
differs depending on endianness.

On little endian, you have

Read: extra = [ buf8[1] | buf8[0] ]

Write: extra = [ buf8[1] | 0 ]

On big endian, you have

Read: extra = [ buf8[0] | buf8[1] ]
Write: extra = [ buf8[1] | 0 ]

I think it's better to use shifts for both read and write, and add an
le16_to_cpu()/
cpu_to_le16() if needed.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
