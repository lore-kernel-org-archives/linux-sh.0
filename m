From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 25 Aug 2014 08:41:26 +0000
Subject: Re: [PATCH 01/03] ARM: shmobile: Consolidate Legacy CPU_V7 Kconfig
Message-Id: <CAMuHMdV_cXaDRoHx=A-=gJ3pdsUSo-stvqko2W32Gcoz9X0qHA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140825034541.9316.31816.sendpatchset@w520>
In-Reply-To: <20140825034541.9316.31816.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Aug 25, 2014 at 5:45 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> Consolidate CPU_V7 under ARCH_SHMOBILE_LEGACY so it can
> be shared by the legacy ARM mach-shmobile support code.
>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>

As V6 (sh7367) is gone, and V8 isn't there yet:

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
