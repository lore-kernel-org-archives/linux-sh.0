From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 20 Jun 2014 20:44:50 +0000
Subject: [PATCH v3 0/3] Add R8A7791/Koelsch/Henninger board PCI DT support
Message-Id: <201406210044.51620.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

   Here's the set of 3 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-v3.16-rc1-20140618' tag. Here we add PCI USB device tree support
for the R8A7791-based Koelsch and Henninger boards. As the 'pci-rcar-gen2'
driver device tree support has been merged for 3.16, this patchset can now be
merged too... 

[1/3] ARM: shmobile: r8a7791: add internal PCI bridge nodes
[2/3] ARM: shmobile: koelsch: enable internal PCI
[3/3] ARM: shmobile: henninger: enable internal PCI

WBR, Sergei
