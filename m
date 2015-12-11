From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 11 Dec 2015 02:12:24 +0000
Subject: [PATCH v3 0/3] usb: renesas_usbhs: More compat strings
Message-Id: <1449799947-19866-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, linux-usb@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>

Hi,

this short series adds generic, and soc-specific r8a7792 and r8a7793 compat
strings to the Renesas USBHS driver. The intention is to provide a complete
set of compat strings for known R-Car SoCs.

Changes since v2:
* Split documentation of SoC names into separate patch
* Use correct fallback compatibility string in example

Changes since v1:
* Add R-Car Gen2 and Gen3 fallback compatibility strings rather than
  a single compatibility string for all of R-Car.

Simon Horman (3):
  usb: renesas_usbhs: add SoC names to compatibility string
    documentation
  usb: renesas_usbhs: add fallback compatibility strings
  usb: renesas_usbhs: add device tree support for r8a779[23]

 .../devicetree/bindings/usb/renesas_usbhs.txt        | 20 +++++++++++++++-----
 drivers/usb/renesas_usbhs/common.c                   |  9 +++++++++
 2 files changed, 24 insertions(+), 5 deletions(-)

-- 
2.1.4

