From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 30 Apr 2009 03:53:36 +0000
Subject: Re: [PATCH] sh: pass through ioremap() for non-mmu processors V2
Message-Id: <20090430035336.GA10420@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090428075934.16285.38017.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090428075934.16285.38017.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Apr 29, 2009 at 11:44:28PM +0900, Magnus Damm wrote:
> This is V2 of the CONFIG_MMU=n pass through ioremap() patch.
> 
> All 32-bit SuperH processors currently go through __ioremap_mode()
> and check for IO_TRAPPED and directly mapped segments. With this
> patch we simplify the MMU less case with a pass through version of
>  __ioremap_mode() which just returns the physical address.
> 
> The effects of this is change are:
>  - fix non-MMU ioremap() of high address hardware blocks (sh7203 CMT)
>  - make sure IO_TRAPPED is not selected

On Wed, Apr 29, 2009 at 11:50:37PM +0900, Magnus Damm wrote:
> This patch contains various fixes for 16-bit cmt hardware.
> With this applied periodic clockevents work fine on sh7203.

Both applied, thanks.
