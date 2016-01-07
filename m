From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 07 Jan 2016 20:51:00 +0000
Subject: [PATCH 2/2] dt-bindings: i2c: eeprom: add another EEPROM device
Message-Id: <1452199860-3601-3-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1452199860-3601-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1452199860-3601-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Simon Horman <horms@verge.net.au>, linux-kernel@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 Documentation/devicetree/bindings/eeprom/eeprom.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/eeprom/eeprom.txt b/Documentation/devicetree/bindings/eeprom/eeprom.txt
index acb600399c3d94..735bc94444bbd7 100644
--- a/Documentation/devicetree/bindings/eeprom/eeprom.txt
+++ b/Documentation/devicetree/bindings/eeprom/eeprom.txt
@@ -12,6 +12,8 @@ Required properties:
 
 	"ramtron,24c64"
 
+	"renesas,r1ex24002"
+
 	 If there is no specific driver for <manufacturer>, a generic
 	 driver based on <type> is selected. Possible types are:
 	 "24c00", "24c01", "24c02", "24c04", "24c08", "24c16", "24c32", "24c64",
-- 
2.1.4

