From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 23 Aug 2011 09:26:33 +0000
Subject: [PATCH] net: sh_eth: fix the compile error
Message-Id: <4E537249.8050806@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: netdev@vger.kernel.org
Cc: SH-Linux <linux-sh@vger.kernel.org>

Fix the following build error:

  CC      drivers/net/sh_eth.o
drivers/net/sh_eth.c:1115: error: expected =91=3D=92, =91,=92, =91;=92, =91=
asm=92 or =91__attribute__=92 before =91sh_eth_interrupt=92
drivers/net/sh_eth.c: In function =91sh_eth_open=92:
drivers/net/sh_eth.c:1387: error: implicit declaration of function =91reque=
st_irq=92
drivers/net/sh_eth.c:1387: error: =91sh_eth_interrupt=92 undeclared (first =
use in this function)
drivers/net/sh_eth.c:1387: error: (Each undeclared identifier is reported o=
nly once
drivers/net/sh_eth.c:1387: error: for each function it appears in.)
drivers/net/sh_eth.c:1391: error: =91IRQF_SHARED=92 undeclared (first use i=
n this function)
drivers/net/sh_eth.c:1424: error: implicit declaration of function =91free_=
irq=92
make[2]: *** [drivers/net/sh_eth.o] Error 1

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/net/sh_eth.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/net/sh_eth.c b/drivers/net/sh_eth.c
index ad35c21..f6de45b 100644
--- a/drivers/net/sh_eth.c
+++ b/drivers/net/sh_eth.c
@@ -30,6 +30,7 @@
 #include <linux/phy.h>
 #include <linux/cache.h>
 #include <linux/io.h>
+#include <linux/interrupt.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/ethtool.h>
--=20
1.7.1
