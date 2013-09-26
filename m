From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 26 Sep 2013 17:30:01 +0000
Subject: [PATCH v6 0/2] ARM: shmobile: r8a73a4: add a DMAC platform device and clock for it
Message-Id: <1380216603-14645-1-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This is a split of a former single patch, as requested by Magnus. No other changes.

Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Guennadi Liakhovetski (2):
  ARM: shmobile: r8a73a4: add a clock alias for the DMAC in DT mode
  ARM: shmobile: r8a73a4: add a DT node for the DMAC

 arch/arm/boot/dts/r8a73a4.dtsi         |   43 ++++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/clock-r8a73a4.c |    1 +
 2 files changed, 44 insertions(+), 0 deletions(-)

-- 
1.7.2.5

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
