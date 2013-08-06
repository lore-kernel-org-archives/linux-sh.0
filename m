From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 06 Aug 2013 20:09:57 +0000
Subject: Re: [PATCH v6 04/10] media: vb2: Take queue or device lock in vb2_fop_mmap()
Message-Id: <47444631.Heq6Wo9coy@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1375725209-2674-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1375725209-2674-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <201308061239.27188.hverkuil@xs4all.nl>
In-Reply-To: <201308061239.27188.hverkuil@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-media@vger.kernel.org, linux-sh@vger.kernel.org, Sakari Ailus <sakari.ailus@iki.fi>, Katsuya MATSUBARA <matsu@igel.co.jp>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>

Hi Hans,

On Tuesday 06 August 2013 12:39:27 Hans Verkuil wrote:
> On Mon 5 August 2013 19:53:23 Laurent Pinchart wrote:
> > The vb2_fop_mmap() function is a plug-in implementation of the mmap()
> > file operation that calls vb2_mmap() on the queue associated with the
> > video device. Neither the vb2_fop_mmap() function nor the v4l2_mmap()
> > mmap handler in the V4L2 core take any lock, leading to race conditions
> > between mmap() and other buffer-related ioctls such as VIDIOC_REQBUFS.
> > 
> > Fix it by taking the queue or device lock around the vb2_mmap() call.
> 
> Hi Laurent,
> 
> Can you do the same for vb2_fop_get_unmapped_area()?

Sure. I'll repost a v7 of this patch that fixes both mmap and 
get_unmapped_area.

> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> > 
> >  drivers/media/v4l2-core/videobuf2-core.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/media/v4l2-core/videobuf2-core.c
> > b/drivers/media/v4l2-core/videobuf2-core.c index 9fc4bab..bd4bade 100644
> > --- a/drivers/media/v4l2-core/videobuf2-core.c
> > +++ b/drivers/media/v4l2-core/videobuf2-core.c
> > @@ -2578,8 +2578,15 @@ EXPORT_SYMBOL_GPL(vb2_ioctl_expbuf);
> > 
> >  int vb2_fop_mmap(struct file *file, struct vm_area_struct *vma)
> >  {
> >  
> >  	struct video_device *vdev = video_devdata(file);
> > 
> > +	struct mutex *lock = vdev->queue->lock ? vdev->queue->lock : vdev-
>lock;
> > +	int err;
> > 
> > -	return vb2_mmap(vdev->queue, vma);
> > +	if (lock && mutex_lock_interruptible(lock))
> > +		return -ERESTARTSYS;
> > +	err = vb2_mmap(vdev->queue, vma);
> > +	if (lock)
> > +		mutex_unlock(lock);
> > +	return err;
> > 
> >  }
> >  EXPORT_SYMBOL_GPL(vb2_fop_mmap);
-- 
Regards,

Laurent Pinchart
