From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 21 Oct 2008 03:45:52 +0000
Subject: Re: [PATCH] soc-camera: fix compile breakage on SH
Message-Id: <20081021034552.GB29105@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.0810142335400.10458@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.0810142335400.10458@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Oct 20, 2008 at 07:44:09PM +0200, Guennadi Liakhovetski wrote:
> On Mon, 20 Oct 2008, Paul Mundt wrote:
> 
> > > Last I checked - just before sending the previous email - it was not yet 
> > > committed, but it is racy, you know:-)
> > > 
> > Then I will merge the original in my tree and we can then focus on
> > getting the API changed properly, and making an incremental transition
> > that doesn't break all of the existing users in the process.
> 
> Shall I ask Mauro to not merge the v4l part? It might still work...
> 
Too late now, so I'll just merge the SH part separately. Please just try
to keep this in mind in the future so we do not have the same problem
again.
