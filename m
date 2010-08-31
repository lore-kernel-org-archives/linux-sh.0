From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 31 Aug 2010 09:59:44 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: ap4evb: modify tsc2007 platform settings
Message-Id: <AANLkTinCCZtTy2W44NaMGWLvy224Y+sat6_wh10=37q0@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3p1v9weglx.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3p1v9weglx.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Fri, Aug 27, 2010 at 6:49 PM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> This patch modify x_plate_ohms to correct value for tsc2007,
> and removed un-necessary ts_get_pendown_state().
> gpio_pull_up() was removed also.
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> =A0arch/arm/mach-shmobile/board-ap4evb.c | =A0 51 ++---------------------=
----------
> =A01 files changed, 3 insertions(+), 48 deletions(-)

Thanks for your work on this. I think removing unnecessary code is a good i=
dea.

I just did some simple testing of this patch on AP4EVB with WVGA panel.

Are you sure the pressure value is working correctly? Maybe this is
normal behavior but I get different pressure ranges on different parts
of the screen. The top left corner next to the fbdev penguin seems to
have the lowest range for some unknown reason.

Top left corner: Pressure value 140-440
Top right corner: Pressure value 650-800
Bottom left corner: Pressure value 200-900
Bottom right corner: Pressure value 140-840

To test I use the following line:
# /evtest /dev/event0 | grep Pressure

I did not test without your patch. Maybe the pressure ranges are
strange because the touch screen is rotated incorrectly?

Do you see the same behavior on your hardware? Thanks for your help!

Cheers,

/ magnus
