From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 10 Jan 2014 10:47:09 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7790: add audio clocks
Message-Id: <2087710.fPFk1GzNhU@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <8738l1jzfv.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <8738l1jzfv.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Thursday 09 January 2014 16:51:52 Kuninori Morimoto wrote:
> Hi Laurent
> 
> Thank you for your help
> 
> > 1. Add the old style clocks to Lager
> > 2. Add the new style clocks to BockW
> > 3. Add the new style clocks to Lager
> > 4. Modify the ADG driver to use the new style clocks
> > 5. Remove the old style clocks from BockW
> > 6. Remove the old style clocks from Lager
> 
> Yes it become clean.
> But hmm,
> I guess #5, #6 (#4 too ?) are happen after merge anyway ?
> If so, this is more clean for me.
> 
> 1. Add the old style clocks to Lager
> 2. Modify the ADG driver to use the new style clocks.
>    BockW/Lager clocls are fixed in same patch.

My point is that you need to add the new style clocks to platform code before 
you modify the ADG driver. If adding old style clocks will get merged during 
the same merge window as the new style clocks and the ADG driver changes, I 
don't think there's a point to add them.

> Here, #2 will be done on ALSA branch side after merge,
> and I guess Simon can use it for topic branch for us ?
> 
> # This kind of merge timing something
> # is headache for us :P

-- 
Regards,

Laurent Pinchart

