From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 07 Apr 2014 22:35:21 +0000
Subject: [PATCH v2 0/2] Add PCI USB DT support for R8A7790/Lager reference board
Message-Id: <201404080235.22151.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

   Here's the set of 2 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-v3.14-20140403' tag. Here we add the PCI USB device tree
support on the R8A7790/Lager reference board. The patchset requires the
'pci-rcar-gen2' driver device tree support (just re-posted) in order to work.

[1/2] ARM: shmobile: r8a7790: add internal PCI bridge nodes
[2/2] ARM: shmobile: lager: enable internal PCI

WBR, Sergei
