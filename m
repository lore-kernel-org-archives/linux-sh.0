From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 14 Jul 2011 01:03:20 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: use GPIO interrupt also for card
Message-Id: <CANqRtoQ+pi-2ek+z2NXhPiVj2prCs8wZ6NYiOX44HQ1NZrei7w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1107140123070.30737@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1107140123070.30737@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <damm@opensource.se>

On Thu, Jul 14, 2011 at 8:25 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> When we switch to transaction-based runtime PM on SDHI / TMIO MMC,
> also card eject events will have to be detected by the platform.
> This patch prepares mackerel to this switch.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> =A0arch/arm/mach-shmobile/board-mackerel.c | =A0 68 +++++++++++++++++++++=
++++++----
> =A01 files changed, 60 insertions(+), 8 deletions(-)

Thanks for your work on this.

What is the reason why we can't use GPIO for all cases of insert/eject
event detection? Switching between GPIO and function mode for the pin
seems overly complex IMO - that unless there is a real win behind it.
Please explain.

Thank you!

/ magnus
