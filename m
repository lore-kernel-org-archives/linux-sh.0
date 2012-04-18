From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 18 Apr 2012 11:00:36 +0000
Subject: Re: ARM: mach-shmobile: remove pointless global clocks
Message-Id: <CANqRtoTkLPRDGUxR9j+wkwuf9vdvu5O6eEUDcB0ST=t+fqrreg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Fri, Apr 13, 2012 at 1:37 PM,  <kuninori.morimoto.gx@renesas.com> wrote:
>
> Hi Rafael
> Cc Paul, Magnus
>
> These patches are not super important,
> but remove pointless global clocks from SH-ARM.
>
> Kuninori Morimoto (17):
> =A0 =A0 =A0ARM: mach-shmobile: sh7367: remove pointless sh7367_extal2_clk
> =A0 =A0 =A0ARM: mach-shmobile: sh7367: remove pointless sh7367_extalb1_clk
> =A0 =A0 =A0ARM: mach-shmobile: sh7367: remove pointless sh7377_extalc1_clk
> =A0 =A0 =A0ARM: mach-shmobile: sh7377: remove pointless sh7377_extal2_clk
> =A0 =A0 =A0ARM: mach-shmobile: sh7362: remove pointless sh7372_dv_clki_clk
> =A0 =A0 =A0ARM: mach-shmobile: sh7372: remove pointless sh7372_dv_clki_di=
v2_clk
> =A0 =A0 =A0ARM: mach-shmobile: sh7372: remove pointless sh7372_extal1_clk
> =A0 =A0 =A0ARM: mach-shmobile: sh7372: remove pointless sh7372_extal2_clk
> =A0 =A0 =A0ARM: mach-shmobile: sh7372: remove pointless sh7372_pllc2_clk
> =A0 =A0 =A0ARM: mach-shmobile: sh7372: remove pointless sh7372_fsiack_clk
> =A0 =A0 =A0ARM: mach-shmobile: sh7372: remove pointless sh7372_fsibck_clk
> =A0 =A0 =A0ARM: mach-shmobile: sh7372: remove pointless sh7372_fsidiva_clk
> =A0 =A0 =A0ARM: mach-shmobile: sh7372: remove pointless sh7372_fsidivb_clk
> =A0 =A0 =A0ARM: mach-shmobile: sh73a0: remove pointless sh73a0_extal1_clk
> =A0 =A0 =A0ARM: mach-shmobile: sh73a0: remove pointless sh73a0_extal2_clk
> =A0 =A0 =A0ARM: mach-shmobile: sh73a0: remove pointless sh73a0_extcki_clk
> =A0 =A0 =A0ARM: mach-shmobile: sh73a0: remove pointless sh73a0_extalr_clk
>
> Current SH-ARMs have global shXXXX_yyyy_clk.
> We are using it for clock reparent or others.
> But we can (should ?) get it by clk_get(xxx) function.
> These patches
> =A0- remove global clock
> =A0- put it as static
> =A0- use clk_get(xxx)

Uhm, I understand what you're doing here, but I wonder why we want that?

So I remember that we made the root clock symbols global to make it
easy for board code to override. This is moving it back again.

Perhaps the right way do deal with this is to modify the
foobar_clock_init() functions to take the board specific frequency as
paramenters?

OTOH, with the common clock framework and upcoming DT bindings and
whatnot I must say that I prefer not to move things around unless we
have a technical reason for the change.

So for now I prefer to skip this series, hope that is ok!

Thanks,

/ magnus
