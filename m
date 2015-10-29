From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 29 Oct 2015 07:54:00 +0000
Subject: Re: Salvator-X I2C is working on HI speed on renesas-drivers-2015-10-27-v4.3-rc7
Message-Id: <CAMuHMdUsLus7zbu=SMWqR0d4R0k8u44bZXoK+h+XtLuLPZ1ZUw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <877fm61988.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <877fm61988.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Thu, Oct 29, 2015 at 8:40 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>> Does it work if you revert commit 2bc3c5a8631db6d8 ("i2c: rcar: init new
>> messages in irq")?
>> That commit was reported by Laurent to break HDMI on Koelsch, cfr.
>> http://www.spinics.net/lists/linux-sh/msg46160.html.
>
> Thank you for your feedback.
> I reverted it, but it was same result.
>
> # 09-29 version works with 100kHz,
> # but, 10-27 version works with 1MHz over in my quick check

If /sys/kernel/debug/clk/clk_summary doesn't show differences (it
shouldn't ;-), please try reverting more i2c commits.

git log --oneline
renesas-drivers-2015-09-29-v4.3-rc3..renesas-drivers-2015-10-27-v4.3-rc7
-- drivers/i2c/busses/i2c-rcar.c | tac
93c659d820ef291f i2c: rcar: rework hw init
59daef909d9ac2ca i2c: rcar: remove unused IOERROR state
738206dec9354817 i2c: rcar: remove spinlock
344beeb23bfc1150 i2c: rcar: refactor setup of a msg
2bc3c5a8631db6d8 i2c: rcar: init new messages in irq
315a1736a2f2d9ad i2c: rcar: don't issue stop when HW does it automatically
2151ba7584b73255 i2c: rcar: check master irqs before slave irqs
e5a7effa09e25743 i2c: rcar: revoke START request early
708ca40841266927 i2c: rcar: clean up after refactoring
4f7effddf4549d57 i2c: rcar: enable RuntimePM before registering to the core
ecc749660556e02a Merge branch 'i2c/for-current' into i2c/for-next
e7db0d34b38d56bb i2c: rcar: add support for r8a7795 (R-Car H3)
c6f1891323e6a259 i2c: rcar: Remove obsolete platform data support
6e82f74d11c8c33d Merge branch 'i2c/for-4.4' into i2c/for-next

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
