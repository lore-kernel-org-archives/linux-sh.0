From: Simon Horman <horms@verge.net.au>
Date: Thu, 01 Aug 2013 08:02:28 +0000
Subject: Re: [PATCH v6 3/3] ARM: shmobile: lager: enable nfsroot in DTS
Message-Id: <20130801080226.GF15265@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1375175361-23027-1-git-send-email-horms+renesas@verge.net.au>
 <1375175361-23027-4-git-send-email-horms+renesas@verge.net.au>
 <87bo5h3lb3.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87bo5h3lb3.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Aug 01, 2013 at 12:46:44AM -0700, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > Now that Ether support has been added to the lager board
> > it is possible to use nfsroot. This configuration is
> > in line with that of other shmobile boards.
> > 
> > Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> (snip)
> >  	chosen {
> > -		bootargs = "console=ttySC6,115200 ignore_loglevel";
> > +		bootargs = "console=ttySC6,115200 ignore_loglevel root=/dev/nfs ip=dhcp nfsroot=,rsize@96,wsize@96 rw";
> 
> Could you please add why this "rsize/wsize" settings
> are needed on bootargs ?
> (other shmobile board's dts file doesn't have these)
> 
> And, I guess r8a7790-lager.dts/r8a7790.dts doesn't have
> "sh-eth" driver DT settings, (or I'm missing ?)
> but you added network/nfsroot settings on bootargs.
> It is OK for me, but for what ?

I think it is copy-paste noise.
I'll remove them.
