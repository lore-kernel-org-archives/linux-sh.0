From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 19 Mar 2010 04:46:30 +0000
Subject: [PATCH 00/05] SH-Mobile ARM dmaengine support V1
Message-Id: <20100319044630.17051.16445.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

SH-Mobile ARM dmaengine support V1

[PATCH 01/05] dmaengine: shdma: Remove sh_dmae_slave_chan_id enum
[PATCH 02/05] dmaengine: shdma: Common SH_DMA_SLAVE_NUMBER
[PATCH 03/05] serial: sh-sci: Use sg_dma_len() and sg_dma_address()
[PATCH 04/05] dmaengine: shdma: Introduce include/linux/sh_dma.h
[PATCH 05/05] dmaengine: shdma: Enable on SH-Mobile ARM

These patches add support for the shdma dmaengine driver on
SH-Mobile ARM. Since some of the data structures are used by
various drivers these patches modify both SH architecture code,
dmaengine, sh-sci and the recently added siu sound driver.

Not sure how to merge this smoothly, but I tried to layer the
changes so they can be added one at a time without breaking
anything.

Compiles fine on sh7377 G4EVM (ARM) and sh7722 Migo-R (SH).

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/include/asm/dmaengine.h |   67 +------------------------
 arch/sh/include/asm/siu.h       |    8 +--
 drivers/dma/Kconfig             |    2 
 drivers/dma/shdma.c             |   23 ++++----
 drivers/dma/shdma.h             |    4 -
 drivers/serial/sh-sci.c         |   18 +++---
 include/linux/serial_sci.h      |    6 +-
 include/linux/sh_dma.h          |  101 +++++++++++++++++++++++++++++++++++++++
 8 files changed, 134 insertions(+), 95 deletions(-)
