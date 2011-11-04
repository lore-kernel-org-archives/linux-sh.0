From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 04 Nov 2011 14:10:22 +0000
Subject: Re: R-Mobile A1 support
Message-Id: <20111104141021.GD29825@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <87bou4qgof.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87bou4qgof.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Sep 30, 2011 at 12:56:18AM -0700, Kuninori Morimoto wrote:
> 
> Hi Iwamatsu-san
> 
> > Do you forget to send an email of 2/5?
> 
> Hmm.. strange..
> 
> I sent 2/5 email, but linux-sh ML didn't get it ?
> OK. I will re-send it
> 
I am still not able to find it anywhere, making me think that it was too
large and was dropped by the list software. Perhaps it can be broken up
in to smaller parts? Also make sure that you are including a stripped
defconfig and not the entire thing, as that will needlessly bloat up the
patch (and I'll just have to strip out the unecessary symbols later),
too.
