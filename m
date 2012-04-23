From: Bastian Hecht <hechtb@googlemail.com>
Date: Mon, 23 Apr 2012 08:43:40 +0000
Subject: Re: [PATCH 2/9] ARM: sh-mobile: mackerel: Add error IRQ resource
Message-Id: <CABYn4syHdmN3Rc5PjjoV3mh2QReipLAKCzsUEmkKK6pZZHJhgQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1334913230-23615-1-git-send-email-hechtb@gmail.com>
 <1334913230-23615-3-git-send-email-hechtb@gmail.com>
 <2098300.FxL39kQn7a@avalon>
In-Reply-To: <2098300.FxL39kQn7a@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org

Hello Laurent,

2012/4/21 Laurent Pinchart <laurent.pinchart@ideasonboard.com>:
> Hi Bastian,
>
> Thanks for the patch.
>
> On Friday 20 April 2012 11:13:43 Bastian Hecht wrote:
>> Supply the platform data for the FLSTEI error IRQ.
>
> This should come before your 1/9 patch, otherwise the FLCTL driver will f=
ail
> to get the IRQ, breaking git bisect.

"git bisect" - I should try this :D

Thanks, I'll swap it.

Best regards,

 Bastian Hecht

>> Signed-off-by: Bastian Hecht <hechtb@gmail.com>
>> ---
>> =A0arch/arm/mach-shmobile/board-mackerel.c | =A0 =A06 +++++-
>> =A01 files changed, 5 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-shmobile/board-mackerel.c
>> b/arch/arm/mach-shmobile/board-mackerel.c index 8758f94..1de1fb7 100644
>> --- a/arch/arm/mach-shmobile/board-mackerel.c
>> +++ b/arch/arm/mach-shmobile/board-mackerel.c
>> @@ -990,7 +990,11 @@ static struct resource nand_flash_resources[] =3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .start =A0=3D 0xe6a30000,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =A0=3D 0xe6a3009b,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0=3D IORESOURCE_MEM,
>> - =A0 =A0 }
>> + =A0 =A0 },
>> + =A0 =A0 [1] =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .start =A0=3D evt2irq(0x0d80), /* flstei: stat=
us error irq */
>> + =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0=3D IORESOURCE_IRQ,
>> + =A0 =A0 },
>> =A0};
>>
>> =A0static struct sh_flctl_platform_data nand_flash_data =3D {
> --
> Regards,
>
> Laurent Pinchart
>
