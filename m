From: Simon Horman <horms@verge.net.au>
Date: Wed, 29 Oct 2014 23:53:35 +0000
Subject: Re: [PATCH 03/03] ARM: shmobile: mackerel: Remove legacy board support
Message-Id: <20141029235335.GB4599@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20141029074717.405.8623.sendpatchset@w520>
In-Reply-To: <20141029074717.405.8623.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Oct 29, 2014 at 10:24:38AM +0100, Geert Uytterhoeven wrote:
> Hi Magnus,
> 
> On Wed, Oct 29, 2014 at 10:13 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> > I do think
> > we can ditch the bindings since we phase out the board support, but
> > perhaps that's wrong. =)
> 
> The DTS only contains the memory node, which we can easily resurrect,
> if needed.
> 
> > Do you think it is good timing to get rid of Mackerel now, or do you
> > prefer to wait?
> 
> I think the Mackerel-specific code can go.
> 
> The sh7372 SoC code is still there. That contains some still interesting parts
> (cpuidle and wake-up source code). If they can stay for a little
> while, I'm happy.

From my point of view I don't see a lot of value in keeping unused SoC code
lying around. For one thing it will be hard to avoid bitrot if we can't
even boot the code. So I'd prefer to remove sh7372 SoC code and Mackerel board
code in one hit. But I am prepared to be convinced otherwise.
