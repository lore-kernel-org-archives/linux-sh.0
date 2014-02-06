From: Simon Horman <horms@verge.net.au>
Date: Thu, 06 Feb 2014 07:05:33 +0000
Subject: Re: [PATCH] ARM: shmobile: Break out R-Car SYSC PM code
Message-Id: <20140206070527.GG17591@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20140115074308.8471.64824.sendpatchset@w520>
In-Reply-To: <20140115074308.8471.64824.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Jan 15, 2014 at 04:43:08PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Break out the R-Car SYSC power management code from
> the r8a7779 SoC code. With this new shared R-Car SYSC
> code base it is possible to hook in Generation 2 SoCs
> as well.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks, I have queued this up.
