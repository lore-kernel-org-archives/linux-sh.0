From: Simon Horman <horms@verge.net.au>
Date: Tue, 29 Oct 2013 04:43:46 +0000
Subject: Re: [PATCH 01/17] ARM: shmobile: r8a73a4: fixup DT node naming for SDHI
Message-Id: <20131029044346.GD20432@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87hacjdlmi.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87hacjdlmi.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Oct 21, 2013 at 05:09:46PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 10/17/2013 06:49 AM, Kuninori Morimoto wrote:
> 
> >>>>-	sdhi0: sdhi@ee100000 {
> >>>>+	sd0: sd@ee100000 {
> 
> >>>    Having to change the node names doesn't mean you need to change
> >>>the labels too (and PFC-related node names too). In fact, I think
> >>>the existing labels are better.
> 
> >>My, this is tedious.
> 
> >>Looking at other dts files I see a lot of entries
> >>of the form "mmcX: mmc@...". And I think that Morimoto-san's patches
> >>are in keeping with that style.
> 
> >>On the other hand, I see your point that its much clearer
> >>to use sdhi0 as that is what the hw manuals refer to and
> >>it would allow differentiation with mmcif.
> 
> >>So I lean towards Sergei's suggestion being a bit nicer.
> 
> >>Morimoto-san, what is your feeling on this?
> 
> >I don't know.
> >Actually, I don't have any interesting about
> >this kind of non-technical patches.
> 
> >I don't want sending many patches in many times.
> >So, please show me your concretely favored style.
> >like this ?
> 
> >	sdhi0: sd@ee100000 {
> 
>    I thought you were asking Simon. Yes, this is the style I'd prefer.

That is fine by me.

Morimoto-san, would you care to refresh the series?
