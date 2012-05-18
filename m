From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Fri, 18 May 2012 21:44:59 +0000
Subject: [GIT PULL] Renesas sh73a0 fix for v3.5
Message-Id: <201205182344.59703.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

Please pull changes since commit d48b97b403d23f6df0b990cee652bdf9a52337a3

    Linux 3.4-rc6

with top-most commit 4da773193414788b52ae14bc246543390faca5ce

    ARM: mach-shmobile: sh73a0: fixup PINT/IRQ16-IRQ31 irq number conflict

from the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/renesas.git soc-core

to receive an sh73a0 fix related to the allocation of IRQs for v3.5.

This is based on material that has been merged into the arm-soc tree already.

Thanks!


 arch/arm/mach-shmobile/include/mach/sh73a0.h |   34 +++++++++++++++++++++++--
 1 files changed, 31 insertions(+), 3 deletions(-)

---------------

Kuninori Morimoto (1):
      ARM: mach-shmobile: sh73a0: fixup PINT/IRQ16-IRQ31 irq number conflict

