From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 26 Feb 2015 09:21:20 +0000
Subject: [PATCH 0/3] [RESEND] Add DU external pixel clocks to DT
Message-Id: <1424942483-10910-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

These three patches add the DU external pixel clocks to DT for the Marzen,
Lager and Koelsch boards. They have been posted previously, and now that the
corresponding DT bindings have been accepted and appeared in v4.0-rc1, they
can be merged.

Laurent Pinchart (3):
  ARM: shmobile: marzen: Add DU external pixel clock to DT
  ARM: shmobile: lager: Add DU external pixel clocks to DT
  ARM: shmobile: koelsch: Add DU external pixel clocks to DT

 arch/arm/boot/dts/r8a7779-marzen.dts  |  9 +++++++++
 arch/arm/boot/dts/r8a7790-lager.dts   | 21 +++++++++++++++++++++
 arch/arm/boot/dts/r8a7791-koelsch.dts | 19 +++++++++++++++++++
 3 files changed, 49 insertions(+)

-- 
Regards,

Laurent Pinchart

