From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 26 Aug 2014 11:00:16 +0000
Subject: Re: Armadillo800EVA legacy defconfig seems busted on my board
Message-Id: <CANqRtoQthPwAVfyaV_UavqURrces_8Mj5AOwPzmbRsOE7h9m2g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <CANqRtoQ2Epyhtu2yKCHJMG5VXjiOo6eWNFDTNtzwPEEtNnw8qg@mail.gmail.com>
In-Reply-To: <CANqRtoQ2Epyhtu2yKCHJMG5VXjiOo6eWNFDTNtzwPEEtNnw8qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

On Fri, Aug 8, 2014 at 10:02 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Magnus,
>
> On Fri, Aug 8, 2014 at 1:26 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> On my r8a7740 Armadillo board I've been playing with multiplatform and
>> CCF recently. While doing that I noticed that the defconfig doesn't
>> seem to work.
>>
>> Maybe this is just my board - the boot loader seems unstable in
>
> When starting the kernel, it indeed sometimes hangs after
>
>         Doing init=/init
>
> Usually this happens after cold boot, so remote controlled power switches
> don't help here.

Hm, I wonder what is causing these issues... INTC? =)

>> general and my entire setup requires an additional switch for the
>> Ethernet PHY to even get link up - autonegotiation seems busted with
>> the boot loader...
>
> Working fine here with both a 100 Mbps or a Gbps switch.
> Gether is supposed to be gigabit, but I only get 100 Mbps.
> Ethtool tells me only 10 or 100 Mbps are available?
>
> What kind of switch do you need? What doesn't work?

A shitty semi-managed Netgear Gigabit switch in Autonegotiation does
not work, however switching to a different unmanaged Netgear Gigabit
switch makes it work. So now i have a 5-port Gigabit switch hooked up
in between.

I suspect it to be some issue related to PHY settings in the boot loader.

>> Anyway, if I try to boot the zImage generated from
>> armadillo800eva_defconfig I get zero console output. I managed to
>> track it down to the FB bits being busted.
>
> Strange, armadillo800eva_defconfig is working fine for me on
> renesas-devel-v3.16-20140808, after I added the appropriate nfsroot> kernel command line parameter.

Odd. In my case I could not even get serial console output.

Thanks for your help!

Cheers,

/ magnus
