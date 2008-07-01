From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 01 Jul 2008 12:47:26 +0000
Subject: [PATCH 05/07] soc_camera: Add 16-bit bus width support
Message-Id: <20080701124726.30446.19600.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
References: <20080701124638.30446.81449.sendpatchset@rx1.opensource.se>
In-Reply-To: <20080701124638.30446.81449.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: video4linux-list@redhat.com
Cc: linux-sh@vger.kernel.org, akpm@linux-foundation.org, lethal@linux-sh.org, mchehab@infradead.org

The SuperH Mobile CEU hardware supports 16-bit width bus,
so extend the soc_camera code with SOCAM_DATAWIDTH_16.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 include/media/soc_camera.h |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- 0008/include/media/soc_camera.h
+++ work/include/media/soc_camera.h	2008-07-01 14:38:34.000000000 +0900
@@ -153,11 +153,12 @@ static inline struct v4l2_queryctrl cons
 #define SOCAM_DATAWIDTH_8		(1 << 6)
 #define SOCAM_DATAWIDTH_9		(1 << 7)
 #define SOCAM_DATAWIDTH_10		(1 << 8)
-#define SOCAM_PCLK_SAMPLE_RISING	(1 << 9)
-#define SOCAM_PCLK_SAMPLE_FALLING	(1 << 10)
+#define SOCAM_DATAWIDTH_16		(1 << 9)
+#define SOCAM_PCLK_SAMPLE_RISING	(1 << 10)
+#define SOCAM_PCLK_SAMPLE_FALLING	(1 << 11)
 
 #define SOCAM_DATAWIDTH_MASK (SOCAM_DATAWIDTH_8 | SOCAM_DATAWIDTH_9 | \
-			      SOCAM_DATAWIDTH_10)
+			      SOCAM_DATAWIDTH_10 | SOCAM_DATAWIDTH_16)
 
 static inline unsigned long soc_camera_bus_param_compatible(
 			unsigned long camera_flags, unsigned long bus_flags)
