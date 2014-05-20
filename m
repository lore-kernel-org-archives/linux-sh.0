From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 20 May 2014 20:08:14 +0000
Subject: [PATCH v3 0/2] Add R8A7790/Lager board PCI USB DT support
Message-Id: <201405210008.15145.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

   Here's the set of 2 patches against Simon Horman's 'renesas.git' repo's
'renesas-devel-v3.15-rc5-20140517' tag. Here we add PCI USB device tree support
for the R8A7790-based Lager board. The patchset requires the 'pci-rcar-gen2'
driver device tree support (re-posted yesterday) in order to work.

[1/2] ARM: shmobile: r8a7790: add internal PCI bridge nodes
[2/2] ARM: shmobile: lager: enable internal PCI

WBR, Sergei
