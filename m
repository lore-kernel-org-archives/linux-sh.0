From: Simon Horman <horms@verge.net.au>
Date: Wed, 27 Mar 2013 10:47:53 +0000
Subject: Re: [PATCH 2/3] ARM: shmobile: sh73a0: add irqpin DT nodes
Message-Id: <20130327104753.GG3040@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1303211659580.32438@axis700.grange>
 <Pine.LNX.4.64.1303211704130.32438@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1303211704130.32438@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Mar 21, 2013 at 05:05:40PM +0100, Guennadi Liakhovetski wrote:
> Add DT nodes for the 4 irqpin interrupt controllers on sh73a0. We add them
> to sh73a0.dtsi, which is also used by configurations, doing all their
> device instantiation from board the .c code. We rely on the fact, that
> such configurations don't instantiate devices from the device-tree.

Thanks, queued up for v3.10 in the soc branch of the renesas tree.
