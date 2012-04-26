From: Bastian Hecht <hechtb@googlemail.com>
Date: Thu, 26 Apr 2012 14:00:58 +0000
Subject: [RFC DT style 0/4] Device Tree implementation for sh_flctl
Message-Id: <1335448862-5201-1-git-send-email-hechtb@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This is a prototype implementation of a device tree version of the flctl flash controller. I thought before posting anything on the mtd list, I get a review first at the "arch corner". Patch 3 contains all the stuff I was unable to figure out where to put - gpio setup and power domain handling. The controller runs smooth with the series booting with DT. So my main concerns are:

 - Do I miss anything important?
 - naming style is ok?
 - will patch 3 become completely unneccessary when DT support grows mature for
   mackerel? 
 - how to handle the evt2irq transformation? Simply supply the result to the device tree? (I omitted irqs in my patches)

Thanks,

 Bastian Hecht

Bastian Hecht (4):
  ARM: sh-mobile: Add sh_flctl to sh7372-mackerel device tree
  mtd: sh_flctl: Add device tree support
  Out-of-tree: sh_flctl: Add dirty hardware init code
  mtd: sh_flctl: Initial device tree binding specification

 .../devicetree/bindings/mtd/rmobile-flctl.txt      |   58 ++++++
 arch/arm/boot/dts/sh7372-mackerel.dts              |   36 ++++
 drivers/mtd/nand/sh_flctl.c                        |  207 +++++++++++++++++++-
 3 files changed, 300 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/rmobile-flctl.txt

-- 
1.7.5.4

