From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 05 Dec 2015 00:03:26 +0000
Subject: [PATCH] MAINTAINERS: add myself as Renesas Ethernet drivers reviewer
Message-Id: <1846877.jRW8849mPU@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

liAdd myself as  a reviewer for the Renesas Ethernet drivers -- hopefully I
won't miss the buggy  patches anymore. :-)

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against DaveM's 'net.git' repo.

 MAINTAINERS |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: net/MAINTAINERS
=================================--- net.orig/MAINTAINERS
+++ net/MAINTAINERS
@@ -8929,6 +8929,14 @@ F:	drivers/rpmsg/
 F:	Documentation/rpmsg.txt
 F:	include/linux/rpmsg.h
 
+RENESAS ETHERNET DRIVERS
+R:	Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
+L:	netdev@vger.kernel.org
+L:	linux-sh@vger.kernel.org
+S:	Maintained
+F:	drivers/net/ethernet/renesas/
+F:	include/linux/sh_eth.h
+
 RESET CONTROLLER FRAMEWORK
 M:	Philipp Zabel <p.zabel@pengutronix.de>
 S:	Maintained

