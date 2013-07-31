From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 31 Jul 2013 12:40:13 +0000
Subject: [PATCH 0/3] ARM: shmobile: ape6evm: MMCIF, SDHI and their regulators
Message-Id: <1375274416-23455-1-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The first patch moves several data blocks to a read-only .init section on 
ape6evm. The other two add MMCIF and SDHI DT nodes on ape6evm-reference 
and update existing regulators on ape6evm.

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
