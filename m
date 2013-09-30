From: Simon Horman <horms@verge.net.au>
Date: Mon, 30 Sep 2013 00:56:05 +0000
Subject: Re: [PATCH v6] ARM: shmobile: armadillo800eva-reference: add SDHI and MMCIF interfaces
Message-Id: <20130930005604.GD30501@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1309270957470.23205@axis700.grange>
 <6703080.azytcWtciQ@avalon>
In-Reply-To: <6703080.azytcWtciQ@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org

On Sat, Sep 28, 2013 at 03:33:07AM +0200, Laurent Pinchart wrote:
> Hi Guennadi,
> 
> Thank you for the patch.
> 
> On Friday 27 September 2013 10:02:57 Guennadi Liakhovetski wrote:
> > Add SDHI0 and MMCIF interfaces to armadillo800eva-reference with
> > regulators and pin configurations. SDHI1 is not added yet, because the
> > switch, that connects the interface either to an SD slot or to a WiFi
> > SDIO card cannot be described in DT yet.
> > 
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> 
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks, I have queued this up for v3.13.
