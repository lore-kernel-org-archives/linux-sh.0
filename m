From: jacopo mondi <jacopo@jmondi.org>
Date: Mon, 18 Dec 2017 14:12:30 +0000
Subject: Re: [PATCH v1 03/10] v4l: platform: Add Renesas CEU driver
Message-Id: <20171218141230.GH20926@w540>
List-Id: <linux-sh.vger.kernel.org>
References: <1510743363-25798-1-git-send-email-jacopo+renesas@jmondi.org>
 <1510743363-25798-4-git-send-email-jacopo+renesas@jmondi.org>
 <db4d1c15-1a6c-7375-b1e1-e780b628ed04@xs4all.nl>
In-Reply-To: <db4d1c15-1a6c-7375-b1e1-e780b628ed04@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, laurent.pinchart@ideasonboard.com, magnus.damm@gmail.com, geert@glider.be, mchehab@kernel.org, linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Hans,
   thanks for review comments

On Wed, Dec 13, 2017 at 01:03:03PM +0100, Hans Verkuil wrote:
> On 15/11/17 11:55, Jacopo Mondi wrote:
> > Add driver for Renesas Capture Engine Unit (CEU).
> > +
> > +	/* Register the video device */
> > +	strncpy(vdev->name, DRIVER_NAME, strlen(DRIVER_NAME));
> > +	vdev->v4l2_dev		= v4l2_dev;
> > +	vdev->lock		= &ceudev->mlock;
> > +	vdev->queue		= &ceudev->vb2_vq;
> > +	vdev->ctrl_handler	= v4l2_sd->ctrl_handler;
> > +	vdev->fops		= &ceu_fops;
> > +	vdev->ioctl_ops		= &ceu_ioctl_ops;
> > +	vdev->release		= ceu_vdev_release;
> > +	vdev->device_caps	= V4L2_CAP_VIDEO_CAPTURE_MPLANE |
>
> Why MPLANE? It doesn't appear to be needed since there are no multiplane
> (really: multibuffer) pixelformats defined.

The driver support NV12/21 and NV16/61 as output pixel formats (along
with single plane YUYV).

NV* formats are semi-planar, as luma is stored in one buffer, while
chrominances are stored together in a different one. Am I wrong?

> >
>
> Regards,

Thanks
   j

>
> 	Hans
