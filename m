From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 06 Apr 2009 15:58:51 +0000
Subject: Re: [PATCH] sh7785lcr: Map whole address space to PCI
Message-Id: <20090406155851.GE17834@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090402180330.00319c4f.yoshii.takashi@renesas.com>
In-Reply-To: <20090402180330.00319c4f.yoshii.takashi@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Apr 06, 2009 at 08:37:15PM +0900, Yoshihiro Shimoda wrote:
> Fix the problem that cannot work PCI device on 32-bit mode because
> influence of the commit 68b42d1b548be1840aff7122fdebeb804daf0fa3
> ("sh: sh7785lcr: Map whole PCI address space."). So this patch was
> implement like a 29-bit mode, map whole physical address space of
> DDR-SDRAM.
> 
> Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>

Applied, thanks.
