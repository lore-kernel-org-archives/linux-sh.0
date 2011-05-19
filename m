From: Federico Fuga <ml@studiofuga.com>
Date: Thu, 19 May 2011 17:12:28 +0000
Subject: ioremap_nocache on sh2a
Message-Id: <D0A17CB4-DE84-47F9-A3A1-40D3F7A27C48@studiofuga.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi everybody,

I was debugging a board with sh7203 that have a great flickering on the LCD panel when the kernel is configured with write-back cache option.
As suggested by Magnus Damm on a previous mail, the framebuffer memory should be uncached (or writed-through). Paul Mundt responded that "we already get the cache management logic for free by virtue of the DMA mapping interface."
So I tried allocating the fb memory with the dma_alloc_coherent() function, without solving the issue.
So I traced the function calls until the ioremap_nocache inside the mm code, after that I have seen that in include/asm/io.h ioremap_nocache is #defined as ioremap() that is a no-op call in a nommu cpu.
Could this be a problem? I think it could, where the noncached memory is not accessed by the DMAC, like the sh7203 case (the LCDC doesn't have a dedicated dma channel). I manually remapped my address by adding 0x20000000. It seems to work fine.
I think that if the CPU provides both a cached and uncached alias, it is wrong that the ioremap_nocache returns a cached memory address, but it should "remap" the address in the uncached zone.
Am I wrong? Could be this workaround be permanent by changing the ioremap_nocache implementation for sh2a at least?

Thank you 

best regards


Federico Fuga



