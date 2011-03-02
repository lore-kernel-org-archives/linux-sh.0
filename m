From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Wed, 02 Mar 2011 12:17:48 +0000
Subject: sh7203 framebuffer question for linux v2.6.37
Message-Id: <201103021317.48884.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi All,
I started for sh7760fb.c for writing sh7203fb.c
I do not start from my sh7203fb.c of linux v2.6.17 patched by MCP data because 
I saw a lot of differences between sh7203fb.c from v 2.6.17 and sh7760fb.c of 
v2.6.37.
In particular I saw the mem alloc function call
static int sh7203fb_alloc_mem(struct fb_info *info)
...
	fbmem = dma_alloc_coherent(info->dev, vram, &par->fbdma, GFP_KERNEL);
...

but the 7760 has a DMA channel connected to LCDC; 7203 doesnt' have a DMA 
channel connected to LCDC.
The question is:
is it still valid to allocate memory using dma_alloc_coherent or another 
memthod is requested?
I add that into sh7203fb.c from v 2.6.17 a static and durect area was set in 
cached part of the SDRAM area.

Thanks in advance for the answer.

Regards


-- 
Ing. Fabio Giovagnini

Aurion s.r.l.
P.I e C.F.
00885711200
skype: aurion.giovagnini
Tel. +39.051.594.78.24
Fax. +39.051.082.14.49
Cell. +39.335.83.50.919
www.aurion-tech.com
