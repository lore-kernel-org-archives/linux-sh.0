From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 17 Dec 2019 08:43:37 +0000
Subject: Re: can someone solve string_32.h issue for SH ?
Message-Id: <CAMuHMdXX7wEBSmj-5G-Ya+n1FKMENRxpHuEhh1rmSV9zME_v=g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87h81zh4ap.wl-kuninori.morimoto.gx@renesas.com>
 <CAMuHMdUHGXkmKrcZVNQo8nOcGo0h6xYgjZ+XmfGy6bJCPK9ZwQ@mail.gmail.com> <8736djgxg2.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8736djgxg2.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux-SH <linux-sh@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

Hi Morimoto-san,

On Tue, Dec 17, 2019 at 9:37 AM Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> Unfortunately, I can't test it :(
> Can someone test it ?

make rts7751r2dplus_defconfig
qemu-system-sh4 qemu-system-sh4 -M r2d -serial null -serial mon:stdio \
        -nographic -no-reboot -m 256 \
        -append "panic=1 HOST=sh4 console=ttySC1 noiotrap" \
        -kernel arch/sh/boot/zImage

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
