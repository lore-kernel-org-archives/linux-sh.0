From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 13 Jan 2016 16:16:07 +0000
Subject: Re: [RFC v2 3/4] i2c: mux: demux-pinctrl: add driver
Message-Id: <CAMuHMdVnYMmrt3PPb-cg4C889RB5pwKN+LX6O-1VSX1oaKY1ww@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1452088285-6427-1-git-send-email-wsa@the-dreams.de>
	<1452088285-6427-4-git-send-email-wsa@the-dreams.de>
	<CAMuHMdUuiuXPFJQpUB+Y3xF34KnqhzdZ+x-E7zL1ywp=sAQWXg@mail.gmail.com>
	<20160113125514.GE1540@katana>
In-Reply-To: <20160113125514.GE1540@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, Jan Luebbe <jlu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Hi Wolfram,

On Wed, Jan 13, 2016 at 1:55 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>> > +struct i2c_demux_pinctrl_priv {
>> > +       int cur_chan;
>> > +       int num_chan;
>>
>> This is always positive, so you can make num_chan and a few loop counters
>> unsigned.
>
> Nope, sadly not. cur_chan can get a -ERRNO, and the type of num_chan is

Sorry for the bad quoting, my comment applied to num_chan only.

> defined by the return type of of_count_phandle_with_args().

But you will never store negative error codes returned by that function, as you
won't get to the storing part...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
