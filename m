From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Tue, 18 Mar 2014 13:48:36 +0000
Subject: Re: [PATCH] ARM: shmobile: Add Lager clock workarounds for SDHI and MMCIF
Message-Id: <53284EB4.60107@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <20140318125247.21670.94176.sendpatchset@w520>
In-Reply-To: <20140318125247.21670.94176.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 18/03/14 14:25, Laurent Pinchart wrote:
> Hi Magnus,
>
> On Tuesday 18 March 2014 21:52:47 Magnus Damm wrote:
>> From: Magnus Damm <damm@opensource.se>
>>
>> Add MMCIF1, SDHI0 and SDHI2 to the clock workaround list for
>> Lager multiplatform. Without these additional lines wakeup
>> from Suspend-to-RAM never happens.
>
> What about fixing the root cause instead of piling up hacks ?

See RFC to move the drivers/sh/pm_runtime.c out of drivers/sh.

I need to address the issue that the code does not actually allow
any devices to PM.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
