From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Wed, 17 Aug 2011 18:41:48 +0000
Subject: [GIT PULL] Power management build fix for 3.1
Message-Id: <201108172041.48394.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>

Hi Linus,

Please pull a power management build fix for 3.1 from:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-fixes

This makes the new generic PM domains code build correctly
if CONFIG_PM_RUNTIME is unset.

Thanks!


 drivers/base/power/domain.c |   30 +++++++++++++++---------------
 include/linux/pm_domain.h   |   10 +++++++---
 kernel/power/Kconfig        |    4 ++++
 3 files changed, 26 insertions(+), 18 deletions(-)

---------------

Rafael J. Wysocki (1):
      PM / Domains: Fix build for CONFIG_PM_RUNTIME unset

