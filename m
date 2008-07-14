From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 14 Jul 2008 12:02:31 +0000
Subject: [PATCH 03/06] videobuf: Fix gather spelling
Message-Id: <20080714120231.4806.47837.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
References: <20080714120204.4806.87287.sendpatchset@rx1.opensource.se>
In-Reply-To: <20080714120204.4806.87287.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: video4linux-list@redhat.com
Cc: paulius.zaleckas@teltonika.lt, linux-sh@vger.kernel.org, mchehab@infradead.org, lethal@linux-sh.org, akpm@linux-foundation.org, g.liakhovetski@gmx.de

Use "scatter gather" instead of "scatter gatter".

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/media/video/videobuf-dma-sg.c  |    2 +-
 drivers/media/video/videobuf-vmalloc.c |    2 +-
 include/media/videobuf-dma-sg.h        |    2 +-
 include/media/videobuf-vmalloc.h       |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

--- 0001/drivers/media/video/videobuf-dma-sg.c
+++ work/drivers/media/video/videobuf-dma-sg.c	2008-07-14 14:33:01.000000000 +0900
@@ -1,7 +1,7 @@
 /*
  * helper functions for SG DMA video4linux capture buffers
  *
- * The functions expect the hardware being able to scatter gatter
+ * The functions expect the hardware being able to scatter gather
  * (i.e. the buffers are not linear in physical memory, but fragmented
  * into PAGE_SIZE chunks).  They also assume the driver does not need
  * to touch the video data.
--- 0001/drivers/media/video/videobuf-vmalloc.c
+++ work/drivers/media/video/videobuf-vmalloc.c	2008-07-14 14:32:50.000000000 +0900
@@ -1,7 +1,7 @@
 /*
  * helper functions for vmalloc video4linux capture buffers
  *
- * The functions expect the hardware being able to scatter gatter
+ * The functions expect the hardware being able to scatter gather
  * (i.e. the buffers are not linear in physical memory, but fragmented
  * into PAGE_SIZE chunks).  They also assume the driver does not need
  * to touch the video data.
--- 0001/include/media/videobuf-dma-sg.h
+++ work/include/media/videobuf-dma-sg.h	2008-07-14 14:33:15.000000000 +0900
@@ -1,7 +1,7 @@
 /*
  * helper functions for SG DMA video4linux capture buffers
  *
- * The functions expect the hardware being able to scatter gatter
+ * The functions expect the hardware being able to scatter gather
  * (i.e. the buffers are not linear in physical memory, but fragmented
  * into PAGE_SIZE chunks).  They also assume the driver does not need
  * to touch the video data.
--- 0001/include/media/videobuf-vmalloc.h
+++ work/include/media/videobuf-vmalloc.h	2008-07-14 14:33:22.000000000 +0900
@@ -1,7 +1,7 @@
 /*
  * helper functions for vmalloc capture buffers
  *
- * The functions expect the hardware being able to scatter gatter
+ * The functions expect the hardware being able to scatter gather
  * (i.e. the buffers are not linear in physical memory, but fragmented
  * into PAGE_SIZE chunks).  They also assume the driver does not need
  * to touch the video data.
