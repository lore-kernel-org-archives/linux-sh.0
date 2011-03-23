From: Simon Horman <horms@verge.net.au>
Date: Wed, 23 Mar 2011 23:16:24 +0000
Subject: Re: [PATCH 0/6 v2] mmc: split the tmio driver into several modules
Message-Id: <20110323231624.GA30365@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1103231156220.6836@axis700.grange>
 <20110323230232.GN20341@verge.net.au>
In-Reply-To: <20110323230232.GN20341@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>, Magnus Damm <magnus.damm@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Paul Mundt <lethal@linux-sh.org>

On Thu, Mar 24, 2011 at 08:02:32AM +0900, Simon Horman wrote:
> Hi Guennadi,
> 
> which tree does this series apply to?
> 
> I have tried both Linus's tree and the mmc-next branch of the mmc tree
> without success.

Actually, could you consider taking my patch into your series?
Any rebase should be trivial.

The patch is:
[PATCH 1/4] mmc: tmio_mmc: Move some defines into a shared header
