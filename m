From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 17 Mar 2011 08:21:58 +0000
Subject: Re: [PATCH] sh: add GETHER's platform_device in board-sh7757lcr
Message-Id: <20110317082157.GC13315@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4D75E200.4040409@renesas.com>
In-Reply-To: <4D75E200.4040409@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Mar 08, 2011 at 05:00:00PM +0900, Yoshihiro Shimoda wrote:
> This patch also modifies for ETHER's platform_device.

On Tue, Mar 08, 2011 at 05:00:04PM +0900, Yoshihiro Shimoda wrote:
> A new parameter is added to sh_eth_plat_data. And the sh_eth driver
> needs additional memory resource if a module has TSU.

Both applied, thanks.
