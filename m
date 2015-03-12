From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 12 Mar 2015 12:42:03 +0000
Subject: [PATCH 3/3] i2c: slave: add documentation for i2c-slave-eeprom
Message-Id: <1426164123-8853-4-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1426164123-8853-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1426164123-8853-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Andrey Danin <danindrey@mail.ru>, Marc Dietrich <marvin24@gmx.de>, Debora Grosse <debora@mds.com>, linux-kernel@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 Documentation/i2c/slave-eeprom-backend | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 Documentation/i2c/slave-eeprom-backend

diff --git a/Documentation/i2c/slave-eeprom-backend b/Documentation/i2c/slave-eeprom-backend
new file mode 100644
index 00000000000000..c8444ef82acfa3
--- /dev/null
+++ b/Documentation/i2c/slave-eeprom-backend
@@ -0,0 +1,14 @@
+Linux I2C slave eeprom backend
+===============
+
+by Wolfram Sang <wsa@sang-engineering.com> in 2014-15
+
+This is a proof-of-concept backend which acts like an EEPROM on the connected
+I2C bus. The memory contents can be modified from userspace via this file
+located in sysfs:
+
+	/sys/bus/i2c/devices/<device-direcory>/slave-eeprom
+
+As of 2015, Linux doesn't support poll on binary sysfs files, so there is no
+notfication when another master changed the content.
+
-- 
2.1.4

