From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 11 Apr 2014 05:51:10 +0000
Subject: Re: [PATCH 01/02] ARM: shmobile: Multicluster APMU prototype support
Message-Id: <CANqRtoSLv5nR28mZw_Yu_rSHBG4Mu11wZoD5qJwNAbgZ0WQGrQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140408124807.9773.97405.sendpatchset@w520>
In-Reply-To: <20140408124807.9773.97405.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

On Fri, Apr 11, 2014 at 4:28 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Magnus,
>
> On Tue, Apr 8, 2014 at 2:48 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> +++ work/arch/arm/mach-shmobile/platsmp-apmu.c  2014-04-08 19:01:55.000000000 +0900
>> @@ -18,6 +18,19 @@
>>  #include <asm/smp_plat.h>
>>  #include <mach/common.h>
>>
>> +/* only enable the cluster that includes the boot CPU by default */
>> +static bool enable_multicluster = false;
>> +
>> +static __init int apmu_setup(char *opt)
>> +{
>> +       if (!opt)
>> +               return -EINVAL;
>> +       if (!strncmp(opt, "multicluster", 12))
>
> Why do you ignore the characters after "multicluster", i.e. why not
> simply "!strcmp(opt, "multicluster)"?

Good point, thanks.

>> +               enable_multicluster = true;
>> +       return 0;
>> +}
>> +early_param("apmu", apmu_setup);
>
> This can use some documentation under Documentation/.

If this was destined for upstream merge I totally agree, but in this
particular case it is just prototype-level code. The proper solution
involves upstream scheduler modifications and perhaps also MCPM once
we care about cluster-level power management.

Cheers,

/ magnus
