From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 09 Apr 2014 04:11:43 +0000
Subject: Re: [PATCH 00/02] ARM: shmobile: r8a7790 8-core boot prototype
Message-Id: <CANqRtoRvR15tXsUtFjOK4Lve0W7wK1u9gU0X2j1qy4xPf6yntA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140408124758.9773.14458.sendpatchset@w520>
In-Reply-To: <20140408124758.9773.14458.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Wed, Apr 9, 2014 at 9:24 AM, Simon Horman <horms@verge.net.au> wrote:
> On Tue, Apr 08, 2014 at 09:47:58PM +0900, Magnus Damm wrote:
>> ARM: shmobile: r8a7790 8-core boot prototype
>>
>> [PATCH 01/02] ARM: shmobile: Multicluster APMU prototype support
>> [PATCH 02/02] ARM: shmobile: r8a7790 CCI configuration
>>
>> Prototype patches to allow 8-core boot on r8a7790. The first patch
>> unlocks multicluster support to allo SMP boot of all CPU cores, and
>> the second initializes the CCI-400 hardware.
>
> Hi Magnus,
>
> I applied these patches on top of renesas-devel-v3.14-20140408,
> compiled using the shmobile_defconfig, and booted a Lager board.
> I was expecting to see 8 cores in /proc/cpuinfo but I only see 4.
>
> Are my expectations wrong or am I missing something?

The maximum number of CPUs in the kernel config may be limited to 4 by default?

Also, to use CA7 with upstream you need to disable the arch timer and
rely on CMT.

To clarify, I don't expect these to be merged upstream. Also, I don't
believe the standard kernel config needs to work out of the box.

Cheers,

/ magnus
