From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 07 May 2015 16:27:14 +0000
Subject: Re: [PATCH 4/4] pinctrl: sh-pfc: r8a7791/3: Add SSP pin group
Message-Id: <CAMuHMdVvSHdtY63is5iHFm2=EVBH19j0onHmDtrS+Z=DQxaOJA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1431015037-25254-5-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1431015037-25254-5-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

On Thu, May 7, 2015 at 6:10 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> "Stream and Security Processor", applicable to r8a7791 and r8a7793.
> Based on patch by Hisashi Nakamura.

If you bother adding these (who uses them?), I think you should add the
_B and _C groups, too.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
