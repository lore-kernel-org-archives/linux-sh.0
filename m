From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 09 Oct 2009 01:31:19 +0000
Subject: Re: [PATCH] sh: sh7785lcr: add possibility of using 128MB pci window on sh7785lcr by using PMB
Message-Id: <20091009013118.GC31816@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4ACDB6B8.9090808@siemens.com>
In-Reply-To: <4ACDB6B8.9090808@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Oct 08, 2009 at 01:54:00PM +0400, Valentin R Sitsikov wrote:
> Only pci may start now from 0xC0000000-phys:0xb8000000-virtual.
> All other mapping is the same as without using PMB. 	
> 
> Signed-off-by: Valentin Sitdikov <valentin.sitdikov@siemens.com>

No, we are not going to add any ifdefs to vary the size of the PCI memory
window. A lot of hard work went in to throwing away all of this ifdef
configuration crap in the first place, and the last thing we want to do
is reinstate more of it. We do not have enough address space with or
without the PMB to make varying configurations realistic.

Having said that, I think 128MB is a fine default, given that presently
we are completely starved for vmalloc space due to the mindless
assignment of PCI memory to that region. As such, perhaps the easiest
thing to do is simply to scale the window size back to 128MB as a maximum
and bump vmalloc space after that (or even 64MB for PCI memory would
probably be fine).

If anyone wants to map more PCI memory than that, they are not going to
be able to use the legacy P1/P2 mappings. We would be better off throwing
out P2 completely and giving it over to sparsemem vmemmap to actually do
something useful with anyways.
