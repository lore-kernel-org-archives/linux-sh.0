From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 15 Dec 2010 07:39:47 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: mackerel: Add mmcif support
Message-Id: <AANLkTi=g61XaRDx9wUGsmEWM0aw0bPQ1TWUYgm1UGKeF@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3p7hfw4po7.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3p7hfw4po7.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Goda-san,

On Wed, Dec 15, 2010 at 4:35 PM, Yusuke Goda <yusuke.goda.sx@renesas.com> w=
rote:
> (2010/12/15 15:43), Magnus Damm wrote:
>> 2010/12/15 Yusuke Goda <yusuke.goda.sx@renesas.com>:
>>> Signed-off-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
>>> ---
>>> +static struct sh_mmcif_plat_data sh_mmcif_plat =3D {
>>> + =A0 =A0 =A0 .sup_pclk =A0 =A0 =A0 =3D 0,
>>> + =A0 =A0 =A0 .ocr =A0 =A0 =A0 =A0 =A0 =A0=3D MMC_VDD_165_195 | MMC_VDD=
_32_33 | MMC_VDD_33_34,
>>> + =A0 =A0 =A0 .caps =A0 =A0 =A0 =A0 =A0 =3D MMC_CAP_4_BIT_DATA |
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_CAP_8_BIT_DATA |
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_CAP_NEEDS_POLL,
>>> + =A0 =A0 =A0 .get_cd =A0 =A0 =A0 =A0 =3D slot_cn7_get_cd,
>>> +};
>>
>> Can we select VDD voltage on this board? I thought it was fixed to
>> 3.3V? Or perhaps I don't understand how the OCR field is supposed to
>> work.
> The mackerel(and ap4evb) can select 1.8v or 3.3v by J22.
> This OCR field set to support either voltage for the card inserted.
> User have to change J22 depends the card to be used.

Ok, I understand. If it is not documented in the board source code
already, please send a patch to add comment about J22 and the OCR
field.

Thank you!

/ magnus
