From: Stratos Karafotis <stratosk@semaphore.gr>
Date: Wed, 16 Apr 2014 07:04:39 +0000
Subject: Re: [PATCH v2 8/8] sh: clk: Use cpufreq_for_each_valid_entry macro for iteration
Message-Id: <534E2B87.10304@semaphore.gr>
List-Id: <linux-sh.vger.kernel.org>
References: <534DB238.5030201@semaphore.gr> <20140416041345.GC27534@verge.net.au>
In-Reply-To: <20140416041345.GC27534@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, linux-sh@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On 16/04/2014 07:13 πμ, Simon Horman wrote:
> On Wed, Apr 16, 2014 at 01:27:04AM +0300, Stratos Karafotis wrote:
>> The cpufreq core now supports the cpufreq_for_each_valid_entry macro
>> helper for iteration over the cpufreq_frequency_table, so use it.
>>
>> It should have no functional changes.
>>
>> Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
> 
> Rafael, please feel free to take this one.
> 
> Acked-by: Simon Horman <horms+renesas@verge.net.au>
> 

Thanks!

Stratos

