From: David Cohen <david.a.cohen@linux.intel.com>
Date: Sun, 17 Nov 2013 02:38:49 +0000
Subject: Re: [PATCH] gpio: rcar: Support both edge trigger with DT
Message-Id: <52882C39.2050505@linux.intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1384359983-29178-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <5285A686.4000405@linux.intel.com> <1678796.qQvoAN1bBU@avalon>
In-Reply-To: <1678796.qQvoAN1bBU@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, Simon Horman <horms@verge.net.au>

Hi Laurent,

>> According to ANSI C, you can't initialize struct with empty { }. You
>> would need at least one 0 inside.
>> Despite gcc accepts it, there are some ppl over there trying kernel
>> with different compilers :)
>>
>> (Hope I'm not being too nitpicky)
> 
> You're certainly not worse than me in that regard ;-) However, given that most 
> (if not all, I've stopped looking after 50) drivers seem to use an empty 
> initializer at the end of their of_device_id array, I'm not sure whether we 
> really need to care. I assume LLVM handles the empty initializer fine.

I looked some examples too. Looks like empty { } are more common in
kernel than { 0 }. I guess either we add this warning to checkpatch or
we keep accepting it waiting for ANSI C will to adopt this at some
point :)

Br, David
