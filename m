From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Tue, 28 Jan 2014 18:53:31 +0000
Subject: [PATCH RFC 0/2] ARM: shmobile: lager: Enable DMA bounce for PCI
Message-Id: <1390935213-12896-1-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This enables DMA bounce for PCI since the controller does
not support more than 2G PCI-AHB memory window.
The problems with DMA transfers can be observed when
setting 2G/2G user/kernel memory split model
(CONFIG_VMSPLIT_2G=y)
These patches help to avoid it.

The patches should be applied on top of the 
"[PATCH V3 0/3] ARM: shmobile: lager: Add USB support" series at
http://marc.info/?l=linux-sh&m9060253506760&w=2

Valentine Barshak (2):
  ARM: shmobile: lager: Use DMA bounce for PCI devices
  ARM: shmobile: lager: Increase the size of ARM corehent DMA pool

 arch/arm/boot/dts/r8a7790-lager.dts  |  2 +-
 arch/arm/mach-shmobile/Kconfig       |  2 ++
 arch/arm/mach-shmobile/board-lager.c | 38 ++++++++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+), 1 deletion(-)

-- 
1.8.3.1

