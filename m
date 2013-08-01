From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 01 Aug 2013 07:41:18 +0000
Subject: [PATCH v4 0/3] ARM: shmobile: ape6evm: MMCIF, SDHI and their regulators
Message-Id: <1375342881-2155-1-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

3 Patches to add MMCIF and SDHI support or their supply voltages to APE6EVM 
in legacy C- and DT-modes.

I pushed all versions to v4, since in the previous submission patch 3/3 was 
at v3 and it's better to unify all versions.

Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Guennadi Liakhovetski (3):
  ARM: shmobile: ape6evm: add "__initconst" annotations where needed
  ARM: shmobile: ape6evm: update MMC0, SDHI0 and SDHI1 with correct
    regulators
  ARM: shmobile: ape6evm-reference: add MMCIF and SDHI DT nodes

 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts |   72 +++++++++++++++++++++++
 arch/arm/mach-shmobile/board-ape6evm.c          |   72 +++++++++++++++++-----
 2 files changed, 127 insertions(+), 17 deletions(-)

-- 
1.7.2.5

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
