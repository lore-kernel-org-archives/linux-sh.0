From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Mar 2014 11:38:27 +0000
Subject: Re: [PATCH] clk: shmobile: mstp: Fix the is_enabled() operation
Message-Id: <CAMuHMdUFiMssxFLke_UFJrqSgFc5cBmQLoZPWynZwZ3G6mEudA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1394658274-6348-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1394658274-6348-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Mar 13, 2014 at 12:27 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> The only clocks we do enable are those we register with
> shmobile_clk_workaround():
>
> MSTP sata0 ON

Sata0 is not registered with shmobile_clk_workaround(), so probably is
managed manually by its driver.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
