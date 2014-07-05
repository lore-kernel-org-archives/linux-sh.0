From: Magnus Damm <magnus.damm@gmail.com>
Date: Sat, 05 Jul 2014 20:57:22 +0000
Subject: Re: [PATCH] ARM: shmobile: Lager: Correct I2C bus for VDD MPU regulator
Message-Id: <CANqRtoTbvz9FGyVNwRimE1kDt2G2YX1MwSY37OFL=AtN5Dy3wg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <53B4AC3D.30801@renesas.com>
In-Reply-To: <53B4AC3D.30801@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jul 3, 2014 at 3:05 AM, Khiem Nguyen
<khiem.nguyen.xt@renesas.com> wrote:
> I2C bus for VDD MPU regulator is IIC3, not I2C3.
>
> Signed-off-by: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
> ---
>  arch/arm/boot/dts/r8a7790-lager.dts |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Hi Khiem-san,

Thanks for your patch. Can you please extend the commit message to
include the reason behind this patch?

From my side this looks like a software policy change. Unless I'm
mistaken both I2C3 and IIC3 share the same pins on the SoC, and
because of that it should be possible to access that particular I2C
bus already without any modification.

So please explain why you want to change this.

Cheers,

/ magnus
