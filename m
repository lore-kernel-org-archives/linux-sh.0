From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 15 Jan 2015 14:54:13 +0000
Subject: [PATCH v2 0/2] Fix OF match for adxl34x driver
Message-Id: <1421333655-31029-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-input@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Geert Uytterhoeven <geert@glider.be>

Hello,

This patch set fixes OF matching for the adxl34x driver when the DT node lists
a device-specific "adi,adxl345" or "adi,adxl346" compatible value first.

The first version (see http://www.spinics.net/lists/linux-i2c/msg18107.html)
added an OF match entry for the "adi,adxl34x" compatible string. The
discussion that followed concluded that that compatible string should be
deprecated and that the driver should match the device-specific strings
instead.

The first patch thus deprecates the "adi,adxl34x" compatible string by
removing it the DT trivial devices list, and the second patch then adds an OF
match table to the adxl34x driver.

Laurent Pinchart (2):
  DT: i2c: Deprecate adi,adxl34x compatible string
  input: adxl34x: Add OF match support

 .../devicetree/bindings/i2c/trivial-devices.txt     |  3 +--
 drivers/input/misc/adxl34x-i2c.c                    | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 2 deletions(-)

-- 
Regards,

Laurent Pinchart

