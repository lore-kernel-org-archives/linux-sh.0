From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Tue, 20 May 2014 12:34:26 +0000
Subject: Re: [PATCH] clk: shmobile: Add R8A7740-specific clock support
Message-Id: <CAO3366zcREudh09Kswig8ecTZQetktagAJ9AWBHEFM-pjBh1VA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1400156437-19694-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <CAMuHMdWDwgugY6jzj3UuvweyrRqj6sey3smLHQ1fgw_0mAJsKw@mail.gmail.com>
In-Reply-To: <CAMuHMdWDwgugY6jzj3UuvweyrRqj6sey3smLHQ1fgw_0mAJsKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, May 19, 2014 at 9:16 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Thu, May 15, 2014 at 2:20 PM, Ulrich Hecht <ulrich.hecht@gmail.com> wrote:
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/renesas,r8a7740-cpg-clocks.txt
[...]
>> +  - clocks: Reference to the two parent clocks
>
> Aren't there 3 parent clocks (extal1, extal2, extalr)?

Yes, there are.

>> +static struct div4_clk div4_clks[] = {
>> +       { "i", CPG_FRQCRA, 20, 0x6fff, CLK_ENABLE_ON_INIT },
>> +       { "zg", CPG_FRQCRA, 16, 0x6fff, CLK_ENABLE_ON_INIT },
>> +       { "b", CPG_FRQCRA,  8, 0x6fff, CLK_ENABLE_ON_INIT },
>> +       { "m1", CPG_FRQCRA,  4, 0x6fff, CLK_ENABLE_ON_INIT },
>> +       { "hp", CPG_FRQCRB,  4, 0x6fff, 0 },
>> +       { "hpp", CPG_FRQCRC, 20, 0x6fff, 0 },
>> +       { "usbp", CPG_FRQCRC, 16, 0x6fff, 0 },
>> +       { "s", CPG_FRQCRC, 12, 0x6fff, 0 },
>> +       { "zb", CPG_FRQCRC,  8, 0x6fff, 0 },
>> +       { "m3", CPG_FRQCRC,  4, 0x6fff, 0 },
>> +       { "cp", CPG_FRQCRC,  0, 0x6fff, 0 },
>
> I assume the identical mask values (0x6fff) are not the final values, and will
> be updated when the field becomes used?

I copied them from the legacy driver, and they are the actual values.
And thus redundant. :) I'll remove the mask.

Thanks for your comments. I'll wait if Laurent has anything to add and
send a new patch then.

CU
Uli
