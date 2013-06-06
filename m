From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 06 Jun 2013 15:38:10 +0000
Subject: [PATCH 0/2] ARM: shmobile: two cosmetic patches
Message-Id: <1370533092-23555-1-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This is a re-send of two earlier submitted patches, now split in smaller 
and logically grouped series.

Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Guennadi Liakhovetski (2):
  ARM: shmobile: armadillo800eva: remove left-overs
  ARM: shmobile: sh73a0: remove "0x" prefix from DT node names

 arch/arm/boot/dts/sh73a0.dtsi                  |   18 +++++++++---------
 arch/arm/mach-shmobile/board-armadillo800eva.c |    9 ---------
 2 files changed, 9 insertions(+), 18 deletions(-)

-- 
1.7.2.5

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
