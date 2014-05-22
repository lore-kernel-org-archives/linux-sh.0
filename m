From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 22 May 2014 09:42:23 +0000
Subject: Re: [PATCH] ARM: shmobile: Fix device node reference leakage in shmobile_init_delay
Message-Id: <1788584.mMvlLncn6E@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1400679065-17287-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1400679065-17287-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Thursday 22 May 2014 12:10:06 Magnus Damm wrote:
> On Thu, May 22, 2014 at 9:50 AM, Laurent Pinchart wrote:
> > On Thursday 22 May 2014 09:24:47 Magnus Damm wrote:
> >> On Thu, May 22, 2014 at 1:13 AM, Laurent Pinchart wrote:
> >> > On Wednesday 21 May 2014 15:56:20 Geert Uytterhoeven wrote:
> >> >> On Wed, May 21, 2014 at 3:31 PM, Laurent Pinchart wrote:
> >> >> > +       bool is_a8_a9 = false;
> >> >> > +       bool is_a15 = false;
> >> >> > +       u32 max_freq = 0;
> >> >> > +
> >> >> > +       cpus = of_find_node_by_path("/cpus");
> >> >> > +       if (!cpus)
> >> >> > +               return;
> >> >> > +
> >> >> > +       for_each_child_of_node(cpus, np) {
> >> >> > +               u32 freq;
> >> >> > +
> >> >> > +               if (!of_property_read_u32(np, "clock-frequency",
> >> >> > &freq))
> >> >> > +                       max_freq = max(max_freq, freq);
> >> >> > 
> >> >> > -       if (max_freq) {
> >> >> > -               if (of_find_compatible_node(NULL, NULL,
> >> >> > "arm,cortex-a8"))
> >> >> > -                       shmobile_setup_delay_hz(max_freq, 1, 3);
> >> >> > -               else if (of_find_compatible_node(NULL, NULL,
> >> >> > "arm,cortex-a9")) -
> >> >> > shmobile_setup_delay_hz(max_freq, 1, 3);
> >> >> > -               else if (of_find_compatible_node(NULL, NULL,
> >> >> > "arm,cortex-a15")) -                       if
> >> >> > (!IS_ENABLED(CONFIG_ARM_ARCH_TIMER))
> >> >> > -                               shmobile_setup_delay_hz(max_freq, 2,
> >> >> > 4);
> >> >> > +               if (of_device_is_compatible(np, "arm,cortex-a8") ||
> >> >> > +                   of_device_is_compatible(np, "arm,cortex-a9"))
> >> >> > +                       is_a8_a9 = true;
> >> >> 
> >> >> So now we have to care about CPU families in two places: here and
> >> >> below, when calling shmobile_setup_delay_hz().
> >> >> 
> >> >> IIUC, "shmobile_setup_delay_hz(max_freq, 2, 4)" is (ignoring rounding)
> >> >> equivalent to "shmobile_setup_delay_hz(max_freq, 1, 2)"?
> >> >> Do we actually have cases where mult needs to be different from 1?
> >> >> If not, we can kill the "mult" parameter, and replace the "is_a8_a9 > >> >> true" by:
> >> >> 
> >> >> div = 3;
> >> >> 
> >> >> > +               else if (of_device_is_compatible(np,
> >> >> > "arm,cortex-a15"))
> >> >> > +                       is_a15 = true;
> >> >> 
> >> >> and
> >> >> 
> >> >> else if (of_device_is_compatible(np, "arm,cortex-a15") &&
> >> >>          !IS_ENABLED(CONFIG_ARM_ARCH_TIMER))
> >> >>         div = 2;
> >> >>         
> >> >> >         }
> >> >> > 
> >> >> > +
> >> >> > +       of_node_put(cpus);
> >> >> > +
> >> >> > +       if (!max_freq)
> >> >> > +               return;
> >> >> > +
> >> >> > +       if (is_a8_a9)
> >> >> > +               shmobile_setup_delay_hz(max_freq, 1, 3);
> >> >> > +       else if (is_a15 && !IS_ENABLED(CONFIG_ARM_ARCH_TIMER))
> >> >> > +               shmobile_setup_delay_hz(max_freq, 2, 4);
> >> >> 
> >> >> and this just becomes:
> >> >> 
> >> >> if (div)
> >> >> 
> >> >>     shmobile_setup_delay_hz(max_freq, div);
> >> >> 
> >> >> Am I missing something?
> >> > 
> >> > That's an option as well, but I find the code flow to slightly be less
> >> > clear in that case. I have no strong preference so I'll let Magnus
> >> > decide.
> >> 
> >> Ouch, I will have to decide? =)
> >> 
> >> If we consider upcoming R-Car E2 that is Cortex-A7 only, i wonder
> >> which way to go to also support that easily?
> > 
> > Depends, what do we need to do on that platform ?
> 
> Like on other SoCs - make sure the delay timings are correct!

Of course, but what does that look like for E2 in terms of div and mult 
values, and how that relates to the architected timer being available or not 
(and possibly other parameters) ?

As we don't seem to have that information at the moment I would vote for 
ignoring E2 for now and revisiting the code later. It's a pretty simple 
function anyway.

So, back to square one, what's your preferred implementation ? :-)

> What makes it special is that it is our first CA7-only platform.
> 
> Not sure how different the CA7 would be from say CA15 though. And the
> existing values may be far from perfect. So I guess someone needs to
> go through the delay cycles in general and figure out what the correct
> settings would be.

-- 
Regards,

Laurent Pinchart

