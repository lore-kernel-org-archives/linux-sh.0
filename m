From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 24 Oct 2014 10:44:32 +0000
Subject: [PATCH v5 0/2] Add HS-USB device tree support for R8A7790/Lager board
Message-Id: <1414147474-2348-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: horms@verge.net.au, sergei.shtylyov@cogentembedded.com, magnus.damm@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk
Cc: devicetree@vger.kernel.org, linux-usb@vger.kernel.org, linux-sh@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Here's the set of 2 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-20141024-v3.18-rc1' tag. Here we add the HS-USB device tree
support on the R8A7790/Lager reference board. The patchset requires the USB PHY
driver (already merged by Kishon and Greg) and the generic PHY support patches
for the HS-USB driver posted by Yoshihiro Shimoda in order to work...

Changes from v4:
 - rebase the repository.

Yoshihiro Shimoda (2):
  ARM: shmobile: r8a7790: add HS-USB device node
  ARM: shmobile: lager: enable HS-USB

 arch/arm/boot/dts/r8a7790-lager.dts |   12 ++++++++++++
 arch/arm/boot/dts/r8a7790.dtsi      |   11 +++++++++++
 2 files changed, 23 insertions(+)

-- 
1.7.9.5

