From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 07 Oct 2014 11:11:13 +0000
Subject: [PATCH v2 0/3] arm: shimobile: add HS-USB device node on r8a7791
Message-Id: <1412680276-3344-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>

 This series is based on Simon's renesas.git branch and
renesas-devel-20141007-v3.17 tag. If we use the generic phy
driver for R-Car Gen2 (drivers/phy/phy-rcar-gen2.c), we can use
the HS-USB on koelsch and henninger.

Changes from v1:
 - Correct typo of git log in patch 1.
 - Change the placement of hsusb node in patch 1.
 - Fix the gpio prop in patch 2.
 - Fix the gpio prop in patch 3.

Yoshihiro Shimoda (3):
  arm: shmobile: r8a7791: add HS-USB device node
  arm: shmobile: koelsch: enable HS-USB
  arm: shmobile: henninger: enable HS-USB

 arch/arm/boot/dts/r8a7791-henninger.dts |    5 +++++
 arch/arm/boot/dts/r8a7791-koelsch.dts   |    5 +++++
 arch/arm/boot/dts/r8a7791.dtsi          |   11 +++++++++++
 3 files changed, 21 insertions(+)

-- 
1.7.9.5

