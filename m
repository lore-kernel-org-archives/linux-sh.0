From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 18 Dec 2014 09:09:24 +0000
Subject: Re: [PATCH v2 00/05] ARM: shmobile: sh73a0 and kzm9g Multiplatform revisit
Message-Id: <CANqRtoTdbE9VbYfhO8hQDpGpZsgo6M+CbMbqBVS2bEGsYM+4Yw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20141217094204.7039.45337.sendpatchset@w520>
In-Reply-To: <20141217094204.7039.45337.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

On Thu, Dec 18, 2014 at 5:03 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Magnus, Simon,
>
> On Wed, Dec 17, 2014 at 10:42 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> ARM: shmobile: sh73a0 and kzm9g Multiplatform revisit
>>
>> [PATCH v2 01/05] ARM: shmobile: kzm9g-reference: 0x48008000 load address
>> [PATCH v2 02/05] ARM: shmobile: sh73a0: Introduce generic setup callback
>> [PATCH v2 03/05] ARM: shmobile: sh73a0: Add Multiplatform support
>> [PATCH v2 04/05] ARM: shmobile: kzm9g: Sync with DT reference
>> [PATCH v2 05/05] ARM: shmobile: kzm9g: Build DTS for Multiplatform
>>
>> This patch series enables sh73a0 Multiplatform support. At this point
>> the KZM9G board code written in C is left as-is, but future updates will
>> make sure to get rid of DT reference DTS and C board code.
>>
>> To make it work you need the sh73a0 CCF v7 series and the DIV6 v7
>> series from Ulrich Hecht.
>>
>> Patch 1-3 should be possible to merge without any special dependencies.
>>
>> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks.

> EXCEPT for "[PATCH v2 01/05] ARM: shmobile: kzm9g-reference: 0x48008000 load
> address", which I'd like to NAK because it drops 25% of RAM.

Ok, but the patch isn't dropping 25% of the RAM, the memory node is
the same as before. It is just the ARM memory handling implementation
that skips over that memory for some reason. =)

So how do you think we should fix it?

Thanks,

/ magnus
