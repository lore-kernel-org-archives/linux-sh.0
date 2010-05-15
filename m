From: Ian Molton <ian@mnementh.co.uk>
Date: Sat, 15 May 2010 10:26:41 +0000
Subject: Re: Status of tmio_mmc DMA support for SDIO
Message-Id: <AANLkTiky1H2rJLoJVa_iDVKyGKLsVKGS7_bb4NctJ1nL@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <A0C4AD4CC48F4CAAA4C9CB027472149D@RSI45> <Pine.LNX.4.64.1005140843320.6147@axis700.grange>
	<AANLkTikKmiRe0f9UXQo3bkwxjCVPzivTrTEYyzY3DcMB@mail.gmail.com>
	<Pine.LNX.4.64.1005141953160.6147@axis700.grange> <1B215080664E44FE81F6BA1DCFA65A38@RSI45>
In-Reply-To: <1B215080664E44FE81F6BA1DCFA65A38@RSI45>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "Charles D. Krebs" <ckrebs@therealtimegroup.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-sh@vger.kernel.org, sailaja.sdn@redpinesignals.com, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org

Could someone send me a copy of the patch to tmio ?

--=20
Ian Molton
Linux, Automotive, and other hacking:
http://www.mnementh.co.uk/



On 14 May 2010 20:43, Charles D. Krebs <ckrebs@therealtimegroup.com> wrote:
>>> Just saw this - am I right in thinking someone has written SDIO
>>> support for TMIO ? Im afraid I dont appear to have the preceeding
>>> emails.
>>
>> This is the first email regarding TMIO SDIO that I'm aware of - from
>> Charles, he's sent it tothe sh ML and to me and I've added you and the m=
mc
>> list to CC.
>
> To clarify - I didn't write that code. =A0It was developed by some of the
> Kernel guys over at Renesas Japan specifically for my request to support
> SDIO under their BSP for 2.6.33. =A0The code in tmio and sh_mobile_sdhi
> replaces a previously closed source module for SD support on the hardware
> due to licensing restrictions of the SD consortium. =A0Apparently those i=
ssues
> were resolved and now the complete SD stack is integrated into the Kernel
> directly. =A0However, the transition didn't include support for SDIO, so =
the
> patch to tmio was provided in the interim.
>
> Magnus - Do you know the author for the SDIO patch?
>
> Charles Krebs, Embedded Solutions Developer
> The Realtime Group
>
> --------------------------------------------------
> From: "Guennadi Liakhovetski" <g.liakhovetski@gmx.de>
> Sent: Friday, May 14, 2010 12:54 PM
> To: "Ian Molton" <ian@mnementh.co.uk>
> Cc: "Charles D. Krebs" <ckrebs@therealtimegroup.com>;
> <linux-sh@vger.kernel.org>; <sailaja.sdn@redpinesignals.com>; "Magnus Dam=
m"
> <magnus.damm@gmail.com>; <linux-mmc@vger.kernel.org>
> Subject: Re: Status of tmio_mmc DMA support for SDIO
>
>> On Fri, 14 May 2010, Ian Molton wrote:
>>
>>> Just saw this - am I right in thinking someone has written SDIO
>>> support for TMIO ? Im afraid I dont appear to have the preceeding
>>> emails.
>>
>> This is the first email regarding TMIO SDIO that I'm aware of - from
>> Charles, he's sent it tothe sh ML and to me and I've added you and the m=
mc
>> list to CC.
>>
>> Thanks
>> Guennadi
>> ---
>> Guennadi Liakhovetski, Ph.D.
>> Freelance Open-Source Software Developer
>> http://www.open-technology.de/
>>
>
>
