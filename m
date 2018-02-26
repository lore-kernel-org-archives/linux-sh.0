From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date: Mon, 26 Feb 2018 13:49:41 +0000
Subject: Re: [PATCH] drivers/sh: clk: drop "const" qualifier in I/O read wrappers
Message-Id: <20180226144941.37447e49@windsurf.lan>
List-Id: <linux-sh.vger.kernel.org>
References: <20171208160640.13125-1-thomas.petazzoni@free-electrons.com>
In-Reply-To: <20171208160640.13125-1-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

Hello,

On Fri,  8 Dec 2017 17:06:40 +0100, Thomas Petazzoni wrote:
> The r8/r16/r32 wrappers around ioread8/ioread16/ioread32 take "const
> void __iomem *" pointers, but ioread8/ioread16/ioread32 as defined in
> <asm-generic/iomap.h> don't take const pointers. This causes a warning
> when building cpg.c:
> 
>   CC      net/ipv4/inet_fragment.o
> drivers/sh/clk/cpg.c: In function ‘r8’:
> drivers/sh/clk/cpg.c:41:17: warning: passing argument 1 of ‘ioread8’ discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
>   return ioread8(addr);
>                  ^~~~
> In file included from arch/sh/include/asm/io.h:21:0,
>                  from include/linux/io.h:25,
>                  from drivers/sh/clk/cpg.c:14:
> include/asm-generic/iomap.h:29:21: note: expected ‘void *’ but argument is of type ‘const void *’
>  extern unsigned int ioread8(void __iomem *);
>                      ^~~~~~~
> drivers/sh/clk/cpg.c: In function ‘r16’:
> drivers/sh/clk/cpg.c:46:18: warning: passing argument 1 of ‘ioread16’ discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
>   return ioread16(addr);
>                   ^~~~
> In file included from arch/sh/include/asm/io.h:21:0,
>                  from include/linux/io.h:25,
>                  from drivers/sh/clk/cpg.c:14:
> include/asm-generic/iomap.h:30:21: note: expected ‘void *’ but argument is of type ‘const void *’
>  extern unsigned int ioread16(void __iomem *);
>                      ^~~~~~~~
> drivers/sh/clk/cpg.c: In function ‘r32’:
> drivers/sh/clk/cpg.c:51:18: warning: passing argument 1 of ‘ioread32’ discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
>   return ioread32(addr);
>                   ^~~~
> In file included from arch/sh/include/asm/io.h:21:0,
>                  from include/linux/io.h:25,
>                  from drivers/sh/clk/cpg.c:14:
> include/asm-generic/iomap.h:32:21: note: expected ‘void *’ but argument is of type ‘const void *’
>  extern unsigned int ioread32(void __iomem *);
> 
> To fix this, we simply drop the const qualifiers in the definitions of
> r8/r16/r32. Changing the prototypes of ioread8/ioread16/ioread32 would
> be a much bigger adventure.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

I've sent the patch almost 3 months ago, and it's a trivial patch. Is
it possible to get some feedback, or alternatively, get this patch
applied ?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
