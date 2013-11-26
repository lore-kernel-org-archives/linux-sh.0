From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Tue, 26 Nov 2013 22:45:27 +0000
Subject: [V2 PATCH 0/2] Defer HCD init until the external PHY, bound to the HCD is ready
Message-Id: <1385505929-30926-1-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This adds remove_phy flag to the HCD structure. If the flag is
set and if hcd->phy is valid, the phy is shutdown and released
whenever usb_add_hcd fails or usb_hcd_remove is called.
This also adds generic external phy support that allows
the HCD driver to search for a USB phy, bound to the HCD,
when the HC is being added.

If the USB PHY is found, it is initialized and the remove_phy flag
is set. In case PHY is not ready, the usb_add_hcd function returns
the -EPROBE_DEFER error code which defers HCD probing till the PHY
becomes ready.
If no PHY is bound to the HCD, or it has been initialized by
the glue-driver before calling usb_add_hcd(), the HCD is
added as usual.

This approach can be used to initialize the external PHY for
the R-Car PCI USB hosts, that share USB ports with USBHS/USBSS devices.
All we need to do is to make R-Car Gen2 platform code bind the
Gen2 USB phy device to the PCI HC devices, and make the phy-rcar-gen2-usb
driver register USB phy with usb_add_phy_dev() AOT usb_add_phy() callback.

Changes from previous version:
* Used #ifdef CONFIG_USB_PHY instead of introducing new config option.

Valentine Barshak (2):
  usb: hcd: Remove USB phy if needed
  usb: hcd: Initialize USB phy if needed

 drivers/usb/core/hcd.c  | 34 +++++++++++++++++++++++++++++++++-
 include/linux/usb/hcd.h |  1 +
 2 files changed, 34 insertions(+), 1 deletion(-)

-- 
1.8.3.1

