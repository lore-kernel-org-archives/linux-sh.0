From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 23 May 2014 08:39:05 +0000
Subject: Re: R-CAR's arch
Message-Id: <CAMuHMdXpTNZN_rb-ZyKsxtpiEcFWcZCJ2bh4vnOywfKGa+FBgg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140522101938.51fec16f@endymion.delvare>
In-Reply-To: <20140522101938.51fec16f@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Jean,

On Fri, May 23, 2014 at 10:23 AM, Jean Delvare <jdelvare@suse.de> wrote:
> For USB PHY the dependencies are clear. For VIN I'm not so sure, does
> anybody know? I'd got for ARCH_SHMOBILE || COMPILE_TEST but I don't know
> if SUPERH should be listed too.

R-Car falls under shmobile (which also covers Emma Mobile and R-Mobile).
I.e. no SUPERH.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
