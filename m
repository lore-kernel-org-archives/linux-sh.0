From: Wolfram Sang <wsa@the-dreams.de>
Date: Sat, 08 Aug 2015 20:33:25 +0000
Subject: [PATCH 08/10] i2c: support 10 bit and slave addresses in sysfs 'new_device'
Message-Id: <1439066007-13951-9-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1439066007-13951-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1439066007-13951-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>, Andrey Danin <danindrey@mail.ru>, Stephen Warren <swarren@wwwdotorg.org>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

We now have seperate address spaces for 10 bit and we-are-slave clients.
Update the sysfs device instantiation method to support these types by
accepting the address offsets that are assigned to the extra address
spaces. Update the documentation, too.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 Documentation/i2c/slave-interface   |  9 ++++++---
 Documentation/i2c/ten-bit-addresses |  4 ++++
 drivers/i2c/i2c-core.c              | 12 +++++++++++-
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/Documentation/i2c/slave-interface b/Documentation/i2c/slave-interface
index 2dee4e2d62df19..61ed05cd95317f 100644
--- a/Documentation/i2c/slave-interface
+++ b/Documentation/i2c/slave-interface
@@ -31,10 +31,13 @@ User manual
 ===== 
 I2C slave backends behave like standard I2C clients. So, you can instantiate
-them as described in the document 'instantiating-devices'. A quick example for
-instantiating the slave-eeprom driver from userspace at address 0x64 on bus 1:
+them as described in the document 'instantiating-devices'. The only difference
+is that i2c slave backends have their own address space. So, you have to add
+0x1000 to the address you would originally request. An example for
+instantiating the slave-eeprom driver from userspace at the 7 bit address 0x64
+on bus 1:
 
-  # echo slave-24c02 0x64 > /sys/bus/i2c/devices/i2c-1/new_device
+  # echo slave-24c02 0x1064 > /sys/bus/i2c/devices/i2c-1/new_device
 
 Each backend should come with separate documentation to describe its specific
 behaviour and setup.
diff --git a/Documentation/i2c/ten-bit-addresses b/Documentation/i2c/ten-bit-addresses
index cdfe13901b99cb..7b2d11e53a49f1 100644
--- a/Documentation/i2c/ten-bit-addresses
+++ b/Documentation/i2c/ten-bit-addresses
@@ -2,6 +2,10 @@ The I2C protocol knows about two kinds of device addresses: normal 7 bit
 addresses, and an extended set of 10 bit addresses. The sets of addresses
 do not intersect: the 7 bit address 0x10 is not the same as the 10 bit
 address 0x10 (though a single device could respond to both of them).
+To avoid ambiguity, the user sees 10 bit addresses mapped to a different
+address space, namely 0xa000-0xa3ff. The leading 0xa (= 10) represents the
+10 bit mode. This is used for creating device names in sysfs. It is also
+needed when instantiating 10 bit devices via the new_device file in sysfs.
 
 I2C messages to and from 10-bit address devices have a different format.
 See the I2C specification for the details.
diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 24c96dd0a5bee4..4c1f31f039964b 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1156,6 +1156,16 @@ i2c_sysfs_new_device(struct device *dev, struct device_attribute *attr,
 		return -EINVAL;
 	}
 
+	if ((info.addr & I2C_ADDR_OFFSET_TEN_BIT) = I2C_ADDR_OFFSET_TEN_BIT) {
+		info.addr &= ~I2C_ADDR_OFFSET_TEN_BIT;
+		info.flags |= I2C_CLIENT_TEN;
+	}
+
+	if (info.addr & I2C_ADDR_OFFSET_SLAVE) {
+		info.addr &= ~I2C_ADDR_OFFSET_SLAVE;
+		info.flags |= I2C_CLIENT_SLAVE;
+	}
+
 	client = i2c_new_device(adap, &info);
 	if (!client)
 		return -EINVAL;
@@ -1207,7 +1217,7 @@ i2c_sysfs_delete_device(struct device *dev, struct device_attribute *attr,
 			  i2c_adapter_depth(adap));
 	list_for_each_entry_safe(client, next, &adap->userspace_clients,
 				 detected) {
-		if (client->addr = addr) {
+		if (i2c_encode_flags_to_addr(client) = addr) {
 			dev_info(dev, "%s: Deleting device %s at 0x%02hx\n",
 				 "delete_device", client->name, client->addr);
 
-- 
2.1.4

