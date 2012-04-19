From: Olof Johansson <olof@lixom.net>
Date: Thu, 19 Apr 2012 21:07:59 +0000
Subject: Re: [git pull] Renesas DT changes for v3.5
Message-Id: <CAOesGMitR0HT7HLCDX9sqohu9iJGPcQp8_TE3oS66ZhfvHizBQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201204152320.56147.rjw@sisk.pl>
In-Reply-To: <201204152320.56147.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi Rafael (and Magnus),

On Sun, Apr 15, 2012 at 2:20 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:

> Magnus Damm (6):
> =A0 =A0 =A0ARM: mach-shmobile: Introduce shmobile_setup_delay()
> =A0 =A0 =A0ARM: mach-shmobile: Introduce INTC_IRQ_PINS_16H
> =A0 =A0 =A0ARM: mach-shmobile: Use 0x3400 as INTCS vector offset
> =A0 =A0 =A0ARM: mach-shmobile: Use INTC_IRQ_PINS_16H on sh7372
> =A0 =A0 =A0ARM: mach-shmobile: Rework sh7372 INTCS demuxer V2
> =A0 =A0 =A0ARM: mach-shmobile: sh7372 generic board support via DT V2

I noticed that none of these patches were posted beyond the shmobile
mailing list.

We normally wouldn't care as much about patches that change various
bit twiddling on the SoC specific parts, but for things like device
tree conversion and bindings, it's useful to get more eyes on the
changes.

Can you please cross-post on linux-arm-kernel@lists.infradead.org with
these kind of platform changes so they get exposed to the wider set of
readers? Also, once you start doing device bindings, they should be
cross-posted to devicetree-discuss@lists.ozlabs.org.

The branch contents looks OK and I'll pull it in, but please start
doing the above for new patches.


Thanks,

-Olof
