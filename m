From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 09 Jun 2011 08:44:21 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: Mackerel USB platform data update
Message-Id: <BANLkTi=CGzRKe1N3QRt4b3b10V5e5kJ_Yg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20110609070337.3122.1679.sendpatchset@t400s>
In-Reply-To: <20110609070337.3122.1679.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Thu, Jun 9, 2011 at 4:09 PM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
> Hi Magnus
>
> Thank you for your patch.
> small comment from me
>
>> +static u32 usbhs0_pipe_cfg[] =3D {
>> + =A0 =A0 USB_ENDPOINT_XFER_CONTROL,
>> + =A0 =A0 USB_ENDPOINT_XFER_ISOC,
>> + =A0 =A0 USB_ENDPOINT_XFER_ISOC,
>> + =A0 =A0 USB_ENDPOINT_XFER_BULK,
>> + =A0 =A0 USB_ENDPOINT_XFER_BULK,
>> + =A0 =A0 USB_ENDPOINT_XFER_BULK,
>> + =A0 =A0 USB_ENDPOINT_XFER_INT,
>> + =A0 =A0 USB_ENDPOINT_XFER_INT,
>> + =A0 =A0 USB_ENDPOINT_XFER_INT,
>> + =A0 =A0 USB_ENDPOINT_XFER_BULK,
>> +};
>
> I think AP4 USB0 pipe9 is interrupt.
> If so, this pipe config is not needed.
> it is same as renesas_usbhs default pipe configs.
> see
> =A0renesas_usbhs/common.c :: usbhs_default_pipe_type

Ok, thanks, can you please send an incremental patch to fix this?

>> =A0static struct resource usb1_host_resources[] =3D {
>> =A0 =A0 =A0 [0] =3D {
>> - =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "USBHS",
>> - =A0 =A0 =A0 =A0 =A0 =A0 .start =A0=3D 0xE68B0000,
>> - =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =A0=3D 0xE68B00E6 - 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "USBHS1",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .start =A0=3D 0xe68b0000,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =A0=3D 0xe68b00e6 - 1,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0=3D IORESOURCE_MEM,
>> =A0 =A0 =A0 },
>
> Is this "big/small char change" (start/end) needed ?
>
>> =A0static struct usbhs_private usbhs1_private =3D {
>> - =A0 =A0 .irq =A0 =A0 =A0 =A0 =A0 =A0=3D evt2irq(0x0300), =A0 =A0 =A0/*=
 IRQ8 */
>> - =A0 =A0 .usbphyaddr =A0 =A0 =3D 0xE60581E2, =A0 =A0 =A0 =A0 =A0 /* USB=
PHY1INTAP */
>> - =A0 =A0 .usbcrcaddr =A0 =A0 =3D 0xE6058130, =A0 =A0 =A0 =A0 =A0 /* USB=
CR4 */
>> + =A0 =A0 .usbphyaddr =A0 =A0 =3D 0xe60581e2, =A0 =A0 =A0 =A0 =A0 /* USB=
PHY1INTAP */
>> + =A0 =A0 .usbcrcaddr =A0 =A0 =3D 0xe6058130, =A0 =A0 =A0 =A0 =A0 /* USB=
CR4 */
>
> here too.
>
>> =A0static struct resource usbhs1_resources[] =3D {
>> =A0 =A0 =A0 [0] =3D {
>> - =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "USBHS",
>> - =A0 =A0 =A0 =A0 =A0 =A0 .start =A0=3D 0xE68B0000,
>> - =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =A0=3D 0xE68B00E6 - 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "USBHS1",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .start =A0=3D 0xe68b0000,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =A0=3D 0xe68b00e6 - 1,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0=3D IORESOURCE_MEM,
>> =A0 =A0 =A0 },
>
> here too
>
>> =A0 =A0 =A0 [1] =3D {
>> @@ -752,7 +846,6 @@ static struct platform_device usbhs1_dev
>> =A0 =A0 =A0 .resource =A0 =A0 =A0 =3D usbhs1_resources,
>> =A0};
>>
>> -
>> =A0/* LED */
>> =A0static struct gpio_led mackerel_leds[] =3D {
>
> this "just line erase" is not needed =3D)

Well, perhaps it's only me, but trying to make the code look less like
shit may be a good idea. =3D)

/ magnus
