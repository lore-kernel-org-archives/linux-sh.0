From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 10 Sep 2014 10:33:27 +0000
Subject: [PATCH 0/4] usb: renesas_usbhs: fixes this driver in gadget mode (part2)
Message-Id: <541028F7.4050405@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <53F725E3.4050304@renesas.com>
In-Reply-To: <53F725E3.4050304@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

If we tested this driver as gadget, some issues below happened:
 - Oops happened if g_audio.
 - A usb enumeration may fail if we do insmod during connected the usb cable.
 - A transaction will not finish if g_zero.
 - A usb enumeration may fail after we re-connected the usb cable.

This patch serias fixes them.
This patch serias is based on Felipe's usb.git, testing/fixes branch.
(commit id: 0b93a4c838fa10370d72f86fe712426ac63804de)

Yoshihiro Shimoda (4):
  usb: renesas_usbhs: gadget: fix NULL pointer dereference in
    ep_disable()
  usb: renesas_usbhs: gadget: fix the behavior of pullup
  usb: renesas_usbhs: fix the timing of dcp_control_transfer_done
  usb: renesas_usbhs: fix usbhs_pipe_clear() for DCP PIPE

 drivers/usb/renesas_usbhs/common.c     |    6 ++++--
 drivers/usb/renesas_usbhs/fifo.c       |   34 ++++++++++++++++---------------
 drivers/usb/renesas_usbhs/fifo.h       |    1 +
 drivers/usb/renesas_usbhs/mod_gadget.c |   35 ++++++++++++++++++++++++++++++--
 drivers/usb/renesas_usbhs/mod_host.c   |    2 +-
 drivers/usb/renesas_usbhs/pipe.c       |    8 ++++++--
 6 files changed, 63 insertions(+), 23 deletions(-)

-- 
1.7.9.5

