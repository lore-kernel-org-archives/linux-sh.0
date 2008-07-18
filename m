From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 18 Jul 2008 21:52:27 +0000
Subject: Re: interval of TMU
Message-Id: <20080718215227.GC21846@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080718.194022.68560338.saito@densan.co.jp>
In-Reply-To: <20080718.194022.68560338.saito@densan.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jul 18, 2008 at 07:40:22PM +0900, Hideo Saito wrote:
> It seems that TCOR register is set by current value of TCNT register,
> when tmu_set_mode() is called after the clock starts in
> tmu_timer_init(). Is this right?
> 
> I think that CLOCK_EVT_MODE_PERIODIC is to initialize the timer, not to
> change interval.
> 
Good question, I don't remember what I was thinking at the time. I'll
check this again on hardware when I'm back in Japan next week after the
PM summit.
