From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 30 Apr 2015 15:55:22 +0000
Subject: Re: [PATCH 02/11] ARM: shmobile: Basic r8a7793 SoC support
Message-Id: <5542506A.8020604@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1425661798-10487-3-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1425661798-10487-3-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 04/30/2015 05:17 PM, Ulrich Hecht wrote:

>>> --- a/arch/arm/mach-shmobile/Kconfig
>>> +++ b/arch/arm/mach-shmobile/Kconfig
>>> @@ -75,6 +75,10 @@ config ARCH_R8A7791
>>>          bool "R-Car M2-W (R8A77910)"
>>>          select ARCH_RCAR_GEN2
>>>
>>> +config ARCH_R8A7793
>>> +       bool "R-Car M2N (R8A77940)"

>> The datasheet calls the SoC "M2-N" (with dash).

> Indeed.

>> The part number should probably be "R8A77930" (not sure about
>> the trailing zero).

> No zero in my datasheet.

    Zero should be there, looking at my latest R-Car H2/E2 manuals.

> CU
> Uli

WBR, Sergei

