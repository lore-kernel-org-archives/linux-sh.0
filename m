From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Wed, 03 Dec 2014 09:57:58 +0000
Subject: Re: [PATCH 5/5] ARM: shmobile: r8a73a4: ape6evm: replace legacy with multiplatform
Message-Id: <CAO3366zV_f9DvyovEYvLtQ06eo3Z=AW59Py0O2KmZD4n9yeWYg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1417509439-31739-6-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1417509439-31739-6-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Dec 2, 2014 at 10:29 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Tue, Dec 2, 2014 at 9:37 AM, Ulrich Hecht
> <ulrich.hecht+renesas@gmail.com> wrote:
>> --- a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
>> +++ /dev/null
>> @@ -1,240 +0,0 @@
[...]
>> -                       clocks = <&zb_clk>;
>
> I may be wrong, but I think something went wrong with the patch generation,
> as "[PATCH 1/3] ARM: shmobile: ape6evm-reference: add ethernet controller
> to DT" did _not_ add the zb_clk?

Looking at the timestamps, it seems I forgot to rerun format-patch on
that one...
Thanks for spotting.

CU
Uli
