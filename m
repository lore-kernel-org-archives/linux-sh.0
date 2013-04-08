From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 08 Apr 2013 11:21:52 +0000
Subject: Re: [PATCH 10/14] media: soc-camera: support OF cameras
Message-Id: <Pine.LNX.4.64.1304081308000.29945@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1348754853-28619-1-git-send-email-g.liakhovetski@gmx.de>
 <1348754853-28619-11-git-send-email-g.liakhovetski@gmx.de>
 <CAGsJ_4zYvF-U0_ETs9EP8i+bOJiJLkXWrJdMNnW_sXU-QwnXQw@mail.gmail.com>
In-Reply-To: <CAGsJ_4zYvF-U0_ETs9EP8i+bOJiJLkXWrJdMNnW_sXU-QwnXQw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "renwei.wu" <renwei.wu-kQvG35nSl+M@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, DL-SHA-WorkGroupLinux <workgroup.linux-kQvG35nSl+M@public.gmane.org>, Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Sylwester Nawrocki <sylvester.nawrocki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, zilong.wu-kQvG35nSl+M@public.gmane.org, xiaomeng.hou-kQvG35nSl+M@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Barry

On Mon, 8 Apr 2013, Barry Song wrote:

> hi Guennadi,
> 
> 2012/9/27 Guennadi Liakhovetski <g.liakhovetski@gmx.de>:
> > With OF we aren't getting platform data any more. To minimise changes we
> > create all the missing data ourselves, including compulsory struct
> > soc_camera_link objects. Host-client linking is now done, based on the OF
> > data. Media bus numbers also have to be assigned dynamically.
> >
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> 
> as your V4L2 core DT based supports
> [media] Add a V4L2 OF parser
> [media] Add common video interfaces OF bindings documentation
> have been in media_tree queue for 3.10. i do care about the status of
> this patch for soc_camera.
> 
> will you have a plan to resend these soc-camera patches based on your
> final V4L2 core DT patches? otherwise, we might do some jobs for that.

This patch depends not only on the above two OF patches, that Sylwester 
kindly polished to make them finally suitable for the mainline :-), but 
also on V4L2 (temporary) clock and asynchronous probing patches, which 
I've just re-posted in their v7. Once those patches stabilise, it will be 
possible to re-spin this patch too. However, currently I don't have any 
interested users for this work, so I can only run it as a low priority 
task in my spare time, of which I don't have much.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
