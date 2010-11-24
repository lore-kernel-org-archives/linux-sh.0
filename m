From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 24 Nov 2010 06:00:24 +0000
Subject: Re: [PATCH 0/6] ARM: mach-shmobile: FSI clock fixup
Message-Id: <20101124060024.GD11705@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <w3pd3q14w2t.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pd3q14w2t.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Nov 19, 2010 at 04:22:02PM +0900, Kuninori Morimoto wrote:
> 
> Dear Paul, Magnus, Mark, Liam, Guennadi
> 
> These patches are FSI clock fixup
> 
> Kuninori Morimoto (6):
>       ARM: mach-shmobile: clock-sh7372: remove fsidiv bogus disable
>       ARM: mach-shmobile: ap4evb: FSI clock use proper process for HDMI
>       ARM: mach-shmobile: ap4evb: FSI clock use proper process for ak4642
>       ARM: mach-shmobile: clock-sh7372: modify error code
>       ARM: mach-shmobile: clock-sh7372: remove unnecessary fsi clocks
>       ARM: mach-shmobile: clock-sh7372: remove pllc2 clock bogus
> 
> These patches modify bogus control of FSI clock.
> To modify it, FSI driver was changed.
> I tested these patches on AP4 and Ecovec.
> 
> >> Mark, Liam
> 
>    Can you please check #2 #3 patches ?
>    It change FSI driver.
> 
> >> Magnus, Paul, Guennadi
> 
>    The last patch change pllc2 bogus, but I'm not sure about it.
>    Of course I tested it though.
>    I put it as RFC.
> 
This is fixing the same bogosity that the FSI clock was doing, so it's a
good step. The FSI changes we do want for .37 anyways, as we don't want
to have that going out with clocks in a half-usable state, it makes sense
to roll the pllc2 change in at the same time.

If Liam or Mark wish to provide Acks for the FSI driver bits I'll add
those in, otherwise I'll plan to send this series (with v2 of patch #2)
to Linus this week.
