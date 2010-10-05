From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 05 Oct 2010 08:08:34 +0000
Subject: Re: [PATCH 6/7] sh: oprofile: Use perf-events oprofile backend
Message-Id: <20101005080833.GA7984@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1286222593.git.matt@console-pimps.org>
	<db62cbe463d5bce89196d6456ad386129ce0022a.1286222593.git.matt@console-pimps.org>
In-Reply-To: <db62cbe463d5bce89196d6456ad386129ce0022a.1286222593.git.matt@console-pimps.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matt Fleming <matt@console-pimps.org>
Cc: linux-arch@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Russell King <linux@arm.linux.org.uk>, linux-sh@vger.kernel.org, Robert Richter <robert.richter@amd.com>, Frederic Weisbecker <fweisbec@gmail.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Deng-Cheng Zhu <dengcheng.zhu@gmail.com>, Ingo Molnar <mingo@elte.hu>, linux-arm-kernel@lists.infradead.org

On Mon, Oct 04, 2010 at 09:44:24PM +0100, Matt Fleming wrote:
> Now that we've got a generic perf-events based oprofile backend we might
> as well make use of it seeing as SH doesn't do anything special with its
> oprofile backend. Also introduce a new CONFIG_HW_PERF_EVENTS symbol so
> that we can fallback to using the timer interrupt for oprofile if the
> CPU doesn't support perf events.
> 
> Signed-off-by: Matt Fleming <matt@console-pimps.org>

Acked-by: Paul Mundt <lethal@linux-sh.org>
