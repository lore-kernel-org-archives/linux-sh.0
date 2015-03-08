From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 08 Mar 2015 10:10:50 +0000
Subject: Re: [PATCH 06/11] ARM: shmobile: r8a7793: add SMP support
Message-Id: <CAMuHMdUMkc0+m2XkWXiYaBkmWf6q_wySyTLAx4mL06b_=xr7NA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1425661798-10487-7-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1425661798-10487-7-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, Mar 7, 2015 at 1:08 AM, Simon Horman <horms@verge.net.au> wrote:
>> +static void __init r8a7793_smp_prepare_cpus(unsigned int max_cpus)
>> +{
>> +     void __iomem *p;
>> +     u32 val;
>> +
>> +     /* let APMU code install data related to shmobile_boot_vector */
>> +     shmobile_smp_apmu_prepare_cpus(max_cpus,
>> +                                    r8a7793_apmu_config,
>> +                                    ARRAY_SIZE(r8a7793_apmu_config));
>> +
>> +     /* setup for debug mode */
>> +     if (rcar_gen2_read_mode_pins() & MD(21)) {
>> +             p = ioremap_nocache(APMU, 0x2000);
>> +             val = readl_relaxed(p + CA15DBGRCR);
>> +             writel_relaxed((val | 0x01f80000), p + CA15DBGRCR);
>> +             iounmap(p);
>
> As you noted elsewhere, the above is inconsistent with the r8a7791 where an
> error returned if debug mode is enabled: that is if the if condition is
> true.

The above may actually be what is needed on r8a7791, too :-)

(See commit 277efd30cfc72ec2 ("ARM: shmobile: Check r8a7791 MD21 at SMP boot")
for what it might fix)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
