From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 26 Oct 2009 12:12:18 +0000
Subject: Re: [PATCH] sh: rsk7203 CONFIG_MTD=n fix
Message-Id: <20091026121218.GA7778@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20091026100855.13528.68879.sendpatchset@rxone.opensource.se>
In-Reply-To: <20091026100855.13528.68879.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Oct 26, 2009 at 12:23:57PM +0100, Fabio Giovagnini wrote:
> OK. Thanks a lot.
> Did you build any application for rsk7203?
> I used MCP data environment, but it is without g++, so I cannot use libraries 
> as SDL, qt embedded, or more.
> I think  exculding all the g++ stuff  is not strategic.
> 
Then talk to MPC about it. This is not an MPC support forum, and
obviously we do not recommend using antiquated toolchains.

The CodeSourcery toolchain is the only one that is current and supported,
although the SH-FDPIC toolchain aimed at SH-2A is not yet publically
available. However you can of course take the source and attempt to
construct a FLAT toolchain from it in the interim (although this too
would result in a currently unsupported configuration).
