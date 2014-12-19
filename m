From: Simon Horman <horms@verge.net.au>
Date: Fri, 19 Dec 2014 00:12:34 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7740: Instantiate GIC from C board code in legacy builds
Message-Id: <20141219001233.GD29188@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1418823642-28154-1-git-send-email-geert+renesas@glider.be>
 <54919119.8030208@arm.com> <20141218003312.GE1421@verge.net.au>
 <CAMuHMdXZfY0eiqcMT89EuyYbZoT1rRnNjUL2gEYtLB-gSSHCkQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXZfY0eiqcMT89EuyYbZoT1rRnNjUL2gEYtLB-gSSHCkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Dec 18, 2014 at 09:14:46AM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Thu, Dec 18, 2014 at 1:33 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Wed, Dec 17, 2014 at 02:20:09PM +0000, Marc Zyngier wrote:
> >> On 17/12/14 13:40, Geert Uytterhoeven wrote:
> >> > As of commit 9a1091ef0017c40a ("irqchip: gic: Support hierarchy irq
> >> > domain."), armadillo-legacy hangs during boot with:
> 
> > can I confirm that you would like me to pick this up - there are a lot of
> > changes flying around at the moment?  If so would you like it considered as
> > a fix for v3.19 and stable? If so I will need some information about what
> > patch introduced the problem in which release. If not can you state why?
> 
> The above-mentioned commit will be in v3.19-rc1. So getting it in
> v3.19 only sounds fine

Thanks, I will see about making it so.

> (unless you want to backport the IRQ domain breakage to 3.14-ltsi ;-)

Hopefully not :)

> Thanks!
> 
> > The reason for requesting such information is so that I can pass it on to
> > the ARM SoC maintainers so it is clear to them how to handle the patch and
> > why.
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
