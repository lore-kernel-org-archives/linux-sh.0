From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 11 Jan 2013 10:23:47 +0000
Subject: Re: [PATCH] sh: define TASK_UNMAPPED_BASE as a page aligned constant
Message-Id: <20130111102346.GA26243@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <87sj684alg.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87sj684alg.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jan 10, 2013 at 09:05:34PM -0800, Michel Lespinasse wrote:
> On Thu, Jan 10, 2013 at 8:17 PM, Kuninori Morimoto
> <kuninori.morimoto.gx@renesas.com> wrote:
> > b4265f12340f809447b9a48055e88c444b480c89
> > (mm: use vm_unmapped_area() on sh architecture)
> > broke sh boot. This patch define TASK_UNMAPPED_BASE
> > as a page aligned constant to solve this issue.
> > Special thanks to Michel
> >
> > Cc: Michel Lespinasse <walken@google.com>
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Acked-by: Michel Lespinasse <walken@google.com>
> 
> > Thanks !!
> > my board start works with this patch.
> > Please check it.
> 
> Looks fine, thanks for finding this :)
> 
Thanks guys, I'll queue it up.
