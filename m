From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 27 Feb 2009 06:33:07 +0000
Subject: Re: [PATCH 2/2] Add support ov772x driver setting to ap325
Message-Id: <20090227063307.GA28802@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <uhc3skvqd.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uhc3skvqd.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Feb 20, 2009 at 11:33:18AM +0900, morimoto.kuninori@renesas.com wrote:
> 
> Dear Iwamatsu-san
> 
> > Please exclude this commit from sh/for-2.6.29.
> > Because patces for media/ov772x.h is not yet taken in in 2.6.29-rcX,
> > compiling it fails.
> > 
> > http://thread.gmane.org/gmane.linux.drivers.video-input-infrastructure/594
> 
> I'm so sorry.
> Yesterday, soc_camera maintainer (Guennadi) sent pull request to Mauro.
> ap325 needs [07/14: ov772x: Add image flip support].
> 
> http://www.mail-archive.com/linux-media@vger.kernel.org/msg01778.html
> 
I've reverted it in the 2.6.29 tree, but it is still there for 2.6.30,
which should now be settled in -next.
