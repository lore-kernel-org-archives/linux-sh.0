From: Matt Fleming <matt@console-pimps.org>
Date: Mon, 30 Nov 2009 19:58:24 +0000
Subject: Re: [PATCH] sh: mach-ecovec24: update ecovec24 defconfig
Message-Id: <20091130195824.GA26460@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
References: <uws1cuyrg.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uws1cuyrg.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Nov 30, 2009 at 07:11:29PM +0900, Kuninori Morimoto wrote:
> 
> Dear Paul
> 
> > > because currect kernel can not use CONFIG_CACHE_WRITEBACK
> > >
> > Uhm, why not? Where is the bug report on this?
> 
> Now I searched by git bisect
> I tested on ms7724se / ecovec24
> 
> -------------------------
> eb3118f652ea7751ecf6a7e467bb637895e3be3b is first bad commit
> commit eb3118f652ea7751ecf6a7e467bb637895e3be3b
> Author: Matt Fleming <matt@console-pimps.org>
> Date:   Thu Oct 29 21:53:30 2009 +0000
> 
> sh: Do not apply virt_to_phys() to a physical address
> 

Could you apply this patch and post the backtrace?

diff --git a/arch/sh/mm/cache-sh4.c b/arch/sh/mm/cache-sh4.c
index 6bfd08d..8440b12 100644
--- a/arch/sh/mm/cache-sh4.c
+++ b/arch/sh/mm/cache-sh4.c
@@ -89,6 +89,8 @@ static inline void flush_cache_one(unsigned long start, unsigned long phys)
 {
 	unsigned long flags, exec_offset = 0;
 
+	WARN_ON(!(phys >= __MEMORY_START && phys < __MEMORY_START + __MEMORY_SIZE));
+
 	/*
 	 * All types of SH-4 require PC to be uncached to operate on the I-cache.
 	 * Some types of SH-4 require PC to be uncached to operate on the D-cache.
