From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Mon, 28 Mar 2011 00:49:24 +0000
Subject: Re: [PATCH 1/2] sh: landisk: Remove mv_nr_irqs
Message-Id: <AANLkTi==8cdrXBhLcMvZG4BtOdU-3OODaPqX5QaJQSV=@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1301200307-5321-1-git-send-email-iwamatsu@nigauri.org>
In-Reply-To: <1301200307-5321-1-git-send-email-iwamatsu@nigauri.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi,

OK, I will split and re-send patches.

Best regards,
  Nobuhiro

2011/3/27 Mike Frysinger <vapier@gentoo.org>:
> On Sun, Mar 27, 2011 at 12:31 AM, Nobuhiro Iwamatsu wrote:
>> --- a/arch/sh/boards/mach-landisk/setup.c
>> +++ b/arch/sh/boards/mach-landisk/setup.c
>> @@ -23,7 +23,7 @@
>>
>> =A0static void landisk_power_off(void)
>> =A0{
>> - =A0 =A0 =A0 =A0__raw_writeb(0x01, PA_SHUTDOWN);
>> + =A0 =A0 =A0 __raw_writeb(0x01, PA_SHUTDOWN);
>> =A0}
>>
>> =A0static struct resource cf_ide_resources[3];
>> @@ -85,7 +85,7 @@ device_initcall(landisk_devices_setup);
>>
>> =A0static void __init landisk_setup(char **cmdline_p)
>> =A0{
>> - =A0 =A0 =A0 =A0/* LED ON */
>> + =A0 =A0 =A0 /* LED ON */
>> =A0 =A0 =A0 =A0__raw_writeb(__raw_readb(PA_LED) | 0x03, PA_LED);
>>
>> =A0 =A0 =A0 =A0printk(KERN_INFO "I-O DATA DEVICE, INC. \"LANDISK Series\=
" support.\n");
>
> shouldnt whitespace noise be a sep patch ?
> -mike
>



--=20
Nobuhiro Iwamatsu
=A0=A0 iwamatsu at {nigauri.org / debian.org}
=A0=A0 GPG ID: 40AD1FA6
