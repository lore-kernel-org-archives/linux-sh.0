From: Simon Horman <horms@verge.net.au>
Date: Wed, 10 Apr 2013 05:20:03 +0000
Subject: Re: [PATCH/RFC 0/2] wait for MSTP clocks to start
Message-Id: <20130410052003.GB29735@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1303221415490.12375@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1303221415490.12375@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Mar 27, 2013 at 02:31:38PM +0900, Simon Horman wrote:
> On Fri, Mar 22, 2013 at 02:24:22PM +0100, Guennadi Liakhovetski wrote:
> > Hi
> > 
> > These patches add an ability to wait for MSTP clocks to start by reading 
> > back their status registers repeatedly, until they update. This assumes, 
> > that *MSTPCR and respective MSTPSR registers use the same bits for the 
> > same clocks. Patches are marked "RFC," because I think at least one ack 
> > is required ;-)
> 
> Thanks Guennadi.
> 
> Magnus, I have no particular objections to these changes.
> What are your thoughts?

Magnus: ping
