From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 24 Sep 2013 13:41:13 +0000
Subject: Re: [PATCH 2/6] serial8250-em: convert to clk_prepare/unprepare
Message-Id: <20130924134113.GA7246@kroah.com>
List-Id: <linux-sh.vger.kernel.org>
References: <52410F86.4040301@renesas.com>
 <20130924131039.3c871cad7acb2a068a988d0f@ops.dti.ne.jp>
 <20130924044432.GD3619@verge.net.au>
In-Reply-To: <20130924044432.GD3619@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: takasi-y@ops.dti.ne.jp, SH-Linux <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, ben.dooks@codethink.co.uk, Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Mike Turquette <mturquette@linaro.org>, linux-kernel@vger.kernel.org

On Tue, Sep 24, 2013 at 01:44:32PM +0900, Simon Horman wrote:
> [ CCed Greg Kroah-Hartman, the serial maintainer for his review ]
> 
> On Tue, Sep 24, 2013 at 01:10:39PM +0900, takasi-y@ops.dti.ne.jp wrote:
> > From: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
> > 
> > Add calls to clk_prepare and unprepare so that EMMA Mobile EV2 can
> > migrate to the common clock framework.
> > 
> > Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
> > [takashi.yoshii.ze@renesas.com: edited for conflicts]
> > Signed-off-by: Takashi Yoshii <takashi.yoshii.zj@renesas.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

