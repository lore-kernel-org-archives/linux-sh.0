From: Wolfram Sang <wsa@the-dreams.de>
Date: Sat, 08 Aug 2015 20:33:24 +0000
Subject: [PATCH 07/10] i2c: take address space into account when checking for used addresses
Message-Id: <1439066007-13951-8-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1439066007-13951-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1439066007-13951-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>, Andrey Danin <danindrey@mail.ru>, Stephen Warren <swarren@wwwdotorg.org>, Stephen Warren <swarren@nvidia.com>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

It is not enough to compare the plain address value, we also need to
check the flags enabling a different address space. E.g. it is valid to
have address 0x50 as a 7-bit address and 0x050 as 10-bit address on the
same bus. Same for addresses when we are the slave.

Tested-by: Andrey Danin <danindrey@mail.ru>
Acked-by: Stephen Warren <swarren@nvidia.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/i2c-core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 7638eb1a5998f8..24c96dd0a5bee4 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -837,7 +837,7 @@ static int __i2c_check_addr_busy(struct device *dev, void *addrp)
 	struct i2c_client	*client = i2c_verify_client(dev);
 	int			addr = *(int *)addrp;
 
-	if (client && client->addr = addr)
+	if (client && i2c_encode_flags_to_addr(client) = addr)
 		return -EBUSY;
 	return 0;
 }
@@ -991,7 +991,7 @@ i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
 	}
 
 	/* Check for address business */
-	status = i2c_check_addr_busy(adap, client->addr);
+	status = i2c_check_addr_busy(adap, i2c_encode_flags_to_addr(client));
 	if (status)
 		goto out_err;
 
@@ -2287,7 +2287,7 @@ static int i2c_detect_address(struct i2c_client *temp_client,
 		return err;
 	}
 
-	/* Skip if already in use */
+	/* Skip if already in use (7 bit, no need to encode flags) */
 	if (i2c_check_addr_busy(adapter, addr))
 		return 0;
 
@@ -2403,7 +2403,7 @@ i2c_new_probed_device(struct i2c_adapter *adap,
 			continue;
 		}
 
-		/* Check address availability */
+		/* Check address availability (7 bit, no need to encode flags) */
 		if (i2c_check_addr_busy(adap, addr_list[i])) {
 			dev_dbg(&adap->dev, "Address 0x%02x already in "
 				"use, not probing\n", addr_list[i]);
-- 
2.1.4

