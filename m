From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Thu, 30 Jun 2016 14:52:00 +0000
Subject: Re: [PATCH v4 12/22] sh: Add PCI host bridge driver for SH7751
Message-Id: <87y45md90v.wl-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1467207667-15768-1-git-send-email-ysato@users.sourceforge.jp>
	<1467207667-15768-13-git-send-email-ysato@users.sourceforge.jp>
	<4273068.i3RgB4Ufiy@wuerfel>
In-Reply-To: <4273068.i3RgB4Ufiy@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 29 Jun 2016 23:57:50 +0900,
Arnd Bergmann wrote:
> 
> On Wednesday, June 29, 2016 10:40:57 PM CEST Yoshinori Sato wrote:
> > +               interrupt-map = <0x0000 0 1 &cpldintc 0 0>,
> > +                                0x0800 0 1 &cpldintc 1 0>,
> > +                                0x1000 0 1 &cpldintc 2 0>,
> > +                                0x1800 0 1 &cpldintc 3 0>,
> > +                                0x1800 0 2 &cpldintc 0 0>;
> 
> I just noticed the typo: you have more closing '>' than opening '<'
> here, so this is not valid syntax.

Oh.
It too old files. I mistake commit.

> > +
> > +static __refdata struct platform_driver sh7751_pci_driver = {
> > +       .driver = {
> > +               .name = "sh7751-pci",
> > +               .of_match_table = sh7751_pci_of_match,
> > +       },
> > +       .probe = sh7751_pci_probe,
> > +};
> > +builtin_platform_driver(sh7751_pci_driver);
> 
> I think you need to add '.suppress_bind_attrs = true' to prevent
> the device to be unbound and rebound through sysfs, otherwise
> the __init annotation on the probe function is wrong.

Yes. This target hot add don't use.
It flag required.

> Everything else looks fine to me now.

OK.
Thanks.

> 	Arnd
> 

-- 
Yoshinori Sato
<ysato@users.sourceforge.jp>
