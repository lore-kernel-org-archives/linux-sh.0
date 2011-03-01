From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 01 Mar 2011 08:02:17 +0000
Subject: Re: [PATCH] sh: Enable PMB support on SH4AL-DSP
Message-Id: <AANLkTi=o1G8dzDc_8KERnerS-02dV7akbNWDm0X4ZR=o@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20110301064150.GB5985@linux-sh.org>
In-Reply-To: <20110301064150.GB5985@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Mar 1, 2011 at 3:41 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Tue, Mar 01, 2011 at 03:45:14PM +0900, Magnus Damm wrote:
>> From: Magnus Damm <damm@opensource.se>
>>
>> The SH4AL-DSP core included in sh7372 requires use of the PMB,
>> update the CONFIG_PMB Kconfig entry to reflect this.
>>
>> Signed-off-by: Magnus Damm <damm@opensource.se>
>
> No. SH4AL-DSP does not in general have a PMB. If this CPU subtype is
> special, then it needs to be special cased.

Well, SH4AL-DSP may not have a PMB in general, but it also may not
"not" have it either.

This is what I can tell after going through data sheet for a bunch of
SH4AL-DSP SoCs:

sh7722 SH4AL-DSP
sh7366 SH4AL-DSP
sh7343 SH4AL-DSP + EXT
sh7367 SH4AL-DSP + EXT + PMB + BOOT
sh7377 SH4AL-DSP + EXT + PMB + BOOT
sh7372 SH4AL-DSP + EXT + PMB + BOOT

EXT = "SH4AL-DSP Extended Functions"
PMB = "32-bit Address Extended Mode"
BOOT = "32-bit Boot Function"

From the table it looks like the SH4AL-DSP core can come with and without PMB.

How would you like to special case it?

/ magnus
