From: Paul Mundt <lethal@linux-sh.org>
Date: Sun, 13 Jan 2008 16:35:16 +0000
Subject: Re: [PATCH] sh: remove voyagergx
Message-Id: <20080113163516.GB7532@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080113133814.28951.81886.sendpatchset@clockwork.opensource.se>
In-Reply-To: <20080113133814.28951.81886.sendpatchset@clockwork.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Jan 13, 2008 at 10:38:14PM +0900, Magnus Damm wrote:
> sh: remove voyagergx
> 
> This patch removes redundant irq handling code together with unused
> consistent alloc code. R2D uart setup code is changed to use sm501-regs.h
> and unused header files are removed.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> ---
> 
>  arch/sh/Makefile                          |    1 
>  arch/sh/boards/renesas/rts7751r2d/irq.c   |    4 
>  arch/sh/boards/renesas/rts7751r2d/setup.c |   73 +++---
>  arch/sh/cchips/voyagergx/Makefile         |    9 
>  arch/sh/cchips/voyagergx/consistent.c     |  121 ----------
>  arch/sh/cchips/voyagergx/irq.c            |  101 --------
>  include/asm-sh/voyagergx.h                |  341 -----------------------------
>  7 files changed, 39 insertions(+), 611 deletions(-)
> 
Nice, this code has been crap for longer than I can remember (either a
testament to how long this code has sucked or that my memory isn't very
good, either way), it's good to finally be rid of it. Now if only we
could move the hd64461x atrocity in to drivers/mfd, we can be rid of
arch/sh/cchips/ entirely.
