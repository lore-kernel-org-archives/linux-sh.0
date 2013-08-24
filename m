From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 24 Aug 2013 21:33:16 +0000
Subject: [PATCH v4 0/2] R8A7778/BOCK-W: HPB-DMAC support for SDHI0
Message-Id: <201308250133.17530.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

   Here's the set of 2 patches against the Simon Horman's 'renesas.git' repo,
'renesas-next-20130823' tag. Here we add the HPB-DMAC platform code working on
the R8A7778 and enable DMA for SDHI0 on BOCK-W (Max has fixed the wrong settings
that led to the SDHI0 DMA working incorrectly). The patchset depends on the
R-Car HPB-DMAC driver patch posted earlier.

[1/2] ARM: shmobile: r8a7778: add HPB-DMAC support
[2/2] ARM: shmobile: BOCK-W: enable DMA for SDHI0

   The former patch #1 has been merged to the next patch moving the data from
the now removed <mach/dma.h> to <mach/r8a7778.h>.

WBR, Sergei
