From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 19 Feb 2015 01:42:07 +0000
Subject: [PATCH 00/03] ARM: shmobile: 64-bit DU/VSP build prototype
Message-Id: <20150219014207.1795.54467.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ARM: shmobile: 64-bit DU/VSP build prototype

[PATCH 01/03] ARM: shmobile: Hack x86_64 to enable OF by default
[PATCH 02/03] ARM: shmobile: Adjust x86_64 defconfig to include DU/VSP1
[PATCH 03/03] ARM: shmobile: Adjust arm64 defconfig to include DU/VSP1

This series contains prototype code and defconfig changes that allow
the DU and VSP drivers to be built on x86_64 and arm64.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Built on top of renesas-devel-20150215-v3.19. Not for upstream merge.

 arch/arm64/configs/defconfig      |   15 ++++++++++++--
 arch/x86/Kconfig                  |    1 
 arch/x86/configs/x86_64_defconfig |   39 ++++++++++++++++++-------------------
 arch/x86/kernel/devicetree.c      |    2 +
 4 files changed, 36 insertions(+), 21 deletions(-)
 
