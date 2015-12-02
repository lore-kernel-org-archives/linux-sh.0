From: Dirk Behme <dirk.behme@de.bosch.com>
Date: Wed, 02 Dec 2015 06:38:44 +0000
Subject: Re: renesas-drivers-2015-12-01-v4.4-rc3
Message-Id: <565E91F4.50207@de.bosch.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1448970627-8690-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1448970627-8690-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 02.12.2015 01:32, Simon Horman wrote:
> Hi Dirk,
>
> On Tue, Dec 01, 2015 at 05:05:24PM +0100, Dirk Behme wrote:
>> Hi Geert und Simon,
>>
>> On 01.12.2015 12:50, Geert Uytterhoeven wrote:
>>> I've pushed renesas-drivers-2015-12-01-v4.4-rc3 to
>>> https://git.kernel.org/cgit/linux/kernel/git/geert/renesas-drivers.git
>>> This tree is meant to ease development of platform support and drivers for
>>> Renesas ARM ("shmobile") SoCs. It's created by merging (a) the for-next
>>> branches of various subsystem trees and (b) branches with driver code
>>> submitted or planned for submission to maintainers into the development
>>> branch of Simon Horman's renesas.git tree.
>>
>>
>> Many thanks for distilling this!
>>
>> Using this on the SalvatorX, we get the latest kernel with the latest
>> drivers.
>>
>> On the other hand, there is
>>
>> https://git.kernel.org/cgit/linux/kernel/git/horms/renesas-bsp.git/log/?h=v4.2/rcar-3.0.x
>>
>> which is on an older kernel using older driver versions. But, it seems to me
>> that compared to renesas-drivers-2015-12-01-v4.4-rc3 it has some additional
>> drivers / functionality.
>>
>> I wonder if we want to try to combine both to get something like the "latest
>> and greatest" for the SalvatorX? I.e. take
>> renesas-drivers-2015-12-01-v4.4-rc3 and extend it by the additional
>> functionality from v4.2/rcar-3.0.x.
>>
>> To illustrate what I'm talking about I cherry picked some low hanging fruits
>> from v4.2/rcar-3.0.x and put them on renesas-drivers-2015-12-01-v4.4-rc3:
>>
>> https://github.com/dirkbehme/linux-renesas-rcar-gen3/commits/dirk/gen3-latest-update
>>
>> The idea is to extend this step by step by additional parts of
>> v4.2/rcar-3.0.x.
>>
>> What do you think?
>>
>> Maybe the first step would be to identify the parts from v4.2/rcar-3.0.x not
>> yet in renesas-drivers-2015-12-01-v4.4-rc3. Having a quick look based on the
>> defconfigs results in
>>
>> * more/extended USB functionality?
>> * SATA?
>> * I2C / ADV7482?
>> * media / camera?
>> * DRM / framebuffer / HDMI?
>> * eMMC ?
>> * ...?
>
> We area in the (slow) process of doing more or less what you describe above.
> Isolating portions of the BSP that look good for mainline and submitting
> them for inclusion there. To be clear our goal is to make mainline as
> feature-rich as possible but its a long road.


Yes, as always, no problem :)

This is totally fine and really welcome from maintenance / mainlining 
point of view!


But from users point of view, it would be nice to have a "latest and 
greatest" branch containing everything what's known to be working. Maybe 
even if it's not mainline ready, yet. I'd think that this would extend 
the testing, too.

This doesn't exist, yet?

I'd be happy to try to work a little bit on this in

https://github.com/dirkbehme/linux-renesas-rcar-gen3/commits/dirk/gen3-latest-update

but I might need some support. At least asking questions and getting 
some details (as I'm in the starting phase with RCar).


Do we know what's in the BSP but not yet in 
renesas-drivers-2015-12-01-v4.4-rc3? I.e. anything like a list I've 
started above?


Best regards

Dirk

