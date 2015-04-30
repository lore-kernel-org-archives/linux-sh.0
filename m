From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Thu, 30 Apr 2015 14:19:25 +0000
Subject: Re: [PATCH 06/11] ARM: shmobile: r8a7793: add SMP support
Message-Id: <CAO3366y1Sxf7SV9DTJ8HFqZGyt4RYqf8v_4syDgtEL63dCc2GA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1425661798-10487-7-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1425661798-10487-7-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, Mar 7, 2015 at 1:08 AM, Simon Horman <horms@verge.net.au> wrote:
>> --- /dev/null
>> +++ b/arch/arm/mach-shmobile/smp-r8a7793.c
>> @@ -0,0 +1,69 @@
[...]
>> +static struct rcar_apmu_config r8a7793_apmu_config[] = {
>> +     {
>> +             .iomem = DEFINE_RES_MEM(0xe6152000, 0x88),
>
> The above seems inconsistent with the r8a7791 where
> 0x188 is used as the size of the resource.

The resource is larger on the r8a7791 because it has more cores.

CU
Uli
