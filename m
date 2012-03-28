From: David Rientjes <rientjes@google.com>
Date: Wed, 28 Mar 2012 07:20:32 +0000
Subject: Re: [PATCH 10/10] oom: Make find_lock_task_mm() sparse-aware
Message-Id: <alpine.DEB.2.00.1203280020100.16201@chino.kir.corp.google.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20120324102609.GA28356@lizard> <20120324103127.GJ29067@lizard>
 <1332593574.16159.31.camel@twins>
In-Reply-To: <1332593574.16159.31.camel@twins>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Sat, 24 Mar 2012, Peter Zijlstra wrote:

> Yeah, so Nacked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> 
> Also, why didn't lockdep catch it?
> 
> Fix sparse already instead of smearing ugly all over.
> 

Fully agreed, please don't add this to the oom killer.
