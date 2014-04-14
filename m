From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 14 Apr 2014 10:58:27 +0000
Subject: [PATCH 00/02] ARM: shmobile: Lager and Koelsch VSP1 prototype patches
Message-Id: <20140414105827.12530.49731.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ARM: shmobile: Lager and Koelsch VSP1 prototype patches

[PATCH 01/02] ARM: shmobile: lager: DT reference VSP1 platform devices
[PATCH 02/02] ARM: shmobile: koelsch: DT reference VSP1 platform devices

These patches enable VSP1 functionality for the DT reference
board support for Lager and Koelsch. With these in place it is
possible to use a single kernel binary with CCF and MULTIPLATFORM
on Lager or Koelsch and use VSP1 even though DT bindings are not
yet merged for that particular driver.

This is intended as a short term prototype to show that VSP1
can be used on R-Car Gen2 hardware such as Lager and Koelsch
even though DT bindings are not yet in place.

Not for upstream merge.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas-devel-v3.15-rc1-20140414v2 and
 [PATCH v2 00/05] ARM: shmobile: Lager and Koelsch USB prototype patches

 arch/arm/mach-shmobile/board-koelsch-reference.c |   74 ++++++++++++++++++
 arch/arm/mach-shmobile/board-lager-reference.c   |   88 ++++++++++++++++++++++
 2 files changed, 162 insertions(+)
