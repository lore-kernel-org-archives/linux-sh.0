From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Thu, 04 Aug 2011 23:47:57 +0000
Subject: Re: [PATCH] cpuidle: Consistent spelling of cpuidle_idle_call()
Message-Id: <20110804234755.GA13321@opensource.wolfsonmicro.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1312475071-22973-1-git-send-email-davidb@codeaurora.org>
	<4E3AD5E7.6040105@codeaurora.org>
In-Reply-To: <4E3AD5E7.6040105@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Aug 04, 2011 at 10:24:55AM -0700, Stephen Boyd wrote:
> On 08/04/2011 09:24 AM, David Brown wrote:
> > Commit a0bfa1373859e9d11dc92561a8667588803e42d8 mispells
> > cpuidle_idle_call() on ARM and SH code.  Fix this to be consistent.

> > The referenced commit breaks compilation on ARM, and appears it would
> > do so on SH as well.

> Mark Brown sent this patch[1] months ago when this build breakage was
> noticed in linux-next. What happened to that patch? It looks like the
> patch that introduced the breakage was pulled from linux-next shortly
> after and then reintroduced today.

Yeah, as far as I remember Stephen applied my patch to -next as Len
didn't respond to it.
