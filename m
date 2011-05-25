From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 25 May 2011 02:32:17 +0000
Subject: Re: [PATCH 0/3] Make DMA slave ID 0 invalid to simplify platform data
Message-Id: <20110525023217.GF14329@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1105241147010.31628@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1105241147010.31628@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Magnus Damm <damm@opensource.se>, Ian Molton <ian@mnementh.co.uk>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>

On Tue, May 24, 2011 at 12:23:55PM +0200, Guennadi Liakhovetski wrote:
> Currently platforms, using the SDHI TMIO driver, have to specify negative 
> DMA slave IDs to force PIO mode. If default 0 is left, the driver 
> recognises it as a valid DMA slave ID and tries to acquire channels. This 
> fails then, because the driver cannot allocate two channels with the same 
> ID, but it would be better to just make 0 an invalid ID to prevent this.
> 
I suppose the ordering for this will be adding the invalid IDs for all of
the CPUs first and then updating the SDHI driver accordingly during -rc2
or something like that.
