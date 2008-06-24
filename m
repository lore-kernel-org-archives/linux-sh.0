From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 24 Jun 2008 03:48:06 +0000
Subject: Re: [2.6 patch] remove pcibios_update_resource() functions
Message-Id: <20080624034806.GA22526@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080617223332.GM25911@cs181133002.pp.htv.fi>
In-Reply-To: <20080617223332.GM25911@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@kernel.org>
Cc: jbarnes@virtuousgeek.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dhowells@redhat.com, gerg@uclinux.org, ralf@linux-mips.org, linux-mips@linux-mips.org, linux-sh@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>

On Wed, Jun 18, 2008 at 01:33:32AM +0300, Adrian Bunk wrote:
> Russell King did the following back in 2003:
> 
> <--  snip  -->
> 
>     [PCI] pci-9: Kill per-architecture pcibios_update_resource()
>     
>     Kill pcibios_update_resource(), replacing it with pci_update_resource().
>     pci_update_resource() uses pcibios_resource_to_bus() to convert a
>     resource to a device BAR - the transformation should be exactly the
>     same as the transformation used for the PCI bridges.
>     
>     pci_update_resource "knows" about 64-bit BARs, but doesn't attempt to
>     set the high 32-bits to anything non-zero - currently no architecture
>     attempts to do something different.  If anyone cares, please fix; I'm
>     going to reflect current behaviour for the time being.
>     
>     Ivan pointed out the following architectures need to examine their
>     pcibios_update_resource() implementation - they should make sure that
>     this new implementation does the right thing.  #warning's have been
>     added where appropriate.
>     
>         ia64
>         mips
>         mips64
>     
>     This cset also includes a fix for the problem reported by AKPM where
>     64-bit arch compilers complain about the resource mask being placed
>     in a u32.
> 
> <--  snip  -->
> 
> 
> This patch removes the unused pcibios_update_resource() functions the 
> kernel gained since.
> 
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>
> 
sh parts -

Acked-by: Paul Mundt <lethal@linux-sh.org>
