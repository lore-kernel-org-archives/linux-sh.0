From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 15 Dec 2014 09:32:00 +0000
Subject: Re: [PATCH 2/5] i2c: sh_mobile: add DMA support
Message-Id: <CAMuHMdWCdvnUAsZOYNfmzat5wfPnaKf1H4mupg0L0mLLKuwqQA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1415355104-2031-1-git-send-email-wsa@the-dreams.de>
	<2462101.Er8OZg9N24@avalon>
	<20141211214732.GC21482@katana>
	<1729516.HWbfnj3Cpn@avalon>
	<20141215064306.GN16827@intel.com>
	<CAMuHMdWsUkQN-+h07Zf2snbD9bEw49_+rasY4zS8QcvqA+aXUQ@mail.gmail.com>
	<20141215090628.GB1031@katana>
In-Reply-To: <20141215090628.GB1031@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Wolfram,

On Mon, Dec 15, 2014 at 10:06 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
>> Solutions under consideration:
>>   1. Wolfram posted a patch to make i2c-sh_mobile fall back to PIO,
>>   and retry DMA initialization in every request, so it will switch to
>>   DMA when it becomes available. But this is suboptimal, as it adds
>>   overhead to every request (and DMA may never become available in
>>   case 2).
>
> Still, I'd think I should repost my patches with your comments
> addressed. It does add a bit of overhead IF the dmaengine core is
> compiled in AND the driver for the DMA hardware is not. Well, yeah. On
> the other hand, it fixes the regression that the driver is not even
> loaded in that case (because it currently will be deferred endlessly).
>
> What do you think?

I think it doesn't hurt to repost, now more people understand the intrinsics
of the problem.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
