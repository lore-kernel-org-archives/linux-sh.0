From: Barry Song <21cnbao@gmail.com>
Date: Mon, 08 Apr 2013 11:49:35 +0000
Subject: Re: [PATCH 10/14] media: soc-camera: support OF cameras
Message-Id: <CAGsJ_4wYCARgV-YZ6uRTTjBvqNb1Ryzagb3AOmGjQksX-OFFzA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1348754853-28619-1-git-send-email-g.liakhovetski@gmx.de>
 <1348754853-28619-11-git-send-email-g.liakhovetski@gmx.de>
 <CAGsJ_4zYvF-U0_ETs9EP8i+bOJiJLkXWrJdMNnW_sXU-QwnXQw@mail.gmail.com> <Pine.LNX.4.64.1304081308000.29945@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1304081308000.29945@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-media@vger.kernel.org, linux-sh@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Magnus Damm <magnus.damm@gmail.com>, Hans Verkuil <hverkuil@xs4all.nl>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, zilong.wu@csr.com, "renwei.wu" <renwei.wu@csr.com>, xiaomeng.hou@csr.com

Hi Guennadi,

2013/4/8 Guennadi Liakhovetski <g.liakhovetski@gmx.de>:
> Hi Barry
>
> On Mon, 8 Apr 2013, Barry Song wrote:
>
>> hi Guennadi,
>>
>> 2012/9/27 Guennadi Liakhovetski <g.liakhovetski@gmx.de>:
>> > With OF we aren't getting platform data any more. To minimise changes we
>> > create all the missing data ourselves, including compulsory struct
>> > soc_camera_link objects. Host-client linking is now done, based on the OF
>> > data. Media bus numbers also have to be assigned dynamically.
>> >
>> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>>
>> as your V4L2 core DT based supports
>> [media] Add a V4L2 OF parser
>> [media] Add common video interfaces OF bindings documentation
>> have been in media_tree queue for 3.10. i do care about the status of
>> this patch for soc_camera.
>>
>> will you have a plan to resend these soc-camera patches based on your
>> final V4L2 core DT patches? otherwise, we might do some jobs for that.
>
> This patch depends not only on the above two OF patches, that Sylwester
> kindly polished to make them finally suitable for the mainline :-), but
> also on V4L2 (temporary) clock and asynchronous probing patches, which
> I've just re-posted in their v7. Once those patches stabilise, it will be
> possible to re-spin this patch too. However, currently I don't have any
> interested users for this work, so I can only run it as a low priority
> task in my spare time, of which I don't have much.

as we are considering putting CSR SiRFprimaII/SiRFatlas6/SiRFmarco
soc_camera based drivers in drivers/media/platform/soc_camera, so we
might become your real user. Old imx, omap users might have lost the
loop.
I will take a careful at all these patches and find the way to make
the things happen faster.

>
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/

-barry
