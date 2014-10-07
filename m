From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 07 Oct 2014 11:10:18 +0000
Subject: [PATCH v2 0/2] arm: shimobile: add HS-USB device node on r8a7790
Message-Id: <1412680220-4552-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>

 This series is based on Simon's renesas.git branch and
renesas-devel-20141007-v3.17 tag. If we use the generic phy
driver for R-Car Gen2 (drivers/phy/phy-rcar-gen2.c), we can use
the HS-USB on lager.

Changes from v1:
 - Correct typo of git log in patch 1.
 - Change the placement of hsusb node in patch 1.
 - Add git log comment in patch 2.
 - Fix the gpio prop in patch 2.

Yoshihiro Shimoda (2):
  arm: shmobile: r8a7790: add HS-USB device node
  arm: shmobile: lager: enable HS-USB

 arch/arm/boot/dts/r8a7790-lager.dts |    5 +++++
 arch/arm/boot/dts/r8a7790.dtsi      |   11 +++++++++++
 2 files changed, 16 insertions(+)

-- 
1.7.9.5

