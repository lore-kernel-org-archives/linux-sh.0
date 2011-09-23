From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 23 Sep 2011 05:52:34 +0000
Subject: [PATCH 00/03] ARM: mach-shmobile: sh7372 CPU sleep patches
Message-Id: <20110923055234.4013.13387.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20110630094653.10442.68817.sendpatchset@t400s>
In-Reply-To: <20110630094653.10442.68817.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ARM: mach-shmobile: sh7372 CPU sleep patches

Subject: [PATCH 01/03] ARM: mach-shmobile: sh7372 generic suspend/resume support
Subject: [PATCH 02/03] ARM: mach-shmobile: sh7372 A3SM support
Subject: [PATCH 03/03] ARM: mach-shmobile: sh7372 sleep warning fixes

These patches update the sh7372 sleep code to make use
of the generic ARM suspend/resume code and to add A3SM
sleep mode support for Suspend-to-RAM. The first two
patches have been posted earlier, and the last contain
a few warning fixes.

Fits the pm-test branch of the linux-pm git repository.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/include/mach/common.h |    6 
 arch/arm/mach-shmobile/pm-sh7372.c           |  252 ++++++++++++++++++++--
 arch/arm/mach-shmobile/sleep-sh7372.S        |  287 +++++---------------------
 3 files changed, 286 insertions(+), 259 deletions(-)
