From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 16 Dec 2014 09:39:21 +0000
Subject: [PATCH 00/02] r8a7779 TWD update
Message-Id: <20141216093921.14252.42200.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

r8a7779 TWD update

[PATCH 01/02] ARM: shmobile: r8a7779: No TWD setup in C for Multiplatform
[PATCH 02/02] ARM: shmobile: r8a7779: Add TWD device to DTS

These patches fix up r8a7779 TWD support in case of Multiplatform.
With these in place we are one step closer to r8a7779 SMP support.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Built on top of renesas-devel-20141216v2-v3.18
 No special dependencies

 arch/arm/boot/dts/r8a7779.dtsi       |    9 +++++++++
 arch/arm/mach-shmobile/smp-r8a7779.c |    2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)
