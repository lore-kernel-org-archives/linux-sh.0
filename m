From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 16 Feb 2015 17:36:37 +0000
Subject: Re: [PATCH v3 05/15] ARM: shmobile: r8a7778: implement SoC and board CCF support
Message-Id: <CAMuHMdXyNDGiOE8PE0Yh=4A3RJj3shRQ-Mt5ah+AnVfXvEEtMg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1424105939-4910-6-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1424105939-4910-6-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Feb 16, 2015 at 5:58 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> Disables the legacy clock framework and passes the mode bits to the CPG
> driver if CCF is enabled.
>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
