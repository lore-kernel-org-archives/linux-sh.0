From: Magnus Damm <magnus.damm@gmail.com>
Date: Sun, 21 Jun 2015 08:09:15 +0000
Subject: [PATCH 01/08] devicetree: bindings: Remove sh7372 CMT binding
Message-Id: <20150621080915.10187.97464.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
References: <20150621080903.10187.20998.sendpatchset@little-apple>
In-Reply-To: <20150621080903.10187.20998.sendpatchset@little-apple>
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
---

 Documentation/devicetree/bindings/timer/renesas,cmt.txt |    2 --
 1 file changed, 2 deletions(-)

--- 0001/Documentation/devicetree/bindings/timer/renesas,cmt.txt
+++ work/Documentation/devicetree/bindings/timer/renesas,cmt.txt	2015-06-20 13:47:59.922366518 +0900
@@ -32,8 +32,6 @@ Required Properties:
 		(CMT[234] on sh7372, sh73a0 and r8a7740)
 		This is a fallback for the above renesas,cmt-32-fast-* entries.
 
-    - "renesas,cmt-48-sh7372" for the sh7372 48-bit CMT
-		(CMT1)
     - "renesas,cmt-48-sh73a0" for the sh73A0 48-bit CMT
 		(CMT1)
     - "renesas,cmt-48-r8a7740" for the r8a7740 48-bit CMT
--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
