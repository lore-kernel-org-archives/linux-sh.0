From: Magnus Damm <magnus.damm@gmail.com>
Date: Sun, 21 Jun 2015 08:10:00 +0000
Subject: [PATCH 05/08] devicetree: bindings: r8a73a4 and R-Car Gen2 CMT bindings
Message-Id: <20150621081000.10187.3979.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
References: <20150621080903.10187.20998.sendpatchset@little-apple>
In-Reply-To: <20150621080903.10187.20998.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org

From: Magnus Damm <damm+renesas@opensource.se>

Update SoC-specific bindings for r8a73a4 and R-Car Gen2 CMT0 and CMT1.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Documentation/devicetree/bindings/timer/renesas,cmt.txt |   26 ++++++++-------
 1 file changed, 15 insertions(+), 11 deletions(-)

--- 0006/Documentation/devicetree/bindings/timer/renesas,cmt.txt
+++ work/Documentation/devicetree/bindings/timer/renesas,cmt.txt	2015-06-20 14:34:16.092366518 +0900
@@ -40,20 +40,24 @@ Required Properties:
 		(CMT1 on sh7372, sh73a0 and r8a7740)
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
--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
