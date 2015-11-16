From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 16 Nov 2015 09:45:51 +0000
Subject: Re: [PATCH 1/2] sh-sci: Add CONFIG_SERIAL_EARLYCON support
Message-Id: <CAMuHMdWzxfztOG1E-knjxGePEnffRRBN3Xg-t-FmwTjcEV4E1g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1447431743-16376-2-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1447431743-16376-2-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

On Fri, Nov 13, 2015 at 5:22 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> "earlyprintk" is architecture specific option.
> I think general "earlycon" option support more better.
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> [uli: preserve other SCSCR bits when asserting RE and TE]

Thanks! That fixed it on Koelsch, too.

U-Boot uses the BRG and SCIF_CLK on Koelsch etc., while it doesn't on
Salvator-X. That's why it worked on R-Car Gen3 but not on Gen2.

> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

The spinlock issues is still there, though, cfr.
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-August/364178.html

BUG: spinlock bad magic on CPU#0, swapper/0
 lock: sci_ports+0x0/0x3480, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
CPU: 0 PID: 0 Comm: swapper Not tainted
4.3.0-koelsch-12027-g4b94677ed7f4a3de-dirty #1974
Hardware name: Generic R8A7791 (Flattened Device Tree)
[<c00173a0>] (unwind_backtrace) from [<c0013094>] (show_stack+0x10/0x14)
[<c0013094>] (show_stack) from [<c01f1e38>] (dump_stack+0x70/0x8c)
[<c01f1e38>] (dump_stack) from [<c0070160>] (do_raw_spin_lock+0x20/0x190)
[<c0070160>] (do_raw_spin_lock) from [<c0266d28>]
(serial_console_write+0x4c/0x120)
[<c0266d28>] (serial_console_write) from [<c007334c>]
(call_console_drivers.constprop.13+0xc8/0xec)
[<c007334c>] (call_console_drivers.constprop.13) from [<c0074d78>]
(console_unlock+0x354/0x440)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
