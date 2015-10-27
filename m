From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 27 Oct 2015 00:26:32 +0000
Subject: RE: [PATCH v3 1/7] usb: host: xhci: fix hcd private size
Message-Id: <SG2PR06MB091977AD0312EB694934CCE7D8220@SG2PR06MB0919.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1445847155-5468-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1445847155-5468-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

> From: Felipe Balbi [mailto:balbi@ti.com]
> Sent: Monday, October 26, 2015 11:27 PM
> 
> Hi,
> 
> Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com> writes:
> > This patch fixes the hcd private size to sutabile size.
>                                            ^^^^^^^^
>                                            suitable

Oops, Thank you for the point.

> > The previous code has "sizeof(struct xhci_hcd *)" in xhci_hc_driver
> > as hcd_priv_size and sizeof(struct xhci_hcd) in xhci_plat_overrides
> > or xhci_pci_overrides as extra_priv_size. However, the xhci driver
> > uses a "sizeof(struct xhcd_hcd)" memory space in each hcd
> > (main_hcd and shared_hcd) actually.
> 
> Nothing against the patch itself, but you're describing what exactly
> you're fixing. Did you find a bug because of this or is this basically a
> cleanup ? Your subject says you're "fixing" hcd private size, but I
> don't how this could be fixing anything. Care to explain ?

My description is wrong. This is basically a cleanup. I don't find any bugs.
So, I will fix this subject and description in v4.

Best regards,
Yoshihiro Shimoda

> --
> balbi
