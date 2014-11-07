From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 07 Nov 2014 10:11:39 +0000
Subject: [PATCH 0/5] i2c: sh_mobile: add DMA support
Message-Id: <1415355104-2031-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>

Here is v1 of the patch series to support DMA with the i2c-sh_mobile core. DMA
works nicely with my tests so far and we save 1 interrupt per transferred byte,
yay! DMA is opt-in, so if setting it up fails, we will fall back to PIO. The
threshold for selecting DMA is still under test, but probably good enough
already. Since the RFC, I learned about dma_request_slave_channel_reason() and
deferred probing with DMA channels, so the major show stopper is gone now and
this should be ready for inclusion IMO. The other open issues (best threshold
value, ensure DMA capable buffers) can later be done incrementally.

Please test, review, comment. The series is based on
renesas-devel-20141030-v3.18-rc2 with Laurent's series "[PATCH v4 0/5] R-Car
Gen2 DMA Controller driver" on top of it. A git tree can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/i2c-shmobile-dma-experimental

Thanks to Geert and Laurent for reviewing the RFC!

   Wolfram

Wolfram Sang (5):
  i2c: sh_mobile: sort includes alphabetically
  i2c: sh_mobile: add DMA support
  i2c: sh_mobile: improve success message
  ARM: shmobile: r8a7790: add DMA nodes for IIC
  ARM: shmobile: r8a7791: add DMA nodes for IIC

 .../devicetree/bindings/i2c/i2c-sh_mobile.txt      |   5 +
 arch/arm/boot/dts/r8a7790.dtsi                     |   8 +
 arch/arm/boot/dts/r8a7791.dtsi                     |   6 +
 drivers/i2c/busses/i2c-sh_mobile.c                 | 219 ++++++++++++++++++---
 4 files changed, 216 insertions(+), 22 deletions(-)

-- 
2.1.1

