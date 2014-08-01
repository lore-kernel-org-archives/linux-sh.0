From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 01 Aug 2014 11:49:04 +0000
Subject: [PATCH 0/2] usb: renesas_usbhs: Add device tree support for R-Car H2 and M2
Message-Id: <53DB7EB0.8000401@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: SH-Linux <linux-sh@vger.kernel.org>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>

This driver supports other SoCs, but they need boards/Soc depend code.
So, this patch adds device tree support for R-Car H2 and M2 initially.

Yoshihiro Shimoda (2):
  usb: renesas_usbhs: Add device tree bindings documentation
  usb: renesas_usbhs: Add device tree support for R-Car H2 and M2

 .../devicetree/bindings/usb/renesas_usbhs.txt      |   24 +++++++++++
 drivers/usb/renesas_usbhs/common.c                 |   43 ++++++++++++++++++++
 2 files changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/renesas_usbhs.txt

-- 
1.7.9.5
