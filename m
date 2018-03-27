From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 27 Mar 2018 07:08:58 +0000
Subject: Re: [PATCH 1/5] drivers/sh/clk: add support for CLK_SET_TO_ENABLE flag
Message-Id: <CAMuHMdXbdO5HjF20ym+ohuii_2QG9crRcD0eYqWW1+xVZg6bhw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20180326212527.12565-2-thomas.petazzoni@bootlin.com>
In-Reply-To: <20180326212527.12565-2-thomas.petazzoni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Thomas,

Thanks for your patch!

On Mon, Mar 26, 2018 at 11:25 PM, Thomas Petazzoni
<thomas.petazzoni@bootlin.com> wrote:
> The current sh_clk_mstp_{enable,disable} functions assume that
> enable_bit must be cleared to enable the clock, and set to disable the
> clock.

Correct, mstp stands for "Module SToP".

> However, this clock type is used for the PHY of the SH7786 PCIe
> controller, which has the opposite polarity: set to enable, clear to
> disable. In order to properly support this clock, we introduce a
> CLK_SET_TO_ENABLE flag.

I think the correct solution is to not model the PHY clock as an MSTP clock,
so you don't need to pollute the MSTP clock driver with foreign clock support.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
