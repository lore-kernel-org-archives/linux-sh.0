From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 24 Oct 2014 10:45:05 +0000
Subject: [PATCH v4 0/3] HS-USB device tree support for R8A7791/Koelsch/Henninger board
Message-Id: <1414147508-5556-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: horms@verge.net.au, sergei.shtylyov@cogentembedded.com, magnus.damm@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk
Cc: devicetree@vger.kernel.org, linux-usb@vger.kernel.org, linux-sh@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

   Here's the set of 3 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-20141024-v3.18-rc1' tag. Here we add the HS-USB device tree
support on the R8A7791/Koelsch/Henninger reference boards. The patchset
requires the USB PHY driver (already merged by Kishon and Greg) and the
generic PHY support patches for the HS-USB driver posted by Yoshihiro Shimoda
in order to work...

Changes from v3:
 - rebase the repository.

Yoshihiro Shimoda (3):
  ARM: shmobile: r8a7791: add HS-USB device node
  ARM: shmobile: koelsch: enable HS-USB
  ARM: shmobile: henninger: enable HS-USB

 arch/arm/boot/dts/r8a7791-henninger.dts |    7 +++++++
 arch/arm/boot/dts/r8a7791-koelsch.dts   |    7 +++++++
 arch/arm/boot/dts/r8a7791.dtsi          |   11 +++++++++++
 3 files changed, 25 insertions(+)

-- 
1.7.9.5

