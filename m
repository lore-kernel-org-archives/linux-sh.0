From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 16 Jan 2015 09:20:38 +0000
Subject: Re: ARM: shmobile: r8a7778: Instantiate GIC from C board code in legacy builds
Message-Id: <CAMuHMdUqAEUW=bdzzxgLGB_TVAApfLRVhPQafE4NhDWDv=UaPw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150116011710.12605.71607.sendpatchset@little-apple>
In-Reply-To: <20150116011710.12605.71607.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jan 16, 2015 at 2:17 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
>
> As of commit 9a1091ef0017c40a ("irqchip: gic: Support hierarchy irq
> domain."), Bock-W legacy hangs during boot with:
>
> Unable to handle kernel paging request at virtual address cf86a128
> pgd = c0004000
> [cf86a128] *pgdo80041e(bad)
> Internal error: Oops: 8000000d [#1] SMP ARM
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.19.0-rc4 #1
> Hardware name: bockw
> task: cf823b40 ti: cf824000 task.ti: cf824000
> PC is at 0xcf86a128
> LR is at request_threaded_irq+0xbc/0x124
>
> This happens because the IRQ numbers of the GIC are now virtual, and no
> longer match the hardcoded hardware IRQ numbers in the platform board
> code.
>
> To fix this, instantiate the GIC from platform board code when compiling
> a legacy kernel, like is done for the sh73a0 and r8a7740 legacy code.
>
> Follows same style as the r8a7740 legacy GIC fix by Geert Uytterhoeven,
> thanks to him for the initial work.
>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
