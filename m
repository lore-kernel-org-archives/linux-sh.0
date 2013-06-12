From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 12 Jun 2013 10:57:16 +0000
Subject: Re: [PATCH 00/03] ARM: 64-bit memory fixes, APE6EVM second memory bank
Message-Id: <CANqRtoSZXz5-z4pMTM_gpTf11qQCc870Vf35qLQ4jpoCPnq4KQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20130605104427.1720.68752.sendpatchset@w520>
 <201306051317.02284.arnd@arndb.de>
In-Reply-To: <201306051317.02284.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Arnd,

On Wed, Jun 5, 2013 at 8:17 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 05 June 2013, Magnus Damm wrote:
>> ARM: 64-bit memory fixes, APE6EVM second memory bank
>>
>> [PATCH 01/03] ARM: Let arm_add_memory() always use 64-bit arguments
>> [PATCH 02/03] ARM: Handle 64-bit memory in case of 32-bit phys_addr_t
>> [PATCH 03/03] ARM: shmobile: Add second memory bank to DTS for APE6EVM
>>
>> This patch set contains two fixes and one mach-shmobile specific patch
>> to add a second memory bank. The fixes attempt to improve the memory bank
>> handling in the ARM kernel in case of 64-bit addresses.
>
> Please have a look at this patch that Stepan Moskovchenko posted:
>
> https://patchwork.kernel.org/patch/2639171/
>
> I think we are going to need only one of the two approaches.

Thanks for pointing out this implementation. Is there anything I can
do to move this forward?

Cheers,

/ magnus
