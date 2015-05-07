From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 07 May 2015 16:28:27 +0000
Subject: Re: [PATCH 1/4] pinctrl: sh-pfc: Add r8a7793 support
Message-Id: <CAMuHMdWuW7qmVV-i1sZFhYj_ubeO_0bWp9qPMKUydh1V2WFpSw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1431015037-25254-2-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1431015037-25254-2-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, May 7, 2015 at 6:10 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> Regarding pin control, r8a7791 and r8a7793 are identical, so it is
> sufficient to add an sh_pfc_soc_info structure to enable r8a7793 support.

Thanks!

> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
