From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 21 May 2015 10:57:24 +0000
Subject: [PATCH v4 0/2] pwm: Add support for R-Car PWM Timer
Message-Id: <1432205846-4312-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: thierry.reding@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org
Cc: linux-pwm@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch set is based on the linux-pwm.git / for-next branch.
(commit id = efb0de55b6a2ec15fc424e660601f22ae2fa487a)

Changes from v3:
 - Fix register size in patch 1.
 - Add "Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>" in patch 1
 - Remove an unnecessary definition in patch 2.
 - Use "ULL" to avoid overflow in patch 2.
 - Remove unnecessary casts in patch 2.

Changes from v2:
 - Add compatible string "renesas,pwm-rcar".
 - Remove compatible strings "renesas,pwm-r8a77xx" in rcar_pwm_of_table.
 - Fix build error.

Changes from v1:
 - Change compatible string to SoC-specific compatible values.
 - Fix #pwm-call value to 2 in the device tree document.
 - Fix "depends on" value in Kconfig.
 - Fix help explanation in Kconfig.
 - Remove an unnecessary member in rcar_pwm_chip.
 - Remove hardcoded number of channels and change chip.npwm value to 1.
 - Fix formulas for clock calculation to improve accuracy.

Yoshihiro Shimoda (2):
  pwm: Add device tree binding document for R-Car PWM Timer
  pwm: Add support for R-Car PWM Timer

 .../devicetree/bindings/pwm/renesas,pwm-rcar.txt   |  27 +++
 drivers/pwm/Kconfig                                |  11 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-rcar.c                             | 261 +++++++++++++++++++++
 4 files changed, 300 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
 create mode 100644 drivers/pwm/pwm-rcar.c

-- 
1.9.1

