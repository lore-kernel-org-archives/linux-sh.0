From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Date: Wed, 25 Jul 2018 09:54:53 +0000
Subject: Re: [GIT PULL FOR v4.19] Various fixes
Message-Id: <20180725065445.01e9b80a@coco.lan>
List-Id: <linux-sh.vger.kernel.org>
References: <a9296b29-09ad-9379-0786-de282b71abf2@xs4all.nl>
        <20180724190413.77025078@coco.lan>
        <20180725071853.GN6784@w540>
In-Reply-To: <20180725071853.GN6784@w540>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jacopo mondi <jacopo@jmondi.org>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, Linux Media Mailing List <linux-media@vger.kernel.org>, Jacopo Mondi <jacopo+renesas@jmondi.org>, Ezequiel Garcia <ezequiel@collabora.com>, Niklas =?UTF-8?B?U8O2ZGVybHVu?= =?UTF-8?B?ZA==?= <niklas.soderlund+renesas@ragnatech.se>, ysato@users.sourceforge.jp, dalias@libc.org, linux-sh@vger.kernel.org

Jacopo,

Please don't do top posting! I reordered the thread for it to be at
the way it should be.

Em Wed, 25 Jul 2018 09:18:53 +0200
jacopo mondi <jacopo@jmondi.org> escreveu:

> On Tue, Jul 24, 2018 at 07:04:13PM -0300, Mauro Carvalho Chehab wrote:
> > Em Wed, 18 Jul 2018 12:38:58 +0200
> > Hans Verkuil <hverkuil@xs4all.nl> escreveu:
> >  
> > > Hi Mauro,
> > >
> > > Various fixes. Please note that I re-added the 'Add support for STD ioctls on subdev nodes'
> > > patch. It really is needed.
> > >
> > > Regards,
> > >
> > > 	Hans
> > >  
> >  
> > > Jacopo Mondi (9):
> > >       sh: defconfig: migor: Update defconfig
> > >       sh: defconfig: migor: Enable CEU and sensor drivers
> > >       sh: defconfig: ecovec: Update defconfig
> > >       sh: defconfig: ecovec: Enable CEU and video drivers
> > >       sh: defconfig: se7724: Update defconfig
> > >       sh: defconfig: se7724: Enable CEU and sensor driver
> > >       sh: defconfig: ap325rxa: Update defconfig
> > >       sh: defconfig: ap325rxa: Enable CEU and sensor driver  
> >
> > I didn't apply the above ones. I understand you want to enable
> > the sensor drivers there, but It should either go via SUPERH
> > tree or we would need his ack to merge on our tree.
> >  
> > >       sh: migor: Remove stale soc_camera include  
> >
> > It caused me lots of doubts if we should either apply this one
> > via the media tree or not. I ended by applying, as we're maintaining
> > the soc_camera stuff, with are being removed. So, it makes more sense
> > to merge it via our tree.
> >
> > Still, it would be nicer if we had the SUPERH maintainer's ack on
> > it.
> >
> >
> > Thanks,
> > Mauro  
>
>
> Mauro,
>    I understand, and I failed to cc the SH people initially.
> 
> Roping in Sato-san, Rich and the SH list.
> Could you guys please have a look here? I've gone through the media
> tree as all these changes sparkled from soc_camera removal, and while
> I was there I updated the defconfigs before enabling CEU and disabling
> soc_camera.
> 
> How long before we miss v4.19 Mauro?

That depends on the policies SH people have. This is just build config
stuff, so I guess it could be applied anytime without much issues.

From my side, I'm planning to apply the latest patches for 4.19 along
this week, reserving the next week for bug fixes only and janitorial
work.

> 
> Thanks
>    j
> 


Thanks,
Mauro
