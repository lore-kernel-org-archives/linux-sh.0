From: "Roni Feldman" <roni.feldman+lkml@gmail.com>
Date: Thu, 10 Jul 2008 18:48:41 +0000
Subject: Several questions about SH PCI
Message-Id: <7b5883fc0807101148g601033e3n4f9ec4a53ed628fa@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello everyone,

I'm wondering about several things in the sh pci api:

1. In arch/sh/driver/pci/pci-sh7751.c, shouldn't sh7751_pci_init() be
tagged as core_initcall and not subsyss_initcall? pcibios_init(),
which scans the bus (and expects the pcic to be already initialized)
is also tagged as subsys_initcall. This might lead to bad ordering in
case more things are introduced in the subsys section, since there's
no order guarantee for functions in the same section, right?

2. I didn't manage to find PCIDMA support in the kernel. Did I
overlook it or is it just something nobody has implemented yet for sh?

3. I was thinking about the case where I'm using non-DMA PCI access,
and I need to change my window (PCIMBR or PCIIOBR). In that case every
section that changes the MBR / IOBR and does PCI access need to be
enclosed in something like pci_lock() and pci_unlock(), to solve the
problem of some other task changing MBR in my "critical section".
Would spinlocks be the best way to implement these locks?

Thanks
