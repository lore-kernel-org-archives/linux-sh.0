From: Wolfram Sang <wsa@the-dreams.de>
Date: Sat, 08 Aug 2015 20:33:21 +0000
Subject: [PATCH 04/10] i2c: rename address check functions
Message-Id: <1439066007-13951-5-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1439066007-13951-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1439066007-13951-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>, Andrey Danin <danindrey@mail.ru>, Stephen Warren <swarren@wwwdotorg.org>, Stephen Warren <swarren@nvidia.com>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

The current naming is based on the arguments of the functions and not on
what they do. Even I as the maintainer find this confusing, so let's
rename them to something more descriptive.

Tested-by: Andrey Danin <danindrey@mail.ru>
Acked-by: Stephen Warren <swarren@nvidia.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/i2c-core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 150ee00b5ff5cb..28766b7208bcc2 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -796,7 +796,7 @@ static unsigned short i2c_encode_flags_to_addr(struct i2c_client *client)
 
 /* This is a permissive address validity check, I2C address map constraints
  * are purposely not enforced, except for the general call address. */
-static int i2c_check_client_addr_validity(const struct i2c_client *client)
+static int i2c_check_addr_validity(const struct i2c_client *client)
 {
 	if (client->flags & I2C_CLIENT_TEN) {
 		/* 10-bit address, all values are valid */
@@ -814,7 +814,7 @@ static int i2c_check_client_addr_validity(const struct i2c_client *client)
  * device uses a reserved address, then it shouldn't be probed. 7-bit
  * addressing is assumed, 10-bit address devices are rare and should be
  * explicitly enumerated. */
-static int i2c_check_addr_validity(unsigned short addr)
+static int i2c_check_7bit_addr_validity_strict(unsigned short addr)
 {
 	/*
 	 * Reserved addresses per I2C specification:
@@ -983,7 +983,7 @@ i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
 	strlcpy(client->name, info->type, sizeof(client->name));
 
 	/* Check for address validity */
-	status = i2c_check_client_addr_validity(client);
+	status = i2c_check_addr_validity(client);
 	if (status) {
 		dev_err(&adap->dev, "Invalid %d-bit I2C address 0x%02hx\n",
 			client->flags & I2C_CLIENT_TEN ? 10 : 7, client->addr);
@@ -2268,7 +2268,7 @@ static int i2c_detect_address(struct i2c_client *temp_client,
 	int err;
 
 	/* Make sure the address is valid */
-	err = i2c_check_addr_validity(addr);
+	err = i2c_check_7bit_addr_validity_strict(addr);
 	if (err) {
 		dev_warn(&adapter->dev, "Invalid probe address 0x%02x\n",
 			 addr);
@@ -2385,7 +2385,7 @@ i2c_new_probed_device(struct i2c_adapter *adap,
 
 	for (i = 0; addr_list[i] != I2C_CLIENT_END; i++) {
 		/* Check address validity */
-		if (i2c_check_addr_validity(addr_list[i]) < 0) {
+		if (i2c_check_7bit_addr_validity_strict(addr_list[i]) < 0) {
 			dev_warn(&adap->dev, "Invalid 7-bit address "
 				 "0x%02x\n", addr_list[i]);
 			continue;
@@ -2960,7 +2960,7 @@ int i2c_slave_register(struct i2c_client *client, i2c_slave_cb_t slave_cb)
 
 	if (!(client->flags & I2C_CLIENT_TEN)) {
 		/* Enforce stricter address checking */
-		ret = i2c_check_addr_validity(client->addr);
+		ret = i2c_check_7bit_addr_validity_strict(client->addr);
 		if (ret) {
 			dev_err(&client->dev, "%s: invalid address\n", __func__);
 			return ret;
-- 
2.1.4

