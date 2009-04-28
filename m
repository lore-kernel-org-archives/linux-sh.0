From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 28 Apr 2009 06:46:22 +0000
Subject: Re: [PATCH] sh-sci h8300 fix
Message-Id: <20090428064622.GA15695@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <87y6tlcrww.wl%ysato@users.sourceforge.jp>
In-Reply-To: <87y6tlcrww.wl%ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Apr 28, 2009 at 12:40:15AM -0400, Yoshinori Sato wrote:
> - Dummy SCIF functions define.

Why? The generic ones should work fine for you.

> - h8300 specific header include.
> 
I guess this one we have to live with. Do you have any plans to convert
the H8300 GPIO API to GENERIC_GPIO?

Also, I note that h8300 does not register an sh-sci platform driver
anywhere. How exactly are you using this driver?
