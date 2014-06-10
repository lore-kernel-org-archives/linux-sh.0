From: Simon Horman <horms@verge.net.au>
Date: Tue, 10 Jun 2014 01:37:35 +0000
Subject: Re: [PATCH 00/02] ARM: shmobile: R-car Gen2 CMA reservation support
Message-Id: <20140610013732.GC30874@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20140609123837.31532.85914.sendpatchset@w520>
In-Reply-To: <20140609123837.31532.85914.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jun 09, 2014 at 09:38:37PM +0900, Magnus Damm wrote:
> ARM: shmobile: R-car Gen2 CMA reservation support
> 
> [PATCH 01/02] ARM: shmobile: Add shared R-Car Gen2 CMA reservation code
> [PATCH 02/02] ARM: shmobile: Enable R-Car Gen2 CMA code in board files
> 
> These patches add CMA reservation code for R-Car Gen2 SoCs and boards.
> 
> Instead of using custom memory reservation hacks for demos and other
> things, make use of standard CMA to reserve a pool of memory. This memory
> is suitable for devices that take physically contiguous memory such as
> DU and VSP1 multimedia devices. At this point no device assignment is
> included - only memory reservation code is added for now.
> 
> All R-Car Gen2 SoCs so far have LPAE support and boards tend to use more
> than 32-bits of physical addresses to access the system memory. These
> patches add code that during run time parses the DT memory banks and nick
> 256MiB from the highest memory bank within the legacy 32-bit physical memory
> space and use that for CMA.
> 
> On Lager and Koelsch boards these 256 MiB is at 0x7000000 -> 0x7fffffff.
> 
> The code uses dynamic calculation of the CMA area base address over static
> DT reservation since this kind of configuration is based on software policy.
> DT is however still used to describe the system memory banks as expected.
> Software memory partitioning is excluded from DT by design.
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>

Hi Magnus,

this seems clean to me. Shall I queue it up?
