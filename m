From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 07 Jul 2014 06:50:07 +0000
Subject: [PATCH 0/2] ARM: shmobile: Remove early_printk from command line
Message-Id: <1404715809-31331-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

As early printk is not supported when devices are initialised
using DT, so remove it from the command line.

Based on renesas-devel-v3.16-rc3-20140706.

Simon Horman (2):
  ARM: shmobile: armadillo800eva-reference: Remove early_printk from
    command line
  ARM: shmobile: kzm9g-reference: Remove early_printk from command line

 arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts | 2 +-
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.0.0.rc2

