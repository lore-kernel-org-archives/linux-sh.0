From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 07 Apr 2014 22:48:13 +0000
Subject: [PATCH 0/2] Add PCI USB DT support for R8A7791/Koelsch reference board
Message-Id: <201404080248.14139.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

   Here's the set of 2 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-v3.14-20140403' tag and R8A7791 EHCI clock device tree support
patch. Here we add the PCI USB device tree support on the R8A7791/Koelsch
reference board. The patchset requires the 'pci-rcar-gen2' driver device tree
support (just re-posted) in order to work.

[1/2] ARM: shmobile: r8a7791: add internal PCI bridge nodes
[2/2] ARM: shmobile: koelsch: enable internal PCI

WBR, Sergei
