From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Sun, 07 Aug 2011 22:26:50 +0000
Subject: [PATCH] sh: Fix boot crash related to SCI
Message-Id: <201108080026.50989.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lethal@linux-sh.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

Commit d006199e72a9cf9537ff567ffa07c3f343b9182a (serial:
sh-sci: Regtype probing doesn't need to be fatal.) made
sci_init_single() return when sci_probe_regmap() succeeds, although
it should return when sci_probe_regmap() fails.  This causes systems
using the serial sh-sci driver to crash during boot.

Fix the problem by using the right return condition.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/tty/serial/sh-sci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/drivers/tty/serial/sh-sci.c
=================================--- linux-2.6.orig/drivers/tty/serial/sh-sci.c
+++ linux-2.6/drivers/tty/serial/sh-sci.c
@@ -1889,7 +1889,7 @@ static int __devinit sci_init_single(str
 
 	if (p->regtype = SCIx_PROBE_REGTYPE) {
 		ret = sci_probe_regmap(p);
-		if (unlikely(!ret))
+		if (unlikely(ret))
 			return ret;
 	}
 
