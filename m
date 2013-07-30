From: Sakari Ailus <sakari.ailus@iki.fi>
Date: Tue, 30 Jul 2013 11:32:21 +0000
Subject: Re: [PATCH v3 4/5] v4l: Add V4L2_PIX_FMT_NV16M and V4L2_PIX_FMT_NV61M formats
Message-Id: <20130730113221.GO12281@valkosipuli.retiisi.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1374757213-20194-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <1374757213-20194-5-git-send-email-laurent.pinchart@ideasonboard.com>
 <20130730110934.GN12281@valkosipuli.retiisi.org.uk>
 <3004984.tPvT1zp9Z5@avalon>
In-Reply-To: <3004984.tPvT1zp9Z5@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-sh@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>, Katsuya MATSUBARA <matsu@igel.co.jp>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>

On Tue, Jul 30, 2013 at 01:16:54PM +0200, Laurent Pinchart wrote:
...
> > > +	<para>This is a multi-planar, two-plane version of the YUV 4:2:0 
> format.
> > > +The three components are separated into two sub-images or planes.
> > > +<constant>V4L2_PIX_FMT_NV16M</constant> differs from
> > > <constant>V4L2_PIX_FMT_NV16 +</constant> in that the two planes are
> > > non-contiguous in memory, i.e. the chroma +plane do not necessarily
> > > immediately follows the luma plane.
> > > +The luminance data occupies the first plane. The Y plane has one byte per
> > > pixel. +In the second plane there is a chrominance data with alternating
> > > chroma samples. +The CbCr plane is the same width and height, in bytes,
> > > as the Y plane. +Each CbCr pair belongs to four pixels. For example,
> > > +Cb<subscript>0</subscript>/Cr<subscript>0</subscript> belongs to
> > > +Y'<subscript>00</subscript>, Y'<subscript>01</subscript>,
> > > +Y'<subscript>10</subscript>, Y'<subscript>11</subscript>.
> > > +<constant>V4L2_PIX_FMT_NV61M</constant> is the same as
> > > <constant>V4L2_PIX_FMT_NV16M</constant> +except the Cb and Cr bytes are
> > > swapped, the CrCb plane starts with a Cr byte.</para> +
> > > +	<para><constant>V4L2_PIX_FMT_NV16M</constant> is intended to be
> > > +used only in drivers and applications that support the multi-planar API,
> > > +described in <xref linkend="planar-apis"/>. </para>
> > 
> > I think you could refer to V4L2_PIX_FMT_NV61M or alternatively move the
> > sentence explaining V4L2_PIX_FMT_NV61M after the above. Up to you.
> 
> Something like
> 
>         <para><constant>V4L2_PIX_FMT_NV16M</constant> and 
> <constant>V4L2_PIX_FMT_NV61M</constant> are intended to be used only in 
> drivers and applications that support the multi-planar API, described in 

Fine for me.

-- 
Cheers,

Sakari Ailus
e-mail: sakari.ailus@iki.fi	XMPP: sailus@retiisi.org.uk
