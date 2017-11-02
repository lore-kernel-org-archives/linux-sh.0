From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 02 Nov 2017 09:45:38 +0000
Subject: Re: [PATCH] sh: remove pointless select of KBUILD_DEFCONFIG
Message-Id: <CAK7LNASW7Jw7-75OspXMi-d2c3nrXOOowiBzAW9XaxONZFOGkw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1507109635-28977-1-git-send-email-yamada.masahiro@socionext.com>
 <CAMuHMdUKdx_f=kH+xg+BEY7VwiUTczqUWtDHOHK52-cLy741iw@mail.gmail.com> <CAK7LNAQOaqMaAypJWoDsWAbS8u23he3QttNVopjSh0hsUQLN-Q@mail.gmail.com>
In-Reply-To: <CAK7LNAQOaqMaAypJWoDsWAbS8u23he3QttNVopjSh0hsUQLN-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

2017-11-02 18:26 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> Hi Geert,
>
> 2017-11-02 18:18 GMT+09:00 Geert Uytterhoeven <geert@linux-m68k.org>:
>> Hi Yamada-san,
>>
>> On Wed, Oct 4, 2017 at 11:33 AM, Masahiro Yamada
>> <yamada.masahiro@socionext.com> wrote:
>>> KBUILD_DEFCONFIG := shx3_defconfig
>>>
>>> is never used in a sensible way.  KBUILD_DEFCONFIG specifies the
>>> defconfig file used by "make defconfig", but CONFIG_SUPERH32 is
>>> never set when building config targets.
>>>
>>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>> ---
>>>
>>>  arch/sh/Makefile | 3 +--
>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/arch/sh/Makefile b/arch/sh/Makefile
>>> index 280bbff..c937ec0 100644
>>> --- a/arch/sh/Makefile
>>> +++ b/arch/sh/Makefile
>>> @@ -96,6 +96,7 @@ defaultimage-$(CONFIG_SH_7619_SOLUTION_ENGINE)        := vmlinux
>>>  # Set some sensible Kbuild defaults
>>>  boot := arch/sh/boot
>>>  KBUILD_IMAGE           := $(boot)/$(defaultimage-y)
>>> +KBUILD_DEFCONFIG       := cayman_defconfig
>>
>> cayman_defconfig is a 64-bit defconfig?
>> As the big chunk of SH platforms are 32-bit (are there any 64-bit out in
>> the wild?), does it make sense to make a 64-bit defconfig the default?
>
>
> No.  Seems 32-bit.
>
>
> $ make ARCH=sh cayman_defconfig && head -n 10 .config
> #
> # configuration written to .config
> #
> #
> # Automatically generated file; DO NOT EDIT.
> # Linux/sh 4.14.0-rc7 Kernel Configuration
> #
> CONFIG_SUPERH=y
> CONFIG_SUPERH32=y
> # CONFIG_SUPERH64 is not set
> CONFIG_ARCH_DEFCONFIG="arch/sh/configs/shx3_defconfig"
> CONFIG_RWSEM_GENERIC_SPINLOCK=y
> CONFIG_GENERIC_BUG=y
>
>
>
> So, both shx3_defconfig and cayman_defconfig are 32-bit defconfig.
>
> I do not know the point of this ifdef select.
>
> Anyway, my clean-up is to remove the unused line from the Makefile.
>
>


Hmm, I was puzzled by SH configuration.

SH decides CPU bit by ARCH environment, not by defconfig.

config SUPERH32
        def_bool ARCH = "sh"



make ARCH=sh defconfig
configures for cayman_defconfig, with CONFIG_SUPERH32

make ARCH=sh64 defconfig
configures for cayman_defconfig, with CONFIG_SUPERH64


shx3_defconfig is never used.


-- 
Best Regards
Masahiro Yamada
