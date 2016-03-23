From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 23 Mar 2016 07:45:17 +0000
Subject: Re: Fixing SH cache assumptions
Message-Id: <CAMuHMdV7FV+gXRjd5CARFVdM3ciy11+mPgzs3GHQj-CmDLYRsg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20160322211905.GA11781@brightrain.aerifal.cx>
In-Reply-To: <20160322211905.GA11781@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Mar 23, 2016 at 6:08 AM, Rob Landley <rob@landley.net> wrote:
> This sounds like something nommu systems do. Are any other nommu systems
> currently device tree enabled? (Blackfish? Coldfire? Is any of the
> Cortex-M stuff actually merged in-tree yet?)

$ git grep cortex-m
[...]
arch/arm/boot/dts/lpc18xx.dtsi:                 compatible = "arm,cortex-m3";
arch/arm/boot/dts/lpc4350.dtsi:                 compatible = "arm,cortex-m4";
arch/arm/boot/dts/lpc4357.dtsi:                 compatible = "arm,cortex-m4";
$

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
