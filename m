From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 29 Nov 2010 04:38:10 +0000
Subject: Re: [PATCH 2/5] ARM: mach-shmobile: mackerel: Add SMSC support
Message-Id: <AANLkTi=cDPahN+6oeGxQdN8Kk2jqchJ+v3Y3Ug__xQ2d@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3pfwuk50pb.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pfwuk50pb.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

Thanks for your patch.

On Mon, Nov 29, 2010 at 11:21 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> +static struct smsc911x_platform_config smsc911x_info =3D {
> + =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D SMSC911X_USE_16BIT | SMSC911X=
_SAVE_MAC_ADDRESS,

There is no EEPROM on this board? I guess so since you use
SMSC911X_SAVE_MAC_ADDRESS.

I suspect that this code is not going to work with romImage since it
depends on the boot loader for mac address.

> @@ -142,6 +172,10 @@ static void __init mackerel_init(void)
> =A0 =A0 =A0 =A0gpio_request(GPIO_FN_SCIFA0_TXD, NULL);
> =A0 =A0 =A0 =A0gpio_request(GPIO_FN_SCIFA0_RXD, NULL);
>
> + =A0 =A0 =A0 /* enable SMSC911X */
> + =A0 =A0 =A0 gpio_request(GPIO_FN_CS5A, =A0 =A0 =A0NULL);
> + =A0 =A0 =A0 gpio_request(GPIO_FN_IRQ6_39, =A0 NULL);
> +

If you have time, please add code to setup optimized memory
read/writing timings for the CS memory window here.

Thanks,

/ magnus
