From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 17 Nov 2015 04:30:47 +0000
Subject: [PATCH 00/04] ARM: shmobile: IPMMU compat string SoC part number update
Message-Id: <20151117043047.4521.84234.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ARM: shmobile: IPMMU compat string SoC part number update

[PATCH 01/04] ARM: shmobile: r8a7790: IPMMU compat string SoC part number update
[PATCH 02/04] ARM: shmobile: r8a7791: IPMMU compat string SoC part number update
[PATCH 03/04] ARM: shmobile: r8a7793: IPMMU compat string SoC part number update
[PATCH 04/04] ARM: shmobile: r8a7794: IPMMU compat string SoC part number update

Update R-Car Gen2 DT compat strings for IPMMU devices to follow the updated
DT binding documentation included in:
"[PATCH v2] iommu/ipmmu-vmsa: Include SoC part number in DT binding docs"

With this compat string change we may in the future add SoC-specific features
such as IPMMU performance counters that only exist on some SoCs.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Written on top of "renesas-devel-20151113-v4.3" together with
 "[PATCH v2 00/03] ARM: shmobile: r8a7794 ALT board DU VGA port enablement V2"
 "[PATCH] ARM: shmobile: r8a7794: alt: Enable PFC DU for the VGA port"
 "[PATCH 01/02] ARM: shmobile: r8a7793: Add DU node to device tree"
 "[PATCH] ARM: shmobile: r8a7793: Add GPIO nodes to device tree"

 arch/arm/boot/dts/r8a7790.dtsi |   12 ++++++------
 arch/arm/boot/dts/r8a7791.dtsi |   14 +++++++-------
 arch/arm/boot/dts/r8a7793.dtsi |   14 +++++++-------
 arch/arm/boot/dts/r8a7794.dtsi |   12 ++++++------
 4 files changed, 26 insertions(+), 26 deletions(-)
