From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 05 Feb 2014 12:45:54 +0000
Subject: Re: FYI: current usb patches
Message-Id: <CANqRtoTmgHirE=OhApUq=8pw9ijObT1fAU1gdasqjJp5wdrOvQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1391595554-20640-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1391595554-20640-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ben,

[CC Valentine]

On Wed, Feb 5, 2014 at 7:19 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> This is the current set of patches I have to get USB working on the
> Lager board with FDT support. Please let me know if I have missed
> anything or if there are new review comments.
>
> Magnus, if you would like these rebased ontop of your bridge changes
> then let me know and I will sort that out.

Thanks. We probably need to discuss about the merge order. Perhaps
Valentine has some patches that we need to take into consideration
too.

> [PATCH 01/11] pci-rcar-gen2: add of match table
> [PATCH 02/11] pci-rcar-gen2: add initial device tree documentation
> [PATCH 03/11] ARM: shmbobile: r8a7790.dtsi: add pci0/1/2 nodes
> [PATCH 04/11] ARM: shmobile: lager.dts: add pci 0/1/2
> [PATCH 05/11] phy-rcar-usb-gen2: add device tree support
> [PATCH 06/11] phy-rcar-usb-gen2: add device tree documentation
> [PATCH 07/11] ARM: shmobile: r8a7790.dtsi: add usbphy node
> [PATCH 08/11] ARM: shmobile: lager.dtb: add usbphy reference
> [PATCH 09/11] PCI: rcar: check platform_get_irq() return code
> [PATCH 10/11] PCI: rcar: add error interrupt handling
> [PATCH 11/11] PCI: rcar: fix bridge logic configuration accesses

Regarding patch 1-4, I had some comment about USB0 gadget for patch 4,
but apart from that they look good to me. I'd like to hear what other
people think about them though. So they need some review time and
because of that from patch queue up point of view perhaps it would
make sense to have them later in the queue.

As for patch 5-8, I'm not sure what is the best way forward there. For
more info please see my reply to patch 8.

Patch 9-11, just by looking at 9 and 10 I can tell that they are good
to merge. I'd like to test patch 11 myself before saying anything.

My gut feeling is that it would be good to split out patch 9-11 and
queue them up first. Then perhaps I can add my patches on top of them
depending on what kind of feedback I get.

What does Valentine think?

Thanks,

/ magnus
