From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 07 Jul 2011 13:32:12 +0000
Subject: [PATCH 00/05] ARM: mach-shmobile: another sh7372 power domain update
Message-Id: <20110707133212.22347.68775.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ARM: mach-shmobile: another sh7372 power domain update

[PATCH 01/05] ARM: mach-shmobile: sh7372 D4 support
[PATCH 02/05] ARM: mach-shmobile: Runtime PM late init callback
[PATCH 03/05] ARM: mach-shmobile: sh7372 late pm domain off
[PATCH 04/05] PM: export pm_genpd_poweron() in header
[PATCH 05/05] ARM: mach-shmobile: sh7372 A3RV requires A4LC

These patches update the partial hardware power domain support
included in the pm-domains branch of the suspend-2.6 git tree.

With these patches applied the unused sh7372 hardware power domains
are powered down during kernel boot. This is currently handled
by the SoC-specific code, but I believe this is something that
can be shared on a framework leve. Until that happens we need some
way to turn off the unused power domains, so here it is.

Included is also code that fixes A3RV support by making sure A4LC
is on whenever A3RV is turned on. This issue started triggering
when "[PATCH 03/05] ARM: mach-shmobile: sh7372 late pm domain off"
got applied and A4LC was turned off automatically.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Applies to the suspend-2.6 git pm-domains branch on top of
 the following acked patches:
 "[PATCH 1/2] ARM: mach-shmobile: sh7372: make sure that fsi is peripheral of spu2"
 "[PATCH 2/2 v2] ARM: mach-shmobile: sh7372 A4MP support"

 arch/arm/mach-shmobile/include/mach/common.h |    1 
 arch/arm/mach-shmobile/include/mach/sh7372.h |    1 
 arch/arm/mach-shmobile/pm-sh7372.c           |   62 ++++++++++++++++++++++++--
 arch/arm/mach-shmobile/pm_runtime.c          |   10 ++++
 arch/arm/mach-shmobile/setup-sh7372.c        |    1 
 drivers/base/power/domain.c                  |    2 
 include/linux/pm_domain.h                    |    5 ++
 7 files changed, 78 insertions(+), 4 deletions(-)
