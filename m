From: Katsuya MATSUBARA <matsu@igel.co.jp>
Date: Mon, 21 Jan 2008 06:25:50 +0000
Subject: [BUG] cannot access IO ports in CMI8738 sound chip.
Message-Id: <20080121.152550.68560038.matsu@igel.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


 Hi all,

 I am writing a code to use a CMI8738 sound chip, which is
 widely used on Intel x86. I am using such a chip through
 a PCI slot on R2D-PLUS.
 The CMI8738 has IO ports. The pci_resource_start() gives
 an IO port number (0x4000), however, this number cannot be
 used for IO accessing by in*()/out*().

 I found a patch for fixing PCI IO port accessing in some SH7780
 platforms and then submitted a similar patch for RTS7751R2D;
 http://www.spinics.net/lists/linux-sh/msg00254.html
 In my understanding, these patch substitute memory addresses
 for IO port numbers. Is it correct?
 Unfortunately CMI8738 cannot treat (large) memory addresses
 as IO port numers because some upper bits of 'Base Address
 Register 0' in the PCI configuration space cannot be updated.
 (pcibios_setup_bars() in arch/sh/drivers/pci/pci-auto.c
 updates the register with the memory address.)
 
 How should I fix the problem?
---
 Katsuya Matsubara
