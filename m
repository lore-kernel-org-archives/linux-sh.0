From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 21 May 2014 16:13:43 +0000
Subject: Re: [PATCH] ARM: shmobile: Fix device node reference leakage in shmobile_init_delay
Message-Id: <6156422.goNWLVtGTU@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1400679065-17287-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1400679065-17287-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

On Wednesday 21 May 2014 15:56:20 Geert Uytterhoeven wrote:
> Hi Laurent, Magnus,
> 
> On Wed, May 21, 2014 at 3:31 PM, Laurent Pinchart wrote:
> > +       bool is_a8_a9 = false;
> > +       bool is_a15 = false;
> > +       u32 max_freq = 0;
> > +
> > +       cpus = of_find_node_by_path("/cpus");
> > +       if (!cpus)
> > +               return;
> > +
> > +       for_each_child_of_node(cpus, np) {
> > +               u32 freq;
> > +
> > +               if (!of_property_read_u32(np, "clock-frequency", &freq))
> > +                       max_freq = max(max_freq, freq);
> > 
> > -       if (max_freq) {
> > -               if (of_find_compatible_node(NULL, NULL, "arm,cortex-a8"))
> > -                       shmobile_setup_delay_hz(max_freq, 1, 3);
> > -               else if (of_find_compatible_node(NULL, NULL,
> > "arm,cortex-a9")) -                      
> > shmobile_setup_delay_hz(max_freq, 1, 3);
> > -               else if (of_find_compatible_node(NULL, NULL,
> > "arm,cortex-a15")) -                       if
> > (!IS_ENABLED(CONFIG_ARM_ARCH_TIMER))
> > -                               shmobile_setup_delay_hz(max_freq, 2, 4);
> > +               if (of_device_is_compatible(np, "arm,cortex-a8") ||
> > +                   of_device_is_compatible(np, "arm,cortex-a9"))
> > +                       is_a8_a9 = true;
> 
> So now we have to care about CPU families in two places: here and below,
> when calling shmobile_setup_delay_hz().
> 
> IIUC, "shmobile_setup_delay_hz(max_freq, 2, 4)" is (ignoring rounding)
> equivalent to "shmobile_setup_delay_hz(max_freq, 1, 2)"?
> Do we actually have cases where mult needs to be different from 1?
> If not, we can kill the "mult" parameter, and replace the "is_a8_a9 = true"
> by:
> 
> div = 3;
> 
> > +               else if (of_device_is_compatible(np, "arm,cortex-a15"))
> > +                       is_a15 = true;
> 
> and
> 
> else if (of_device_is_compatible(np, "arm,cortex-a15") &&
>          !IS_ENABLED(CONFIG_ARM_ARCH_TIMER))
>         div = 2;
> 
> >         }
> > 
> > +
> > +       of_node_put(cpus);
> > +
> > +       if (!max_freq)
> > +               return;
> > +
> > +       if (is_a8_a9)
> > +               shmobile_setup_delay_hz(max_freq, 1, 3);
> > +       else if (is_a15 && !IS_ENABLED(CONFIG_ARM_ARCH_TIMER))
> > +               shmobile_setup_delay_hz(max_freq, 2, 4);
> 
> and this just becomes:
> 
> if (div)
>     shmobile_setup_delay_hz(max_freq, div);
> 
> Am I missing something?

That's an option as well, but I find the code flow to slightly be less clear 
in that case. I have no strong preference so I'll let Magnus decide.

-- 
Regards,

Laurent Pinchart

