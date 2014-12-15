From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 15 Dec 2014 23:49:20 +0000
Subject: Re: [PATCH 0/2] Add VSP1 devices to DT for r8a7790 and r8a7791
Message-Id: <3340292.c9zq3U75Jo@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1410651385-13090-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1410651385-13090-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Devendra,

On Monday 15 December 2014 03:42:59 Devendra Talegaonkar wrote:
> Laurent Pinchart writes:
> > On Tuesday 30 September 2014 13:47:32 Cao Minh Hiep wrote:
> > > Hi Laurent,
> > > 
> > > We are testing the upstream linux version on Lager.
> > > I have tried to test VSP1 driver on r8a7790(Lager).
> > > But I don't know how to test it.
> > > Could you please tell the method to test it?
> > 
> > Sure.
> > 
> > I've attached the test script I use to configure the VSP1 pipeline to this
> > e- mail.
> > 
> > Syntax: vsp1.sh dev cmd [...]
> > 
> > Supported commands:
> >  - m2d | m2d-bru | m2d-crop | m2d-scale | m2m | m2m-crop | m2m-scale infmt
> > 
> > outfmt
> > 
> >  - input index infmt
> >  - output index outfmt
> > 
> > The input and output commands will invoke yavta to capture images from a
> > WPF (output) or stream images to an RPF (input). You can find a tarball
> > with the test frames I use at
> > http://www.ideasonboard.org/frame-reference.tar.bz2, but you can replace
> > them with any binary test image.
> 
> Hello,
> I am testing VSP1 on lager board. You have mentioned that by invoking input
> command, file can be streamed to RPF. Does that mean, If we stream the file
> via input command we can seee it on LCD via VSPD0. If my understanding is
> correct can you explain how to test that by setting plane priority? Because
> VSPD0 can out put the data on predefined plane.
> As I am stuck here, awaiting for the earliest response.

The direct connection between the VSPD and the DU isn't supported in the 
mainline kernel I'm afraid. I've implemented it in out-of-tree patches, but 
they would require extensions to the DRM API that I'm not happy with in their 
current form (so I don't expect the DRM developers to be happy either).

I've rebased the patches on a recent kernel, you can find them at

	git://linuxtv.org/pinchartl/fbdev.git vsp1/devel

Please note that I haven't had time to test the rebased version yet.

You can find a patched version of the modetest utility at

	git://git.ideasonboard.com/renesas/drm.git live

You might need to update the kernel headers, ioctl numbers might have changed 
when I've rebased the kernel patches.

-- 
Regards,

Laurent Pinchart

