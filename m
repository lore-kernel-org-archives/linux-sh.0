From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 02 May 2014 19:15:06 +0000
Subject: [PATCH v2 00/10] i2c: sh_mobile: cleanups & bugfixes
Message-Id: <1399058116-7721-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>

Some cleanups and bugfixes for i2c-sh_mobile. Tested on top of
renesas-devel-v3.15-rc3-20140429 and with a lager board. Branch is at

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/sh_mobile-cleanup

Changes since V1:
* added patches to make bus speed calculation more robust
* added patch to fix bus speed calculation for rcar-gen2 SoCs
* added tags from Geert to patches


Wolfram Sang (10):
  i2c: sh_mobile: replace magic hex values with constants
  i2c: sh_mobile: improve error handling
  i2c: sh_mobile: honor DT bus speed settings
  i2c: sh_mobile: add devicetree documentation
  i2c: sh_mobile: devm conversion, low hanging fruits
  i2c: sh_mobile: devm conversion, irq setup
  i2c: sh_mobile: remove superfluous offset parameter
  i2c: sh_mobile: bail out on errors when initializing
  i2c: sh_mobile: check timing parameters for valid range
  i2c: sh_mobile: fix clock calculation for newer SoCs

 .../devicetree/bindings/i2c/i2c-sh_mobile.txt      |  26 +++
 drivers/i2c/busses/i2c-sh_mobile.c                 | 222 ++++++++++-----------
 2 files changed, 130 insertions(+), 118 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt

-- 
1.9.2

