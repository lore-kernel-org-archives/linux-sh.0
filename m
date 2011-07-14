From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 14 Jul 2011 08:04:40 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: use GPIO interrupt also for card
Message-Id: <Pine.LNX.4.64.1107140911560.10688@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1107140123070.30737@axis700.grange>
 <CANqRtoQ+pi-2ek+z2NXhPiVj2prCs8wZ6NYiOX44HQ1NZrei7w@mail.gmail.com>
In-Reply-To: <CANqRtoQ+pi-2ek+z2NXhPiVj2prCs8wZ6NYiOX44HQ1NZrei7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <damm@opensource.se>

Hi Magnus

On Thu, 14 Jul 2011, Magnus Damm wrote:

> On Thu, Jul 14, 2011 at 8:25 AM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > When we switch to transaction-based runtime PM on SDHI / TMIO MMC,
> > also card eject events will have to be detected by the platform.
> > This patch prepares mackerel to this switch.
> >
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > ---
> > =A0arch/arm/mach-shmobile/board-mackerel.c | =A0 68 +++++++++++++++++++=
++++++++----
> > =A01 files changed, 60 insertions(+), 8 deletions(-)
>=20
> Thanks for your work on this.
>=20
> What is the reason why we can't use GPIO for all cases of insert/eject
> event detection? Switching between GPIO and function mode for the pin
> seems overly complex IMO - that unless there is a real win behind it.
> Please explain.

Because the way, board-supported (cold) card-detection is currently=20
implemented on mackerel is, that on a card slot event a pm_runtime_get()=20
is issued, which then calls the .runtime_resume() hook in the tmio driver. =

However, if the runtime PM is inactive, if the hook doesn't get called,=20
e.g., bacause the power domain, the respective SDHI controller is in, is=20
held on by other devices, the event would be missed. That's why the normal =

pin state is the SDHI card-detection function, which then works performs=20
the detection in such cases.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
