From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Thu, 28 May 2015 15:17:05 +0000
Subject: [PATCH 6/6] clocksource: sh_cmt: Document r8a7793-specific bindings
Message-Id: <1432826225-6743-7-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1432826225-6743-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1432826225-6743-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree@vger.kernel.org, geert@linux-m68k.org
Cc: horms@verge.net.au, linux-sh@vger.kernel.org, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Mark Rutland <mark.rutland@arm.com>

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 Documentation/devicetree/bindings/timer/renesas,cmt.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/renesas,cmt.txt b/Documentation/devicetree/bindings/timer/renesas,cmt.txt
index 1a05c1b..ca13de6 100644
--- a/Documentation/devicetree/bindings/timer/renesas,cmt.txt
+++ b/Documentation/devicetree/bindings/timer/renesas,cmt.txt
@@ -48,10 +48,13 @@ Required Properties:
 		(CMT[01])
     - "renesas,cmt-48-r8a7791" for the r8a7791 48-bit CMT
 		(CMT[01])
+    - "renesas,cmt-48-r8a7793" for the r8a7793 48-bit CMT
+		(CMT[01])
     - "renesas,cmt-48-gen2" for all second generation 48-bit CMT
-		(CMT[01] on r8a73a4, r8a7790 and r8a7791)
+		(CMT[01] on r8a73a4, r8a7790, r8a7791, and r8a7793)
 		This is a fallback for the renesas,cmt-48-r8a73a4,
-		renesas,cmt-48-r8a7790 and renesas,cmt-48-r8a7791 entries.
+		renesas,cmt-48-r8a7790, renesas,cmt-48-r8a7791, and
+		renesas,cmt-48-r8a7793 entries.
 
   - reg: base address and length of the registers block for the timer module.
   - interrupts: interrupt-specifier for the timer, one per channel.
-- 
2.3.5

