From: Rob Herring <robherring2@gmail.com>
Date: Thu, 16 Feb 2012 13:29:49 +0000
Subject: Re: [PATCH v2 00/13] Make mach/irqs.h optional
Message-Id: <4F3D04CD.80504@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1327091591-27125-1-git-send-email-robherring2@gmail.com>
 <20120216084536.GH13673@n2100.arm.linux.org.uk>
 <20120216090542.GA23641@n2100.arm.linux.org.uk>
In-Reply-To: <20120216090542.GA23641@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Russell,

On 02/16/2012 03:05 AM, Russell King - ARM Linux wrote:
> On Thu, Feb 16, 2012 at 08:45:36AM +0000, Russell King - ARM Linux wrote:
>> On Fri, Jan 20, 2012 at 02:32:58PM -0600, Rob Herring wrote:
>>> From: Rob Herring <rob.herring@calxeda.com>
>>>
>>> This series removes the include of mach/irqs.h from asm/irq.h when
>>> SPARSE_IRQ is selected. Platforms which select SPARSE_IRQ have been
>>> updated.
>>
>> Rob,
>>
>> Last night, I merged devel-stable into the stuff which gets built, and it
>> seems your IRQ changes are breaking PXA:
>>
>> Before merge:
>> http://www.arm.linux.org.uk/developer/build/result.php?type=build&idx9
>>
>> After merge:
>> http://www.arm.linux.org.uk/developer/build/result.php?type=build&idx7
> 
> Also see SA11x0 breakage - before:
> http://www.arm.linux.org.uk/developer/build/result.php?type=build&idx7
> after:
> http://www.arm.linux.org.uk/developer/build/result.php?type=build&idx5

For SA1100, it's due to this change being done before my changes and
also possibly reverting of rtc driver changes. I'm working on fixes.

commit 7b7c67bc4284d07285985d487b4ee1a7cc8456e2
Author: Russell King <rmk+kernel@arm.linux.org.uk>
Date:   Sun Jan 29 11:40:08 2012 +0000

    ARM: sa11x0: convert to sparse IRQ

    Now that Neponset, UCB1x00 and SA1111 are all converted to use the IRQ
    allocation interfaces, we can enable sparse IRQ support for SA11x0
    platforms.

    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>


Rob
