From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 16 Feb 2010 04:02:06 +0000
Subject: Re: [PATCH] ARM: ap4evb: Add SMSC 9220 network support
Message-Id: <aec7e5c31002152002r74f3e2dao4c1b3880309699b4@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <ueiklq518.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <ueiklq518.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hey Morimoto-san,

Thanks for your work on this!

On Tue, Feb 16, 2010 at 11:30 AM, Kuninori Morimoto
<morimoto.kuninori@renesas.com> wrote:
> @@ -111,10 +141,24 @@ static void __init ap4evb_map_io(void)
> =A0 =A0 =A0 =A0shmobile_setup_console();
> =A0}
>
> +#define =A0 =A0 =A0 =A0PORT39CR =A0 =A0 =A0 =A00xE6051027
> +#define =A0 =A0 =A0 =A0PORT65CR =A0 =A0 =A0 =A00xE6052041
> =A0static void __init ap4evb_init(void)
> =A0{
> =A0 =A0 =A0 =A0sh7372_add_standard_devices();
>
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* enable SMSC911X
> + =A0 =A0 =A0 =A0*
> + =A0 =A0 =A0 =A0* FIXME
> + =A0 =A0 =A0 =A0*
> + =A0 =A0 =A0 =A0* AP4 doesn't have pinmux support now.
> + =A0 =A0 =A0 =A0* So, set the value directly here
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 __raw_writeb(0x01, PORT65CR); /* enable CS5A */
> + =A0 =A0 =A0 __raw_writeb(0x00, PORT39CR); /* enable IRQ6 */
> + =A0 =A0 =A0 enable_irq(6);
> +
> =A0 =A0 =A0 =A0platform_add_devices(ap4evb_devices, ARRAY_SIZE(ap4evb_dev=
ices));
> =A0}

Why enable_irq(6)?

/ magnus
