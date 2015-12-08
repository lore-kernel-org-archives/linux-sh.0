From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 08 Dec 2015 05:51:49 +0000
Subject: [PATCH 0/2] usb: renesas_usbhs: More compat strings
Message-Id: <1449553911-21412-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, linux-usb@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>

Hi,

this short series adds generic, and soc-specific r8a7792 and r8a7793 compat
strings to the Renesas USBHS driver. The intention is to provide a complete
set of compat strings for known R-Car SoCs.

Simon Horman (2):
  usb: renesas_usbhs: add fallback compatibility string
  usb: renesas_usbhs: add device tree support for r8a779[23]

 Documentation/devicetree/bindings/usb/renesas_usbhs.txt | 14 ++++++++------
 drivers/usb/renesas_usbhs/common.c                      |  4 ++++
 2 files changed, 12 insertions(+), 6 deletions(-)

-- 
2.1.4

