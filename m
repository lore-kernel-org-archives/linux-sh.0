From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 05 Jun 2013 00:48:18 +0000
Subject: Re: [PATCH 3/3 v3] ARM: shmobile: bockw: add SDHI0 support
Message-Id: <87hahd5qnl.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8738uwpavc.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8738uwpavc.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

Thank you for your reply

> > > This patch is directly accessing to PUPR4 register which can
> > > control SDHI0 CD/WP pin pull-up setting.
> > > It should be replaced in the future.
> > > 
> > > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > ---
(snip)
> 
> I have dropped this patch as it currently seems to be causing a build failure.
> Please resolve this and re-post.
> 
>   CC      arch/arm/mach-shmobile/board-bockw.o
> arch/arm/mach-shmobile/board-bockw.c:60: error: variable ‘sdhi0_info’ has initializer but incomplete type
> arch/arm/mach-shmobile/board-bockw.c:61: error: unknown field ‘tmio_caps’ specified in initializer
> arch/arm/mach-shmobile/board-bockw.c:61: warning: excess elements in struct initializer
> arch/arm/mach-shmobile/board-bockw.c:61: warning: (near initialization for ‘sdhi0_info’)
> arch/arm/mach-shmobile/board-bockw.c:62: error: unknown field ‘tmio_ocr_mask’ specified in initializer
> arch/arm/mach-shmobile/board-bockw.c:62: warning: excess elements in struct initializer
> arch/arm/mach-shmobile/board-bockw.c:62: warning: (near initialization for ‘sdhi0_info’)
> arch/arm/mach-shmobile/board-bockw.c:63: error: unknown field ‘tmio_flags’ specified in initializer
> arch/arm/mach-shmobile/board-bockw.c:63: warning: excess elements in struct initializer
> arch/arm/mach-shmobile/board-bockw.c:63: warning: (near initialization for ‘sdhi0_info’)
> arch/arm/mach-shmobile/board-bockw.c: In function ‘bockw_init’:
> arch/arm/mach-shmobile/board-bockw.c:134: error: implicit declaration of function ‘r8a7778_sdhi_init’

Hmm... strange.
I couldn't get this error/warning.
I used renesas-next-20130604v2 + above patch,
but no error

---- my git log -----------------
commit c01ca82e8e49063135d6f6d44135716b04417a94
Author: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date:   Thu Apr 18 20:09:32 2013 -0700

    ARM: shmobile: bockw: add SDHI0 support
    
    This patch is directly accessing to PUPR4 register which can
    control SDHI0 CD/WP pin pull-up setting.
    It should be replaced in the future.
    
    Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

commit 58e3e8accf4f2e5f14a632dd51f5146de416524c
Merge: 2e05645 993b0e4
Author: Simon Horman <horms+renesas@verge.net.au>
Date:   Tue Jun 4 21:47:42 2013 +0900

    Merge branch 'heads/soc' into next
    
    Conflicts:
        arch/arm/mach-shmobile/Kconfig
        arch/arm/mach-shmobile/include/mach/r8a7778.h
        arch/arm/mach-shmobile/setup-r8a7778.c





Best regards
---
Kuninori Morimoto
