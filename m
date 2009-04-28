From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Tue, 28 Apr 2009 20:46:09 +0000
Subject: Re: [PATCH] sh-sci h8300 fix
Message-Id: <87k554wlpq.wl%ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <87y6tlcrww.wl%ysato@users.sourceforge.jp>
In-Reply-To: <87y6tlcrww.wl%ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

At Tue, 28 Apr 2009 15:46:22 +0900,
Paul Mundt wrote:
> 
> On Tue, Apr 28, 2009 at 12:40:15AM -0400, Yoshinori Sato wrote:
> > - Dummy SCIF functions define.
> 
> Why? The generic ones should work fine for you.

SCI don't have SCFCR, SCFDR and SCLSR register.
So use dummy r/w functions.


> 
> > - h8300 specific header include.
> > 
> I guess this one we have to live with. Do you have any plans to convert
> the H8300 GPIO API to GENERIC_GPIO?

Yes.
But not working now.

> Also, I note that h8300 does not register an sh-sci platform driver
> anywhere. How exactly are you using this driver?

It's already fixed.

-- 
Yoshinori Sato
<ysato@users.sourceforge.jp>
