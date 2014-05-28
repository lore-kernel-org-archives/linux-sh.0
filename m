From: Jingoo Han <jg1.han@samsung.com>
Date: Wed, 28 May 2014 01:35:43 +0000
Subject: Re: [PATCH v2] of/irq: provide int of_irq_parse_and_map_pci wrapper
Message-Id: <002301cf7a15$23eb5180$6bc1f480$%han@samsung.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4527717.yJh2gX3xCP@wuerfel>
 <1399624119.4833.3.camel@weser.hi.pengutronix.de> <5744457.bgUFy9g0ST@wuerfel>
 <CAMuHMdXXFmxmq9H1fuc7fRg8BHQ+3m6=4mPDe5FjL0hLLvwUUw@mail.gmail.com>
In-Reply-To: <CAMuHMdXXFmxmq9H1fuc7fRg8BHQ+3m6=4mPDe5FjL0hLLvwUUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Geert Uytterhoeven' <geert@linux-m68k.org>, 'Arnd Bergmann' <arnd@arndb.de>
Cc: 'Lucas Stach' <l.stach@pengutronix.de>, devicetree@vger.kernel.org, 'Grant Likely' <grant.likely@linaro.org>, 'Rob Herring' <robh+dt@kernel.org>, 'Bjorn Helgaas' <bhelgaas@google.com>, 'Magnus Damm' <damm@opensource.se>, 'Ben Dooks' <ben.dooks@codethink.co.uk>, 'linux-pci' <linux-pci@vger.kernel.org>, 'Linux-sh list' <linux-sh@vger.kernel.org>, 'Jingoo Han' <jg1.han@samsung.com>

On Friday, May 09, 2014 6:10 PM, Geert Uytterhoeven wrote:
> On Fri, May 9, 2014 at 11:03 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > The pci-rcar driver is enabled for compile tests, and this has
> > now shown that the driver cannot build without CONFIG_OF,
> > following the inclusion of f8f2fe7355fb "PCI: rcar: Use new OF
> > interrupt mapping when possible":
> >
> > drivers/built-in.o: In function `rcar_pci_map_irq':
> > :(.text+0x1cc7c): undefined reference to `of_irq_parse_and_map_pci'
> >
> > As pointed out by Ben Dooks and Geert Uytterhoeven, this is actually
> > supposed to build fine, which we can achieve if we make the
> > declaration of of_irq_parse_and_map_pci conditional on CONFIG_OF
> > and provide an empty inline function otherwise, as we do for
> > a lot of other of interfaces.
> >
> > This lets us build the rcar_pci driver again without CONFIG_OF
> > for build testing. All platforms using this driver select OF,
> > so this doesn't change anything for the users.
> 
> Thanks!
> 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Magnus Damm <damm@opensource.se>
> > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > Cc: Ben Dooks <ben.dooks@codethink.co.uk>
> > Cc: linux-pci@vger.kernel.org
> > Cc: linux-sh@vger.kernel.org
> 
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Reviewed-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

