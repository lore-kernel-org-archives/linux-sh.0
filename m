From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 02 Jul 2013 05:52:23 +0000
Subject: Re: [PATCH 00/03] ARM: 64-bit memory fixes, APE6EVM second memory bank
Message-Id: <CANqRtoR=oDnJc48CpvF2GZjL1bBByoaWno58fVAyP9GeqpFSfQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20130605104427.1720.68752.sendpatchset@w520>
 <201306051317.02284.arnd@arndb.de>
 <CANqRtoSZXz5-z4pMTM_gpTf11qQCc870Vf35qLQ4jpoCPnq4KQ@mail.gmail.com>
 <201306121441.35924.arnd@arndb.de>
In-Reply-To: <201306121441.35924.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Russel, Arnd, Stepan,

On Wed, Jun 12, 2013 at 9:41 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 12 June 2013, Magnus Damm wrote:
>> On Wed, Jun 5, 2013 at 8:17 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Wednesday 05 June 2013, Magnus Damm wrote:
>> >> ARM: 64-bit memory fixes, APE6EVM second memory bank
>> >>
>> >> [PATCH 01/03] ARM: Let arm_add_memory() always use 64-bit arguments
>> >> [PATCH 02/03] ARM: Handle 64-bit memory in case of 32-bit phys_addr_t
>> >> [PATCH 03/03] ARM: shmobile: Add second memory bank to DTS for APE6EVM
>> >>
>> >> This patch set contains two fixes and one mach-shmobile specific patch
>> >> to add a second memory bank. The fixes attempt to improve the memory bank
>> >> handling in the ARM kernel in case of 64-bit addresses.
>> >
>> > Please have a look at this patch that Stepan Moskovchenko posted:
>> >
>> > https://patchwork.kernel.org/patch/2639171/
>> >
>> > I think we are going to need only one of the two approaches.
>>
>> Thanks for pointing out this implementation. Is there anything I can
>> do to move this forward?
>
> I'm fine with either solution. If Russell doesn't have a preference
> one way or the other, I'd suggest you agree with Stepan on one of the
> two and put that into the patch tracker.

Thanks for your guidance, Arnd. After pinging Stepan I assume that he
doesn't have any preference either.

Russel, what is your opinion?

Thanks,

/ magnus
