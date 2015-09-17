From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 17 Sep 2015 09:55:11 +0000
Subject: [PATCH v2 11/11] devicetree: bindings: Remove deprecated properties
Message-Id: <20150917095511.5369.41259.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
References: <20150917095325.5369.73893.sendpatchset@little-apple>
In-Reply-To: <20150917095325.5369.73893.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org, laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, linux-sh@vger.kernel.org, daniel.lezcano@linaro.org, horms+renesas@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, tglx@linutronix.de

From: Magnus Damm <damm+renesas@opensource.se>

The deprecated DT properies are part of the GIT history,
no need to keep them around any longer.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Changes since V1:
 - New patch

 Documentation/devicetree/bindings/timer/renesas,cmt.txt |    4 ----
 1 file changed, 4 deletions(-)

--- 0011/Documentation/devicetree/bindings/timer/renesas,cmt.txt
+++ work/Documentation/devicetree/bindings/timer/renesas,cmt.txt	2015-09-17 18:08:17.000513000 +0900
@@ -35,8 +35,6 @@ Required Properties:
     - "renesas,cmt1-rcar-gen2" for 48-bit CMT1 devices included in R-Car Gen2.
 		These are fallbacks for r8a73a4 and all the R-Car Gen2
 		entries	listed above.
-
-    - "renesas,cmt-48-gen2" is <deprecated>, use "renesas,cmt[01]-*" instead.
     
   - reg: base address and length of the registers block for the timer module.
   - interrupts: interrupt-specifier for the timer, one per channel.
@@ -44,8 +42,6 @@ Required Properties:
     in clock-names.
   - clock-names: must contain "fck" for the functional clock.
 
-  - renesas,channels-mask: <deprecated>, information kept in device driver.
-
 
 Example: R8A7790 (R-Car H2) CMT0 and CMT1 nodes
 
