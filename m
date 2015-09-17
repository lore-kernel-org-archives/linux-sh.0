From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 17 Sep 2015 09:53:34 +0000
Subject: [PATCH v2 01/11] devicetree: bindings: Remove sh7372 CMT binding
Message-Id: <20150917095334.5369.70615.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
References: <20150917095325.5369.73893.sendpatchset@little-apple>
In-Reply-To: <20150917095325.5369.73893.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org, laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, linux-sh@vger.kernel.org, daniel.lezcano@linaro.org, horms+renesas@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, tglx@linutronix.de

From: Magnus Damm <damm+renesas@opensource.se>

Remove the sh7372 CMT compat string to reduce maintenance burden.

It should be fine to break DT compatibility because:
1) The sh7372 SoC support has been removed from upstream
2) The sh7372 CMT DT binding was never part of upstream DTS
3) The CMT driver never matches on the sh7372 binding

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---

 Changes since V1:
 - Removed all references to sh7372
 - Added Acked-by and Tested-by from Geert
 - Added Acked-by from Laurent

 Documentation/devicetree/bindings/timer/renesas,cmt.txt |   12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

--- 0001/Documentation/devicetree/bindings/timer/renesas,cmt.txt
+++ work/Documentation/devicetree/bindings/timer/renesas,cmt.txt	2015-09-17 17:22:52.420513000 +0900
@@ -14,32 +14,26 @@ Required Properties:
   - compatible: must contain one or more of the following:
     - "renesas,cmt-32-r8a7740" for the r8a7740 32-bit CMT
 		(CMT0)
-    - "renesas,cmt-32-sh7372" for the sh7372 32-bit CMT
-		(CMT0)
     - "renesas,cmt-32-sh73a0" for the sh73a0 32-bit CMT
 		(CMT0)
     - "renesas,cmt-32" for all 32-bit CMT without fast clock support
-		(CMT0 on sh7372, sh73a0 and r8a7740)
+		(CMT0 on sh73a0 and r8a7740)
 		This is a fallback for the above renesas,cmt-32-* entries.
 
     - "renesas,cmt-32-fast-r8a7740" for the r8a7740 32-bit CMT with fast
 		clock support (CMT[234])
-    - "renesas,cmt-32-fast-sh7372" for the sh7372 32-bit CMT with fast
-		clock support (CMT[234])
     - "renesas,cmt-32-fast-sh73a0" for the sh73A0 32-bit CMT with fast
 		clock support (CMT[234])
     - "renesas,cmt-32-fast" for all 32-bit CMT with fast clock support
-		(CMT[234] on sh7372, sh73a0 and r8a7740)
+		(CMT[234] on sh73a0 and r8a7740)
 		This is a fallback for the above renesas,cmt-32-fast-* entries.
 
-    - "renesas,cmt-48-sh7372" for the sh7372 48-bit CMT
-		(CMT1)
     - "renesas,cmt-48-sh73a0" for the sh73A0 48-bit CMT
 		(CMT1)
     - "renesas,cmt-48-r8a7740" for the r8a7740 48-bit CMT
 		(CMT1)
     - "renesas,cmt-48" for all non-second generation 48-bit CMT
-		(CMT1 on sh7372, sh73a0 and r8a7740)
+		(CMT1 on sh73a0 and r8a7740)
 		This is a fallback for the above renesas,cmt-48-* entries.
 
     - "renesas,cmt-48-r8a73a4" for the r8a73a4 48-bit CMT
