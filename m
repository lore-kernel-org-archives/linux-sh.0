From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 22 Oct 2014 20:59:35 +0000
Subject: Re: [PATCH v2] ARM: shmobile: Add early debugging support using SCIF(A)
Message-Id: <1467605.AdUxz6EOpv@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1413993263-10444-1-git-send-email-geert+renesas@glider.be>
 <20141022160800.GB1895@katana>
 <CAMuHMdUqWaaP9DKADj3t2gTib9_+nNE5N-teLc2dMk_zVowZFA@mail.gmail.com>
In-Reply-To: <CAMuHMdUqWaaP9DKADj3t2gTib9_+nNE5N-teLc2dMk_zVowZFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Geert,

On Wednesday 22 October 2014 19:34:17 Geert Uytterhoeven wrote:
> On Wed, Oct 22, 2014 at 6:08 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> >> I'm wondering whether this can be fixed in the i2c driver? Does it really
> >> have to enable and disable the clock?
> > 
> > From a power-saving PoV, this makes sense. I assume serial output works
> > again as soon as the regular scif driver takes over? Isn't that a
> 
> Yes it continues fine afterwards.
> With TMU0 in DT, it's enabled again even earlier, as they share the parent.

Would it make sense to have a list of clocks to reference from setup code when 
DEBUG_LL is defined ? It's a bit hackish, but DEBUG_LL is hackish anyway.

> > generic problem of early_printk drivers that they are not refcounted for
> > the clocks?
> 
> Yes.
> 
> BTW, the code in sh_mobile_i2c_init() does this:
> 
>         /* Get clock rate after clock is enabled */
>         clk_prepare_enable(pd->clk);
>         i2c_clk_khz = clk_get_rate(pd->clk) / 1000;
>         clk_disable_unprepare(pd->clk);
> 
> I assume the enable/disable is no longer needed with CCF?

I assume so as well.

-- 
Regards,

Laurent Pinchart

