From: Magnus Damm <magnus.damm@gmail.com>
Date: Sat, 03 May 2014 19:16:13 +0000
Subject: Re: [PATCH v2 02/02] ARM: shmobile: Add SDHI devices for Koelsch DTS
Message-Id: <CANqRtoSsKPGE2L_+_pziPh6GrhO40QUuJ7oVVV5GrDz2DXSrWA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140212095404.4832.61203.sendpatchset@w520>
In-Reply-To: <20140212095404.4832.61203.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Sergei,

On Sat, May 3, 2014 at 3:51 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Hello.
>
>
> On 05/03/2014 04:11 AM, Sergei Shtylyov wrote:
>
>>> From: Magnus Damm <damm@opensource.se>
>
>
>>> Add DT support for SDHI0, SDHI1 and SDHI2 on Koelsch.
>
>
>>> The board specific handling of CD and WP pins are
>>> using GPIOs.
>
>
>>     Frankly speaking, I didn't understand why. The native SDHI[012] CD/WP
>> pins
>> are used in the legacy Koelsch code, why not do the same in the device
>> tree?
>
>
>    Ah, after looking at the SDHI driver, it seems I've figured that out: it
> only can use GPIO for the CD signal, and the WP signal is ignored for R-Car
> gen2 SoCs, so that only GPIO can actually work... Now I'm wondering how the
> legacy code manages to work. :-)

I believe the WP and CD signals are not included on all SDHI
implementations. Only some have it. So for the cases when no WP and CD
are implemented by a certain SDHI instance or when more flexible pin
assignment has been used GPIO is a good choice. Also, as you know, the
WP signal is not used in case of micro-SD, so all these tend to be
pretty board specific. And they are not exactly performance sensitive,
so I think it is good to optimize for flexibility over performance for
those signals.

Cheers,

/ magnus
