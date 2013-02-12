From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 12 Feb 2013 14:55:33 +0000
Subject: [PATCH 1/2] ARM: shmobile: fix a syntax error in sh73a0.dtsi from a bad merge
Message-Id: <Pine.LNX.4.64.1302121533590.7059@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

A semicolon went missing in the merge

commit 6dffe18b5dbe1e3d5ccf1792a4793c854bad7e87
Merge: 95c746f 68c80f0
Author: Simon Horman <horms+renesas@verge.net.au>
Date:   Thu Feb 7 17:23:58 2013 +0900

    Merge branch 'topic/pfc' into topic/all+next

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/boot/dts/sh73a0.dtsi |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index ebbd604..c97edb2 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -35,5 +35,5 @@
 		      <0xe605801c 0x1c>;
 		gpio-controller;
 		#gpio-cells = <2>;
-	}
+	};
 };
-- 
1.7.2.5

