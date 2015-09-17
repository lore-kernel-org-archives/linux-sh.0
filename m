From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 17 Sep 2015 09:53:53 +0000
Subject: [PATCH v2 03/11] devicetree: bindings: R-Car Gen2 CMT0 and CMT1 bindings
Message-Id: <20150917095353.5369.23696.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
References: <20150917095325.5369.73893.sendpatchset@little-apple>
In-Reply-To: <20150917095325.5369.73893.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org, laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, linux-sh@vger.kernel.org, daniel.lezcano@linaro.org, horms+renesas@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, tglx@linutronix.de

From: Magnus Damm <damm+renesas@opensource.se>

Add documentation for new separate CMT0 and CMT1 DT compatible strings
for R-Car Gen2. These compat strings allow us to enable CMT1-specific
features in the driver. The old compat strings will be deprecated in
the not so distant future.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---

 Changes since V1:
 - Added Acked-by and Tested-by from Geert
 - Added Acked-by from Laurent

 Documentation/devicetree/bindings/timer/renesas,cmt.txt |    3 +++
 1 file changed, 3 insertions(+)

--- 0002/Documentation/devicetree/bindings/timer/renesas,cmt.txt
+++ work/Documentation/devicetree/bindings/timer/renesas,cmt.txt	2015-09-17 17:26:57.440513000 +0900
@@ -36,6 +36,9 @@ Required Properties:
 		(CMT1 on sh73a0 and r8a7740)
 		This is a fallback for the above renesas,cmt-48-* entries.
 
+    - "renesas,cmt0-rcar-gen2" for 32-bit CMT0 devices included in R-Car Gen2.
+    - "renesas,cmt1-rcar-gen2" for 48-bit CMT1 devices included in R-Car Gen2.
+
     - "renesas,cmt-48-r8a73a4" for the r8a73a4 48-bit CMT
 		(CMT[01])
     - "renesas,cmt-48-r8a7790" for the r8a7790 48-bit CMT
