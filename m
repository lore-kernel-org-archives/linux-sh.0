From: Wolfram Sang <wsa@the-dreams.de>
Date: Sat, 08 Aug 2015 20:33:27 +0000
Subject: [PATCH 10/10] i2c: dt: describe generic bindings
Message-Id: <1439066007-13951-11-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1439066007-13951-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1439066007-13951-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>, Andrey Danin <danindrey@mail.ru>, Stephen Warren <swarren@wwwdotorg.org>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Start a new file which describes the generic bindings used for I2C with
device tree. So we have a central place to look for them, increase
visibility of them, and hopefully reduce the amount of custom properties
introduced.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 Documentation/devicetree/bindings/i2c/i2c.txt | 33 +++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c.txt b/Documentation/devicetree/bindings/i2c/i2c.txt
new file mode 100644
index 00000000000000..1175efed4a41b5
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c.txt
@@ -0,0 +1,33 @@
+Generic device tree bindings for I2C busses
+=====================+
+This document describes generic bindings which can be used to describe I2C
+busses in a device tree.
+
+Required properties
+-------------------
+
+- #address-cells  - should be <1>. Read more about addresses below.
+- #size-cells     - should be <0>.
+- compatible      - name of I2C bus controller following generic names
+		    recommended practice.
+
+For other required properties e.g. to describe register sets, interrupts,
+clocks, etc. check the binding documentation of the specific driver.
+
+The cells properties above define that an address of children of an I2C bus
+are described by a single value. This is usually a 7 bit address. However,
+flags can be attached to the address. I2C_TEN_BIT_ADDRESS is used to mark a 10
+bit address. It is needed to avoid the ambiguity between e.g. a 7 bit address
+of 0x50 and a 10 bit address of 0x050 which, in theory, can be on the same bus.
+Another flag is I2C_OWN_SLAVE_ADDRESS to mark addresses on which we listen to
+be devices ourselves.
+
+Optional properties
+-------------------
+
+These properties may not be supported by all drivers. However, if a driver
+wants to support one of the below features, it should adapt the bindings below.
+
+- clock-frequency	- frequency of bus clock in Hz
+- wakeup-source		- device can be used as a wakeup source.
-- 
2.1.4

