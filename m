From: Ingo Molnar <mingo@kernel.org>
Date: Sun, 15 Jun 2014 06:54:23 +0000
Subject: Re: [PATCH 0/6] perf: Use common PMU interrupt disabled code on all architectures
Message-Id: <20140615065423.GA20028@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <alpine.DEB.2.10.1406150156510.16738@vincent-weaver-1.umelst.maine.edu>
In-Reply-To: <alpine.DEB.2.10.1406150156510.16738@vincent-weaver-1.umelst.maine.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vince Weaver <vincent.weaver@maine.edu>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@redhat.com>, Vineet Gupta <vgupta@synopsys.com>, Steven Miao <realmz6@gmail.com>, James Hogan <james.hogan@imgtec.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Cody P Schafer <cody@linux.vnet.ibm.com>, linux-sh@vger.kernel.org, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>


* Vince Weaver <vincent.weaver@maine.edu> wrote:

> 
> Now that "perf/x86: Use common PMU interrupt disabled code"
> (c184c980de30dc) was merged, I went and audited all of the
> architectures.  The following patchset attempts to move
> all of the ones that have code disabling sampled events
> due to lack of overflow interrupt to the new common code.
> 
> ARM and x86 were already updated with the original changeset.
> 
> Note that this is an ABI change in some cases, as many
> architectures returned EINVAL previously rather than
> EOPNOTSUPP.
> 
> Unfortunately these patches are not tested at all, as I don't have
> access to the hardware.

Looks good to me, for v3.17. Peter, what do you think?

Reviewed-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
