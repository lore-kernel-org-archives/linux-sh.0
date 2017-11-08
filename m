From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 08 Nov 2017 18:31:22 +0000
Subject: Re: [PATCH] sh: migor: Reserve memory block for CEU
Message-Id: <CAMuHMdX5V1Zw+_HoBukkFx=7=n75WCDfrKTZrjH8JfQmNjFyQw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1510164346-21134-1-git-send-email-jacopo+renesas@jmondi.org>
In-Reply-To: <1510164346-21134-1-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linux-sh list <linux-sh@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Jacopo,

On Wed, Nov 8, 2017 at 7:05 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> A memory region for CEU video buffer has to be reserved during machine
> initialization.
>
> Originally, it was allocated through DMA API helpers and stored in the
> second IORESOURCE_MEM entry, to be later remapped by the CEU driver with
> a call to 'dma_declare_coherent_memory()'
>
> As Linux does not allow anymore to remap system RAM regions with
> 'memremap' function, sh_mobile_ceu driver fails when trying to remap the
> memory area:
>
> WARN_ONCE(1, "memremap attempted on ram %pa size: %#lx\n",
>           &offset, (unsigned long) size)
>
> from 'memremap()' function in kernel/memremap.c
>
> To avoid hitting that WARN_ONCE() and have memory successfully remapped,
> reserve a region using '.mv_mem_reserve' member of SH's 'struct
> sh_machine_vector' to make sure memory is reserved early enough, and
> removed from the available system RAM.
>
> This is similar to what happens on ARM architecture with
> 'arm_memblock_steal()' function.
>
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

I assume this failure isnot limited to CEU on Migo-R, but applies to
the other 24
callers of platform_resource_setup_memory(), too?

Can platform_resource_setup_memory() be fixed instead, or is that difficult
due to the need to reserve the memory very early in the boot process?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
