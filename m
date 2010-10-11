From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 11 Oct 2010 11:09:25 +0000
Subject: Re: [PATCH 7/7] sh: oprofile: Use perf-events oprofile backend
Message-Id: <20101011110925.GB1155@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1286584677.git.matt@console-pimps.org> <a0c83396f5fb8a29baff3daf43d29b2e601511ff.1286584677.git.matt@console-pimps.org> <20101011110654.GR13563@erda.amd.com>
In-Reply-To: <20101011110654.GR13563@erda.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Robert Richter <robert.richter@amd.com>
Cc: Matt Fleming <matt@console-pimps.org>, Will Deacon <will.deacon@arm.com>, Russell King <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, Frederic Weisbecker <fweisbec@gmail.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Deng-Cheng Zhu <dengcheng.zhu@gmail.com>, Grant Likely <grant.likely@secretlab.ca>

On Mon, Oct 11, 2010 at 01:06:54PM +0200, Robert Richter wrote:
> Matt and Paul,
> 
> are those (upper case) cpu_type strings already supported by the
> oprofile userland?
> 
I've only ever used out-of-tree patches with it due to the generally
volatile nature of support. Now that we have a more consistent interface
to go through, it probably makes sense to get those bits merged, too.
We're certainly not tied down to any ABI at this point.
