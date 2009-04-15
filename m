From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 15 Apr 2009 12:16:10 +0000
Subject: Re: [PATCH 3/6] Add USB support for SH7724
Message-Id: <aec7e5c30904150516h515372bfj81b52dff8379c801@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uzlej1ubl.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uzlej1ubl.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi again Morimoto-san,

[CC Shimoda-san]

On Wed, Apr 15, 2009 at 8:49 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> On Wed, Apr 15, 2009 at 11:42 AM, Kuninori Morimoto
> <morimoto.kuninori@renesas.com> wrote:
>> +++ b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c

>> +#define UPONCR0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00xa40501d4
>> +#define UPONCR1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00xa4050192
>> +#define USBPOWERON =A0 =A0 0x0600
>> +static void __init sh7724_usb_setup(void)
>> +{
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* USB initial settings
>> + =A0 =A0 =A0 =A0*
>> + =A0 =A0 =A0 =A0* The following settings are necessary
>> + =A0 =A0 =A0 =A0* for using the USB modules.
>> + =A0 =A0 =A0 =A0*
>> + =A0 =A0 =A0 =A0* see "USB Inital Settings" for detail
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 __raw_writew(USBPOWERON , UPONCR0);
>> + =A0 =A0 =A0 __raw_writew(USBPOWERON , UPONCR1);
>> +}
>
> Hm... In the future we want to control the above dynamically for
> better power savings. I guess it's ok as-is for now.

Looking a bit in r8a66597.h, I wonder if USBPOWERON is similar to
VBOUT that is present in DVSTCR on external devices?

/ magnus
