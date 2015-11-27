From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 27 Nov 2015 08:04:07 +0000
Subject: Re: [RFC 5/9] i2c: rcar: honor additional i2c timings from DT
Message-Id: <CAMuHMdU1fWjH2Lv00W2uxRW7-XGp1YaEoA4Ftq5o6yk6WamCBQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1448578757-12613-1-git-send-email-wsa@the-dreams.de>
	<1448578757-12613-6-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1448578757-12613-6-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

On Thu, Nov 26, 2015 at 11:59 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> --- a/drivers/i2c/busses/i2c-rcar.c
> +++ b/drivers/i2c/busses/i2c-rcar.c
> @@ -211,12 +214,12 @@ static int rcar_i2c_clock_calculate(struct rcar_i2c_priv *priv, struct i2c_timin
>          * it is impossible to calculate large scale
>          * number on u32. separate it
>          *
> -        * F[(ticf + tr + intd) * ick]
> -        *  = F[(35 + 200 + 50)ns * ick]
> -        *  = F[285 * ick / 1000000000]
> -        *  = F[(ick / 1000000) * 285 / 1000]
> +        * F[(ticf + tr + intd) * ick] with sum = (ticf + tr + intd)
> +        *  = F[sum * ick / 1000000000]
> +        *  = F[(ick / 1000000) * sum / 1000]
>          */
> -       round = (ick + 500000) / 1000000 * 285;
> +       sum = t->scl_fall_ns + t->scl_rise_ns + t->scl_int_delay_ns;
> +       round = (ick + 500000) / 1000000 * sum;

If you're sure it cannot overflow, doing the "* sum" before the division
improves accuracy.

>         round = (round + 500) / 1000;

You can use DIV_ROUND_CLOSEST everywhere, e.g.

    round = DIV_ROUND_CLOSEST(round, 1000)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
