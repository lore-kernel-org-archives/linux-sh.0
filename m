From: Simon Horman <horms@verge.net.au>
Date: Fri, 02 May 2014 02:30:12 +0000
Subject: Re: [PATCH] ARM: shmobile: henninger: specify EXTAL frequency
Message-Id: <20140502023012.GH2265@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <201405020256.34093.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201405020256.34093.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, May 02, 2014 at 02:56:33AM +0400, Sergei Shtylyov wrote:
> When creating the initial device tree for the Henninger board,  I've overlooked
> that EXTAL frequency needs to be overridden there. The 'sh-sci' driver  managed
> to work somehow but the SDHI driver that I've tried to enable just hanged with
> the default EXTAL frequency of 0...
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> This patch is against 'renesas-devel-v3.15-rc3-20140429' tag of Simon Horman's
> 'renesas.git' repo.

Thanks, I have queued this up.
