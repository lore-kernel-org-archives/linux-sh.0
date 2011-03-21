From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Mon, 21 Mar 2011 15:30:58 +0000
Subject: sh7203 LCDC - mmap problem
Message-Id: <201103211630.59224.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi All,
I can manage the vodeo memori, but I cannot access it through mmap
.
The dma_alloc_coherent(info->dev, vram, &par->fbdma, GFP_KERNEL) funciotn 
returns to me 0x0e100000;
mmap from the userspace returns to me 0xe1800000.
What do I need to check?

Thanks a lot in advance

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
