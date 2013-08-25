From: Vinod Koul <vinod.koul@intel.com>
Date: Sun, 25 Aug 2013 07:48:01 +0000
Subject: Re: [PATCH v2] DMA: shdma: make a pointer const
Message-Id: <20130825073601.GE8091@intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1308021610240.28012@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1308021610240.28012@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org

On Fri, Aug 02, 2013 at 04:18:09PM +0200, Guennadi Liakhovetski wrote:
> Platform data shouldn't be changed at run-time, so, pointers to it should
> be const.
Applied, thanks

~Vinod
