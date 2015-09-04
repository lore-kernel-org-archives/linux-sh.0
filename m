From: Simon Horman <horms@verge.net.au>
Date: Fri, 04 Sep 2015 01:16:55 +0000
Subject: Re: [PATCH 0/3] Basic GPIO support for r8a7795
Message-Id: <20150904011654.GC5869@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1441035401-5843-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1441035401-5843-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Sep 01, 2015 at 10:22:04AM +0900, Simon Horman wrote:
> Hi Ulrich,
> 
> On Mon, Aug 31, 2015 at 05:36:38PM +0200, Ulrich Hecht wrote:
> > Hi!
> > 
> > This has been broken out of horms's GPIO and EthernetAVB RFC (thanks again)
> > and has its minor issues fixed, hopefully.  Specifically, it fixes the GPIO
> > 6 and 7 clock references, dumps the MSTP's "clock-output-names" property,
> > and omits the extraneous options in defconfig.
> 
> I have pushed this seris to the renesas tree in the topic/r8a7795-gpio-v1
> branch.  It is based on the topic/arm64-rcar-gen3-v8 branch.
> 
> To be quite clear none of these patches are queued up for mainline yet and
> as such they are not included in the next or devel branches of the renesas
> tree.

I added a new topic branch, topic/r8a7795-gpio-v1.rebase, which
is this series rebased on top of topic/arm64-rcar-gen3-v9.

As I was unsure if this is what you want I have kept the
topic/r8a7795-gpio-v1 branch unchanged.
