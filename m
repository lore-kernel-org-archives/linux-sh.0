From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 17 Sep 2015 09:54:52 +0000
Subject: [PATCH v2 09/11] devicetree: bindings: Remove unused 32-bit CMT bindings
Message-Id: <20150917095452.5369.320.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
References: <20150917095325.5369.73893.sendpatchset@little-apple>
In-Reply-To: <20150917095325.5369.73893.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org, laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, linux-sh@vger.kernel.org, daniel.lezcano@linaro.org, horms+renesas@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, tglx@linutronix.de

From: Magnus Damm <damm+renesas@opensource.se>

Remove the 32-bit CMT compat strings to reduce maintenance burden.

It should be fine to break DT compatibility because the 32-bit
32-bit CMT DT binding was never part of any upstream DTS file.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Changes since V1:
 - New patch

 Documentation/devicetree/bindings/timer/renesas,cmt.txt |   16 ---------------
 1 file changed, 16 deletions(-)

--- 0008/Documentation/devicetree/bindings/timer/renesas,cmt.txt
+++ work/Documentation/devicetree/bindings/timer/renesas,cmt.txt	2015-09-17 18:04:35.060513000 +0900
@@ -12,22 +12,6 @@ datasheets.
 Required Properties:
 
   - compatible: must contain one or more of the following:
-    - "renesas,cmt-32-r8a7740" for the r8a7740 32-bit CMT
-		(CMT0)
-    - "renesas,cmt-32-sh73a0" for the sh73a0 32-bit CMT
-		(CMT0)
-    - "renesas,cmt-32" for all 32-bit CMT without fast clock support
-		(CMT0 on sh73a0 and r8a7740)
-		This is a fallback for the above renesas,cmt-32-* entries.
-
-    - "renesas,cmt-32-fast-r8a7740" for the r8a7740 32-bit CMT with fast
-		clock support (CMT[234])
-    - "renesas,cmt-32-fast-sh73a0" for the sh73A0 32-bit CMT with fast
-		clock support (CMT[234])
-    - "renesas,cmt-32-fast" for all 32-bit CMT with fast clock support
-		(CMT[234] on sh73a0 and r8a7740)
-		This is a fallback for the above renesas,cmt-32-fast-* entries.
-
     - "renesas,cmt-48-sh73a0" for the sh73A0 48-bit CMT
 		(CMT1)
     - "renesas,cmt-48-r8a7740" for the r8a7740 48-bit CMT
