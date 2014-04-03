From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Thu, 03 Apr 2014 03:16:15 +0000
Subject: [PATCH 0/2] DMA: shdma: add DMA cyclic transfer support
Message-Id: <87lhvnrtkw.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@intel.com>
Cc: Linux-SH <linux-sh@vger.kernel.org>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org


Hi Vinod, all

These patches adds DMA cyclic transfer support on shdma driver

Kuninori Morimoto (2):
      DMA: shdma: tidyup callback chunk finder
      DMA: shdma: add cyclic transfer support

 drivers/dma/sh/shdma-base.c |   90 +++++++++++++++++++++++++++++++++++--------
 include/linux/shdma-base.h  |    1 +
 2 files changed, 75 insertions(+), 16 deletions(-)


Best regards
---
Kuninori Morimoto
