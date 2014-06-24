From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 24 Jun 2014 17:57:04 +0000
Subject: [PATCH v5 0/2] Add R8A7790/Lager board PCI USB DT support
Message-Id: <201406242157.05973.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

   Here's the set of 2 patches against Simon Horman's 'renesas.git' repo's
'renesas-devel-v3.16-rc2-20140623' tag. Here we add PCI USB device tree support
for the R8A7790-based Lager board. As the 'pci-rcar-gen2' driver device tree
support has been merged for 3.16, this patchset can now be merged too...

[1/2] ARM: shmobile: r8a7790: add internal PCI bridge nodes
[2/2] ARM: shmobile: lager: enable internal PCI

WBR, Sergei
