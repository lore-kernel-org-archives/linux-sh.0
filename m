From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Thu, 30 Apr 2015 14:18:55 +0000
Subject: [PATCH v2 06/15] pinctrl: sh-pfc: Add renesas,pfc-r8a7793 to binding documentation
Message-Id: <1430403544-26742-7-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1430403544-26742-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1430403544-26742-1-git-send-email-ulrich.hecht+renesas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org, horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Ulrich Hecht <ulrich.hecht+renesas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Also renames "R-Car M2" to "R-Car M2-W" to avoid confusion.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: devicetree@vger.kernel.org
---
 Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt
index bfe72ec..6bcf851 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt
@@ -16,7 +16,8 @@ Required Properties:
     - "renesas,pfc-r8a7778": for R8A7778 (R-Mobile M1) compatible pin-controller.
     - "renesas,pfc-r8a7779": for R8A7779 (R-Car H1) compatible pin-controller.
     - "renesas,pfc-r8a7790": for R8A7790 (R-Car H2) compatible pin-controller.
-    - "renesas,pfc-r8a7791": for R8A7791 (R-Car M2) compatible pin-controller.
+    - "renesas,pfc-r8a7791": for R8A7791 (R-Car M2-W) compatible pin-controller.
+    - "renesas,pfc-r8a7793": for R8A7793 (R-Car M2-N) compatible pin-controller.
     - "renesas,pfc-sh73a0": for SH73A0 (SH-Mobile AG5) compatible pin-controller.
 
   - reg: Base address and length of each memory resource used by the pin
-- 
2.3.5

