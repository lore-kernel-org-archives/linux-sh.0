From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 25 Dec 2015 11:52:35 +0000
Subject: [PATCH v2 0/6] arm64: renesas: add USB 2.0 device nodes for r8a7795
Message-Id: <1451044361-5896-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: horms@verge.net.au, magnus.damm@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch set is based on the renesas.git / 20151221renesas-devel-20151221-v4.4-rc6 tag.
(commit id = fe0e8e675dedf1877709a17258e88151c2614b77)

Changed from v1:
 - Fix register size from 0xff to 0x100 in patch 2

Yoshihiro Shimoda (6):
  arm64: renesas: r8a7795: add usb2_phy device nodes
  arm64: renesas: r8a7795: add USB2.0 Host (EHCI/OHCI) device nodes
  arm64: renesas: r8a7795: add HS-USB device node
  arm64: renesas: salvator-x: enable usb2_phy
  arm64: renesas: salvator-x: enable USB 2.0 Host channel 1 and 2
  arm64: renesas: salvator-x: enable HS-USB

 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |  54 +++++++++-
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 113 +++++++++++++++++++++
 2 files changed, 166 insertions(+), 1 deletion(-)

-- 
1.9.1

