From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 19 Jan 2010 13:52:28 +0000
Subject: [PATCH] sh: update PFC to allow any enum in MARK lists
Message-Id: <20100119135228.2820.86210.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch updates the PFC code with some clarifying
comments together with a functional change. The change
allows function type of GPIO to select any type of enum
in their MARK lists. Without this patch only function
type of enums are allowed in MARK lists.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/sh/pfc.c |   34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

--- 0001/drivers/sh/pfc.c
+++ work/drivers/sh/pfc.c	2010-01-18 14:23:44.000000000 +0900
@@ -337,12 +337,36 @@ static int pinmux_config_gpio(struct pin
 		if (!enum_id)
 			break;
 
+		/* first check if this is a function enum */
 		in_range = enum_in_range(enum_id, &gpioc->function);
-		if (!in_range && range) {
-			in_range = enum_in_range(enum_id, range);
-
-			if (in_range && enum_id = range->force)
-				continue;
+		if (!in_range) {
+			/* not a function enum */
+			if (range) {
+				/* other range exists, so this pin is
+				 * a regular GPIO pin that now is being
+				 * bound to a specific direction.
+				 *
+				 * for this case we only allow function enums
+				 * and the enums that match the other range.
+				 */
+				in_range = enum_in_range(enum_id, range);
+
+				/* special case pass through for fixed
+				 * input-only or output-only pins without
+				 * function enum register association.
+				 */
+				if (in_range && enum_id = range->force)
+					continue;
+			} else {
+				/* no other range exists, so this pin
+				 * must then be of the function type.
+				 *
+				 * allow function type pins to select
+				 * any combination of function/in/out
+				 * in their MARK lists.
+				 */
+				in_range = 1;
+			}
 		}
 
 		if (!in_range)
