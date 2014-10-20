From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 20 Oct 2014 10:29:52 +0000
Subject: Re: [Issue] access cpu_cycles PMU conter in r8a7791
Message-Id: <CAMuHMdUrzkLX=pPLrg_c3MKUNTs5-C_v4V1=PN9EciKm=ZrZBA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <543E64EC.7090009@cn.fujitsu.com>
In-Reply-To: <543E64EC.7090009@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Oct 20, 2014 at 12:14 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> After wrapping everything in local_irq_save(flags) / local_irq_restore(flags),
> and moving the printk() outside the measurement loop, it looks much better:

The printk() was the biggest culprit. Disabling interrupts isn't needed.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
