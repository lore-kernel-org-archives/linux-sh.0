From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Mon, 01 Oct 2012 10:01:55 +0000
Subject: Re: [PATCH] ASoC: fixup simple-card probe order
Message-Id: <20121001100154.GA4360@opensource.wolfsonmicro.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5068E775.7040601@jinso.co.jp>
In-Reply-To: <5068E775.7040601@jinso.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Do Q.Thang" <dq-thang@jinso.co.jp>
Cc: alsa-devel@alsa-project.org, linux-sh@vger.kernel.org, Simon Horman <horms@verge.net.au>

On Mon, Oct 01, 2012 at 09:44:37AM +0900, Do Q.Thang wrote:
> Hi all,
> 
> KZM-A9-GT board and Armadillo-800eva board use the asoc-simple-card.
> but probe of this sound card needs the fsi-dai's registered before.
> So this message appear in the bootlog.
> 
> " asoc-simple-card asoc-simple-card.0: CPU DAI fsia-dai not registered
> platform asoc-simple-card.0: Driver asoc-simple-card requests probe
> deferral "
> 
> The asoc-simple-card was probed while fsi-dai probe hasn't run yet.
> So asoc-simple-card probe deferral is requested.
> I think the simple-card should be probed after the fsi-dai probe.
> I think this patch can fix this issue.
> 
> What do you think about this?

The above is normal and expected behaviour, there is no issue here.
