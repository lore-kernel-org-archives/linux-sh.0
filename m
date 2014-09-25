From: Simon Horman <horms@verge.net.au>
Date: Thu, 25 Sep 2014 01:24:14 +0000
Subject: Re: regulator node names and unit-addresses? (Re: [PATCH v2 1/5] ARM: shmobile: kzm9d: Remove spurio
Message-Id: <20140925012414.GE20466@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdVC2h4_Q+4BpV5iLbhfviimzrnfZ3+c6dqnegTAxBHw_g@mail.gmail.com>
 <20140924081455.GU4015@sirena.org.uk>
 <CAMuHMdWQfSLwqMMigLOZuGFJqQO03Qyw+ZHE1YAgd6mNDGmrEg@mail.gmail.com>
 <20140924082726.GX4015@sirena.org.uk>
In-Reply-To: <20140924082726.GX4015@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Sep 24, 2014 at 09:27:26AM +0100, Mark Brown wrote:
> On Wed, Sep 24, 2014 at 10:21:12AM +0200, Geert Uytterhoeven wrote:
> > On Wed, Sep 24, 2014 at 10:14 AM, Mark Brown <broonie@kernel.org> wrote:
> 
> > > As far as the regulator API is concerned the node name is completly
> > > immaterial and all this stuff is just verbiage we're forced to include.
> > > As far as I can tell the requirement that node names be in the form
> > > "regulator" or whatever is just another thing that wasn't terribly well
> > > thought through in ePAPR, they were trying to do classes I think.
> 
> > So perhaps we should just keep "regulator@0" and "regulator@1"?
> 
> I don't care what they're called so long as things work; the DT people
> are the ones to ask though.

Ok, lets just leave them as "regulator@0" and "regulator@1".
If better names emerge then we can use them.


