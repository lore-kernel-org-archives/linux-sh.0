From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 31 Oct 2014 04:20:07 +0000
Subject: [PATCH v5 0/4] usb: renesas_usbhs: fixes this driver in gadget mode (part2)
Message-Id: <1414729211-3276-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
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
This patch serias is based on Felipe's usb.git / testing/fixes branch.
(commit id: 9f2104db129512fd2ee086c8a616d296d1afbb75)

Changes from v4:
 - Add "Fixes:" and version info for "Cc: stable@vger.kernel.org" in patch 1.

Changes from v3:
 - Change redundant condtion in patch 1.

Changes from v2:
 - Use USBHSG_STATUS_ instead of a new variable in patch 2.

Changes from v1:
 - Rebase this patch serias for the latest testing/fixes branch.
 - Add "From:" in patch 1 and 2.
 - Add "Cc: <stable@vger.kernel.org>" in patch 1.

Yoshihiro Shimoda (4):
  usb: renesas_usbhs: gadget: fix NULL pointer dereference in
    ep_disable()
  usb: renesas_usbhs: gadget: fix the behavior of pullup
  usb: renesas_usbhs: fix the timing of dcp_control_transfer_done
  usb: renesas_usbhs: fix usbhs_pipe_clear() for DCP PIPE

 drivers/usb/renesas_usbhs/common.c     |    6 +++--
 drivers/usb/renesas_usbhs/fifo.c       |   34 ++++++++++++++--------------
 drivers/usb/renesas_usbhs/fifo.h       |    1 +
 drivers/usb/renesas_usbhs/mod_gadget.c |   38 ++++++++++++++++++++++++++++++--
 drivers/usb/renesas_usbhs/mod_host.c   |    2 +-
 drivers/usb/renesas_usbhs/pipe.c       |    8 +++++--
 6 files changed, 66 insertions(+), 23 deletions(-)

-- 
1.7.9.5

