From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sun, 25 Aug 2013 17:43:32 +0000
Subject: [PATCH v2 0/2] R8A7779/Marzen: HPB-DMAC support for SDHI0
Message-Id: <201308252143.33458.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

   Here's the set of 2 patches against the Simon Horman's 'renesas.git' repo,
'renesas-devel-20130823' tag. Here we add the HPB-DMAC platform code working on
R8A7779 and enable DMA for SDHI0 on Marzen. The patchset depends on the R-Car
HPB-DMAC driver patch posted earlier.

[1/2] ARM: shmobile: r8a7779: add HPB-DMAC support
[2/2] ARM: shmobile: Marzen: enable DMA for SDHI0

WBR, Sergei
