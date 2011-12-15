From: David Brown <davidb@codeaurora.org>
Date: Thu, 15 Dec 2011 18:14:50 +0000
Subject: Re: [PATCH v4 REPOST 2/5] ARM: SMP: Refactor Kconfig to be more
Message-Id: <20111215181450.GA22330@codeaurora.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1323862781-3465-1-git-send-email-dave.martin@linaro.org>
 <1323862781-3465-3-git-send-email-dave.martin@linaro.org>
In-Reply-To: <1323862781-3465-3-git-send-email-dave.martin@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Dec 14, 2011 at 11:39:38AM +0000, Dave Martin wrote:
> Making SMP depend on (huge list of MACH_ and ARCH_ configs) is
> bothersome to maintain and likely to lead to merge conflicts.
> 
> This patch moves the knowledge of which platforms are SMP-capable
> to the individual machines.  To enable this, a new HAVE_SMP config
> option is introduced to allow machines to indicate that they can
> run in a SMP configuration.

There still seem to be several people and lists from the
get_maintainer.pl output that are missing.  Russell should be
included, as well as the MSM maintainers and that list.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
