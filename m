From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 18 Apr 2011 10:00:24 +0000
Subject: Re: [RFC][PATCH] sh: fixup fpu.o compile order
Message-Id: <20110418100024.GJ32457@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <w3paafs2c2z.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3paafs2c2z.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Apr 15, 2011 at 04:44:27PM +0900, Kuninori Morimoto wrote:
> According to arch/sh/include/asm/fpu.h,
> "init_fpu" might be called in all environment.
> OTOH the other function on fpu.c are implemented
> under #ifdef CONFIG_SH_FPU.
> This mean fpu.c can be compiled in all environment.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> Paul
> 
> We can not compile Migo-R or other board.
> because there is no "init_fpu" function without CONFIG_SH_FPU
> on current Kernel.
> 
> Iwamatsu-san's patch or this patch is needed.
> I added [RFC] because I'm not familiar with FPU_EMU.
> 
>  arch/sh/kernel/cpu/Makefile |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
> 
Your approach is certainly the cleanest, so lets just go with that.
