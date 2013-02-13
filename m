From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 13 Feb 2013 00:47:20 +0000
Subject: Re: [PATCH 00/06] ARM: shmobile: Trivial SMP cleanups
Message-Id: <CANqRtoSL-qFvg+r03CRb-2k=zRoDuoiH2b4fK+uJ3uHgTgHR8A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20130212154438.13067.77359.sendpatchset@w520>
 <20130212221622.GA24325@verge.net.au>
In-Reply-To: <20130212221622.GA24325@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Simon,

On Wed, Feb 13, 2013 at 7:16 AM, Simon Horman <horms@verge.net.au> wrote:
> On Wed, Feb 13, 2013 at 12:44:38AM +0900, Magnus Damm wrote:
>> ARM: shmobile: Trivial SMP cleanups
>>
>> [PATCH 01/06] ARM: shmobile: Remove unused headers from hotplug.c
>> [PATCH 02/06] ARM: shmobile: Remove partial CPU Hotplug from EMEV2
>> [PATCH 03/06] ARM: shmobile: Move EMEV2 CPU boot vector setup code
>> [PATCH 04/06] ARM: shmobile: Remove sh73a0_get_core_count()
>> [PATCH 05/06] ARM: shmobile: Remove r8a7779_get_core_count()
>> [PATCH 06/06] ARM: shmobile: Remove emev2_get_core_count()
>>
>> This series contains random trivial SMP cleanups for mach-shmobile.
>>
>> The patches are known to build for sh73a0, r8a7779 and EMEV2,
>> and on top of that they also work well on the KZM9D/EMEV2 board.
>
> Thanks, I have applied these to a new soc5 branch,
> based on the soc4 branch which has been merged into arm-soc.
>
> I have also updated next and topic/all+next with these changes.
>
> I anticipate these changes will appear upstream in 3.10.

Thanks, that is of course fine with me. I will prepare my second batch
of SMP updates then.

Cheers,

/ magnus
