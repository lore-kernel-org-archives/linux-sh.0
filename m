From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 01 May 2013 05:38:21 +0000
Subject: Re: [PATCH v2 1/4] V4L2: soc_camera: Renesas R-Car VIN driver
Message-Id: <Pine.LNX.4.64.1305010733400.8781@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <201304200231.31802.sergei.shtylyov@cogentembedded.com>
 <Pine.LNX.4.64.1304201201370.10520@axis700.grange> <517D7195.1020301@cogentembedded.com>
 <518000EE.40502@cogentembedded.com>
In-Reply-To: <518000EE.40502@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, mchehab@redhat.com, Linux Media Mailing List <linux-media@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, phil.edworthy@renesas.com, matsu@igel.co.jp

On Tue, 30 Apr 2013, Vladimir Barinov wrote:

[snip]

> > > > +static int rcar_vin_init_videobuf2(struct vb2_queue *vq,
> > > > +                   struct soc_camera_device *icd)
> > > > +{
> > > > +    vq->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
> > > > +    vq->io_modes = VB2_MMAP | VB2_USERPTR;
> > > > +    vq->drv_priv = icd;
> > > > +    vq->ops = &rcar_vin_vb2_ops;
> > > > +    vq->mem_ops = &vb2_dma_contig_memops;
> > > > +    vq->buf_struct_size = sizeof(struct rcar_vin_buffer);
> > 
> > > Please, add
> > 
> > >     vq->timestamp_type = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
> > 
> There is not such field in "struct vb2_queue".

Please, look at the current kernel, e.g. the "next" tree, within days 
this will be in Linus' tree too. Mainline submissions should always be 
developed against the newest kernel version.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
