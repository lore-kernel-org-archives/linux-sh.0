From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 30 Sep 2011 03:16:57 +0000
Subject: [PATCH] net: sh_eth: fix build failure
Message-Id: <4E8534A9.3050002@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, netdev@vger.kernel.org, SH-Linux <linux-sh@vger.kernel.org>

The following commit removed some including headers:
 "net: sh_eth: move the asm/sh_eth.h to include/linux/"
 (commit id: d4fa0e35fdbd54acf791fa3793d6d17f7795f7ae)

Then, the build failure happened on the linux-next:

drivers/net/ethernet/renesas/sh_eth.c:601: error: 'THIS_MODULE' undeclared here (not in a function)
drivers/net/ethernet/renesas/sh_eth.c:1970: error: expected declaration specifiers or '...' before string constant
drivers/net/ethernet/renesas/sh_eth.c:1970: warning: data definition has no type or storage class
drivers/net/ethernet/renesas/sh_eth.c:1970: warning: type defaults to 'int' in declaration of 'MODULE_AUTHOR'
drivers/net/ethernet/renesas/sh_eth.c:1970: warning: function declaration isn't a prototype
drivers/net/ethernet/renesas/sh_eth.c:1971: error: expected declaration specifiers or '...' before string constant
drivers/net/ethernet/renesas/sh_eth.c:1971: warning: data definition has no type or storage class
drivers/net/ethernet/renesas/sh_eth.c:1971: warning: type defaults to 'int' in declaration of 'MODULE_DESCRIPTION'
drivers/net/ethernet/renesas/sh_eth.c:1971: warning: function declaration isn't a prototype
drivers/net/ethernet/renesas/sh_eth.c:1972: error: expected declaration specifiers or '...' before string constant
drivers/net/ethernet/renesas/sh_eth.c:1972: warning: data definition has no type or storage class
drivers/net/ethernet/renesas/sh_eth.c:1972: warning: type defaults to 'int' in declaration of 'MODULE_LICENSE'
drivers/net/ethernet/renesas/sh_eth.c:1972: warning: function declaration isn't a prototype

This patch fixes the issue. This patch also get back include/kernel.h
and linux/spinlock.h.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/net/ethernet/renesas/sh_eth.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
index 6aa0704..9b23074 100644
--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -21,6 +21,9 @@
  */

 #include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/spinlock.h>
 #include <linux/interrupt.h>
 #include <linux/dma-mapping.h>
 #include <linux/etherdevice.h>
-- 
1.7.1
