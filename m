From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 25 Nov 2008 13:18:52 +0000
Subject: Re: [PATCH] sh: P4 ioremap pass-through
Message-Id: <20081125131852.GC20883@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20081125125729.8565.28530.sendpatchset@rx1.opensource.se>
In-Reply-To: <20081125125729.8565.28530.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Nov 25, 2008 at 09:57:29PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@igel.co.jp>
> 
> This patch adds a pass-through case when ioremapping P4 addresses.
> 
> Addresses passed to ioremap() should be physical addresses, so the
> best option is usually to convert the virtual address to a physical
> address before calling ioremap. This will give you a virtual address
> in P2 which matches the physical address and this works well for
> most internal hardware blocks on the SuperH architecture.
> 
> However, some hardware blocks must be accessed through P4. Converting
> the P4 address to a physical and then back to a P2 does not work. One
> example of this is the sh7722 TMU block, it must be accessed through P4.
> 
> Without this patch P4 addresses will be mapped using PTEs which
> requires the page allocator to be up and running.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

Applied, thanks.
