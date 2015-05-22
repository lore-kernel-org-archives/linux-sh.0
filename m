From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 22 May 2015 09:29:06 +0000
Subject: Re: [PATCH v3 11/11] ARM: shmobile: gose: enable R-Car Gen2 regulator quirk
Message-Id: <CAMuHMdUx_E09f5dfVQRzQW8dp0q5-pYGcpfw_LeD93nc648ayg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1432205293-9488-12-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1432205293-9488-12-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

On Fri, May 22, 2015 at 11:10 AM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> On Fri, May 22, 2015 at 11:07 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> Does it also print "IRQ2 is not asserted, removing quirk", to indicate success
>> after masking the da9063 and da9210 interrupt sources?
>
> Yep:
>
> i2c 6-0058: Masking da9063 interrupt sources
> i2c 6-0068: Masking da9210 interrupt sources
> i2c 6-0068: IRQ2 is not asserted, removing quirk

Thanks for testing!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
