From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 04 Sep 2014 21:40:15 +0000
Subject: [PATCH v5 0/2] Add generic PHY support to USB HCD
Message-Id: <5072811.p8odmvpxdS@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
Cc: linux-sh@vger.kernel.org, yoshihiro.shimoda.uh@renesas.com, Peter.Chen@freescale.com, stern@rowland.harvard.edu, swarren@wwwdotorg.org, thierry.reding@gmail.com, balbi@ti.com, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, antoine.tenart@free-electrons.com

Hello.

   This patchset is against the usb-next' branch of Greg KH's 'usb.git' repo.
Here I add support for the generic PHY to the 'struct usb_hcd' (having to
rename the existing 'phy' field to 'usb_phy' beforehand). This was mainly
intended to be used with the PCI OHCI/EHCI drivers and also xHCI driver;
however there are several more dependent patchsets now posted to 'linux-usb'.
   Greg, if you want links to these patchsets and the device tree patches using
this patchset in order to link the PCI OHCI/EHCI devices to the PHY, just ask
(I have already posted the previously but will probably have to repost them
again)...

[1/2] usb: rename phy to usb_phy in HCD
[2/2] usb: hcd: add generic PHY support

WBR, Sergei

