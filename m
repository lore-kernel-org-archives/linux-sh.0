From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 20 Sep 2011 00:54:26 +0000
Subject: Re: Ecovec (SH7724) board doesn't work on latest linus tree
Message-Id: <20110920005426.GA24403@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <w3pvcwf5xuu.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pvcwf5xuu.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Sep 08, 2011 at 05:52:11PM +0900, Nobuhiro Iwamatsu wrote:
> Your patch does not seem to have a meaning.
> In the case of 29bit, CAC/UNCAC_ADDR may not return a right address.
> I think that it is to use P1SEGADDR, and P2SEGADDR in CAC/UNCAC_ADDR
> to easily revise this.
> I attached my patch.
> 
Morimoto-san, does this fix your issue? If you can provide your Tested-by
for this then I'll queue it up and get it off to Linus.
