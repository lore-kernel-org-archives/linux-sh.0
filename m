From: Simon Horman <horms@verge.net.au>
Date: Tue, 30 Nov 2010 07:18:20 +0000
Subject: Re: [PATCH 1/2] [rfc] mmc, sh: Read MMCIF during zboot
Message-Id: <20101130071818.GD1529@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1290812757-20571-1-git-send-email-horms@verge.net.au>
 <1290812757-20571-2-git-send-email-horms@verge.net.au>
 <AANLkTi=f-o6Bskb_ZAgco2+Hwm-ra+A_oOvtkogycQup@mail.gmail.com>
In-Reply-To: <AANLkTi=f-o6Bskb_ZAgco2+Hwm-ra+A_oOvtkogycQup@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Yusuke Goda <yusuke.goda.sx@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>

On Tue, Nov 30, 2010 at 02:11:43PM +0900, Magnus Damm wrote:
> Hi Simon,
> 
> Thanks for your work on this! It's nice to see that you can actually
> load some data early on.
> 
> On Sat, Nov 27, 2010 at 8:05 AM, Simon Horman <horms@verge.net.au> wrote:
> > This is a prototype of code to read the MMCIF during
> > zboot initialisation. The intention is that it will form
> > part of enabling booting from MMC. Very roughly the plan is
> >
> > 1) The Mask Rom will load a small boot program from MMC.
> >   Essentially this will be the first portion of
> >   the kernel to be booted.
> > 2) That program will load the remainder of the kernel
> >   from MMC and boot from it.
> >
> > This patch demonstrates code to perform the read portion of 2).
> > It uses a dummy buffer and only reads in one 512 byte sector.
> > A full implementation of 2) would of course read much more.
> >
> > The patch currently hooks into head-shmobile.S as it
> > depends on initialisation that occurs in that file.
> > However, it is likely that the final implementation
> > will need to be located in head.S where relocation is
> > currently handled.
> >
> > I used a multi-voltage MMC mobile card to test this code.
> > I observed that a single-voltage MMC and MMCplus card caused
> > the code to time-out in sh_mmcif_boot_init() which causes
> > the boot to stop.
> >
> > This patch depends on "ARM: mach-shmobile: Add zboot support for SuperH
> > Mobile ARM" and "mmc, sh: Correct value for reset".
> >
> > Signed-off-by: Simon Horman <horms@verge.net.au>
> > ---
> >  arch/arm/boot/compressed/Makefile        |    4 +
> >  arch/arm/boot/compressed/head-shmobile.S |   16 +++++
> >  arch/arm/boot/compressed/mmcif-sh7372.c  |  100 ++++++++++++++++++++++++++++++
> >  3 files changed, 120 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/boot/compressed/mmcif-sh7372.c
> >
> > diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
> > index 0a8f748..f730c10 100644
> > --- a/arch/arm/boot/compressed/Makefile
> > +++ b/arch/arm/boot/compressed/Makefile
> > @@ -49,6 +49,10 @@ ifeq ($(CONFIG_ARCH_SHMOBILE),y)
> >  OBJS           += head-shmobile.o
> >  endif
> >
> > +ifeq ($(CONFIG_ARCH_SH7372),y)
> > +OBJS           += mmcif-sh7372.o
> > +endif
> > +
> >  #
> >  # We now have a PIC decompressor implementation.  Decompressors running
> >  # from RAM should not define ZTEXTADDR.  Decompressors running directly
> > diff --git a/arch/arm/boot/compressed/head-shmobile.S b/arch/arm/boot/compressed/head-shmobile.S
> > index 30973b7..700d622 100644
> > --- a/arch/arm/boot/compressed/head-shmobile.S
> > +++ b/arch/arm/boot/compressed/head-shmobile.S
> > @@ -26,6 +26,22 @@
> >  #include <mach/zboot.h>
> >
> >        b       1f
> > +       .align
> > +__tmp_stack:
> > +       .space  128
> > +__dummy_buf:
> > +       .space  512
> > +__dummy_buf_size:
> > +       .long   512
> > +1:
> > +       adr     sp, __tmp_stack
> > +       add     sp, sp, #128
> > +       adr     r0, __dummy_buf
> > +       ldr     r1, __dummy_buf_size
> 
> Regarding the destination address, look into using CONFIG_MEMORY_START
> or perhaps something more advanced like the actual destination address
> for the kernel - see arch/arm/boot/compressed/head.S and TEXT_OFFSET
> or zreladdr.

Thanks, I'll take a look at that

> As for the number of bytes to load, please have a look at the sh7724
> implementation.

Thanks, will do.

> 
> > +       mov     lr, pc
> > +       b       mmcif_loader
> > +
> > +       b       1f
> >  __atags:@ tag #1
> >        .long   12                      @ tag->hdr.size = tag_size(tag_core);
> >        .long   0x54410001              @ tag->hdr.tag = ATAG_CORE;
> > diff --git a/arch/arm/boot/compressed/mmcif-sh7372.c b/arch/arm/boot/compressed/mmcif-sh7372.c
> > new file mode 100644
> > index 0000000..7ffaf27
> > --- /dev/null
> > +++ b/arch/arm/boot/compressed/mmcif-sh7372.c
> > @@ -0,0 +1,100 @@
> > +/*
> > + * sh7372 MMCIF loader
> > + *
> > + * Copyright (C) 2010 Magnus Damm
> > + * Copyright (C) 2010 Simon Horman
> > + *
> > + * This file is subject to the terms and conditions of the GNU General Public
> > + * License.  See the file "COPYING" in the main directory of this archive
> > + * for more details.
> > + */
> > +
> > +#include <linux/mmc/sh_mmcif.h>
> > +
> > +#define MMCIF_BASE      (void __iomem *)0xe6bd0000
> > +
> > +#define PORT84CR       0xe6050054
> > +#define PORT85CR       0xe6050055
> > +#define PORT86CR       0xe6050056
> > +#define PORT87CR       0xe6050057
> > +#define PORT88CR       0xe6050058
> > +#define PORT89CR       0xe6050059
> > +#define PORT90CR       0xe605005a
> > +#define PORT91CR       0xe605005b
> > +#define PORT92CR       0xe605005c
> > +#define PORT99CR       0xe6050063
> > +#define PORT185CR      0xe60520b9
> > +#define PORT186CR      0xe60520ba
> > +#define PORT187CR      0xe60520bb
> > +#define PORT188CR      0xe60520bc
> > +#define PORTR191_160DR  0xe6056014
> > +
> > +#define SMSTPCR3       0xe615013c
> > +
> > +enum { MMCIF_PROGRESS_ENTER, MMCIF_PROGRESS_INIT,
> > +       MMCIF_PROGRESS_LOAD, MMCIF_PROGRESS_DONE };
> > +
> > +static void mmcif_update_progress(int n)
> > +{
> > +       __raw_writel((__raw_readl(PORTR191_160DR) & ~(0xf << 25)) |
> > +                    (1 << (25 + n)), PORTR191_160DR);
> > +}
> 
> This seems like a board specific property to me. So please break it
> out in to a per-board header or similar.

Sure.

> I guess next step is to extend the prototype code so it loads the
> entire kernel from MMC and then jumps to it. =)

Yes :-)

