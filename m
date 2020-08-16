From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 16 Aug 2020 08:34:40 +0000
Subject: Re: Ping: Pull Request for 5.9
Message-Id: <CAMuHMdVunSe+2OPg3kSaeLoX-AUOWqHHNb=8AZi1x2DhNOeQeA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <b9ea23ec-4925-aee6-07a8-571971a42194@physik.fu-berlin.de>
In-Reply-To: <b9ea23ec-4925-aee6-07a8-571971a42194@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Adrian,

On Sat, Aug 15, 2020 at 12:41 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> @Geert: What about that patch to fix the serial interface on LANDISK?

It's a fix for serial parity handling for SCIF, and thus not really needed for
a serial console.    No need to worry, as it's already in.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
