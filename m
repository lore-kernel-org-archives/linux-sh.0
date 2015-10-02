From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 02 Oct 2015 21:53:38 +0000
Subject: [PATCH] ARM: shmobile: fix SILK board name
Message-Id: <6818713.ulHphNVRsJ@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201404250239.39150.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201404250239.39150.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Unfortunately, the SILK board bindings were not quite correct, as the  board
name should be all caps.  Fix that,  adding the board model #  in parens and
removing stray semicolon.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 Documentation/devicetree/bindings/arm/shmobile.txt |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: renesas/Documentation/devicetree/bindings/arm/shmobile.txt
=================================--- renesas.orig/Documentation/devicetree/bindings/arm/shmobile.txt
+++ renesas/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -57,5 +57,5 @@ Boards:
     compatible = "renesas,marzen", "renesas,r8a7779"
   - Porter (M2-LCDP)
     compatible = "renesas,porter", "renesas,r8a7791"
-  - Silk
-    compatible = "renesas,silk", "renesas,r8a7794";
+  - SILK (RTP0RC7794LCB00011S)
+    compatible = "renesas,silk", "renesas,r8a7794"

