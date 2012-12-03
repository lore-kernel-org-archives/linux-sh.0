From: "Koul, Vinod" <vinod.koul@intel.com>
Date: Mon, 03 Dec 2012 17:48:27 +0000
Subject: RE: [PATCH 3.7] dma: sh: Don't use ENODEV for failing slave lookup
Message-Id: <8D3F6266AEB6384E807C6FFC6FE195E302270D4C@BGSMSX101.gar.corp.intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1211280740190.32652@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1211280740190.32652@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

> 
> If dmaengine driver's .device_alloc_chan_resources() method returns -ENODEV,
> dma_request_channel() will decide, that the driver has been removed and will remove
> the device from its list. To prevent this use ENXIO if a slave lookup fails.
> 
> Reported-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Applied thanks, CCed stable as well

--
~Vinod
