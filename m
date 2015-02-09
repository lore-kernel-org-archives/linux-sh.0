From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 09 Feb 2015 08:24:37 +0000
Subject: [PATCH 0/2] ARM: shmobile: r8a7790: add for USB-DMAC
Message-Id: <1423470279-6340-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1386935560-16739-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1386935560-16739-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>

This patch set is based on renesas.git / renesas-devel-20150202-v3.19-rc7
tag. (commit id = bcfb200689185c6f7c5357c832d1d8fcea80c80c)

This patch set is related to the usb-dmac driver. Now I submitted
some patches:
http://thread.gmane.org/gmane.linux.drivers.devicetree/109578/

Yoshihiro Shimoda (2):
  ARM: shmobile: r8a7791: add USB-DMAC device nodes
  ARM: shmobile: r8a7791: Enable DMA for HSUSB

 arch/arm/boot/dts/r8a7791.dtsi |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

-- 
1.7.9.5

