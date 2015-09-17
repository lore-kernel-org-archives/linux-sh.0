From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 17 Sep 2015 09:54:13 +0000
Subject: [PATCH v2 05/11] devicetree: bindings: r8a73a4 and R-Car Gen2 CMT bindings
Message-Id: <20150917095413.5369.73009.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
References: <20150917095325.5369.73893.sendpatchset@little-apple>
In-Reply-To: <20150917095325.5369.73893.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org, laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, linux-sh@vger.kernel.org, daniel.lezcano@linaro.org, horms+renesas@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, tglx@linutronix.de

From: Magnus Damm <damm+renesas@opensource.se>

Update SoC-specific bindings for r8a73a4 and R-Car Gen2 CMT0 and CMT1.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---

 Changes since V1:
 - Added Acked-by and Tested-by from Geert
 - Added Acked-by from Laurent

 Documentation/devicetree/bindings/timer/renesas,cmt.txt |   26 ++++++++-------
 1 file changed, 15 insertions(+), 11 deletions(-)

--- 0005/Documentation/devicetree/bindings/timer/renesas,cmt.txt
+++ work/Documentation/devicetree/bindings/timer/renesas,cmt.txt	2015-09-17 17:31:02.650513000 +0900
@@ -36,20 +36,24 @@ Required Properties:
 		(CMT1 on sh73a0 and r8a7740)
 		This is a fallback for the above renesas,cmt-48-* entries.
 
+    - "renesas,cmt0-r8a73a4" for the 32-bit CMT0 device included in r8a73a4.
+    - "renesas,cmt1-r8a73a4" for the 48-bit CMT1 device included in r8a73a4.
+    - "renesas,cmt0-r8a7790" for the 32-bit CMT0 device included in r8a7790.
+    - "renesas,cmt1-r8a7790" for the 48-bit CMT1 device included in r8a7790.
+    - "renesas,cmt0-r8a7791" for the 32-bit CMT0 device included in r8a7791.
+    - "renesas,cmt1-r8a7791" for the 48-bit CMT1 device included in r8a7791.
+    - "renesas,cmt0-r8a7793" for the 32-bit CMT0 device included in r8a7793.
+    - "renesas,cmt1-r8a7793" for the 48-bit CMT1 device included in r8a7793.
+    - "renesas,cmt0-r8a7794" for the 32-bit CMT0 device included in r8a7794.
+    - "renesas,cmt1-r8a7794" for the 48-bit CMT1 device included in r8a7794.
+
     - "renesas,cmt0-rcar-gen2" for 32-bit CMT0 devices included in R-Car Gen2.
     - "renesas,cmt1-rcar-gen2" for 48-bit CMT1 devices included in R-Car Gen2.
+		These are fallbacks for r8a73a4 and all the R-Car Gen2
+		entries	listed above.
 
-    - "renesas,cmt-48-r8a73a4" for the r8a73a4 48-bit CMT
-		(CMT[01])
-    - "renesas,cmt-48-r8a7790" for the r8a7790 48-bit CMT
-		(CMT[01])
-    - "renesas,cmt-48-r8a7791" for the r8a7791 48-bit CMT
-		(CMT[01])
-    - "renesas,cmt-48-gen2" for all second generation 48-bit CMT
-		(CMT[01] on r8a73a4, r8a7790 and r8a7791)
-		This is a fallback for the renesas,cmt-48-r8a73a4,
-		renesas,cmt-48-r8a7790 and renesas,cmt-48-r8a7791 entries.
-
+    - "renesas,cmt-48-gen2" is <deprecated>, use "renesas,cmt[01]-*" instead.
+    
   - reg: base address and length of the registers block for the timer module.
   - interrupts: interrupt-specifier for the timer, one per channel.
   - clocks: a list of phandle + clock-specifier pairs, one for each entry
