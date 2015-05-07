From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Thu, 07 May 2015 16:10:33 +0000
Subject: [PATCH 0/4] r8a7793 pin control support
Message-Id: <1431015037-25254-1-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi!

This is the PFC portion broken out of the previously posted r8a7793 series. 
Sharing the code of the r8a7791 implementation, it is now about 6000 lines
smaller. *cough*

The one feature that was missing in the existing r8a7791 PFC implementation
is the SSP pin group, which has been moved to a separate patch in this
series.

CU
Uli


Ulrich Hecht (4):
  pinctrl: sh-pfc: Add r8a7793 support
  pinctrl: sh-pfc: Enable building of r8a7793 PFC support
  pinctrl: sh-pfc: Add renesas,pfc-r8a7793 to binding documentation
  pinctrl: sh-pfc: r8a7791/3: Add SSP pin group

 .../bindings/pinctrl/renesas,pfc-pinctrl.txt       |  3 +-
 drivers/pinctrl/sh-pfc/Kconfig                     |  5 +++
 drivers/pinctrl/sh-pfc/Makefile                    |  1 +
 drivers/pinctrl/sh-pfc/core.c                      |  6 ++++
 drivers/pinctrl/sh-pfc/core.h                      |  1 +
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c               | 41 ++++++++++++++++++++++
 6 files changed, 56 insertions(+), 1 deletion(-)

-- 
2.3.5

