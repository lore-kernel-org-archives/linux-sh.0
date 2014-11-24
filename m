From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 24 Nov 2014 13:22:42 +0000
Subject: DIV6 Bus State Controller clock on sh73a0/r8a73a4
Message-Id: <CAMuHMdWwVsaaTTrgQ1jNFiy5uMuU3p30r+nLJaSS0vAtbb73pQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

While debugging an issue with the sh73a0's BSC (Bus State Controller) clock
on kzm9g-multiplatform, I noticed it's running at the wrong frequency:

# cat /sys/kernel/debug/clk/zb/clk_rate
208000000

According to the sh73a0 datasheet, the ZB clock runs at 104 MHz, not 208 MHz.
Note that the ZB clock also has this wrong value when using the pre-CCF clock
code.

The divider value used for this clock is 2, which is the default value.
Hence the DIV6 driver divides the pll1_div2 clock rate by 3 to get the BSC clock
rate.

# cat /sys/kernel/debug/clk/pll1_div2/clk_rate
624000000

However, the documentation for the "BSC Clock Frequency Control Register
(ZBCKCR)" states (for both sh73a0 and r8a73a4):

    The clock source specified by EXSRC is divided by the division ratio
    of 1 / (2 *(setting + 1)).

Note the "2". Other DIV6 clocks do not have this "2" there.
As the driver cannot know about this without external input, I'm afraid the
DIV6 bindings must be amended, e.g. by adding an additional property for a
post-divider value?

Fortunately there are no real ill effects of this, as nobody really uses
(gets/sets) the rate of the BSC clock.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
