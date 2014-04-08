From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 08 Apr 2014 12:47:58 +0000
Subject: [PATCH 00/02] ARM: shmobile: r8a7790 8-core boot prototype
Message-Id: <20140408124758.9773.14458.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ARM: shmobile: r8a7790 8-core boot prototype

[PATCH 01/02] ARM: shmobile: Multicluster APMU prototype support
[PATCH 02/02] ARM: shmobile: r8a7790 CCI configuration

Prototype patches to allow 8-core boot on r8a7790. The first patch
unlocks multicluster support to allo SMP boot of all CPU cores, and
the second initializes the CCI-400 hardware.

Not for upstream merge.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Applies on top of renesas-devel-v3.14-20140408

 arch/arm/mach-shmobile/platsmp-apmu.c |   16 ++++++++++++++--
 arch/arm/mach-shmobile/smp-r8a7790.c  |   15 +++++++++++++++
 2 files changed, 29 insertions(+), 2 deletions(-)
