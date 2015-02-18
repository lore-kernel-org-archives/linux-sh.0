From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 18 Feb 2015 21:16:58 +0000
Subject: Re: [PATCH] [media] soc-camera: Remove bogus devm_kfree() in soc_of_bind()
Message-Id: <Pine.LNX.4.64.1502182216060.31387@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1424277163-24869-1-git-send-email-geert+renesas@glider.be>
 <54E4D2DB.4050909@cogentembedded.com>
In-Reply-To: <54E4D2DB.4050909@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Ben Dooks <ben.dooks@codethink.co.uk>, Mauro Carvalho Chehab <m.chehab@samsung.com>, linux-media@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

On Wed, 18 Feb 2015, Sergei Shtylyov wrote:

> Hello.
> 
> On 02/18/2015 07:32 PM, Geert Uytterhoeven wrote:
> 
> > Unlike scan_async_group(), soc_of_bind() doesn't allocate its
> > soc_camera_async_client structure using devm_kzalloc(), but has it
> > embedded inside the soc_of_info structure.  Hence on failure, it must
> > not free it using devm_kfree(), as this will cause a warning, and may
> > cause slab corruption:
> 
> [...]
> 
> > Fixes: 1ddc6a6caa94e1e1 ("[media] soc_camera: add support for dt binding
> > soc_camera drivers")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > Triggered with shmobile-defconfig on r8a7791/koelsch.
> > ---
> >   drivers/media/platform/soc_camera/soc_camera.c | 1 -
> >   1 file changed, 1 deletion(-)
> 
> > diff --git a/drivers/media/platform/soc_camera/soc_camera.c
> > b/drivers/media/platform/soc_camera/soc_camera.c
> > index cee7b56f84049944..d8a072fe46035821 100644
> > --- a/drivers/media/platform/soc_camera/soc_camera.c
> > +++ b/drivers/media/platform/soc_camera/soc_camera.c
> > @@ -1665,7 +1665,6 @@ eclkreg:
> >   eaddpdev:
> >   	platform_device_put(sasc->pdev);
> >   eallocpdev:
> > -	devm_kfree(ici->v4l2_dev.dev, sasc);
> 
>    Perhaps Ben meant 'info' ISO 'sasc'? This way it would make more sense.

Agree. Geert, could you double-check and respin?

Thanks
Guennadi

> 
> >   	dev_err(ici->v4l2_dev.dev, "group probe failed: %d\n", ret);
> > 
> >   	return ret;
> 
> WBR, Sergei
> 
