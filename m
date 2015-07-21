From: Mikhail Ulyanov <mikhail.ulyanov@cogentembedded.com>
Date: Tue, 21 Jul 2015 02:00:22 +0000
Subject: [PATCH 3/3] MAINTAINERS: V4L2: PLATFORM: Add entry for Renesas JPEG Processing Unit driver
Message-Id: <1437444022-28916-4-git-send-email-mikhail.ulyanov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1437444022-28916-1-git-send-email-mikhail.ulyanov@cogentembedded.com>
In-Reply-To: <1437444022-28916-1-git-send-email-mikhail.ulyanov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: hverkuil@xs4all.nl, horms@verge.net.au, magnus.damm@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, mchehab@osg.samsung.com
Cc: laurent.pinchart@ideasonboard.com, j.anaszewski@samsung.com, kamil@wypas.org, sergei.shtylyov@cogentembedded.com, devicetree@vger.kernel.org, linux-media@vger.kernel.org, linux-sh@vger.kernel.org, Mikhail Ulyanov <mikhail.ulyanov@cogentembedded.com>

Update RENESAS JPU driver maintainer in MAINTAINERS file.

Signed-off-by: Mikhail Ulyanov <mikhail.ulyanov@cogentembedded.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b65b22b..da57ec1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5381,6 +5381,12 @@ S:	Maintained
 F:	fs/jbd2/
 F:	include/linux/jbd2.h
 
+JPU V4L2 MEM2MEM DRIVER FOR RENESAS
+M:	Mikhail Ulyanov <mikhail.ulyanov@cogentembedded.com>
+L:	linux-media@vger.kernel.org
+S:	Maintained
+F:	drivers/media/platform/rcar_jpu.c
+
 JSM Neo PCI based serial card
 M:	Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
 L:	linux-serial@vger.kernel.org
-- 
2.1.4

