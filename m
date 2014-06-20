From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 20 Jun 2014 20:34:57 +0000
Subject: [PATCH v4 0/2] Add R8A7790/Lager board PCI USB DT support
Message-Id: <201406210034.57784.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

   Here's the set of 2 patches against Simon Horman's 'renesas.git' repo's
'renesas-devel-v3.16-rc1-20140618' tag. Here we add PCI USB device tree support
for the R8A7790-based Lager board. As the 'pci-rcar-gen2' driver device tree
support has been merged for 3.16, this patchset can now be merged too...

[1/2] ARM: shmobile: r8a7790: add internal PCI bridge nodes
[2/2] ARM: shmobile: lager: enable internal PCI

WBR, Sergei
