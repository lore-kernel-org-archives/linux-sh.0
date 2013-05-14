From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 14 May 2013 21:35:10 +0000
Subject: [PATCH 0/2] marzen-reference ethernet patches
Message-Id: <1368567312-11640-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

Here are two small patches that attemps to fix ethernet support for the
marzen-reference board. Unfortunately this doesn't seem to be enough, I still
can't get any meaningful interrupt from the smsc911x ethernet controller.

I'm probably not going to spend more time on this, it would be appreciated if
anyone could take over.

Laurent Pinchart (2):
  ARM: shmobile: marzen-reference: Reference the correct IRQ for
    ethernet
  ARM: shmobile: marzen-reference: Update lan device name in pinctrl
    maps

 arch/arm/boot/dts/r8a7779-marzen-reference.dts  | 4 ++--
 arch/arm/mach-shmobile/board-marzen-reference.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
Regards,

Laurent Pinchart

