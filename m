From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 08 Oct 2012 21:14:01 +0000
Subject: Re: [PATCH 04/14] media: add V4L2 DT binding documentation
Message-Id: <Pine.LNX.4.64.1210082312570.14454@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1348754853-28619-1-git-send-email-g.liakhovetski@gmx.de>
 <Pine.LNX.4.64.1210021626220.15778@axis700.grange>
 <507330E6.1010409@wwwdotorg.org> <4043536.qVaHVXMbPA@avalon>
In-Reply-To: <4043536.qVaHVXMbPA@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>, Sylwester Nawrocki <sylvester.nawrocki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, 8 Oct 2012, Laurent Pinchart wrote:

> On Monday 08 October 2012 14:00:38 Stephen Warren wrote:
> > On 10/02/2012 08:33 AM, Guennadi Liakhovetski wrote:
> > > On Tue, 2 Oct 2012, Rob Herring wrote:
> > >> On 09/27/2012 09:07 AM, Guennadi Liakhovetski wrote:
> > >>> This patch adds a document, describing common V4L2 device tree bindings.
> > >>> 
> > >>> diff --git a/Documentation/devicetree/bindings/media/v4l2.txt
> > >>> b/Documentation/devicetree/bindings/media/v4l2.txt>> 
> > >> One other comment below:
> > >>> +
> > >>> +General concept
> > >>> +---------------
> > >>> +
> > >>> +Video pipelines consist of external devices, e.g. camera sensors,
> > >>> controlled +over an I2C, SPI or UART bus, and SoC internal IP blocks,
> > >>> including video DMA +engines and video data processors.
> > >>> +
> > >>> +SoC internal blocks are described by DT nodes, placed similarly to
> > >>> other SoC +blocks. External devices are represented as child nodes of
> > >>> their respective bus +controller nodes, e.g. I2C.
> > >>> +
> > >>> +Data interfaces on all video devices are described by "port" child DT
> > >>> nodes. +Configuration of a port depends on other devices participating
> > >>> in the data +transfer and is described by "link" DT nodes, specified as
> > >>> children of the +"port" nodes:
> > >>> +
> > >>> +/foo {
> > >>> +	port@0 {
> > >>> +		link@0 { ... };
> > >>> +		link@1 { ... };
> > >>> +	};
> > >>> +	port@1 { ... };
> > >>> +};
> > >>> +
> > >>> +If a port can be configured to work with more than one other device on
> > >>> the same +bus, a "link" child DT node must be provided for each of
> > >>> them. If more than one +port is present on a device or more than one
> > >>> link is connected to a port, a +common scheme, using "#address-cells,"
> > >>> "#size-cells" and "reg" properties is +used.
> > >>> +
> > >>> +Optional link properties:
> > >>> +- remote: phandle to the other endpoint link DT node.
> > >> 
> > >> This name is a little vague. Perhaps "endpoint" would be better.
> > > 
> > > "endpoint" can also refer to something local like in USB case. Maybe
> > > rather the description of the "remote" property should be improved?
> > 
> > The documentation doesn't show up in all the .dts files that use it; it
> > might be useful to try and make the .dts file as obviously readable as
> > possible.
> > 
> > Perhaps "remote-port" or "connected-port" would be sufficiently descriptive.
> 
> I like remote-port better than the already proposed remote-link.

Yes, remote-port sounds better, than remote-link, but might be more 
difficult to correlate with the fact, that the phandle value of this 
property points to a link DT node, and not to a port.

Thanks
Guennadi

> > (and yes, I know I'm probably bike-shedding now).
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
