From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 25 Nov 2009 08:12:35 +0000
Subject: [PATCH 00/02] clocksource: SuperH CMT driver resume changes
Message-Id: <20091125081235.25416.32481.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, linux-sh@vger.kernel.org, johnstul@us.ibm.com, lethal@linux-sh.org, Magnus Damm <magnus.damm@gmail.com>, tglx@linutronix.de

clocksource: SuperH CMT driver resume changes

[PATCH 01/02] clocksource: Add argument to resume callback
[PATCH 02/02] clocksource: Start CMT at clocksource resume

These patches modify the clocksource code so the CMT
driver can be resumed properly. Trivial stuff, but may
cause slight breakage if I managed to miss any clocksource
drivers that use the resume callback.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/ia64/kernel/time.c      |    4 ++--
 arch/x86/kernel/hpet.c       |    4 ++--
 arch/x86/kernel/tsc.c        |    4 ++--
 drivers/clocksource/sh_cmt.c |   16 ++++++++++++++++
 include/linux/clocksource.h  |    4 ++--
 kernel/time/clocksource.c    |    4 ++--
 6 files changed, 26 insertions(+), 10 deletions(-)
