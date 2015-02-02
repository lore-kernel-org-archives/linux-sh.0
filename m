From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 02 Feb 2015 09:32:43 +0000
Subject: Re: [RFC 0/5] r8a7790: lager: add support for RCLK watchdog
Message-Id: <CAMuHMdV1qfuLcSJ3g+QSL54NzJyk+5fD7uDKJnHxAjKFThCNeg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1422802074-1921-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1422802074-1921-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Wolfram,

On Sun, Feb 1, 2015 at 3:47 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> I needed a watchdog for my lager board to deploy some long-term tests. Also, a
> working reboot command is so convenient :) I saw the DA9063 work from Geert
> which seems to suffer from an unsolved mystery still. So, I took the liberty to
> hack a driver for the RCLK watchdog. It works fine for me on my Lager board. I
> will add support for the other RCar SoC in the next round, they are all the
> same (according to docs, at least). Then, I'll also add binding documentation.
> This is a "release early" series, so you can already comment if you wish. For
> that reason, the watchdog list is not yet on CC. So, test if you like and
> comment.

Thanks for your series!

Before I started using the DA9063, I did try the RWDT, but I could only get it
to work for CONFIG_SMP=n kernels. With CONFIG_SMP=y, the system locks up
instead of restarting. I played a bit with the various RST registers, but to
no avail. Hence I went with the DA9063 instead. Note that I plan to look into
the DA9063 interrupt storm issue soon.

I've just tried your series on Koelsch, and it suffers from the same problem.
Does it work on Lager for both CONFIG_SMP=y and CONFIG_SMP=n?

From the limited information available about the SWDT, it may be compatible
with the RWDT. Or not. U-Boot disables both the RWDT and the SWDT on startup,
using identical operations.

The RWDT exists on various shmobile SoCs.
From digging into the datasheets, I had discovered two variants:
  1. 32-bit registers
       a. R-Car Gen2: using RST for restarting
       b. R-Mobile APE6: using SYSC for restarting
  2. 8-bit registers (SH-Mobile AP4/AG5, R-Mobile A1)

The differences are small: the variant with 8-bit registers has a smaller
maximum timeout, and no magic value to be stored in the upper bits.

Have fun!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
