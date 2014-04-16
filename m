From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 16 Apr 2014 04:12:24 +0000
Subject: Re: [PATCH v2 8/8] sh: clk: Use cpufreq_for_each_valid_entry macro for iteration
Message-Id: <CAKohponxbA_rPFF=vzZEnjYkLLCkNOWHP7kxAUZ5mKpTPp_Myw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <534DB238.5030201@semaphore.gr>
	<20140416011120.GC8833@verge.net.au>
	<20140416012454.GA3941@verge.net.au>
In-Reply-To: <20140416012454.GA3941@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: Stratos Karafotis <stratosk@semaphore.gr>, Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, SH-Linux <linux-sh@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On 16 April 2014 06:54, Simon Horman <horms@verge.net.au> wrote:
> I have dropped this patch.
>
> Please let me know if there is a stable branch which
> includes cpufreq_frequency_table which I can use as a base to apply
> this patch.
>
> Alternatively, I would be happy to Ack this patch and let someone
> else pick up this patch, but I'm entirely unclear on who that would be.

Rafael will take this patch, please Ack it :)
