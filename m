From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 14 Sep 2015 10:13:38 +0000
Subject: Re: [PATCH v2] clk: add CS2000 Fractional-N driver
Message-Id: <CAMuHMdUZ+-7-N7znngJ0Gk9-TX3-dQxDsYc2NjWut426rKjF9Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87egi1jpz9.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87egi1jpz9.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Simon <horms@verge.net.au>, Michael Turquette <mturquette@baylibre.com>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-Kernel <linux-kernel@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>

On Mon, Sep 14, 2015 at 11:47 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> +static int cs2000_ratio_set(struct i2c_client *client,
> +                           int ch, u32 rate_in, u32 rate_out)
> +{
> +       u64 val;
> +       unsigned int i;
> +       int ret;
> +
> +       if (CH_SIZE_ERR(ch))
> +               return -EINVAL;
> +
> +       /*
> +        * ratio = rate_out / rate_in * 2^20
> +        *
> +        * To avoid over flow, rate_out is u64
> +        * The result should be u32
> +        */
> +
> +       val = rate_out;
> +       val *= (1 << 20);

val <<= 20

Or

    val = (u64)rate_out << 20;

> +       do_div(val, rate_in);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
