From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 08 May 2015 07:24:44 +0000
Subject: RE: [PATCH] phy: phy-rcar-gen2: Fix USBHS_UGSTS_LOCK value
Message-Id: <SG2PR06MB091954414B0D7D1FB2F15E26D8DE0@SG2PR06MB0919.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1427961671-8064-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1427961671-8064-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "kishon@ti.com" <kishon@ti.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

Hi Kishon,

> Sent: Thursday, April 02, 2015 5:01 PM
> 
> According to the technical update (No. TN-RCS-B011A/E), the UGSTS LOCK
> bit location is bit 8, not bits 1 and 0. It also says that the register
> address offset of UGSTS is 0x88, not 0x90.
> So, this patch fixes the USBHS_UGSTS_LOCK value and some comments.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Would you apply this patch to your repository?
I tried to apply this patch on the current fixes branch of linux-phy today,
this patch could be applied without any error.

Best regards,
Yoshihiro Shimoda

