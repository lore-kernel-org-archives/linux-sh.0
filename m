From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sat, 13 Sep 2014 23:36:23 +0000
Subject: [PATCH 0/2] Add VSP1 devices to DT for r8a7790 and r8a7791
Message-Id: <1410651385-13090-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

This patch set simply adds all available VSP1 devices to the r8a7790 and
r8a7791 .dtsi.

Laurent Pinchart (2):
  ARM: shmobile: r8a7790: Add VSP1 devices to DT
  ARM: shmobile: r8a7791: Add VSP1 devices to DT

 arch/arm/boot/dts/r8a7790.dtsi | 51 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/r8a7791.dtsi | 39 ++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+)

-- 
Regards,

Laurent Pinchart

