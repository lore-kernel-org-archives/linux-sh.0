From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 18 Mar 2013 12:32:45 +0000
Subject: [PATCH 35/43] ARM: shmobile: r8a7779: fixup dtsi typo
Message-Id: <1363609973-31086-36-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1363609973-31086-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1363609973-31086-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

r8a7779 is not r8a7740 chip

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index 0016302..c73eb37 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -1,5 +1,5 @@
 /*
- * Device Tree Source for Renesas r8a7740
+ * Device Tree Source for Renesas r8a7779
  *
  * Copyright (C) 2013 Renesas Solutions Corp.
  * Copyright (C) 2013 Simon Horman
-- 
1.7.10.4

