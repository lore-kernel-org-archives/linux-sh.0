From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 27 Jun 2012 14:22:34 +0000
Subject: Re: [PATCH] asm-generic: fix compile breakage "'TAINT_WARN' undeclared"
Message-Id: <20120627142233.GK24033@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1206271507200.24173@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1206271507200.24173@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

On Wed, Jun 27, 2012 at 03:52:27PM +0200, Guennadi Liakhovetski wrote:
> TAINT_WARN is defined in kernel.h and used in asm-generic/bug.h. Not 
> including kernel.h there breaks build on sh:
> 
> In file included from linux/include/linux/thread_info.h:54,
>                  from linux/include/linux/preempt.h:9,
>                  from linux/include/linux/spinlock.h:50,
>                  from linux/include/linux/mmzone.h:7,
>                  from linux/include/linux/gfp.h:4,
>                  from linux/include/linux/mm.h:8,
>                  from linux/arch/sh/kernel/asm-offsets.c:13:
> linux/arch/sh/include/asm/thread_info.h: In function 'set_restore_sigmask':
> linux/arch/sh/include/asm/thread_info.h:172: error: 'TAINT_WARN' undeclared (first use in this function)
> linux/arch/sh/include/asm/thread_info.h:172: error: (Each undeclared identifier is reported only once
> linux/arch/sh/include/asm/thread_info.h:172: error: for each function it appears in.)
> 
> Also, since nothing in bug.h is usable from assembly, it is safe to extend 
> the "#ifndef __ASSEMBLY__" block over all WARN() macros.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Already fixed in mainline.
