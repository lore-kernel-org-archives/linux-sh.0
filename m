From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 14 Jan 2016 17:32:04 +0000
Subject: Re: [RFC v4 0/4] watchdog: add driver for RWDT watchdog
Message-Id: <CAMuHMdWOD5qBFN7kOLcWf8A7LV3yYAD2Cj97F0ma5JU1Xkxhpg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1452287553-18895-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1452287553-18895-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Wolfram,

On Fri, Jan 8, 2016 at 10:12 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> So, here is my newest version of the RWDT watchdog driver. Changes since last RFC:
>
> * added binding docs
> * removed 'timeout' module parameter in favor of dt setting 'timeout-sec'
>   (The Gen3 BSP did this using an incremental patch)
> * added comment about this driver and Gen2 HW issues
> * rebased to renesas-drivers-2016-01-05-v4.4-rc8
> * use min_t() instead of min()
>
> I tested this on Lager with my hacky patches enabling RWDT in UP mode. For this
> series, I picked and updated the integration patches for Gen3 from the BSP.
> Note that this driver also needs a RESET module driver to work on Gen3. Since
> we don't have that yet (couldn't even find it in the BSP), it is untested on
> Gen3. Since it works on Gen2 and the datasheet doesn't specify any difference,
> my proposal would be that I mark this task as done and leave the integration
> with the reset module to the core group. If any problems with this driver show
> up, I'll be there, of course. Would that be okay with the core group?

Just wondering: can't you test it on Gen3 the same way as on Gen2?
Or does the firmware interfere?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
