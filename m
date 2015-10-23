From: Simon Horman <horms@verge.net.au>
Date: Fri, 23 Oct 2015 00:24:17 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7794: Disable all IPMMU nodes by default
Message-Id: <20151023002417.GE15844@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20151018052656.3608.65682.sendpatchset@little-apple>
In-Reply-To: <20151018052656.3608.65682.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Oct 18, 2015 at 02:26:56PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
> 
> The r8a7794 IPMMU nodes for MX and DS are currently lacking
> a line containing 'status = "disabled"', fix this by
> making sure they are disabled like all other IPMMU nodes.
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>

Thanks, I have queued this up for v4.5.
