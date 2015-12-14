From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 14 Dec 2015 10:27:02 +0000
Subject: Re: [PATCH 00/10] drivers/pci: avoid module_init in non-modular host/pci*
Message-Id: <3302340.SIljl1qYTl@wuerfel>
List-Id: <linux-sh.vger.kernel.org>
References: <1449970917-12633-1-git-send-email-paul.gortmaker@windriver.com>
 <CAFiDJ5-Y8afg5kDRQLK1pain-k1kPQAn3vhWrVkB1ADPRHvx+A@mail.gmail.com>
 <20151214091940.GA15126@ulmo.nvidia.com>
In-Reply-To: <20151214091940.GA15126@ulmo.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Monday 14 December 2015 10:19:40 Thierry Reding wrote:
> > PCIe host driver that use fixup (DECLARE_PCI_FIXUP_*) can't use tristate.
> > Fixup region is in kernel region and this region if not updated when
> > loading a module.
> 
> Interesting, I hadn't thought about that. I suppose this means that the
> module will end up containing an unused section with the fixup code. It
> might be useful to add a way for that to trigger a warning at build
> time.
> 
> Perhaps to fix this a mechanism could be introduced to add a table of
> fixups to a host controller driver and that will get applied to all
> children of the bridge. It could be problematic to cover all of the
> different fixup stages, though.
> 


I think a lot of the fixups shouldn't really be there in the first place,
they are about stuff that we can fix up in the probe function, or that should
be fixed up in the probe function with some appropriate core support added.

	Arnd
