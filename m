From: Simon Horman <horms@verge.net.au>
Date: Tue, 30 Jul 2013 02:39:18 +0000
Subject: Re: [PATCH 6/6 v2] ARM: shmobile: r8a7779: cleanup registration of usb phy
Message-Id: <20130730023918.GH31526@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87y58tbwoy.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87y58tbwoy.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jul 26, 2013 at 05:14:48PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 26-07-2013 11:35, Kuninori Morimoto wrote:
> 
>    The subject hardly matches what's being done in the patch.
> 
> >usb phy driver which needs platform data at the time of
> >registration is used from BockW only.
> 
>    s/BockW/Marzen/.
> 
> >Now, ARM/shmobile aims to support DT,
> >and the C code base board support will be removed
> >if DT support is completed.
> >Current driver registration method which needs platform data
> >and which is not shared complicates codes.
> >This means legacy C code cleanup after DT supporting
> >will be more complicated
> >This patch registers it on board code as cleanup C code
> 
> >Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
>    I cannot approve this patch. I see it as nothing other as pointless churn.
> My opinion probably doesn't matter in the light of Magnus' desire to
> get it merged but I'm still clinging to it.

Magnus has explained quite clearly the reasons for this change,
which are to make this board consistent with other boards which
are written in this way for historical reasons.

I understand that you have a different opinion but
the place for cleanly separating SoC and board code is
in DT not in the legacy C code.

Both Magnus and now I are in agreement on this.

I plan to fix up s/BockW/Marzen/ and queue up this patch for v3.12
in the cleanup3 branch.
