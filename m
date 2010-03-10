From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 10 Mar 2010 07:49:24 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: ap4evb SDHI0 platform data
Message-Id: <aec7e5c31003092349g6b98abdfibf8df0154a3dc8a4@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20100310071528.5975.28821.sendpatchset@t400s>
In-Reply-To: <20100310071528.5975.28821.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Wed, Mar 10, 2010 at 4:36 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Wed, Mar 10, 2010 at 04:15:28PM +0900, Magnus Damm wrote:
>> @@ -206,10 +207,38 @@ static struct platform_device keysc_devi
>> =A0 =A0 =A0 },
>> =A0};
>>
>> +/* SDHI0 */
>> +static struct sh_mobile_sdhi_info sdhi0_info =3D {
>> +};
>> +
> Try again?

The sh_mobile_sdhi driver allows omitting the platform data, so
perhaps that's a better idea.

>> +static struct resource sdhi0_resources[] =3D {
>> + =A0 =A0 [0] =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "SDHI0",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .start =A0=3D 0xe6850000,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =A0=3D 0xe68501ff,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0=3D IORESOURCE_MEM,
>
> If you aren't going to use a useful name for the resource, then the
> name can just be left unset, this will ensure that the driver core
> assigns the resource a name matching the device name/id pair.

The data sheet refers to this hardware block as SDHI0.

> So if left unset you would end up with "sh_mobile_sdhi.0" in /proc/iomem,
> which could be more intuitive.

Sure, that's also an option. For sh7724 (and perhaps earlier
SH-Mobile) most resources use the data sheet name for /proc/iomem.

/ magnus
