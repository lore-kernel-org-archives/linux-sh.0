From: yoshihiro shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 16 Jan 2015 10:10:27 +0000
Subject: RE: [PATCH] usb: renesas_usbhs: Add access control for INTSTS1 and INTENB1 register
Message-Id: <HKNPR06MB3229CE07FCD85BFC8247C93D84F0@HKNPR06MB322.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1420763321-4868-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1420763321-4868-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Iwamatsu-san,

> INTSTS1 and INTENB1 register of renesas_usbhs can access only Host mode.
> This adds process of accessing INTSTS1 and INTENB1 only when renesas_usbhs
> is Host mode.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>

Thank you for the patch.

Acked-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

