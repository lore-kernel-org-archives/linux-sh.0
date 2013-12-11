From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 11 Dec 2013 02:48:14 +0000
Subject: [PATCH 0/4] Fix backlight on Armadillo 800 EVA
Message-Id: <1386730098-26641-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

Commit 22ceeee16eb8f0d04de3ef43a5174fb30ec18af9 ("pwm-backlight: Add power
supply support") added a mandatory power supply for the PWM backlight,
resulting in broken backlight on the Armadillo board. This patch set fixes the
issue by adding power supplies to board code and DT, and adds proper handling
of the panel enable signal through the PWM backlight enable GPIO.

Patch 1/4 fixes a v3.13 regression. Strictly speaking patch 3/4 is as well,
but the backlight was broken anyway with DT due to the enable GPIO not being
handled at all, so there's no need to push it to v3.13.

Laurent Pinchart (4):
  ARM: shmobile: armadillo: Add PWM backlight power supply
  ARM: shmobile: armadillo: Set backlight enable GPIO
  ARM: shmobile: armadillo: dts: Add PWM backlight power supply
  ARM: shmobile: armadillo: dts: Add PWM backlight enable GPIO

 arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts | 11 +++++++++++
 arch/arm/mach-shmobile/board-armadillo800eva.c          | 12 ++++++++----
 2 files changed, 19 insertions(+), 4 deletions(-)

-- 
Regards,

Laurent Pinchart

