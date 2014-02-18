From: Simon Horman <horms@verge.net.au>
Date: Tue, 18 Feb 2014 00:09:29 +0000
Subject: Re: [PATCH] ARM: shmobile: Remove EMEV2 header file
Message-Id: <20140218000926.GB4776@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20140217073508.11156.21720.sendpatchset@w520>
In-Reply-To: <20140217073508.11156.21720.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Feb 17, 2014 at 04:35:08PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> There is no C board code left for the EMEV2 SoC, so
> get rid of the emev2.h include file to save some lines.
> While at it make functions static.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks, I have queued this up.

