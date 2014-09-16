From: Simon Horman <horms@verge.net.au>
Date: Tue, 16 Sep 2014 06:02:12 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7794: Reserve memory as other R-Car Gen2 SoCs
Message-Id: <20140916060209.GB20805@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20140915133536.21371.34861.sendpatchset@w520>
In-Reply-To: <20140915133536.21371.34861.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Sep 15, 2014 at 10:35:36PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
> 
> Other R-Car Gen2 SoCs such as r8a7790 and r8a7791 reserve
> the top 256 MiB of memory for use with CMA. Adjust the
> board-less r8a7794 code to do the same.
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>

Thanks, I have queued this up.
