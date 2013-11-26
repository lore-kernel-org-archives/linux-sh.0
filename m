From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 26 Nov 2013 01:21:17 +0000
Subject: [PATCH 0/2] KZM9G gpio-keys support in DT
Message-Id: <1385428879-26849-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

These two patches add support for GPIO keys support to the KZM9G DT. The
first patch adds the I2C GPIO extender to the board DT, and the second patch
the GPIO keys support.

The patches are based on top of renesas-devel-v3.13-rc1-20131125.

Laurent Pinchart (2):
  ARM: shmobile: kzm9g-reference: Add PCF8575 GPIO extender to DT
  ARM: shmobile: kzm9g-reference: Add GPIO keys to DT

 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts | 57 ++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

-- 
Regards,

Laurent Pinchart

