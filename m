From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 22 Jun 2015 01:00:05 +0000
Subject: Re: [PATCH 0/6][RFC] arm64: Renesas Gen3 initial patch
Message-Id: <87si9k8sqn.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87616pwp7a.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87616pwp7a.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Ulrich

Thak you for your feedback

> > I guess I need to Cc ARM-ML, but I didn't at this point.
> >
> > These are initial patch set for Gen3 support. These were tested on our
> [...]
> > My concern about these patches are about clocks. CPG/MSTP/APMU need
> > write protection on Gen3, but these need to share same protection.
> > Current version is using new global rcar_cpgwpcr_lock(),
> > but we should to create new driver ? Then DT is ?
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
> 
> Or disable write protection. :)

According to datasheet and HW team, it seems that we can disable write protection,
but, we have not tested it yet.
I and Inami-san talked about this topics last week, and he will test it on emulator.
If it (= disabling write protection) works, v2 patch doesn't use it.

Thank you

Best regards
---
Kuninori Morimoto
--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
