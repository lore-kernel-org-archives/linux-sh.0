From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 25 Jul 2013 11:44:12 +0000
Subject: Re: [PATCH v2 3/5] v4l: Add media format codes for ARGB8888 and AYUV8888 on 32-bit busses
Message-Id: <2328654.t4tri5nhxO@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1374072882-14598-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1374072882-14598-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <51F04688.6090900@gmail.com>
In-Reply-To: <51F04688.6090900@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-media@vger.kernel.org, linux-sh@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>, Sakari Ailus <sakari.ailus@iki.fi>

Hi Sylwester,

On Wednesday 24 July 2013 23:26:32 Sylwester Nawrocki wrote:
> On 07/17/2013 04:54 PM, Laurent Pinchart wrote:
> > Signed-off-by: Laurent Pinchart<laurent.pinchart+renesas@ideasonboard.com>
> > 
> > ---
> > 
> >   Documentation/DocBook/media/v4l/subdev-formats.xml | 609   ++++++-------
> >   Documentation/DocBook/media_api.tmpl               |   6 +
> >   include/uapi/linux/v4l2-mediabus.h                 |   6 +-
> >   3 files changed, 254 insertions(+), 367 deletions(-)
> > 
> > diff --git a/Documentation/DocBook/media/v4l/subdev-formats.xml
> > b/Documentation/DocBook/media/v4l/subdev-formats.xml index
> > 0c2b1f2..9100674 100644
> > --- a/Documentation/DocBook/media/v4l/subdev-formats.xml
> > +++ b/Documentation/DocBook/media/v4l/subdev-formats.xml
> > @@ -97,31 +97,39 @@
> 
> [...]
> 
> > +	<row id="V4L2-MBUS-FMT-ARGB888-1X24">
> > +	<entry>V4L2_MBUS_FMT_ARGB888_1X24</entry>
> 
> This should be V4L2_MBUS_FMT_ARGB888_1X32, right ?

Oops, indeed.

> 
> Fix this correction feel free to add:
> 
>   Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

Thank you.

> > +	<entry>0x100d</entry>
> > +	<entry></entry>

-- 
Regards,

Laurent Pinchart

