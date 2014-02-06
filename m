From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Thu, 06 Feb 2014 12:01:16 +0000
Subject: Re: [PATCH 1/3] mmc: tmio-mmc: add DMA SG synchronisation
Message-Id: <52F3798C.4040906@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1401311237080.3234@axis700.grange>
 <Pine.LNX.4.64.1401311248320.3234@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1401311248320.3234@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 31/01/14 11:54, Guennadi Liakhovetski wrote:
> According to the DMA API data has to be synchronised before starting
> a DMA transfer to device and after completing a DMA transfer from device.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

I've got 1/3 and 2/3, but not 3/3 ?


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
