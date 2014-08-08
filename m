From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 08 Aug 2014 11:48:55 +0000
Subject: [PATCH 00/02] ARM: shmobile: r8a7779 and Marzen NR_IRQS_LEGACY removal
Message-Id: <20140808114855.14647.62725.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ARM: shmobile: r8a7779 and Marzen NR_IRQS_LEGACY removal

[PATCH 01/02] ARM: shmobile: r8a7779: Remove NR_IRQS_LEGACY
[PATCH 02/02] ARM: shmobile: marzen: Remove NR_IRQS_LEGACY

Remove NR_IRQS_LEGACY from the machine vector on r8a7779 and Marzen,
completely untested but other Multiplatform SMP SoCs with GIC seem
to work well without this - and so does legacy Marzen.

The reason for this removal is that this is just legacy left over
cruft that once used to be necessary for static interrupt assignment
(I think) while we migrated to DT support for the GIC.

Not needed in case of Multiplatform and Sparse IRQ.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Written on top of renesas-devel-v3.16-20140808

 arch/arm/mach-shmobile/board-marzen-reference.c |    1 -
 arch/arm/mach-shmobile/setup-r8a7779.c          |    1 -
 2 files changed, 2 deletions(-)

