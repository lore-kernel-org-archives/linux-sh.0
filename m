From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 18 Feb 2013 05:40:49 +0000
Subject: Re: [PATCH 05/06] ARM: shmobile: Common shmobile_scu_base in headsmp-scu.S
Message-Id: <CANqRtoRtPOjqy+uhWOxpbQMdp=sDaRMAEqZqjMUBcruLB0NuwQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20130213134628.12153.47120.sendpatchset@w520>
 <20130213134717.12153.6162.sendpatchset@w520>
 <CABYn4syysDVAKRpjDUc9j26SgmUcjxV3rNf3u2kZMZWurhrjiw@mail.gmail.com>
In-Reply-To: <CABYn4syysDVAKRpjDUc9j26SgmUcjxV3rNf3u2kZMZWurhrjiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello Bastian,

On Mon, Feb 18, 2013 at 7:20 AM, Bastian Hecht <hechtb@gmail.com> wrote:
> Hi,
>
> this breaks the secondary CPU startup when I test it. I think you
> can't access shmobile_scu_address this way with the MMU still turned
> off.
>
> But instead of
>> +       ldr     r1, =shmobile_scu_base
>> +       ldr     r1, [r1]                @ SCU base address
>
> try
>
> +        mrc     p15, 4, r1, c15, c0, 0 @ get SCU base address
>
> to get it from the coprocessor.

Thanks. Can you please let us know which platform you see this?

I've executed this on sh73a0 and KZM9G myself without any issues.

Could it be that you are powering down the power domain in your own code?

Thanks,

/ magnus
