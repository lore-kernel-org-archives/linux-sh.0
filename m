From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 08 Aug 2013 21:40:14 +0000
Subject: [PATCH 0/2] R8A7779/Marzen: HPB-DMAC support for SDHI0
Message-Id: <201308090140.14515.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

   Here's the set of 2 patches against the Simon Horman's 'renesas.git' repo,
'renesas-devel-20130807' tag. Here we add the HPB-DMAC platform code working on
R8A7779 and enable DMA for SDHI0 on Marzen. The patchset depends on the R-Car
HPB-DMAC driver patch posted earlier (we are still working on it). It has been
actually tested on top of the 'renesas.git' unlike the R8A7778/BOCK-W patchset
(which, unfortunately, doesn't work).

[1/2] ARM: shmobile: r8a7779: add HPB-DMAC support
[2/2] ARM: shmobile: Marzen: enable DMA for SDHI0

WBR, Sergei
