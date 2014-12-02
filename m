From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 02 Dec 2014 21:13:50 +0000
Subject: Re: [PATCH v3 0/6] r8a73a4 common clock framework implementation
Message-Id: <CAMuHMdXxkVY7MDguxfQ+3AxF3qjyzJX7K8k-id1OLros_61Ceg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1417509409-31638-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1417509409-31638-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

On Tue, Dec 2, 2014 at 9:36 AM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> Version 3 of the CCF implementation for r8a73a4.  Again, this includes
> multi-parent DIV6 clocks and thus depends on the "clk: shmobile: DIV6 clock
> variable parent support" patch set from the clk-next tree.
>
> This version fixes three real issues acutely spotted by Laurent and Geert,
> adds a number of acks, and includes the usual reformatting routine.  See
> below for details.

Thanks for your series!

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
