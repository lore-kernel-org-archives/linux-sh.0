From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 09 Nov 2017 01:32:07 +0000
Subject: Re: [PATCH] sh: migor: Reserve memory block for CEU
Message-Id: <1691054.qjv9XWrNm9@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1510164346-21134-1-git-send-email-jacopo+renesas@jmondi.org> <CAMuHMdX5V1Zw+_HoBukkFx=7=n75WCDfrKTZrjH8JfQmNjFyQw@mail.gmail.com>
In-Reply-To: <CAMuHMdX5V1Zw+_HoBukkFx=7=n75WCDfrKTZrjH8JfQmNjFyQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Geert,

On Wednesday, 8 November 2017 20:31:22 EET Geert Uytterhoeven wrote:
> On Wed, Nov 8, 2017 at 7:05 PM, Jacopo Mondi wrote:
> > A memory region for CEU video buffer has to be reserved during machine
> > initialization.
> > 
> > Originally, it was allocated through DMA API helpers and stored in the
> > second IORESOURCE_MEM entry, to be later remapped by the CEU driver with
> > a call to 'dma_declare_coherent_memory()'
> > 
> > As Linux does not allow anymore to remap system RAM regions with
> > 'memremap' function, sh_mobile_ceu driver fails when trying to remap the
> > memory area:
> > 
> > WARN_ONCE(1, "memremap attempted on ram %pa size: %#lx\n",
> > 
> >           &offset, (unsigned long) size)
> > 
> > from 'memremap()' function in kernel/memremap.c
> > 
> > To avoid hitting that WARN_ONCE() and have memory successfully remapped,
> > reserve a region using '.mv_mem_reserve' member of SH's 'struct
> > sh_machine_vector' to make sure memory is reserved early enough, and
> > removed from the available system RAM.
> > 
> > This is similar to what happens on ARM architecture with
> > 'arm_memblock_steal()' function.
> > 
> > Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> 
> I assume this failure isnot limited to CEU on Migo-R, but applies to
> the other 24 callers of platform_resource_setup_memory(), too?
> 
> Can platform_resource_setup_memory() be fixed instead, or is that difficult
> due to the need to reserve the memory very early in the boot process?

That's exactly the problem, memory needs to be reserved early at boot, earlier 
than the current call sites of platform_resource_setup_memory().

The real fix in my opinion would be to use CMA, but implementing CMA for SH is 
out of scope of Jacopo's work on the CEU driver. And that would still require 
patching all the 24 callers of platform_resource_setup_memory() anyway.

-- 
Regards,

Laurent Pinchart

