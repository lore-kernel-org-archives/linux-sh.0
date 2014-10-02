From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 02 Oct 2014 08:04:31 +0000
Subject: [PATCH 0/2] arm: shimobile: add HS-USB device node on r8a7790
Message-Id: <1412237073-1288-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: horms@verge.net.au, magnus.damm@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk
Cc: devicetree@vger.kernel.org, linux-usb@vger.kernel.org, linux-sh@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

 This series is based on Simon's renesas.git branch and
renesas-devel-20141002-v3.17-rc7 tag. If we use the generic phy
driver for R-Car Gen2 (drivers/phy/phy-rcar-gen2.c), we can use
the HS-USB on lager.

Yoshihiro Shimoda (2):
  arm: shimobile: r8a7790: add HS-USB device node
  arm: shmobile: lager: enable HS-USB

 arch/arm/boot/dts/r8a7790-lager.dts |    5 +++++
 arch/arm/boot/dts/r8a7790.dtsi      |   10 ++++++++++
 2 files changed, 15 insertions(+)

-- 
1.7.9.5

