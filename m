From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 28 Jun 2012 23:57:42 +0000
Subject: Re: [PATCH 04/10 v3] ARM: mach-shmobile: add fixed voltage regulators to armadillo800eva
Message-Id: <CANqRtoQQR4tDaFd5wR1swKcVmvt3V20Q36pP_tn1w9_kD_c6BA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1340749952-8534-5-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1340749952-8534-5-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Thu, Jun 28, 2012 at 12:56 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> On Wed, 27 Jun 2012, Guennadi Liakhovetski wrote:
>
>> On armadillo800eva provide a 3.3V supply for its SD/MMC-card interfaces.
>>
>> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>> ---
>> =A0arch/arm/mach-shmobile/board-armadillo800eva.c | =A0 16 +++++++++++++=
+++
>> =A01 files changed, 16 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/m=
ach-shmobile/board-armadillo800eva.c
>> index 9e37026..819cee5 100644
>> --- a/arch/arm/mach-shmobile/board-armadillo800eva.c
>> +++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
>> @@ -28,6 +28,8 @@
>> =A0#include <linux/platform_device.h>
>> =A0#include <linux/gpio.h>
>> =A0#include <linux/gpio_keys.h>
>> +#include <linux/regulator/fixed.h>
>> +#include <linux/regulator/machine.h>
>> =A0#include <linux/sh_eth.h>
>> =A0#include <linux/videodev2.h>
>> =A0#include <linux/usb/renesas_usbhs.h>
>> @@ -407,6 +409,17 @@ static struct platform_device gpio_keys_device =3D {
>> =A0 =A0 =A0 },
>> =A0};
>>
>> +/* Fixed 3.3V regulator to be used by SDHI0, SDHI1, MMCIF */
>> +static struct regulator_consumer_supply fixed3v3_power_consumers[] >> +{
>> + =A0 =A0 REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.0"),
>> + =A0 =A0 REGULATOR_SUPPLY("vqmmc", "sh_mobile_sdhi.0"),
>> + =A0 =A0 REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.1"),
>> + =A0 =A0 REGULATOR_SUPPLY("vqmmc", "sh_mobile_sdhi.1"),
>> + =A0 =A0 REGULATOR_SUPPLY("vmmc", "sh_mmcif.0"),
>> + =A0 =A0 REGULATOR_SUPPLY("vqmmc", "sh_mmcif.0"),
>
> There is a slight problem with this patch: a1 (r8a7740) SoCs are currently
> the only ones registering their MMCIF device without an index, i.e., with
> .id =3D -1. This is reflected in board-armadillo800eva.c and in
> clock-r8a7740.c. This patch erroneously uses sh_mmcif.0 for device name,
> which is also what every single other ARM and sh platform in the mainline,
> using mmcif, AFAICS, currently does.
>
> Therefore question: Magnus, Rafael: what would you prefer - fix the above
> regulator entries to not use a device ID, or unify a1 with other SoCs to
> use .id =3D 0?

As I mentioned over private email and as you know by now - I prefer to
focus on function over cosmetics. Morimoto-san picked a -1 in the A1
case but I can't really see how that is relevant to anything
functional in this series.

Anyway, so regarding this particular matter, as long as it works I'm
fine with anything.

In this case this means - please don't add any further dependencies -
just fix and post a new version. If you want to discuss these minor
things with Morimoto-san then feel free to do so, but that should be
dealt with incrementally on top of this if so.

Thanks,

/ magnus
