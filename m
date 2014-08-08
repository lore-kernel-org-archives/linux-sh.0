From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Fri, 08 Aug 2014 14:23:07 +0000
Subject: [PATCH v2 0/5] ARM: shmobile: r8a7740: add clocks to DT
Message-Id: <1407507792-8121-1-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: horms@verge.net.au
Cc: linux-sh@vger.kernel.org, mturquette@linaro.org, devicetree@vger.kernel.org, magnus.damm@gmail.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Hi!

Here's the r8a7740 DT clock patch(es) with the changes requested by Simon
and Magnus as specified below.  Enjoy!

changes since v1:
- split up into separate patches
- added MSTP clock assignments

CU Uli


Ulrich Hecht (5):
  ARM: shmobile: r8a7740: document MSTP clock support
  ARM: shmobile: r8a7740: clock register bits
  ARM: shmobile: r8a7740: add SoC clocks to DTS
  ARM: shmobile: r8a7740: add MSTP clock assignments to DT
  ARM: shmobile: armadillo800eva-reference: add clock overrides to DTS

 .../bindings/clock/renesas,cpg-mstp-clocks.txt     |   1 +
 .../boot/dts/r8a7740-armadillo800eva-reference.dts |  13 ++
 arch/arm/boot/dts/r8a7740.dtsi                     | 208 ++++++++++++++++++++-
 include/dt-bindings/clock/r8a7740-clock.h          |  77 ++++++++
 4 files changed, 298 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/clock/r8a7740-clock.h

-- 
1.8.4.5

