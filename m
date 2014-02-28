From: Benoit Cousson <bcousson@baylibre.com>
Date: Fri, 28 Feb 2014 16:34:55 +0000
Subject: Re: [RFC 0/4] ARM: shmobile: Add CPUFreq support for r8a7790-lager platform
Message-Id: <5310BAAF.5030709@baylibre.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1393456190-7870-1-git-send-email-bcousson@baylibre.com>
In-Reply-To: <1393456190-7870-1-git-send-email-bcousson@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On 28/02/2014 15:54, Geert Uytterhoeven wrote:
> On Fri, Feb 28, 2014 at 3:15 PM, Benoit Cousson <bcousson@baylibre.com> w=
rote:
>> For the voltage, it should be similar, but I do not have any information=
 and
>> I'm not sure that the regulator used on the Koelsh board is the same
>> (da9210).
>
> Koelsch also has a DA9210 regulator. At first sight, the wiring seems sim=
ilar.
> It's connected to i2c6 instead of i2c3, though.

OK, that's a good news. Thanks for checking.


Laurent,

In order to check the voltage, just enable the DA9210 driver but do not=20
enable cpufreq.

Then just check the regulator voltage. It was 1.08v by default on the Lager.

Regards,
Benoit

>
> Gr{oetje,eeting}s,
>
>                          Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                  -- Linus Torvalds
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--=20
Beno=C3=AEt Cousson
BayLibre
Embedded Linux Technology Lab
www.baylibre.com
