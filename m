From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 26 May 2015 11:13:41 +0000
Subject: [PATCH 0/2] usb: renesas_usbhs: fix for Control write
Message-Id: <1432638823-3028-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch set is based on Felipe's usb.git / testing/next branch.
(commit id: 672bfdaa310004368a0d493478e2a40f2f2f914f)

Kazuya Mizuguchi (1):
  usb: renesas_usbhs: Fix fifo unclear in usbhsf_prepare_pop

Yoshihiro Shimoda (1):
  usb: renesas_usbhs: Don't disable the pipe if Control write status
    stage

 drivers/usb/renesas_usbhs/fifo.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

-- 
1.9.1

