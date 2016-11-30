From: Simon Horman <horms@verge.net.au>
Date: Wed, 30 Nov 2016 09:55:23 +0000
Subject: Re: [PATCH/RFC linux-mtd] mtd: sh_flctl: Remove sh7372 and device tree support
Message-Id: <20161130095520.GB2336@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1480059181-29355-1-git-send-email-horms+renesas@verge.net.au>
 <20161129170949.GZ1555@brightrain.aerifal.cx>
 <CAMuHMdUnaXbG-4GFB0BcTpYjcKHh8xA3Z0Z5CwiHJqCT-QhBJA@mail.gmail.com>
 <20161129174445.GA1555@brightrain.aerifal.cx>
In-Reply-To: <20161129174445.GA1555@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Cyrille Pitchen <cyrille.pitchen@atmel.com>, Matthias Brugger <matthias.bgg@gmail.com>, MTD Maling List <linux-mtd@lists.infradead.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>

On Tue, Nov 29, 2016 at 12:44:45PM -0500, Rich Felker wrote:
> On Tue, Nov 29, 2016 at 06:23:38PM +0100, Geert Uytterhoeven wrote:
> > Hi Rich,
> > 
> > On Tue, Nov 29, 2016 at 6:09 PM, Rich Felker <dalias@libc.org> wrote:
> > > On Fri, Nov 25, 2016 at 08:33:01AM +0100, Simon Horman wrote:
> > >> Commit edf4100906044225 ("ARM: shmobile: sh7372 dtsi: Remove Legacy file")
> > >> removed the sh7272 SoC from the kernel in v4.1.
> > >>
> > >> This patch removes support for the sh7272 SoC from the sh_flctl driver.
> > >> As that SoC was the only user of device tree support also remove that
> > >> from the driver.
> > >>
> > >> In essence it reverts commit 7c8f680e96ed ("mtd: sh_flctl: Add device tree
> > >> support"). This commit may be used as a reference for re-adding device
> > >> tree support to this driver if a need for it is found in future.
> > >>
> > >> This commit has been build-testesd against the ap325rxa_defconfig.
> > >> I do not have access to the hardware to perform run-time testing
> > >> on that board which appears to be the only remaining user of this driver.
> > >> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > >> ---
> > >>  .../devicetree/bindings/mtd/flctl-nand.txt         | 49 ---------------
> > >>  drivers/mtd/nand/sh_flctl.c                        | 70 +++-------------------
> > >>  2 files changed, 8 insertions(+), 111 deletions(-)
> > >>  delete mode 100644 Documentation/devicetree/bindings/mtd/flctl-nand.txt
> > >
> > > While I'm not the maintainer for this (and I'm not clear that the
> > > linux-sh list even should have been cc'd; it seems to be shmobile arm
> > > soc stuff rather than sh arch) I think this is a bad change. If the
> > > driver is completely unused, it should just be removed, but if there
> > 
> > Its sole remaining in-kernel user is arch/sh/boards/mach-ap325rxa/setup.c.
> 
> If indeed there's a user in arch/sh, it makes even more sense not to
> remove it. arch/sh/boards/* is intended to be removed with only DT
> support remaining, once drivers have DT support. :-)

I think we can trivially bring and end to speculation on the presence of a
user in arch/sh:

$ make kernelrelease
4.9.0-rc7
$ grep -r sh_flctl arch/sh/
arch/sh/boards/mach-ap325rxa/setup.c:#include <linux/mtd/sh_flctl.h>
arch/sh/boards/mach-ap325rxa/setup.c:static struct sh_flctl_platform_data nand_flash_data = {
arch/sh/boards/mach-ap325rxa/setup.c:   .name           = "sh_flctl",

> > > are remaining users that are still using legacy platform device
> > > bindings, they should gradually be transitioned to device tree, and
> > > having the device tree support still present makes it easier to do
> > > that.
> > 
> > Enjoy converting ap325rxa to DT ;-)
> 
> Not sure if that's expected to be worse than the rest of it and if it
> makes sense to convert or just remove. But I don't think changes that
> put us farther away from DT-only make sense.
> 
> > > Removing the *bindings* is even worse, as these are a permanent
> > > interface between hardware/firmware and software.
> > 
> > While it is a permanent interface, it is only a git revert away...
> 
> Indeed, but one that requires coordination between subsystem
> maintainers to get it back in a working state.

For now I think it would be best if this thread served to document that
sh7372 support should be removed either when another user of the bindings
is added or when DT support is removed from the driver.
