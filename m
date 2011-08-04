From: Stephen Boyd <sboyd@codeaurora.org>
Date: Thu, 04 Aug 2011 17:24:55 +0000
Subject: Re: [PATCH] cpuidle: Consistent spelling of cpuidle_idle_call()
Message-Id: <4E3AD5E7.6040105@codeaurora.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1312475071-22973-1-git-send-email-davidb@codeaurora.org>
In-Reply-To: <1312475071-22973-1-git-send-email-davidb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 08/04/2011 09:24 AM, David Brown wrote:
> Commit a0bfa1373859e9d11dc92561a8667588803e42d8 mispells
> cpuidle_idle_call() on ARM and SH code.  Fix this to be consistent.
>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Paul Mundt <lethal@linux-sh.org>
> Cc: x86@kernel.org
> Cc: Len Brown <len.brown@intel.com>
> Signed-off-by: David Brown <davidb@codeaurora.org>
> ---
> The referenced commit breaks compilation on ARM, and appears it would
> do so on SH as well.

Mark Brown sent this patch[1] months ago when this build breakage was
noticed in linux-next. What happened to that patch? It looks like the
patch that introduced the breakage was pulled from linux-next shortly
after and then reintroduced today.

[1]https://lkml.org/lkml/2011/4/4/109

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

