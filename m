From: "Magnus Damm" <magnus.damm@gmail.com>
Date: Fri, 18 Jul 2008 01:14:02 +0000
Subject: Re: [PATCH] sh: Add SuperH Mobile MSTPCR bits to clock framework
Message-Id: <aec7e5c30807171814k490e1fe9p4a0d35455314ca3f@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20080717095615.19566.83528.sendpatchset@rx1.opensource.se>
In-Reply-To: <20080717095615.19566.83528.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jul 18, 2008 at 7:41 AM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Thu, Jul 17, 2008 at 06:56:15PM +0900, Magnus Damm wrote:
>> +#define DECLARE_MSTPCRN(regnr, bitnr, bitstr)                \
>> +{                                                    \
>> +     .name = "mstp" __stringify(regnr) bitstr,       \
>> +     .arch_flags = bitnr,                            \
>> +     .ops = &sh7722_mstpcr ## regnr ## _clk_ops,     \
>> +}
>> +
>> +#define DECLARE_MSTPCR(regnr) \
>> +     DECLARE_MSTPCRN(regnr, 31, "31"), \
>
> This looks a bit clumsy. Why can't you __stringify bitnr and paste that
> against the stringified regnr? You may not be able to use the helper
> macros directly, but you can certainly abuse the pre-processor in such a
> way.

I wanted to do it that way but I couldn't figure out how to create
clock names identical to the data sheet - for instance "mstp209".
Using stringified regnr and bitnr i could only come up with "mstp29",
ie the prefix "0" in bitnr is missing.

Thanks,

/ magnus
