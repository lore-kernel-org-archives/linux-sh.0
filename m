From: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
Date: Fri, 05 Oct 2012 12:32:04 +0000
Subject: Re: [PATCH 00/14] V4L2 DT support
Message-Id: <506ED344.2020407@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1348754853-28619-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1348754853-28619-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-media@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans Verkuil <hverkuil@xs4all.nl>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Stephen Warren <swarren@wwwdotorg.org>, Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@secretlab.ca>

Hi Guennadi,

Any chance for a GIT tree including this patch series ? I'd like
to see all these pieces put together and I don't seem to find any
base tree that this series would have applied cleanly to.

...(20121005_media_for_v3.7-dt)$ git am -3 \[PATCH\ *
Applying: i2c: add dummy inline functions for when CONFIG_OF_I2C(_MODULE) isn't defined
Applying: of: add a dummy inline function for when CONFIG_OF is not defined
Applying: OF: make a function pointer argument const
Applying: media: add V4L2 DT binding documentation
Applying: media: add a V4L2 OF parser
Applying: media: soc-camera: prepare for asynchronous client probing
Applying: media: soc-camera: support deferred probing of clients
fatal: sha1 information is lacking or useless (drivers/media/platform/soc_camera/soc_camera.c).
Repository lacks necessary blobs to fall back on 3-way merge.
Cannot fall back to three-way merge.
Patch failed at 0007 media: soc-camera: support deferred probing of clients
When you have resolved this problem run "git am --resolved".
If you would prefer to skip this patch, instead run "git am --skip".
To restore the original branch and stop patching run "git am --abort".

--

Thanks,
Sylwester
