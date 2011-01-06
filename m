From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 06 Jan 2011 03:11:16 +0000
Subject: Re: [PATCH 0/3] ARM: mach-shmobile: mackerel: HDMI support
Message-Id: <20110106031116.GJ23889@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <w3pwrmjk2yu.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pwrmjk2yu.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jan 06, 2011 at 09:51:14AM +0900, Kuninori Morimoto wrote:
> > Kuninori Morimoto (3):
> >       ARM: mach-shmobile: mackerel: Add fsi_set_rate
> >       ARM: mach-shmobile: mackerel: add HDMI video support
> >       ARM: mach-shmobile: mackerel: Add HDMI sound support
> > 
> > These are based on Paul's rmobile-latest branch (not mackerel branch)
> 
> I'm so sorry.
> I noticed big mistake on these patches.
> Please drop it.
> And give me 2nd chance
> 
Ok, I've taken the second version.

On Thu, Jan 06, 2011 at 11:43:00AM +0900, Kuninori Morimoto wrote:
> fsib_clk will be used when fdiv_clk failed on fsi_hdmi_set_rate.

And also applied this, thanks.
