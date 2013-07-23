From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 23 Jul 2013 16:12:00 +0000
Subject: [PATCH 0/4] net: smsc911x: support reset GPIO and use it on ape6evm
Message-Id: <1374595924-12338-1-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Steve Glendinning <steve.glendinning@shawell.net>, netdev@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

The first two patches add support for a reset GPIO to the smsc911x driver
in the platform data and in DT. The latter 2 patches use the reset GPIO
on APE6EVM in DT and non-DT modes. They therefore should be applied after
the first two patches are merged.

Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Guennadi Liakhovetski (4):
  net: smsc911x: add support for a reset GPIO
  net: smsc911x: add a reset GPIO DT binding
  ARM: shmobile: ape6evm: use smsc911x platform parameters to handle
    eth reset
  ARM: shmobile: ape6evm-reference: add smsc911x ethernet support

 Documentation/devicetree/bindings/net/smsc911x.txt |    1 +
 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts    |   25 ++++++++++++++++-
 arch/arm/mach-shmobile/board-ape6evm.c             |    5 +--
 drivers/net/ethernet/smsc/smsc911x.c               |   30 +++++++++++++++++++-
 include/linux/smsc911x.h                           |   10 ++++++
 5 files changed, 66 insertions(+), 5 deletions(-)

-- 
1.7.2.5

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
