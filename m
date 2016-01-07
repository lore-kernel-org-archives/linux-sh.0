From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 07 Jan 2016 20:50:58 +0000
Subject: [PATCH 0/2] dt-bindings: refactor i2c eeprom bindings, step 1
Message-Id: <1452199860-3601-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Simon Horman <horms@verge.net.au>, linux-kernel@vger.kernel.org

A first step to clean up the bindings for i2c eeproms. Please see the patch
descriptions for further details.

I suggest I take these via my i2c tree. D'accord?

Thanks,

   Wolfram


Wolfram Sang (2):
  dt-bindings: move I2C eeprom descriptions to the proper file
  dt-bindings: i2c: eeprom: add another EEPROM device

 Documentation/devicetree/bindings/eeprom/eeprom.txt | 21 ++++++++++++++++-----
 .../devicetree/bindings/i2c/trivial-devices.txt     | 13 -------------
 2 files changed, 16 insertions(+), 18 deletions(-)

-- 
2.1.4

