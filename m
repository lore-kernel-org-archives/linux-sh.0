From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 25 Jun 2012 15:55:33 +0000
Subject: Re: [PATCH 0/1][RFC] ARM: shmobile: r8a7740: basic PM domain support
Message-Id: <CANqRtoSuaTRRDhYpEFcUkNQtnaBRYoBBGOh2cuP3KOaD44Hyyw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87fw9jlm4q.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fw9jlm4q.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Mon, Jun 25, 2012 at 7:30 PM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
> Hi Rafael, Magnus
> Cc Simon
>
> This patch adds very basic PM domain support to Armadillo board.
>
> On my debug, it seems accessed correctly to PM domain register.
> (saved PM register value when power up/down. and printed it in safety tim=
ing)
>
> I tested it on Armadillo board, and maybe OK from "register value" point =
of view.
> But I can't check from "real voltage" point, since ...
> =A0- I don't have measuring machine
> =A0- Armadillo doesn't have measuring spot (?)
>
> I added [RFC] on this patch, since I'm not good at PM frame work.
>
> I tested it by
>
> echo mem > /sys/power/state

Thanks for your work on this, Morimoto-san!

In general I think it looks good for a V1, but I wonder about upcoming
patches for PM domain support for board-specific devices on the
Armadillo board. Do you have any other Armadillo-specific patch that
for instance hooks up the board specific LCDC device to the correct
power domain?

I recommend you to test during runtime with subsystem specific
interfaces - not only suspend-to-RAM. As an example, I believe the
LCDC can be powered on and off using some fbdev specific "blanking"
file in sysfs.

Thanks,

/ magnus
