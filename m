From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 15 Dec 2015 13:26:34 +0000
Subject: [PATCH/RFC 00/03] ARM: shmobile: r8a7795 Salvator-X IPMMU test code
Message-Id: <20151215132634.15356.29848.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ARM: shmobile: r8a7795 Salvator-X IPMMU test code

[PATCH/RFC 01/03] ARM: shmobile: External Salvator-X SCIF3/HSCIF3 loop
[PATCH/RFC 02/03] ARM: shmobile: r8a7795: Hack up SYS-DMAC0 support
[PATCH/RFC 03/03] ARM: shmobile: r8a7795: Tie in IPMMU with SYS-DMAC0

Hook up the external SCIF3/HSCIF3 loop back adapter via DT and tie
in SYS-DMAC0 and the IPMMU units for test purpose.

Not for upstream merge.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Developed on top of renesas-drivers-2015-12-08-v4.4-rc4 and
 [PATCH 00/06] iommu/ipmmu-vmsa: IPMMU multi-arch update
 [PATCH/RFC 00/10] iommu/ipmmu-vmsa: Experimental r8a7795 support

 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |   28 ++++++++++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           |   54 +++++++++++++++++++-
 2 files changed, 81 insertions(+), 1 deletion(-)
