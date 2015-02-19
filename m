From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 19 Feb 2015 01:28:03 +0000
Subject: [PATCH 01/01] ARM: shmobile: Drop VSP1 deps to allow 64-bit build
Message-Id: <20150219012803.1740.86640.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Drop dependencies to allow building the VSP1 driver on any architecture
including 64-bit ones such as x86_64 and arm64. Not for upstream merge.

Not-Yet-Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 drivers/media/platform/Kconfig |    1 -
 1 file changed, 1 deletion(-)

--- 0001/drivers/media/platform/Kconfig
+++ work/drivers/media/platform/Kconfig	2015-02-19 06:44:38.525523599 +0900
@@ -223,7 +223,6 @@ config VIDEO_SH_VEU
 config VIDEO_RENESAS_VSP1
 	tristate "Renesas VSP1 Video Processing Engine"
 	depends on VIDEO_V4L2 && VIDEO_V4L2_SUBDEV_API && HAS_DMA
-	depends on ARCH_SHMOBILE || COMPILE_TEST
 	select VIDEOBUF2_DMA_CONTIG
 	---help---
 	  This is a V4L2 driver for the Renesas VSP1 video processing engine.
