From: Sergei Shtylyov <sshtylyov@mvista.com>
Date: Thu, 19 May 2011 11:50:08 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: sh73a0 twd_base fix
Message-Id: <4DD503F0.4050201@ru.mvista.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20110519062620.27921.52669.sendpatchset@t400s>
In-Reply-To: <20110519062620.27921.52669.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

On 19-05-2011 10:26, Magnus Damm wrote:

> From: Magnus Damm<damm@opensource.se>

> Fix the case of too late twd_base initialization for SMP
> on sh73a0 which bas been broken because sh73a0 specific
> smp_prepare_cpu() and percpu_timer_setup() changed order
> in the commits:

> 05c74a6cbcfb416286a947668ba32f63d99fe74a
> c413521eb4e2d7ffd5ce432a144708d479054bd3

    Please also specify those commits' summaries -- for the human readers.

> Without this fix the sh73a0 SMP kernel panics on boot.

> Signed-off-by: Magnus Damm<damm@opensource.se>

WBR, Sergei
