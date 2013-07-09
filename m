From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 09 Jul 2013 09:15:46 +0000
Subject: Re: [PATCH 03/04] ARM: shmobile: Add EMEV2 and KZM9D to ARCH_SHMOBILE_MULTI
Message-Id: <CANqRtoTcqYxCTWRok4cuzRWbCBULxwGYhgPyiVH_FgxBLtx7SQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20130709054331.14007.66068.sendpatchset@w520>
 <20130709054359.14007.23619.sendpatchset@w520>
 <201307090937.29805.arnd@arndb.de>
In-Reply-To: <201307090937.29805.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Arnd,

On Tue, Jul 9, 2013 at 4:37 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 09 July 2013, Magnus Damm wrote:
>> +void __init __weak emev2_clock_init(void)
>> +{
>> +       /* in case legacy clocks are disabled then do nothing */
>> +}
>
> Nitpicking:
>
> I don't like the __weak symbols too much, in general I prefer
> doing either
>
>         if (IS_ENABLED(CONFIG_SHMOBILE_CLOCKS)
>                 emev2_clock_init()
>
> or using an inline alternative in the header file.

Sure, good idea. I plan on using the following if you don't mind:

         if (!IS_ENABLED(CONFIG_COMMON_CLK)
                 emev2_clock_init()

Cheers,

/ magnus
