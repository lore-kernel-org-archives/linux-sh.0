From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 29 Mar 2013 21:05:47 +0000
Subject: [PATCH v3 0/5] ARM: shmobile: mackerel: streamline SD and MMC devices
Message-Id: <1364591152-4780-1-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch series is a split of a previous monolithic patch with no changes
of the content.

Guennadi Liakhovetski (5):
  ARM: shmobile: mackerel: SDHI resources do not have to be numbered
  ARM: shmobile: mackerel: remove OCR masks, where regulators are used
  ARM: shmobile: mackerel: switch SDHI and MMCIF interfaces to
    slot-gpio
  ARM: shmobile: mackerel: add interrupt names for SDHI0
  ARM: shmobile: mackerel: clean up MMCIF vs. SDHI1 selection

 arch/arm/mach-shmobile/board-mackerel.c |  111 +++++++++++--------------------
 1 files changed, 40 insertions(+), 71 deletions(-)

-- 
1.7.2.5

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
