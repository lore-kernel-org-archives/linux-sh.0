From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 04 Dec 2015 21:58:07 +0000
Subject: [PATCH 1/2] ravb: read MAC address registers only once
Message-Id: <6904286.WCKWH7i1NK@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <10429393.qU4CxZ5nlj@wasted.cogentembedded.com>
In-Reply-To: <10429393.qU4CxZ5nlj@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: linux-sh@vger.kernel.org

The code reading the MAHR/MALR registers in ravb_read_mac_address() is
terribly ineffective -- it reads  MAHR 4 times and MALR 2 times, while
it's enough to read each register only once. Use the local variables to
achieve that, somewhat beautifying the code while at it...

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 drivers/net/ethernet/renesas/ravb_main.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

Index: net-next/drivers/net/ethernet/renesas/ravb_main.c
=================================--- net-next.orig/drivers/net/ethernet/renesas/ravb_main.c
+++ net-next/drivers/net/ethernet/renesas/ravb_main.c
@@ -115,12 +115,15 @@ static void ravb_read_mac_address(struct
 	if (mac) {
 		ether_addr_copy(ndev->dev_addr, mac);
 	} else {
-		ndev->dev_addr[0] = (ravb_read(ndev, MAHR) >> 24);
-		ndev->dev_addr[1] = (ravb_read(ndev, MAHR) >> 16) & 0xFF;
-		ndev->dev_addr[2] = (ravb_read(ndev, MAHR) >> 8) & 0xFF;
-		ndev->dev_addr[3] = (ravb_read(ndev, MAHR) >> 0) & 0xFF;
-		ndev->dev_addr[4] = (ravb_read(ndev, MALR) >> 8) & 0xFF;
-		ndev->dev_addr[5] = (ravb_read(ndev, MALR) >> 0) & 0xFF;
+		u32 mahr = ravb_read(ndev, MAHR);
+		u32 malr = ravb_read(ndev, MALR);
+
+		ndev->dev_addr[0] = (mahr >> 24) & 0xFF;
+		ndev->dev_addr[1] = (mahr >> 16) & 0xFF;
+		ndev->dev_addr[2] = (mahr >>  8) & 0xFF;
+		ndev->dev_addr[3] = (mahr >>  0) & 0xFF;
+		ndev->dev_addr[4] = (malr >>  8) & 0xFF;
+		ndev->dev_addr[5] = (malr >>  0) & 0xFF;
 	}
 }
 

