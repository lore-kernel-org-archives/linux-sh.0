From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 27 Aug 2014 00:35:21 +0000
Subject: [PATCH v2 0/5] ARM: shmobile: correct memory maps
Message-Id: <1409099726-21814-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This short series builds on a previous posting
of a patch to correct the value of the second memory region
of the lager. It does that and also corrects the syntax
used for the lager and other shmobile boards.

Simon Horman (5):
  ARM: shmobile: lager: correct memory map value and syntax
  ARM: shmobile: henninger: correct memory map syntax
  ARM: shmobile: koelsch: correct memory map syntax
  ARM: shmobile: ape6evm-reference: correct memory map syntax
  ARM: shmobile: ape6evm: correct memory map syntax

 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts | 2 +-
 arch/arm/boot/dts/r8a73a4-ape6evm.dts           | 2 +-
 arch/arm/boot/dts/r8a7790-lager.dts             | 2 +-
 arch/arm/boot/dts/r8a7791-henninger.dts         | 2 +-
 arch/arm/boot/dts/r8a7791-koelsch.dts           | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.0.1

