From: yoshihiro shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 06 Jan 2015 11:15:49 +0000
Subject: RE: [PATCH] spi: sh-msiof: fix MDR1_FLD_MASK value
Message-Id: <HKNPR06MB322CD2512711FAE69EBC5F3D8590@HKNPR06MB322.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1420538486-1420-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdUjor__TCQwDcHAR9-vH54=qB-_E5AM2a4hp2B+wE9c4Q@mail.gmail.com>
 <HKNPR06MB322387C2B14F90694CA90A8D8590@HKNPR06MB322.apcprd06.prod.outlook.com>
 <20150106110831.GV2634@sirena.org.uk>
In-Reply-To: <20150106110831.GV2634-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Mark,

> 
> On Tue, Jan 06, 2015 at 10:57:32AM +0000, yoshihiro shimoda wrote:
> 
> > > This patch doesn't apply, since Mark has applied your other patch
> > > "spi: sh-msiof: Configure MSIOF sync signal timing in device tree".
> > >
> > > Please rebase on top of spi/for-next (or renesas-drivers-2015-01-06-v3.19-rc3).
> 
> > Oops. Thank you for the point.
> > I used spi/for-linux branch. So, I will rebase on top of spi/for-next.
> 
> Actually since it's a fix I applied it on a fix branch anyway and
> merged.

Thank you!
I already submitted v2 patch, but please ignore it.

Best regards,
Yoshihiro Shimoda

