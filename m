From: Simon Horman <horms@verge.net.au>
Date: Thu, 27 Jun 2013 07:31:57 +0000
Subject: Re: [PATCH v2] clocksource: sh_cmt: Use devm_* managed helpers
Message-Id: <20130627073156.GA13927@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1371558978-10870-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <CANqRtoQUadXd+RGbW3S1S4vxvz+iQJVoAVXY-JL-2G-DJTT6WQ@mail.gmail.com>
In-Reply-To: <CANqRtoQUadXd+RGbW3S1S4vxvz+iQJVoAVXY-JL-2G-DJTT6WQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, SH-Linux <linux-sh@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, John Stultz <john.stultz@linaro.org>, Sachin Kamat <sachin.kamat@linaro.org>

On Tue, Jun 18, 2013 at 10:29:38PM +0900, Magnus Damm wrote:
> On Tue, Jun 18, 2013 at 9:36 PM, Laurent Pinchart
> <laurent.pinchart+renesas@ideasonboard.com> wrote:
> > This simplifies the main error path by getting rid of it.
> >
> > Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> 
> Looking good, thanks!
> 
> Acked-by: Magnus Damm <damm@opensource.se>

Thanks, queued up for v3.12 in the clocksource branch.
