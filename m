From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 01 Jul 2008 12:46:38 +0000
Subject: [PATCH 00/07] soc_camera: SuperH Mobile CEU support
Message-Id: <20080701124638.30446.81449.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: video4linux-list@redhat.com
Cc: akpm@linux-foundation.org, lethal@linux-sh.org, mchehab@infradead.org, linux-sh@vger.kernel.org

These patches add support for the SuperH Mobile CEU interface.

[PATCH 01/07] soc_camera: Remove default spinlock operations
[PATCH 02/07] soc_camera: Let the host select videobuf_queue type
[PATCH 03/07] soc_camera: Remove vbq_ops and msize
[PATCH 04/07] soc_camera: Remove unused file lock pointer
[PATCH 05/07] soc_camera: Add 16-bit bus width support
[PATCH 06/07] videobuf: Add physically contiguous queue code
[PATCH 07/07] sh_mobile_ceu_camera: Add SuperH Mobile CEU driver

The patches can be divided in 3 groups:
 - soc_camera - make videobuf_queue host specific + minor changes
 - videobuf - add support for physically contiguous memory buffers
 - new driver - add the SuperH Mobile CEU driver 

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/media/video/Kconfig                |   16 
 drivers/media/video/Makefile               |    2 
 drivers/media/video/pxa_camera.c           |   21 
 drivers/media/video/sh_mobile_ceu_camera.c |  622 ++++++++++++++++++++++++++++
 drivers/media/video/soc_camera.c           |   52 --
 drivers/media/video/videobuf-dma-contig.c  |  413 ++++++++++++++++++
 include/asm-sh/sh_mobile_ceu.h             |   10 
 include/media/soc_camera.h                 |   16 
 include/media/videobuf-dma-contig.h        |   39 +
 9 files changed, 1129 insertions(+), 62 deletions(-)

