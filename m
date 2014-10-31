From: yoshihiro shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 31 Oct 2014 03:46:42 +0000
Subject: RE: [PATCH v4 1/4] usb: renesas_usbhs: gadget: fix NULL pointer dereference in ep_disable()
Message-Id: <4f5ac72bc1a747ba8f07ca34f4fb4512@HKNPR06MB322.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1414718664-4568-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1414718664-4568-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

> On Fri, Oct 31, 2014 at 10:24:21AM +0900, Yoshihiro Shimoda wrote:
> > From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> >
> > This patch fixes an issue that the NULL pointer dereference happens
> > when we uses g_audio driver. Since the g_audio driver will call
> > usb_ep_disable() in afunc_set_alt() before it calls usb_ep_enable(),
> > the uep->pipe of renesas usbhs driver will be NULL. So, this patch
> > adds a condition to avoid the oops.
> >
> > Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> > Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Cc: <stable@vger.kernel.org>
> 
> which commit caused this ? You need something like:
> 
> Fixes: deadbeef (commit subject line)
> Cc: <stable@vger.kernel.org> # v3.14+
> 
> So stable folks know how far back this needs to be backported to.

Thank you for the point. I will add them.

Best regards,
Yoshihiro Shimoda

