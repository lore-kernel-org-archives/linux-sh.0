From: Simon Horman <horms@verge.net.au>
Date: Wed, 09 Jan 2013 01:51:12 +0000
Subject: Re: [PATCH 2/2] ARM: shmobile: add a reference DT implementation for mackerel
Message-Id: <20130109015112.GA6496@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1212311213510.24596@axis700.grange>
 <Pine.LNX.4.64.1212311214370.24596@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1212311214370.24596@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Dec 31, 2012 at 12:23:54PM +0100, Guennadi Liakhovetski wrote:
> Add a DT-only mackerel implementation. So far it only contains a limited
> set of devices, already implementing DT support. As more drivers are
> extended with DT initialisation option, respective devices shall be added
> to sh7372-mackerel-reference.dts.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Hi Guennadi,

thanks. This looks good to me.
I will apply it once I have applied the INTC and pinmux changes.
