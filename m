From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Tue, 12 May 2015 09:13:18 +0000
Subject: [PATCH v2 0/3] r8a7793 pin control support
Message-Id: <1431422001-530-1-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi!

This is identical to v1, but drops the non-essential SSP pin group and adds
Geert's and Laurent's acks.

CU
Uli

Changes since v1:
- added acks
- dropped SSP pin group


Ulrich Hecht (3):
  pinctrl: sh-pfc: Add r8a7793 support
  pinctrl: sh-pfc: Enable building of r8a7793 PFC support
  pinctrl: sh-pfc: Add renesas,pfc-r8a7793 to binding documentation

 .../bindings/pinctrl/renesas,pfc-pinctrl.txt       |  3 ++-
 drivers/pinctrl/sh-pfc/Kconfig                     |  5 +++++
 drivers/pinctrl/sh-pfc/Makefile                    |  1 +
 drivers/pinctrl/sh-pfc/core.c                      |  6 ++++++
 drivers/pinctrl/sh-pfc/core.h                      |  1 +
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c               | 23 ++++++++++++++++++++++
 6 files changed, 38 insertions(+), 1 deletion(-)

-- 
2.3.5

