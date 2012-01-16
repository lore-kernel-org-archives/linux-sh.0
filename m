From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Mon, 16 Jan 2012 19:28:52 +0000
Subject: [GIT PULL] Power management fixes and additional updates for 3.3
Message-Id: <201201162028.52945.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Linus,

Please pull power management fixes and additional updates (on top of commit
96e80a7851b44f3decaac0625665cd64e550b71d) for 3.3 from:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-for-linus

with top-most commit ee34a37049114303011e154478c63b977bcff24c
(PM / Hibernate: Drop the check of swap space size for compressed image).

They include:

* Build fixes for generic PM domains.

* A3SP power domain suspend fix from Guennadi Liakhovetski.

* Fix for a regression that made sysrq-o unavailable for CONFIG_PM unset.

* Hibernate modification dropping swap size check for compressed images.

Thanks!


 arch/arm/mach-shmobile/pm-sh7372.c   |    2 +-
 drivers/base/power/domain.c          |   15 +++++++++++++++
 drivers/base/power/domain_governor.c |   24 +++++++++++++++++++-----
 kernel/Makefile                      |    3 +--
 kernel/power/swap.c                  |   13 +++++++------
 5 files changed, 43 insertions(+), 14 deletions(-)

---------------

Barry Song (1):
      PM / Hibernate: Drop the check of swap space size for compressed image

Guennadi Liakhovetski (1):
      PM / shmobile: fix A3SP suspend method

Rafael J. Wysocki (3):
      PM: Make sysrq-o be available for CONFIG_PM unset
      PM / Domains: Fix build for CONFIG_PM_SLEEP unset
      PM / Domains: Skip governor functions for CONFIG_PM_RUNTIME unset

