From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Thu, 21 May 2015 10:48:12 +0000
Subject: [PATCH v3 10/11] clocksource: sh_cmt: Document r8a7793-specific bindings
Message-Id: <1432205293-9488-11-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 Documentation/devicetree/bindings/timer/renesas,cmt.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/renesas,cmt.txt b/Documentation/devicetree/bindings/timer/renesas,cmt.txt
index 1a05c1b..b3c9547 100644
--- a/Documentation/devicetree/bindings/timer/renesas,cmt.txt
+++ b/Documentation/devicetree/bindings/timer/renesas,cmt.txt
@@ -48,6 +48,8 @@ Required Properties:
 		(CMT[01])
     - "renesas,cmt-48-r8a7791" for the r8a7791 48-bit CMT
 		(CMT[01])
+    - "renesas,cmt-48-r8a7793" for the r8a7793 48-bit CMT
+		(CMT[01])
     - "renesas,cmt-48-gen2" for all second generation 48-bit CMT
 		(CMT[01] on r8a73a4, r8a7790 and r8a7791)
 		This is a fallback for the renesas,cmt-48-r8a73a4,
-- 
2.3.5

