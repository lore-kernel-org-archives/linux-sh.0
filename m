From: Simon Horman <horms@verge.net.au>
Date: Wed, 16 Apr 2014 01:11:20 +0000
Subject: Re: [PATCH v2 8/8] sh: clk: Use cpufreq_for_each_valid_entry macro for iteration
Message-Id: <20140416011120.GC8833@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <534DB238.5030201@semaphore.gr>
In-Reply-To: <534DB238.5030201@semaphore.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stratos Karafotis <stratosk@semaphore.gr>
Cc: Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, linux-sh@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Wed, Apr 16, 2014 at 01:27:04AM +0300, Stratos Karafotis wrote:
> The cpufreq core now supports the cpufreq_for_each_valid_entry macro
> helper for iteration over the cpufreq_frequency_table, so use it.
> 
> It should have no functional changes.
> 
> Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>

Thanks, I have queued this up.
