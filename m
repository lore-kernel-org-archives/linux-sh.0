From: Simon Horman <horms@verge.net.au>
Date: Fri, 06 Jun 2014 08:35:31 +0000
Subject: Re: [PATCH v2] ARM: shmobile: Lager memory map update
Message-Id: <20140606083528.GC27546@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20140606064026.14410.80482.sendpatchset@w520>
In-Reply-To: <20140606064026.14410.80482.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jun 06, 2014 at 03:40:26PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
> 
> Update the Lager DTS to make use of the new unified legacy 
> memory map where the legacy window on Lager and Koelsch
> have the same size.
> 
> With this change in place the code gets aligned with the
> documentation.
> 
> After update the Lager board has the following map:
> Bank0: 1GiB RAM (Legacy 32-bit: 0x40000000->0x7fffffff)
> Bank1: 3GiB RAM (LPAE area: 0x140000000->0x1ffffffff)
> 
> Before the update the old map looked like this:
> Bank0: 2GiB RAM (Legacy 32-bit: 0x40000000->0xbfffffff)
> Bank1: 2GiB RAM (LPAE area: 0x180000000->0x1ffffffff)
> 
> Tested with and without LPAE on r8a7790 Lager.
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>

Thanks, I have queued this up.
