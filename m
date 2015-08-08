From: Wolfram Sang <wsa@the-dreams.de>
Date: Sat, 08 Aug 2015 20:33:22 +0000
Subject: [PATCH 05/10] i2c: make address check indpendent from client struct
Message-Id: <1439066007-13951-6-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1439066007-13951-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1439066007-13951-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>, Andrey Danin <danindrey@mail.ru>, Stephen Warren <swarren@wwwdotorg.org>, Stephen Warren <swarren@nvidia.com>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

We want to use this function with struct boardinfo soon, so let's just
pass the parameters really needed. We also extend the type of addr, so
more types can be input. Remove a superfluous dangling comment while
here.

Tested-by: Andrey Danin <danindrey@mail.ru>
Acked-by: Stephen Warren <swarren@nvidia.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/i2c-core.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 28766b7208bcc2..4a83d39a5aabe2 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -796,15 +796,15 @@ static unsigned short i2c_encode_flags_to_addr(struct i2c_client *client)
 
 /* This is a permissive address validity check, I2C address map constraints
  * are purposely not enforced, except for the general call address. */
-static int i2c_check_addr_validity(const struct i2c_client *client)
+static int i2c_check_addr_validity(unsigned addr, unsigned short flags)
 {
-	if (client->flags & I2C_CLIENT_TEN) {
+	if (flags & I2C_CLIENT_TEN) {
 		/* 10-bit address, all values are valid */
-		if (client->addr > 0x3ff)
+		if (addr > 0x3ff)
 			return -EINVAL;
 	} else {
 		/* 7-bit address, reject the general call address */
-		if (client->addr = 0x00 || client->addr > 0x7f)
+		if (addr = 0x00 || addr > 0x7f)
 			return -EINVAL;
 	}
 	return 0;
@@ -982,8 +982,7 @@ i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
 
 	strlcpy(client->name, info->type, sizeof(client->name));
 
-	/* Check for address validity */
-	status = i2c_check_addr_validity(client);
+	status = i2c_check_addr_validity(client->addr, client->flags);
 	if (status) {
 		dev_err(&adap->dev, "Invalid %d-bit I2C address 0x%02hx\n",
 			client->flags & I2C_CLIENT_TEN ? 10 : 7, client->addr);
-- 
2.1.4

