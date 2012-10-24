From: Ming Lei <tom.leiming@gmail.com>
Date: Wed, 24 Oct 2012 13:07:05 +0000
Subject: Re: [Q] "console=" command line ignored?
Message-Id: <CACVXFVOv-zMj_cEyRuehhWMjCF1nvd-tkW7c8o5raHZoMbCZiQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1210241226060.31768@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1210241226060.31768@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>, linux-sh@vger.kernel.org

On Wed, Oct 24, 2012 at 6:49 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Hi
>
> I cannot seem to force selection of a serial console by specifying
> "console=ttySC0..." on the command line with modern (yesterday's "next")
> kernels. The kernel insists on
>
> console [tty0] enabled

Please see https://lkml.org/lkml/2012/10/23/307

>
> The reason might also well be, that the respective "sh-sci" driver is
> only registered later. I'll try to look at this in more detail - since
> when this is broken and how the registration order looked before. This is
> just a first heads-up in case someone has a solution immediately at hand.



Thanks,
-- 
Ming Lei
