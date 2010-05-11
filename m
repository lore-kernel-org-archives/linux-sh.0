From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 11 May 2010 12:38:36 +0000
Subject: Re: [PATCH 0/9 v3] add DMA support to tmio_mmc, using dmaengine API, use it on SH
Message-Id: <20100511123836.GA22690@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1005071625260.4777@axis700.grange> <Pine.LNX.4.64.1005111156170.6810@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1005111156170.6810@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Ian Molton <ian@mnementh.co.uk>, Magnus Damm <magnus.damm@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

On Tue, May 11, 2010 at 12:07:07PM +0200, Guennadi Liakhovetski wrote:
> 2.6.35 release is approaching and Ian hasn't found time yet to review this 
> series, so I was wondering, maybe you could take it into mm at least for 
> now?
> 
Note that the tmio_mmc tree has also been dropped from -next due to being
unreachable. I'm not sure how this impacts the pending changes, though.
