From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 15 Jul 2008 08:58:01 +0000
Subject: Re: Several questions about SH PCI
Message-Id: <20080715085801.GA23440@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <7b5883fc0807101148g601033e3n4f9ec4a53ed628fa@mail.gmail.com>
In-Reply-To: <7b5883fc0807101148g601033e3n4f9ec4a53ed628fa@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jul 10, 2008 at 09:48:41PM +0300, Roni Feldman wrote:
> 1. In arch/sh/driver/pci/pci-sh7751.c, shouldn't sh7751_pci_init() be
> tagged as core_initcall and not subsyss_initcall? pcibios_init(),
> which scans the bus (and expects the pcic to be already initialized)
> is also tagged as subsys_initcall. This might lead to bad ordering in
> case more things are introduced in the subsys section, since there's
> no order guarantee for functions in the same section, right?
> 
It's link order dependent, but yes, there's a potential issue here if we
start out with the PCIC completely disabled at boot time.

> 2. I didn't manage to find PCIDMA support in the kernel. Did I
> overlook it or is it just something nobody has implemented yet for sh?
> 
It's not been implemented. Feel free to send patches.

> 3. I was thinking about the case where I'm using non-DMA PCI access,
> and I need to change my window (PCIMBR or PCIIOBR). In that case every
> section that changes the MBR / IOBR and does PCI access need to be
> enclosed in something like pci_lock() and pci_unlock(), to solve the
> problem of some other task changing MBR in my "critical section".
> Would spinlocks be the best way to implement these locks?
> 
Yes.
