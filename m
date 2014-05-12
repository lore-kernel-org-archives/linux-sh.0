From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 12 May 2014 12:11:13 +0000
Subject: Re: [PATCH v5 00/15] Renesas CMT, MTU2 and TMU platform cleanups
Message-Id: <CAMuHMdUhAhTF=C0gpnwxoXaoc1=9QCFOykAbT=UXShrdBY_u=g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1398251722-31667-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1398251722-31667-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent, Simon,

On Sun, May 11, 2014 at 4:24 AM, Simon Horman <horms@verge.net.au> wrote:
> On Wed, Apr 23, 2014 at 01:15:07PM +0200, Laurent Pinchart wrote:
>> This patch set switches all Renesas platforms to the new style CMT, MTU2 and
>> TMU device platform data. All patches have been previously posted as part of
>> the "[PATCH v3 00/52] Renesas CMT and TMU cleanups" and "[PATCH 00/22] SH MTU2
>> DT support" patch series.
>>
>> This new version fixes an interrupt-related bug introduced when switching the
>> sh7372 and sh73a0 platforms to the new style TMU device, caused by mistakenly
>> using evt2irq instead of intcs_evt2irq for the IRQ resources.
>>
>> Simon, I've tested this on Mackerel and the board now boots correctly. Could
>> you please assist me in debugging the Bock-W boot hang issue, as I don't have
>> access to that board ?
>
> Thanks Laurent,
>
> I have queued this up locally using v6 of patch 12 after resolving some
> conflicts which I will highlight by responding to the patches that are
> affected.
>
> I plan to push this once I have done some testing: especially of the
> resolution to the bockw problem. (I am on a plane with neither internet
> access nor a consignment of boards.)

Tested on Koelsch/r8a7791 (legacy and reference), Armadillo/r8a7740
(legacy and reference), and Genmai/r7s72100 (legacy, reference, and
multiplatform+CCF).

On Koelsch (both legacy and reference), I get:

-sh_cmt sh_cmt.0: used for clock events
-sh_cmt sh_cmt.0: used for periodic clock events
+sh_cmt sh-cmt-48-gen2.0: ch0: used for clock events
+sh_cmt sh-cmt-48-gen2.0: ch0: used for periodic clock events
+sh_cmt sh-cmt-48-gen2.0: ch1: used as clock source
+Switched to clocksource sh-cmt-48-gen2.0
+Clockevents: could not switch to one-shot mode:
+Clockevents: could not switch to one-shot mode: dummy_timer is not functional.
+Could not switch to high resolution mode on CPU 1
+ dummy_timer is not functional.
+Could not switch to high resolution mode on CPU 0

What's up with the high resolution mode?

Armadillo-legacy:

- sh_tmu.0: used for clock events
- sh_tmu.0: used for periodic clock events
- sh_tmu.1: used as clock source
+ sh-tmu.0: ch0: used for clock events
+ sh-tmu.0: ch0: used for periodic clock events
+ sh-tmu.0: ch1: used as clock source
+ sh-cmt-48.1: ch0: used for clock events
+ sh-cmt-48.1: ch1: used as clock source

-sh_cmt sh_cmt.10: used for clock events
-sh_cmt sh_cmt.10: used as clock source
-sh_tmu sh_tmu.0: kept as earlytimer
-sh_tmu sh_tmu.1: kept as earlytimer
-sh_tmu sh_tmu.2: used as clock source
+sh_cmt sh-cmt-48.1: kept as earlytimer
+sh_tmu sh-tmu.0: kept as earlytimer

Armadillo-reference:

-sh_cmt sh_cmt.10: used for clock events
-sh_cmt sh_cmt.10: used for periodic clock events
-sh_cmt sh_cmt.10: used as clock source
+sh_cmt sh-cmt-48.1: ch0: used for clock events
+sh_cmt sh-cmt-48.1: ch0: used for periodic clock events
+sh_cmt sh-cmt-48.1: ch1: used as clock source
 Advanced Linux Sound Architecture Driver Initialized.
-Switched to clocksource sh_cmt.10
+Switched to clocksource sh-cmt-48.1

Genmai-legacy/reference:

-sh_mtu2 sh_mtu2.0: no of_node; not parsing pinctrl DT
-sh_mtu2 sh_mtu2.0: used for clock events
-sh_mtu2 sh_mtu2.0: used for periodic clock events
+sh_mtu2 sh-mtu2: no of_node; not parsing pinctrl DT
+sh_mtu2 sh-mtu2: ch0: used for clock events
+sh_mtu2 sh-mtu2: ch0: used for periodic clock events

Genmai-multiplatform+CCF (note: needs addtional patches):

-sh_mtu2 sh_mtu2.0: no of_node; not parsing pinctrl DT
-sh_mtu2 sh_mtu2.0: used for clock events
-sh_mtu2 sh_mtu2.0: used for periodic clock events
+sh_mtu2 sh-mtu2: no of_node; not parsing pinctrl DT
+sh_mtu2 sh-mtu2: using pinctrl dummy state (default)
+sh_mtu2 sh-mtu2: using pinctrl dummy state (sleep)
+sh_mtu2 sh-mtu2: using pinctrl dummy state (idle)
+sh_mtu2 sh-mtu2: ch0: used for clock events
+sh_mtu2 sh-mtu2: ch0: used for periodic clock events

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
