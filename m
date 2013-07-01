From: Simon Horman <horms@verge.net.au>
Date: Mon, 01 Jul 2013 01:14:57 +0000
Subject: Re: [PATCH] ARM: shmobile: Sort r8a7790 MSTP entries
Message-Id: <20130701011456.GA14567@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130628101327.26876.89435.sendpatchset@w520>
In-Reply-To: <20130628101327.26876.89435.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Jun 28, 2013 at 07:13:27PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> The r8a7790 MSTP bits should be kept sorted in the same way
> as on other mach-shmobile SoCs. Move the HSCIF and thermal
> bits to clean up the current state.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks, I will queue this up in the cleanup branch.
