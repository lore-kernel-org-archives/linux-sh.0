From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 13 Jan 2016 02:00:35 +0000
Subject: [PATCH v3 0/2] usb: host: xhci-plat: add R-Car Gen2 and Gen3 fallback compatibility strings
Message-Id: <1452650437-26312-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

this short series adds Gen2 and Gen3 fallback compatibility strings to the
xhci-plat driver.

Changes between v2 and v3:
* Refer to Armada 38x rather than 380 SoCs.

Changes between v1 and v2:
* Use consistent line ending in documentation
* Group compat strings at the bottom of usb_xhci_of_match[]
* Include follow-up patch from Julia Lawall to ensure usb_xhci_of_match
  is correctly terminated

Julia Lawall (1):
  usb: host: xhci-plat: fix of_table.cocci warnings

Simon Horman (1):
  usb: host: xhci-plat: add R-Car Gen2 and Gen3 fallback compatibility
    strings

 Documentation/devicetree/bindings/usb/usb-xhci.txt | 21 +++++++++++++++++----
 drivers/usb/host/xhci-plat.c                       |  6 ++++++
 2 files changed, 23 insertions(+), 4 deletions(-)

-- 
2.1.4

