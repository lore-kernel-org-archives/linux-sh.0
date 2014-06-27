From: Simon Horman <horms@verge.net.au>
Date: Fri, 27 Jun 2014 23:56:22 +0000
Subject: Re: [PATCH v5 0/2] Add R8A7790/Lager board PCI USB DT support
Message-Id: <20140627235622.GA29865@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <201406242157.05973.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201406242157.05973.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Jun 24, 2014 at 09:57:04PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
>    Here's the set of 2 patches against Simon Horman's 'renesas.git' repo's
> 'renesas-devel-v3.16-rc2-20140623' tag. Here we add PCI USB device tree support
> for the R8A7790-based Lager board. As the 'pci-rcar-gen2' driver device tree
> support has been merged for 3.16, this patchset can now be merged too...
> 
> [1/2] ARM: shmobile: r8a7790: add internal PCI bridge nodes
> [2/2] ARM: shmobile: lager: enable internal PCI

Thanks, I will queue these up with
Shimoda-san's Tested-by.
