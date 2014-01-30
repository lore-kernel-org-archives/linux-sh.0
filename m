From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Thu, 30 Jan 2014 00:55:04 +0000
Subject: [PATCH 0/10] ARM: shmobile: enable CONFIG_DEVTMPFS in defconfig
Message-Id: <87lhxyi90a.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

These patches enable DEVTMPFS for all Renesas board
on defconfig

Kuninori Morimoto (10):
      ARM: shmobile: marzen: enable CONFIG_DEVTMPFS in defconfig
      ARM: shmobile: mackerel: enable CONFIG_DEVTMPFS in defconfig
      ARM: shmobile: lager: enable CONFIG_DEVTMPFS in defconfig
      ARM: shmobile: kzm9g: enable CONFIG_DEVTMPFS in defconfig
      ARM: shmobile: kzm9d: enable CONFIG_DEVTMPFS in defconfig
      ARM: shmobile: koelsch: enable CONFIG_DEVTMPFS in defconfig
      ARM: shmobile: genmai: enable CONFIG_DEVTMPFS in defconfig
      ARM: shmobile: bockw: enable CONFIG_DEVTMPFS in defconfig
      ARM: shmobile: armadillo: enable CONFIG_DEVTMPFS in defconfig
      ARM: shmobile: ape6evm: enable CONFIG_DEVTMPFS in defconfig

 arch/arm/configs/ape6evm_defconfig         |    2 ++
 arch/arm/configs/armadillo800eva_defconfig |    2 ++
 arch/arm/configs/bockw_defconfig           |    2 ++
 arch/arm/configs/genmai_defconfig          |    2 ++
 arch/arm/configs/koelsch_defconfig         |    2 ++
 arch/arm/configs/kzm9d_defconfig           |    2 ++
 arch/arm/configs/kzm9g_defconfig           |    2 ++
 arch/arm/configs/lager_defconfig           |    2 ++
 arch/arm/configs/mackerel_defconfig        |    2 ++
 arch/arm/configs/marzen_defconfig          |    2 ++
 10 files changed, 20 insertions(+)

Best regards
---
Kuninori Morimoto
