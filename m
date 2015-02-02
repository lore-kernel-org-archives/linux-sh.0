From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 02 Feb 2015 10:09:59 +0000
Subject: Re: [RFC 5/5] watchdog: sh_mobile: add driver
Message-Id: <1741717.r8MbnsiXNB@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1422802074-1921-6-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1422802074-1921-6-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

On Monday 02 February 2015 11:01:54 Geert Uytterhoeven wrote:
> On Mon, Feb 2, 2015 at 10:54 AM, Laurent Pinchart wrote:
> > How about PM (system and runtime) support ? How does the watchdog behave
> > during system suspend ? You could then replace the clk_prepare_enable()
> > and
> > clk_disable_unprepare() calls with pm_runtime_get_sync() and
> > pm_runtime_put().
>
> That's a good question.
> 
> If the RWDT MSTP clock is disabled, it can't count, and thus can't trigger.

I'd still like to test that. MSTP stands for module stop. While this is 
probably implemented as clock gates in most cases, there is no guarantee that 
it will always be the case. All MSTP guarantees is that the module is stopped, 
but the definition of "stopped" isn't explained. The watchdog counter might 
behave in a special way.

> But I don't know what's the maximum time interval you can have in the system
> between enabling the MSTP clock during system resume, and the first call of
> watchdog_ops.sh_wdt_ping.

-- 
Regards,

Laurent Pinchart

