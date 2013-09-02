From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 02 Sep 2013 11:03:04 +0000
Subject: Re: [PATCH] ARM: shmobile: armadillo: fixup ether pinctrol naming
Message-Id: <4854976.8NC3ynB8v1@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <87fvtnsxr9.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fvtnsxr9.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Sergei,

On Monday 02 September 2013 14:59:45 Sergei Shtylyov wrote:
> Hello.
> 
> On 02-09-2013 14:37, Laurent Pinchart wrote:
> >> e5c9b4cd665106d9b5397114ea81a53059410b6a
> >> (sh_eth: get R8A7740 support out of #ifdef)
> >> exchanged sh-eth driver name to r8a7740-gether,
> >> but, eva_pinctrl_map[] didn't follow it.
> >> This patch fixes it.
> >> 
> >> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > 
> > Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > 
> > I've taken the patch in my tree and will push it to v3.13.
> 
> Why to 3.13 if this is a bug fix?

My bad, I meant v3.12. I've added the patch to my fixes branch, which I will 
ask Simon to pull into v3.12-rc.

-- 
Regards,

Laurent Pinchart

