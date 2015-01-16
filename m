From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 16 Jan 2015 09:20:54 +0000
Subject: Re: ARM: shmobile: r8a7779: Instantiate GIC from C board code in legacy builds
Message-Id: <CAMuHMdU-BOdsJdcxHOcgUcEKhsqrugFnSim72f6wE75UQpP_rQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150116014919.30817.13079.sendpatchset@little-apple>
In-Reply-To: <20150116014919.30817.13079.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jan 16, 2015 at 2:49 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
>
> As of commit 9a1091ef0017c40a ("irqchip: gic: Support hierarchy irq
> domain."), Marzen legacy hangs during boot with:
>
>    Image Name:   'Linux-3.19.0-rc4'
>    Image Type:   ARM Linux Kernel Image (uncompressed)
>    Data Size:    3445880 Bytes = 3.3 MiB
>    Load Address: 60008000
>    Entry Point:  60008000
>    Verifying Checksum ... OK
>    Loading Kernel Image ... OK
> OK
>
> Starting kernel ...
>
> Enabling DEBUG_LL does not seem to change the situation, however this
> patch by itself fixes this issue and re-enables normal boot.
>
> This issue happens because the IRQ numbers of the GIC are now virtual,
> and no longer match the hardcoded hardware IRQ numbers in the platform
> board code.
>
> To fix this, instantiate the GIC from platform board code when compiling
> a legacy kernel, like is done for the sh73a0, r8a7740 and r8a7778 legacy code.
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
