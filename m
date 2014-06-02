From: Benoit Cousson <bcousson@baylibre.com>
Date: Mon, 02 Jun 2014 07:11:01 +0000
Subject: Re: [PATCH 3/7] ARM: shmobile: Disable DVS support for r8a7790
Message-Id: <538C2385.40702@baylibre.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5386E66D.3020502@bp.renesas.com>
In-Reply-To: <5386E66D.3020502@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi,

On 02/06/2014 05:14, Gaku Inami wrote:
> Hi Geert
>
> Thank you for your feedback.
>
>> The role of the DT is to describe the hardware.
>> Not using DVS because the effect of power consumption is low or non-exis=
tent
>> is a software policy.
>>
>> So perhaps it should be kept?
>
> I understand what you mean. I will keep the setting of VDD into DT,
> and consider to disable DVS in a different way.
>

Indeed, the line "cpu0-supply =3D <&vdd_dvfs>;" does just provide the name =

of the power rail that supply the ca15 cluster.

The postfix _dvfs is a little bit misleading in this case, I do agree.

If you do no want voltage scaling, it is just a matter of keeping the=20
same voltage in the OPP table. This is what I have done in the series I=20
sent a while back.

That being said, what is the exact voltage range supported by the CPU?
AFAIR, with 28nm process some SoCs are able to scale down to 0.9v.

Thanks,
Benoit

--=20
Beno=C3=AEt Cousson
BayLibre
Embedded Linux Technology Lab
www.baylibre.com
