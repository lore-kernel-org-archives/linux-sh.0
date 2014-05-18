From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Sun, 18 May 2014 21:31:18 +0000
Subject: Re: [PATCH v3 7/7] soc_camera: initial of code
Message-Id: <Pine.LNX.4.64.1405182323550.23804@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1397471802-27216-8-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1397471802-27216-8-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ben,

An additional note:

On Sat, 3 May 2014, Guennadi Liakhovetski wrote:

> On Mon, 14 Apr 2014, Ben Dooks wrote:
> 
> > Add initial support for OF based soc-camera devices that may be used
> > by any of the soc-camera drivers. The driver itself will need converting
> > to use OF.
> > 
> > These changes allow the soc-camera driver to do the connecting of any
> > async capable v4l2 device to the soc-camera driver. This has currently
> > been tested on the Renesas Lager board.
> > 
> > Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> > ---
> > Changes since v1:
> > 
> > 	- Updated to make the i2c mclk name compatible with other
> > 	  drivers. The issue of having mclk which is not part of
> > 	  the drivers/clk interface is something that can be dealt
> > 	  with separately.
> > ---
> >  drivers/media/platform/soc_camera/soc_camera.c | 117 ++++++++++++++++++++++++-
> >  1 file changed, 116 insertions(+), 1 deletion(-)

[snip]

> > +{
> > +	struct device_node *np = ici->v4l2_dev.dev->of_node;
> > +	struct device_node *epn = NULL;
> > +	struct device_node *ren;
> > +
> > +	while (true) {
> > +		epn = v4l2_of_get_next_endpoint(np, epn);
> > +		if (!epn)
> > +			break;
> > +
> > +		ren = v4l2_of_get_remote_port(epn);
> 
> Please, rebase on top of current -next. You'll probably use 
> of_graph_get_next_endpoint() and of_graph_get_remote_port() respectively.

While at it, I think it would be good to also add a call to 
v4l2_of_parse_endpoint() to your patch. I think the atmel-isi driver can 
make use of some endpoint parsing results immediately.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
