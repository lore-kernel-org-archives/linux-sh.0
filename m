From: Aurelien Jarno <aurelien@aurel32.net>
Date: Fri, 11 Jun 2010 06:33:19 +0000
Subject: Re: [PATCH v2] sh_tmu: compute mult and shift before registration
Message-Id: <20100611063319.GB21417@hall.aurel32.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1275342348-22499-1-git-send-email-aurelien@aurel32.net>
In-Reply-To: <1275342348-22499-1-git-send-email-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jun 11, 2010 at 03:01:51PM +0900, Paul Mundt wrote:
> > I agree with adding a __clocksource_updatefreq_hz(cs, p->rate) line to
> > sh_cmt_clocksource_enable(), but the p->rate value should already be
> > up to date so I don't think you need to add any clk_get_rate() call.
> > 
> > Want me to hack up a replacement patch?
> > 
> This all started out from Aurelien's bug report, so as long as that
> remains addressed I'm pretty flexible with how we handle the
> registration/enable case. 
> 

I am ready to test new patches if needed.

-- 
Aurelien Jarno	                        GPG: 1024D/F1BCDB73
aurelien@aurel32.net                 http://www.aurel32.net
