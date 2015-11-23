From: Marc Zyngier <marc.zyngier@arm.com>
Date: Mon, 23 Nov 2015 10:15:21 +0000
Subject: Re: [PATCH] PCI: pcie-rcar: Fix OF node passed to MSI irq domain
Message-Id: <20151123101521.07e8dc9b@arm.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1446542899-25137-1-git-send-email-phil.edworthy@renesas.com>
	<PS1PR06MB11804ED428472FC1FD776F6EF5150@PS1PR06MB1180.apcprd06.prod.outlook.com>
	<20151109161115.GA13870@ulmo.nvidia.com>
	<PS1PR06MB1180111D6423287273B64B0FF5150@PS1PR06MB1180.apcprd06.prod.outlook.com>
	<20151110155232.GA25368@ulmo.nvidia.com>
	<20151111163802.3a96080c@arm.com>
	<PS1PR06MB11806B2B906CABB553B94442F5120@PS1PR06MB1180.apcprd06.prod.outlook.com>
	<20151112203100.2e91da2a@arm.com>
	<PS1PR06MB11800B547C8957B226077B83F5110@PS1PR06MB1180.apcprd06.prod.outlook.com>
	<564A2101.90600@arm.com>
	<PS1PR06MB11804FF05BBF30F2CA2083FCF51C0@PS1PR06MB1180.apcprd06.prod.outlook.com>
	<564EECA9.9070400@arm.com>
	<PS1PR06MB1180D8114604DE8AC1125E96F5070@PS1PR06MB1180.apcprd06.prod.outlook.com>
In-Reply-To: <PS1PR06MB1180D8114604DE8AC1125E96F5070@PS1PR06MB1180.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Thierry Reding <treding@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, Wolfram Sang <wsa@the-dreams.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms@verge.net.au>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ley Foon Tan <lftan@altera.com>, Jingoo Han <jg1.han@samsung.com>

On Mon, 23 Nov 2015 09:44:10 +0000
Phil Edworthy <phil.edworthy@renesas.com> wrote:

> Hi Marc,
>=20
> On 20 November 2015 09:49, Marc Zyngier wrote:
> > On 18/11/15 18:01, Phil Edworthy wrote:
> > > Hi Marc,
> > >
> > > On 16 November 2015 18:31, Marc Zyngier wrote:
> > >> On 13/11/15 09:36, Phil Edworthy wrote:
> > > <snip>
> > >>> Since the stack trace doesn't help that much I added some tracing:
> > >>> pci_msi_setup_msi_irqs()
> > >>>   calls pci_msi_get_domain()
> > >>>     calls dev_get_msi_domain(), gets a non-NULL domain.
> > >>> pci_msi_setup_msi_irqs()
> > >>>   calls pci_msi_domain_alloc_irqs()
> > >>>     calls msi_domain_alloc_irqs()
> > >>> msi_domain_alloc_irqs:273: ops=FFffffc03193a810
> > >>> msi_domain_alloc_irqs:274: ops->msi_check=FFffffc031161418
> > >>> systemd-udevd[1311]: undefined instruction: pc=FFffffc03116141c
> > >>> That looks to me as though msi_check is off pointing to the weeds.
> > >>
> > >> So the next step is to find out who initializes msi_check. Assuming
> > >> someone does...
> > > Nothing initializes msi_check...
> > >
> > >
> > >>> By passing a NULL domain into irq_domain_add_linear() you get:
> > >>> pci_msi_setup_msi_irqs()
> > >>>   calls pci_msi_get_domain()
> > >>>     calls dev_get_msi_domain(), gets a NULL domain.
> > >>>     calls arch_setup_msi_irq()
> > >>> All ok then.
> > >>
> > >> Yes, because you're sidestepping the issue. Any chance you could dig=
 a
> > >> bit deeper? I'd really like to nail this one down (before we convert
> > >> your PCI driver to the right API... ;-).
> > > The problem appears to be that when the pci host driver enables msi
> > > it calls the following:
> > > 	msi->domain =3D irq_domain_add_linear(pcie->dev->of_node,
> > INT_PCI_MSI_NR,
> > > 					    &msi_domain_ops, &msi->chip);
> > > The last arg is documented as:
> > > * @host_data: Controller private data pointer
> > > In _irq_domain_add() this ptr is stored in struct irq_domain's host_d=
ata.
> > >
> > > However, msi_domain_alloc_irqs() expects host_data to be a ptr to a
> > > struct msi_domain_info.
> > >
> > > It seems that a number of other pci host drivers do the same, so I am
> > > surprised that no one else has seen this.
> >=20
> > Can you please give this hack a go and let me know if that helps?
> Works for me!

Cool. I'll post a patch with your Reported-by/Tested-by later today.

Thanks a lot.

	M.
--=20
Jazz is not dead. It just smells funny.
