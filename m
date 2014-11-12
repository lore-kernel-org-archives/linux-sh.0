From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 12 Nov 2014 08:59:33 +0000
Subject: [PATCH 0/4] ARM: shmobile: Use keyboard as gpio-keys node name
Message-Id: <1415782777-4729-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

this trivial series updates shmobile dts files to use use keyboard as the
gpio-keys node name. This appears to be the best match for ePAPR.

Simon Horman (4):
  ARM: shmobile: armadillo800eva: Use keyboard as gpio-keys node name
  ARM: shmobile: lager: Use keyboard as gpio-keys node name
  ARM: shmobile: koelsch: Use keyboard as gpio-keys node name
  ARM: shmobile: kzm9g-reference: Use keyboard as gpio-keys node name

 arch/arm/boot/dts/r8a7740-armadillo800eva.dts | 2 +-
 arch/arm/boot/dts/r8a7790-lager.dts           | 2 +-
 arch/arm/boot/dts/r8a7791-koelsch.dts         | 2 +-
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.1.1

