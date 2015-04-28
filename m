From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 28 Apr 2015 01:36:59 +0000
Subject: RE: [PATCH] usb: phy: rcar-gen2-usb: Fix USBHS_UGSTS_LOCK value
Message-Id: <SG2PR06MB0919FCD536849E2C83E2F6BDD8E80@SG2PR06MB0919.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1427973754-4868-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1427973754-4868-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

> Sent: Tuesday, April 28, 2015 4:45 AM
> 
> Hi,
> 
> On Thu, Apr 02, 2015 at 08:22:34PM +0900, Yoshihiro Shimoda wrote:
> > According to the technical update (No. TN-RCS-B011A/E), the UGSTS LOCK
> > bit location is bit 8, not bits 9 and 8. So, this patch fixes the
> > USBHS_UGSTS_LOCK value.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> 
> this doesn't apply to v4.1-rc1, if it's still needed, please rebase.

Thank you for the notice. I found that this patch has been already merged in v4.1-rc1 by Greg.

Best regards,
Yoshihiro Shimoda

> --
> balbi
