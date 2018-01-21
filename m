From: jacopo mondi <jacopo@jmondi.org>
Date: Sun, 21 Jan 2018 17:49:09 +0000
Subject: Re: [PATCH v6 0/9] Renesas Capture Engine Unit (CEU) V4L2 driver
Message-Id: <20180121174909.GP24926@w540>
List-Id: <linux-sh.vger.kernel.org>
References: <1516139101-7835-1-git-send-email-jacopo+renesas@jmondi.org>
 <6fcd22c1-19a5-e0b7-2b00-961e1cd1ebaa@xs4all.nl>
In-Reply-To: <6fcd22c1-19a5-e0b7-2b00-961e1cd1ebaa-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
Cc: Jacopo Mondi <jacopo+renesas-AW8dsiIh9cEdnm+yROfE0A@public.gmane.org>, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, geert-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sakari.ailus-X3B1VOXEql0@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pombredanne-od1rfyK75/E@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Hans,

On Fri, Jan 19, 2018 at 12:26:09PM +0100, Hans Verkuil wrote:
> Hi Jacopo,
>
> On 01/16/18 22:44, Jacopo Mondi wrote:
> > Hello,
> >    new version of CEU after Hans' review.
> >
> > Added his Acked-by to most patches and closed review comments.
> > Running v4l2-compliance, I noticed a new failure introduced by the way I now
> > calculate the plane sizes in set/try_fmt.
> >
> > This is the function used to update per-plane bytesperline and sizeimage:
> >
> > static void ceu_update_plane_sizes(struct v4l2_plane_pix_format *plane,
> > 				   unsigned int bpl, unsigned int szimage)
> > {
> > 	if (plane->bytesperline < bpl)
> > 		plane->bytesperline = bpl;
> > 	if (plane->sizeimage < szimage)
> > 		plane->sizeimage = szimage;
> > }
> >
> > I'm seeing a failure as v4l2-compliance requires buffers with both bytesperline
> > and sizeimage set to MAX_INT . Hans, is this expected from v4l2-compliance?
> > How should I handle this, if that has to be handled by the single drivers?
>
> I commented on this in my review of patch 3/9.

Fixed thank you.

>
> >
> > Apart from that, here it is the output of v4l2-compliance, with the last tests
> > failing due to the above stated reason, and two errors in try/set format due to
> > the fact the driver is not setting ycbcr encoding after it receives an invalid
>
> Which driver? The CEU driver or the sensor driver? I don't actually see where
> it fails.
>

Here it is:

                fail: v4l2-test-formats.cpp(335): ycbcr_enc >= 0xff
                fail: v4l2-test-formats.cpp(451): testColorspace(pix_mp.pixelformat, pix_mp.colorspace, pix_mp.ycbcr_enc, pix_mp.quantization)
                fail: v4l2-test-formats.cpp(736): Video Capture Multiplanar is valid, but TRY_FMT failed to return a format
                test VIDIOC_TRY_FMT: FAIL
                fail: v4l2-test-formats.cpp(335): ycbcr_enc >= 0xff
                fail: v4l2-test-formats.cpp(451): testColorspace(pix_mp.pixelformat, pix_mp.colorspace, pix_mp.ycbcr_enc, pix_mp.quantization)
                fail: v4l2-test-formats.cpp(996): Video Capture Multiplanar is valid, but no S_FMT was implemented
                test VIDIOC_S_FMT: FAIL


> > format. I would set those, but I'm not sure what it the correct value and not
> > all mainline drivers do that.
>
> In any case, the default for ycbcr_enc, xfer_func and quantization is 0.
>

Thanks again. I do expect to be the sensor driver to set ycbcr_enc and
quantization, but from a very trivial grep on media/i2c/ I see only a
few drivers taking care of them (adv7511 and adv7842). What about the
others? I assume v4l2-compliance would not fail on them as it does on
ov7670, but I don't see where ycbr_enc (and others) are managed.

Overall, with this addressed, the other issue I mentioned on patch
[3/9] on readbuffers clarified and frameinterval handled for ov722x, I
hope we're done with this series. Thanks again your continued effort
in reviews and guidance.

Thanks
   j

> >
> > -------------------------------------------------------------------------------
> > v4l2-compliance SHA   : 1d3c611dee82090d9456730e24af368b51dcb4a9
>
> I can't find this SHA in the v4l-utils repo. You should always compile
> v4l2-compliance from the master branch.
>
> Also test with 'v4l2-compliance -f': this tests streaming in all formats.
>
> >
> > Driver Info:
> > 	Driver name   : renesas-ceu
> > 	Card type     : Renesas CEU e8210000.ceu
> > 	Bus info      : platform:renesas-ceu-e8210000.c
> > 	Driver version: 4.14.0
> > 	Capabilities  : 0x84201000
> > 		Video Capture Multiplanar
> > 		Streaming
> > 		Extended Pix Format
> > 		Device Capabilities
> > 	Device Caps   : 0x04201000
> > 		Video Capture Multiplanar
> > 		Streaming
> > 		Extended Pix Format
> >
> > Compliance test for device /dev/video0 (not using libv4l2):
> >
> > Required ioctls:
> > 	test VIDIOC_QUERYCAP: OK
> >
> > Allow for multiple opens:
> > 	test second video open: OK
> > 	test VIDIOC_QUERYCAP: OK
> > 	test VIDIOC_G/S_PRIORITY: OK
> > 	test for unlimited opens: OK
> >
> > Debug ioctls:
> > 	test VIDIOC_DBG_G/S_REGISTER: OK
> > 	test VIDIOC_LOG_STATUS: OK (Not Supported)
> >
> > Input ioctls:
> > 	test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
> > 	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
> > 	test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
> > 	test VIDIOC_ENUMAUDIO: OK (Not Supported)
> > 	test VIDIOC_G/S/ENUMINPUT: OK
> > 	test VIDIOC_G/S_AUDIO: OK (Not Supported)
> > 	Inputs: 1 Audio Inputs: 0 Tuners: 0
> >
> > Output ioctls:
> > 	test VIDIOC_G/S_MODULATOR: OK (Not Supported)
> > 	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
> > 	test VIDIOC_ENUMAUDOUT: OK (Not Supported)
> > 	test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
> > 	test VIDIOC_G/S_AUDOUT: OK (Not Supported)
> > 	Outputs: 0 Audio Outputs: 0 Modulators: 0
> >
> > Input/Output configuration ioctls:
> > 	test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
> > 	test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
> > 	test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
> > 	test VIDIOC_G/S_EDID: OK (Not Supported)
> >
> > Test input 0:
> >
> > 	Control ioctls:
> > 		test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
> > 		test VIDIOC_QUERYCTRL: OK
> > 		test VIDIOC_G/S_CTRL: OK
> > 		test VIDIOC_G/S/TRY_EXT_CTRLS: OK
> > 		fail: v4l2-test-controls.cpp(782): subscribe event for control 'User Controls' failed
> > 		test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: FAIL
> > 		test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
> > 		Standard Controls: 12 Private Controls: 0
> >
> > 	Format ioctls:
> > 		test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
> > 		fail: v4l2-test-formats.cpp(1162): ret && node->has_frmintervals
> > 		test VIDIOC_G/S_PARM: FAIL
> > 		test VIDIOC_G_FBUF: OK (Not Supported)
> > 		test VIDIOC_G_FMT: OK
> > 		fail: v4l2-test-formats.cpp(335): ycbcr_enc >= 0xff
> > 		fail: v4l2-test-formats.cpp(451): testColorspace(pix_mp.pixelformat, pix_mp.colorspace, pix_mp.ycbcr_enc, pix_mp.quantization)
> > 		fail: v4l2-test-formats.cpp(736): Video Capture Multiplanar is valid, but TRY_FMT failed to return a format
> > 		test VIDIOC_TRY_FMT: FAIL
> > 		fail: v4l2-test-formats.cpp(335): ycbcr_enc >= 0xff
> > 		fail: v4l2-test-formats.cpp(451): testColorspace(pix_mp.pixelformat, pix_mp.colorspace, pix_mp.ycbcr_enc, pix_mp.quantization)
> > 		fail: v4l2-test-formats.cpp(996): Video Capture Multiplanar is valid, but no S_FMT was implemented
> > 		test VIDIOC_S_FMT: FAIL
> > 		test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
> > 		test Cropping: OK (Not Supported)
> > 		test Composing: OK (Not Supported)
> > 		test Scaling: OK (Not Supported)
> >
> > 	Codec ioctls:
> > 		test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
> > 		test VIDIOC_G_ENC_INDEX: OK (Not Supported)
> > 		test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)
> >
> > 	Buffer ioctls:
> > 		test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
> > 		test VIDIOC_EXPBUF: OK
> >
> > Test input 0:
> >
> >
> > Total: 43, Succeeded: 39, Failed: 4, Warnings: 0
>
> 'Failed' must be 0, otherwise I won't Ack this driver.
>
> Regards,
>
> 	Hans
