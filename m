From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 25 Aug 2010 09:19:01 +0000
Subject: Re: [PATCH 0/3] Generalise ARM perf-events backend for oprofile
Message-Id: <1282727941.22370.606.camel@pasglop>
List-Id: <linux-sh.vger.kernel.org>
References: <1282560381-7700-1-git-send-email-matt@console-pimps.org>
	<20100823105759.GA18638@infradead.org>
	<1282700516.22370.567.camel@pasglop>
	<1282727242.5727.7.camel@e102144-lin.cambridge.arm.com>
In-Reply-To: <1282727242.5727.7.camel@e102144-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, 2010-08-25 at 10:07 +0100, Will Deacon wrote:
> Ideally, the OProfile userspace tools would talk native perf and we
> could do away with oprofilefs and the oprofile buffer altogether.
> Compatibility with the old [read current] OProfile tools can be
> maintained using these patches until the API is deprecated.
> 
> Or is that a bit too optimistic? :) 

Heh, well, dunno, I suspect just moving userspace to native perf tools
is going to happen as soon is not sooner :-)

Ben.

