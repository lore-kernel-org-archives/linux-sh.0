From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 22 Jun 2015 09:51:57 +0000
Subject: Re: [PATCH 0/6][RFC] arm64: Renesas Gen3 initial patch
Message-Id: <CAMuHMdVycc_cbrZTYG1=AwauAFxxu1keLbKGoOScvC8swygF_g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87616pwp7a.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87616pwp7a.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jun 19, 2015 at 12:38 PM, Ulrich Hecht <ulrich.hecht@gmail.com> wrote:
> On Mon, Jun 15, 2015 at 6:49 AM, Kuninori Morimoto
> <kuninori.morimoto.gx@renesas.com> wrote:
>> I guess I need to Cc ARM-ML, but I didn't at this point.
>>
>> These are initial patch set for Gen3 support. These were tested on our
> [...]
>> My concern about these patches are about clocks. CPG/MSTP/APMU need
>> write protection on Gen3, but these need to share same protection.
>> Current version is using new global rcar_cpgwpcr_lock(),
>> but we should to create new driver ? Then DT is ?
>
> IMO the task of the CPG drivers is to encapsulate the weirdness that
> is not reasonably-well describable in the device tree, and the
> write-protect feature falls into that field.
>
> I'd leave the CPG device to be the owner of the write-protect
> registers and provide a write function used by all drivers touching
> clock registers. Depending on initialization by the CPG driver, this
> function would either do a regular write, or one with the
> write-protect safety dance.  No new drivers, no new DT bindings, and
> no code duplication between write-protect users.

Yes, that sounds like the best interim solution.

> Or disable write protection. :)

Let's see whether it's really needed...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
