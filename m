From: Simon Horman <horms@verge.net.au>
Date: Thu, 21 Mar 2013 10:35:08 +0000
Subject: Re: [PATCH 1/2] ARM: shmobile: kzm9g: SDHI0 and SDHI1 use a 3.3V power supply
Message-Id: <20130321103508.GC2348@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1303191340060.11768@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1303191340060.11768@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Mar 19, 2013 at 01:47:39PM +0100, Guennadi Liakhovetski wrote:
> kzm9g supplies 3.3V to its SDHI0 and SDHI2 interfaces. Specifying 2.8V
> prevents some (e.g. certain SDIO) cards from working. This patch fixes the
> voltage and removes redundant OCR masks from platform data.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Thanks, applied to the boards branch.
