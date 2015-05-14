From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 14 May 2015 07:05:32 +0000
Subject: RE: [PATCH] usb: renesas_usbhs: Add access control for INTSTS1 and INTENB1 register
Message-Id: <SG2PR06MB09196049E108616048E482A0D8D80@SG2PR06MB0919.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1420763321-4868-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1420763321-4868-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

> Sent: Thursday, May 14, 2015 3:47 PM
> Hi,
< snip >
> On Thu, May 14, 2015 at 06:18:06AM +0000, Yoshihiro Shimoda wrote:
> > Hi Felipe,
> >
> > > Sent: Friday, March 06, 2015 3:55 PM
> > >
> > > ping?
> > >
> > > (2015/01/16 19:10), yoshihiro shimoda wrote:
> > > > Hi Iwamatsu-san,
> > > >
> > > >> INTSTS1 and INTENB1 register of renesas_usbhs can access only Host mode.
> > > >> This adds process of accessing INTSTS1 and INTENB1 only when renesas_usbhs
> > > >> is Host mode.
> > > >>
> > > >> Signed-off-by: Nobuhiro Iwamatsu<nobuhiro.iwamatsu.yj@renesas.com>
> > > >
> > > > Thank you for the patch.
> > > >
> > > > Acked-by: Yoshihiro Shimoda<yoshihiro.shimoda.uh@renesas.com>
> > > >
> > > > Best regards,
> > > > Yoshihiro Shimoda
> > > >
> >
> > Would you apply this patch to your testing/next branch?
> > This patch is very old, but I could apply it to the latest testing/next branch.
> > (commit id = 1c14905ef951fb968c8da90e4e64be02c309a2ae)
> 
> thanks for adding me to Cc list, I wasn't in Cc and ended up missing
> this completely. Luckily I still have it in my inbox and will apply it
> in the morning (it's 1:50 AM :-p)

Thank you very much for your prompt reply at midnight!
I got it.

Best regards,
Yoshihiro Shimoda

> regards
> 
> --
> balbi
