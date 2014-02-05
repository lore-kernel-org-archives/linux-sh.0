From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 05 Feb 2014 06:52:43 +0000
Subject: [PATCH 00/04] PCI: rcar: Driver model and physical address space update
Message-Id: <20140205065243.29445.76593.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-pci@vger.kernel.org
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, valentine.barshak@cogentembedded.com, horms@verge.net.au, bhelgaas@google.com, Magnus Damm <magnus.damm@gmail.com>, ben.dooks@codethink.co.uk

PCI: rcar: Driver model and physical address space update

[PATCH 01/04] PCI: rcar: Register each instance independently
[PATCH 02/04] PCI: rcar: Break out window size handling
[PATCH 03/04] PCI: rcar: Add DMABOUNCE support
[PATCH 04/04] PCI: rcar: Enable BOUNCE in case of HIGHMEM

These patches update the pci-rcar-gen2.c driver in various ways
including cleanups for driver model interface (1/4), readability
update (2/4) and also bounce buffer support (3/4, 4/4). Basically
the first two are just cleanups and the rest are fixes.

As it is today without these patches the system memory start address
is hard coded at 0x4000000 and the window is fixed at 1GiB. So we
have board specific code hidden in the driver which is good to avoid.

With these hard coded board specific constants there are some error cases
that are not handled, in particular the issue that only maximum 1GiB of
physical address space can be used for bus mastering with a single window.
The common case of using ARM CONFIG_VMSPLIT_3G results in no visible issues
as long as CONFIG_BOUNCE is used, but other CONFIG_VMSPLIT settings will
break due to the hard coded 1GiB window not being enough. It has been
verified that reducing the window size to 256MB makes the driver behave
the same with VMSPLIT_3G as 1GiB window size and other VMSPLIT settings.

To handle the maximum 1GiB physical address space limitation two types
of bounce buffers are added. The ARM specific DMABOUNCE code is in 3/4
hooked up to a chunk of local memory that is also handed of as coherent
memory to the pci devices hanging off the PCI bridge. The driver makes
sure to set the window so the local memory is always included. When the
PCI devices are operating and in case memory is used outside the window
then the DMABOUNCE buffers kicks in. This makes the driver support all
kinds of VMSPLIT settings and window sizes. The BOUNCE code in 4/4 is
selected to make sure bounce buffers are used for HIGHMEM.

With these patches this driver can be used with or without CMA and
with or without DMA zone. Basically the system wide memory setup is
left to the user. If a DMA zone is used then the PCI window will
be setup to cover that. Same thing with CMA.

Tested with USB storage using LPAE and various VMSPLIT settings together
with renesas git tag renesas-devel-v3.14-rc1-20140204 from kernel.org

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas.git tag renesas-devel-v3.14-rc1-20140204

 drivers/pci/host/Kconfig         |    3 
 drivers/pci/host/pci-rcar-gen2.c |  367 +++++++++++++++++++++++++++++++-------
 2 files changed, 306 insertions(+), 64 deletions(-)
