From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 26 Apr 2010 07:11:12 +0000
Subject: Re: [PATCH] sh: Fix maximum number of SCIF ports in R2D defconfigs
Message-Id: <20100426071112.GH11770@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20100422060604.8151.71593.sendpatchset@t400s>
In-Reply-To: <20100422060604.8151.71593.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Apr 22, 2010 at 03:06:04PM +0900, Magnus Damm wrote:
> Update the R2D defconfigs to bump up the maximum
> number of SCIF ports on the system.
> 
> Fixes a broken serial console regression added
> by cd5f107628ab89c5dec5ad923f1c27f4cba41972.

On Thu, Apr 22, 2010 at 03:21:10PM +0900, Magnus Damm wrote:
> This patch updates the sh7751 pci code to handle io ports
> correctly. The code is based on the sh7788x implementation.
> 
> Tested on a R2D-1 board with CONFIG_8139TOO_PIO=y.

Both applied for 2.6.34, thanks.
