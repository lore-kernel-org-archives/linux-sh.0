From: David Miller <davem@davemloft.net>
Date: Fri, 28 Mar 2014 18:22:29 +0000
Subject: Re: [PATCH] sh_eth: pm_runtime should not need null operations
Message-Id: <20140328.142229.614593837271428017.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1395396913-24354-1-git-send-email-ben.dooks@codethink.co.uk>
	<CAMuHMdWO-kNdWT_AxzAmCTrx3NerWpTG+auFNZTcL5hsbN+++A@mail.gmail.com>
	<532C1B13.7000805@codethink.co.uk>
In-Reply-To: <532C1B13.7000805@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ben.dooks@codethink.co.uk
Cc: geert@linux-m68k.org, linux-kernel@lists.codethink.co.uk, netdev@vger.kernel.org, linux-sh@vger.kernel.org, rjw@rjwysocki.net

From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Fri, 21 Mar 2014 11:57:23 +0100

> On 21/03/14 11:30, Geert Uytterhoeven wrote:
>> Hi Ben,
>>
>> On Fri, Mar 21, 2014 at 11:15 AM, Ben Dooks
>> <ben.dooks@codethink.co.uk> wrote:
>>> The driver has a no-op for the pm_runtime callbacks but
>>> the pm_runtime core should correctly ignore drivers without
>>> any pm_rumtime callback ops.
>>
>> The pm_runtime core doesn't ignore non-existing
>> runtime_{suspend,resume}
>> callbacks, it turns them into a failure withv -ENOSYS.
>> Only non-existing runtime_idle callbacks are ignored.
> 
> I've added Rafael Wysocki as he may be able to add better
> feedback to this issue.

This discussion has stalled so I'm marking this patch as
"deferred" in patchwork.

Please resubmit once things are resolved, thanks.
