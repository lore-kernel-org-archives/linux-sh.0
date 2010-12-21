From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 21 Dec 2010 00:36:45 +0000
Subject: Re: about ap4evb HDMI video
Message-Id: <20101221003645.GC30700@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <w3pbp4g6enp.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pbp4g6enp.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Dec 21, 2010 at 09:36:39AM +0900, Kuninori Morimoto wrote:
> > > It print below when boot.
> > > Why is this happen ?
> > 
> > Strange, it works for me with the same board and branch as of commit 
> > 09dd7ded60019d6a4fd2ae20a08c4ad2bc3ed3e9 and without any warnings. I'll 
> > forward you off-list my .config.
> 
> Thanks
> your .config works well
> I check my .config
> Thanks again
> 
Please let us know what the differences are. If you have a config option
enabled that causes an -ENOMEM then we need to know what that is, and
what is causing it.
