From: Rob Landley <rob@landley.net>
Date: Sat, 20 Aug 2016 03:40:14 +0000
Subject: Re: [PATCH] sh: Fix building j2_defconfig
Message-Id: <1112fd08-212e-03d3-2de8-ad6a7dfefa88@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20160816154140.25022-1-jason@lakedaemon.net>
 <398e6385-ec40-4493-449d-c8c43fd11d85@landley.net>
 <20160816212349.GS3353@io.lakedaemon.net>
In-Reply-To: <20160816212349.GS3353@io.lakedaemon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jason Cooper <jason@lakedaemon.net>
Cc: Rich Felker <dalias@libc.org>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

On 08/16/2016 04:23 PM, Jason Cooper wrote:
> Hi Rob,
> 
> On Tue, Aug 16, 2016 at 04:15:22PM -0500, Rob Landley wrote:
>> On 08/16/2016 10:41 AM, Jason Cooper wrote:
>>> When targeting the j2, we need to retain '-m2'.  Previously, the
>>> Makefile blew out -m2 on the next line via :=.
>>>
>>> Fix this by s/:=/+=/ when building for the J2.
>>>
>>> Fixes: 5a846abad07f6 ("sh: add support for J-Core J2 processor")
>>> Signed-off-by: Jason Cooper <jason@lakedaemon.net>
>>
>> Speaking of j2, any status on the missing pieces of infratsructure that
>> went in through other trees, without which booting hangs awaiting the
>> first interrupt?
>>
>>   http://lists.j-core.org/pipermail/j-core/2016-August/000326.html
>>
>> It would be nice if the rest of the board support could make it in this
>> release. Which trees are they going through?
> 
> I'm not aware of the status of other bits, but the irqchip driver can be
> found [1] in a stable, based off of v4.8-rc1, branch here:
> 
>   git://git.infradead.org/users/jcooper/linux.git irqchip/jcore

That's got the interrupt controller, and presumably Thomas' tree has the
timer.

Is it likely to go upstream this dev cycle? Basic j2 board support did,
and as I said it hangs before userspace without the rest of the
interrupt controller and timer plumbing (which are currently only used
by this board).

The above message to the j-core list had an attached patch that adds the
missing bits to -rc2. I tested that patch and it worked for me:

Tested-by: Rob Landley <rob@landley.net>

I just checked the current git pull (not quite rc3) and vanilla is still
hanging at the same place, and the patch still applies cleanly. I'm
aware we're in bugfix-only mode, but "kernel hangs before launching
init" seems bug-ish to me.

Rob
