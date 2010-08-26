From: Marin Mitov <mitov@issp.bas.bg>
Date: Thu, 26 Aug 2010 10:18:22 +0000
Subject: Re: [RFC][PATCH] add dma_reserve_coherent_memory()/dma_free_reserved_memory() API
Message-Id: <201008261318.31784.mitov@issp.bas.bg>
List-Id: <linux-sh.vger.kernel.org>
References: <201008201450.12585.mitov@issp.bas.bg>
	<Pine.LNX.4.64.1008261100150.14167@axis700.grange>
	<20100826091725.GC5355@pengutronix.de>
In-Reply-To: <20100826091725.GC5355@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Thursday, August 26, 2010 12:17:25 pm Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> On Thu, Aug 26, 2010 at 11:06:20AM +0200, Guennadi Liakhovetski wrote:
> > On Thu, 26 Aug 2010, FUJITA Tomonori wrote:
> >=20
> > > On Thu, 26 Aug 2010 09:04:14 +0300
> > > Marin Mitov <mitov@issp.bas.bg> wrote:
> > >=20
> > > > On Thursday, August 26, 2010 08:40:47 am FUJITA Tomonori wrote:
> > > > > On Fri, 20 Aug 2010 14:50:12 +0300
> > > > > Marin Mitov <mitov@issp.bas.bg> wrote:
> > > > >=20
> > > > > > On Friday, August 20, 2010 11:35:06 am FUJITA Tomonori wrote:
> > > > > > > On Fri, 20 Aug 2010 11:13:45 +0300
> > > > > > > Marin Mitov <mitov@issp.bas.bg> wrote:
> > > > > > >=20
> > > > > > > > > > This tric is already used in drivers/staging/dt3155v4l.c
> > > > > > > > > > dt3155_alloc_coherent()/dt3155_free_coherent()
> > > > > > > > > >=20
> > > > > > > > > > Here proposed for general use by popular demand from vi=
deo4linux folks.
> > > > > > > > > > Helps for videobuf-dma-contig framework.
> > > > > > > > >=20
> > > > > > > > > What you guys exactly want to do? If you just want to pre=
-allocate
> > > > > > > > > coherent memory for latter usage,
> > > > > > > >=20
> > > > > > > > Yes, just to preallocate not coherent, but rather contiguou=
s memory for latter usage.
> > > > > > > > We use coherent memory because it turns out to be contiguou=
s.
> > > > > > >=20
> > > > > > > Hmm, you don't care about coherency? You just need contiguous=
 memory?
> > > > > >=20
> > > > > > Yes. We just need contiguous memory. Coherency is important as =
far as when dma
> > > > > > transfer finishes user land is able to see the new data. Could =
be done by something like
> > > > > > dma_{,un}map_single()
> > > > >=20
> > > > > Then, we should avoid using coherent memory as I exaplained befor=
e. In
> > > > > addition, dma_alloc_coherent can't provide large enough contigous
> > > > > memory for some drivers so this patch doesn't help much.
> > > >=20
> > > > Please, look at drivers/media/video/videobuf-dma-contig.c. Using co=
herent memory
> > > > is inavoidable for now, there is no alternative for it for now. The=
 two new functions,
> > > > which I propose are just helpers for those of us who already use co=
herent memory
> > > > (via videobuf-dma-contig API). May be adding these two functions to=
=20
> > > > drivers/media/video/videobuf-dma-contig.c will be better solution?
> > >=20
> > > If you add something to the videobuf-dma-contig API, that's fine by me
> > > because drivers/media/video/videobuf-dma-contig.c uses the own
> > > structure and plays with dma_alloc_coherent. As long as a driver
> > > doesn't touch device->dma_mem directly, it's fine, I think (that is,
> > > dt3155v4l driver is broken). There are already some workarounds for
> > > contigous memory in several drivers anyway.
> >=20
> > No, this will not work - this API has to be used from board code and=20
> > videobuf can be built modular.
> >=20
> > > We will have the proper API for contiguous memory. I don't think that
> > > adding such workaround to the DMA API is a good idea.
> >=20
> > We have currently a number of boards broken in the mainline. They must =
be=20
> > fixed for 2.6.36. I don't think the mentioned API will do this for us. =
So,=20
> > as I suggested earlier, we need either this or my patch series
> >=20
> > http://thread.gmane.org/gmane.linux.ports.sh.devel/8595
> this seems to be more mature to me.  The original patch in this thread
> uses a symbol DT3155_COH_FLAGS which seems misplaced in generic code and
> doesn't put the new functions in a header.

You are right. DT3155_COH_FLAGS should be defined, and a declaration should=
 be=20
put in the headers.

But it is just RFC :-)

Marin Mitov

>=20
> Best regards
> Uwe
>=20
>=20
