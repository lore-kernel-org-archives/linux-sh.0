From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 09 Feb 2015 08:23:32 +0000
Subject: [PATCH 0/2] ARM: shmobile: r8a7790: add for USB-DMAC
Message-Id: <1423470214-7140-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1386935560-16739-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1386935560-16739-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: horms@verge.net.au, magnus.damm@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk
Cc: devicetree@vger.kernel.org, linux-usb@vger.kernel.org, linux-sh@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch set is based on renesas.git / renesas-devel-20150202-v3.19-rc7
tag. (commit id = bcfb200689185c6f7c5357c832d1d8fcea80c80c)

This patch set is related to the usb-dmac driver. Now I submitted
some patches:
http://thread.gmane.org/gmane.linux.drivers.devicetree/109578/

Yoshihiro Shimoda (2):
  ARM: shmobile: r8a7790: add USB-DMAC device nodes
  ARM: shmobile: r8a7790: Enable DMA for HSUSB

 arch/arm/boot/dts/r8a7790.dtsi |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

-- 
1.7.9.5

