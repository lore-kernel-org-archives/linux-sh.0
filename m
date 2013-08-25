From: Vinod Koul <vinod.koul@intel.com>
Date: Sun, 25 Aug 2013 07:46:20 +0000
Subject: Re: [PATCH] DMA: shdma: fix CHCLR register address calculation
Message-Id: <20130825073420.GC8091@intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1307021733280.1965@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1307021733280.1965@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

On Tue, Jul 02, 2013 at 05:37:58PM +0200, Guennadi Liakhovetski wrote:
> struct sh_dmae_device::chan_reg is a pointer to u32, therefore when adding
> offsets to it care should be taken to add offsets in sizeof(u32) units, not
> in bytes. This patch corrects such a bug. While at it we also remove the
> redundant parameter of the affected function.
Applied, thanks

~Vinod
