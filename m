From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 10 Jun 2014 10:51:38 +0000
Subject: Re: [PATCH 01/02] ARM: shmobile: Add shared R-Car Gen2 CMA reservation code
Message-Id: <CANqRtoQQvWt+AGq13JJU1B80VjRgaN_KvztobJf4=C2pNSb1wQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140306032824.10814.21953.sendpatchset@w520>
In-Reply-To: <20140306032824.10814.21953.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

Thanks for your feedback!

On Tue, Jun 10, 2014 at 4:19 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Magnus,
>
> On Mon, Jun 9, 2014 at 2:38 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> --- 0001/arch/arm/mach-shmobile/setup-rcar-gen2.c
>> +++ work/arch/arm/mach-shmobile/setup-rcar-gen2.c       2014-06-09 21:01:33.000000000 +0900
>
>> +static int __init rcar_gen2_scan_mem(unsigned long node, const char *uname,
>> +                                    int depth, void *data)
>> +{
>
>> +       u64 lpae_start = (u64)1 << 32;
>
> Casts are evil:
>
> 1ULL << 32
>
> (I hope one day gcc will gain a "-Wcast" option, so we can easily find and
>  inspect all casts, as C-style casts are much more difficult to grep for than
>  C++-style casts).

Oh, right, I totally forgot I added that one. =)

>> +       /* We are scanning "memory" nodes only */
>> +       if (type = NULL) {
>> +               /*
>> +                * The longtrail doesn't have a device_type on the
>> +                * /memory node, so look for the node called /memory@0.
>> +                */
>> +               if (depth != 1 || strcmp(uname, "memory@0") != 0)
>> +                       return 0;
>
> AFAIK Open Firmware in the LongTrail does not support plugging in ARM CPUs
> in its PPC 603e/604e-compatible CPU socket ;-)

You never know - anything is possible with DT. =)

But yes, I get your point - will clean up.

>> +struct cma *rcar_gen2_dma_contiguous;
>> +
>> +void __init rcar_gen2_reserve(void)
>> +{
>
>> +#ifdef CONFIG_DMA_CMA
>> +       if (mrc.size)
>> +               dma_contiguous_reserve_area(mrc.size, mrc.base, 0,
>> +                                           &rcar_gen2_dma_contiguous);
>> +#endif
>
> I assume one day rcar_gen2_dma_contiguous will become used?

That's the idea, yes!

Since Simon kindly queued this up already I will submit an incremental
fix to deal with the issues that you pointed out.

Cheers,

/ magnus
