From: Will Deacon <will.deacon@arm.com>
Date: Wed, 10 Apr 2013 11:11:48 +0000
Subject: Re: [PATCH] ARM: hw_breakpoint: Do not use __cpuinitdata for dbg_cpu_pm_nb
Message-Id: <20130410111148.GA26992@mudshark.cambridge.arm.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1365588278-5185-1-git-send-email-hechtb+renesas@gmail.com>
In-Reply-To: <1365588278-5185-1-git-send-email-hechtb+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Apr 10, 2013 at 11:04:38AM +0100, Bastian Hecht wrote:
> We must not declare dbg_cpu_pm_nb as __cpuinitdata as we need it after
> system initialization for Suspend and CPUIdle.
> 
> This was done in commit 9a6eb310eaa5336b89a27a0bbb78da4bba35f6f1
> ARM: hw_breakpoint: Debug powerdown support for self-hosted debug
> 
> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>

Thanks Bastian, I'll take this into my tree.

Will
