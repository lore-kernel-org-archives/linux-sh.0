From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 15 Dec 2010 06:40:52 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: mackerel: Add mmcif support
Message-Id: <AANLkTimJhCbxapjJ7z-zrsw=+P87TRK2OvsE2apWC_BR@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3p7hfw4po7.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3p7hfw4po7.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Wed, Dec 15, 2010 at 3:02 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Wed, Dec 15, 2010 at 01:08:05PM +0900, Yusuke Goda wrote:
>> @@ -723,6 +770,7 @@ static void __init mackerel_init(void)
>> =A0 =A0 =A0 gpio_request(GPIO_FN_SDHID0_1, NULL);
>> =A0 =A0 =A0 gpio_request(GPIO_FN_SDHID0_0, NULL);
>>
>> +#if !defined(CONFIG_MMC_SH_MMCIF)
>> =A0 =A0 =A0 /* enable SDHI1 */
>> =A0 =A0 =A0 gpio_request(GPIO_FN_SDHICMD1, NULL);
>> =A0 =A0 =A0 gpio_request(GPIO_FN_SDHICLK1, NULL);
>> @@ -730,6 +778,7 @@ static void __init mackerel_init(void)
>> =A0 =A0 =A0 gpio_request(GPIO_FN_SDHID1_2, NULL);
>> =A0 =A0 =A0 gpio_request(GPIO_FN_SDHID1_1, NULL);
>> =A0 =A0 =A0 gpio_request(GPIO_FN_SDHID1_0, NULL);
>> +#endif
>> =A0 =A0 =A0 /* card detect pin for MMC slot (CN7) */
>> =A0 =A0 =A0 gpio_request(GPIO_PORT41, NULL);
>> =A0 =A0 =A0 gpio_direction_input(GPIO_PORT41);
>> @@ -742,6 +791,18 @@ static void __init mackerel_init(void)
>> =A0 =A0 =A0 gpio_request(GPIO_FN_SDHID2_1, NULL);
>> =A0 =A0 =A0 gpio_request(GPIO_FN_SDHID2_0, NULL);
>>
>> + =A0 =A0 /* MMCIF */
>> + =A0 =A0 gpio_request(GPIO_FN_MMCD0_0, NULL);
>> + =A0 =A0 gpio_request(GPIO_FN_MMCD0_1, NULL);
>> + =A0 =A0 gpio_request(GPIO_FN_MMCD0_2, NULL);
>> + =A0 =A0 gpio_request(GPIO_FN_MMCD0_3, NULL);
>> + =A0 =A0 gpio_request(GPIO_FN_MMCD0_4, NULL);
>> + =A0 =A0 gpio_request(GPIO_FN_MMCD0_5, NULL);
>> + =A0 =A0 gpio_request(GPIO_FN_MMCD0_6, NULL);
>> + =A0 =A0 gpio_request(GPIO_FN_MMCD0_7, NULL);
>> + =A0 =A0 gpio_request(GPIO_FN_MMCCMD0, NULL);
>> + =A0 =A0 gpio_request(GPIO_FN_MMCCLK0, NULL);
>> +
>
> So we can infer that MMCIF and SDHI1 are muxed on the same pins and we
> need to select one or the other based on the configuration. Is there a
> way to figure out which mode we are in based off of the card detect pin?
> It would be nice to detect this at runtime instead of having to hardcode
> the configuration.

Good luck with that. =3D)

The "mackerel" board is quite similar to AP4EVB. There is no way to
detect during runtime.

/ magnus
