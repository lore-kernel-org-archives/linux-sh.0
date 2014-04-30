From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 30 Apr 2014 22:21:04 +0000
Subject: [PATCH 0/6] i2c: sh_mobile: cleanups
Message-Id: <1398896470-24663-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

Some cleanups for i2c-sh_mobile. Tested on top of renesas-devel-v3.15-rc3-20140429
and with a lager board. Branch is at

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/sh_mobile-cleanup

Wolfram Sang (6):
  i2c: sh_mobile: replace magic hex values with constants
  i2c: sh_mobile: improve error handling
  i2c: sh_mobile: honor DT bus speed settings
  i2c: sh_mobile: add devicetree documentation
  i2c: sh_mobile: devm conversion, low hanging fruits
  i2c: sh_mobile: devm conversion, irq setup

 .../devicetree/bindings/i2c/i2c-sh_mobile.txt      |  26 ++++
 drivers/i2c/busses/i2c-sh_mobile.c                 | 132 +++++++--------------
 2 files changed, 67 insertions(+), 91 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt

-- 
1.9.2

